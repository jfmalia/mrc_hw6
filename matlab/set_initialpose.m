% LT Joshua Malia
% ME4823 - MRC
% Pose Initialization for Navigation

function [] = set_initialpose(X,Y,Yaw)

yaw_quat = eul2quat([0 0 Yaw]);

Initialize = rospublisher('/amcl_pose');

msg = rosmessage(Initialize);
    msg.Pose.Pose.Position.X = X;
    msg.Pose.Pose.Position.Y = Y;
    msg.Pose.Pose.Orientation.X = yaw_quat(:,1);
    msg.Pose.Pose.Orientation.Y = yaw_quat(:,2);
    msg.Pose.Pose.Orientation.Z =yaw_quat(:,3);
    msg.Pose.Pose.Orientation.W = yaw_quat(:,4);
    msg.Pose.Covariance = [0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.0, ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ...
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ...
        0.06853891945200942];
    
send(Initialize,msg)
   

end
   