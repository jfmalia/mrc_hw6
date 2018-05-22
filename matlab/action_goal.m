function [] = action_goal(goal,client,goal_msg)

    % Callback Functions for Action Client
    client.ActivationFcn=@(~)disp('Goal active');
    client.FeedbackFcn=@(~,msg)fprintf('Feedback: X=%.2f, Y=%.2f, yaw=%.2f, pitch=%.2f, roll=%.2f  \n',msg.BasePosition.Pose.Position.X,...
        msg.BasePosition.Pose.Position.Y,quat2eul([msg.BasePosition.Pose.Orientation.W,...
        msg.BasePosition.Pose.Orientation.X,msg.BasePosition.Pose.Orientation.Y, ...
        msg.BasePosition.Pose.Orientation.Z]));

    client.FeedbackFcn=@(~,msg)fprintf('Feedback: X=%.2f\n',msg.BasePosition.Pose.Position.X);
    client.ResultFcn=@(~,res)fprintf('Result received: State: <%s>, StatusText: <%s>\n',res.State,res.StatusText);

    % Goal Message Assembly
    goal_msg.TargetPose.Header.FrameId = 'map';

    goal_msg.TargetPose.Pose.Position.X = goal(:,1);
    goal_msg.TargetPose.Pose.Position.Y = goal(:,2);
    angles = eul2quat([goal(:,3) 0 0]);
    goal_msg.TargetPose.Pose.Orientation.W = angles(1);
    goal_msg.TargetPose.Pose.Orientation.X = angles(2);
    goal_msg.TargetPose.Pose.Orientation.Y = angles(3);
    goal_msg.TargetPose.Pose.Orientation.Z = angles(4);
    showdetails(goal_msg)

%     resultmsg = sendGoalAndWait(client,goal_msg);
    sendGoalAndWait(client,goal_msg);

%     fprintf('Action completed: State: <%s>, StatusText: <%s>\n',resultmsg.State,resultmsg.StatusText);

    cancelAllGoals(client)
    delete(client)   
    clear goal_msg

end