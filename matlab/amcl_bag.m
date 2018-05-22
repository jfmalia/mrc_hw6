% LT Joshua Malia
% ME4823 - MRC
% .bag file data extraction plotting
% amcl bag file deconstruction

function [amcl_X,amcl_Y,amcl_Heading,amcl_Time] = amcl_bag(bagselect)

% Create timeseries
ts1 = timeseries(bagselect,'Pose.Pose.Position.X','Pose.Pose.Position.Y');
ts2 = timeseries(bagselect,'Pose.Pose.Orientation.W','Pose.Pose.Orientation.X','Pose.Pose.Orientation.Y','Pose.Pose.Orientation.Z');

% Rename Data Columns for plotting
amcl_X = ts1.Data(:,1); amcl_Y = ts1.Data(:,2); 

angles = quat2eul([ts2.Data(:,1) ts2.Data(:,2) ts2.Data(:,3) ts2.Data(:,4)]);
amcl_Heading = angles(:,1);

% Reset to Relative Time
amcl_Time = ts1.Time-ts1.Time(1);

end