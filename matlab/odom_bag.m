% LT Joshua Malia
% ME4823 - MRC
% .bag file data extraction plotting
% odom bag file deconstruction

function [X,Y,Heading,LinearVelocity,AngularVelocity,Time] = odom_bag(bagselect)

% Create timeseries
ts1 = timeseries(bagselect,'Pose.Pose.Position.X','Pose.Pose.Position.Y');
ts2 = timeseries(bagselect,'Pose.Pose.Orientation.W','Pose.Pose.Orientation.X','Pose.Pose.Orientation.Y','Pose.Pose.Orientation.Z');
ts3 = timeseries(bagselect,'Twist.Twist.Linear.X','Twist.Twist.Linear.Y');
ts4 = timeseries(bagselect,'Twist.Twist.Angular.Z');

% Rename Data Columns for plotting
X = ts1.Data(:,1); Y = ts1.Data(:,2); 

angles = quat2eul([ts2.Data(:,1) ts2.Data(:,2) ts2.Data(:,3) ts2.Data(:,4)]);
Heading = angles(:,1);

LinearVelocity = ts3.Data(:,1); 
AngularVelocity = ts4.Data(:,1);

% Reset to Relative Time
Time = ts1.Time-ts1.Time(1);

end