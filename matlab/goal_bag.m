% LT Joshua Malia
% ME4823 - MRC
% .bag file data extraction plotting
% goal bag file deconstruction

function [goal_X,goal_Y,goal_Heading,goal_Time] = goal_bag(bagselect)

% Create timeseries
ts1 = timeseries(bagselect,'Goal.TargetPose.Pose.Position.X','Goal.TargetPose.Pose.Position.Y');
ts2 = timeseries(bagselect,'Goal.TargetPose.Pose.Orientation.W','Goal.TargetPose.Pose.Orientation.X','Goal.TargetPose.Pose.Orientation.Y','Goal.TargetPose.Pose.Orientation.Z');

% Rename Data Columns for plotting
goal_X = ts1.Data(:,1); goal_Y = ts1.Data(:,2); 

angles = quat2eul([ts2.Data(:,1) ts2.Data(:,2) ts2.Data(:,3) ts2.Data(:,4)]);
goal_Heading = angles(:,1);

% Reset to Relative Time
goal_Time = ts1.Time-ts1.Time(1);

end