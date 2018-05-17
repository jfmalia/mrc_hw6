% LT Joshua Malia
% ME4823 - MRC
% .bag file data extraction plotting
% Move Base Navigation

clear; clc;
close all;

% Load bag file
cd('~/catkin_ws/src/mrc_hw6/matlab')
bag = rosbag('../data/navigation.bag');

%----------------------------ODOM DATA------------------------------------%
odom_select = select(bag,'Topic','/odom');
[X,Y,Heading,LinearVelocity,AngularVelocity,Time] = odom_bag(odom_select);

%----------------------------AMCL TOPIC-----------------------------------%
amcl_select = select(bag,'Topic','/amcl_pose'); 
[amcl_X,amcl_Y,amcl_Heading,amcl_Time] = amcl_bag(amcl_select);


%----------------------------GOAL TOPIC-----------------------------------%
goal_select = select(bag,'Topic','/move_base/goal'); 
[goal_X,goal_Y,goal_Heading,goal_Time] = goal_bag(goal_select);

%------------------------------MAP----------------------------------------%
ifile = '../maps/map.pgm';   % Image file name
I=imread(ifile);
 
% Set the size scaling
xWorldLimits = [-10 9.2];
yWorldLimits = [-10 9.2];
RI = imref2d(size(I),xWorldLimits,yWorldLimits);
 
% Plot Map Image
figure(1);
    imshow(flipud(I),RI); hold on
    set(gca,'YDir','normal')
figure(2);
    imshow(flipud(I),RI); hold on
    set(gca,'YDir','normal')
    
%--------------------------------PLOTS------------------------------------%
% XY Odom Position Plot
figure(1);
    plot(X,Y);grid on;hold on
% amcl Position Plot
figure(1);
    plot(amcl_X,amcl_Y,'.')
% Goals
figure(1);
    plot(goal_X,goal_Y,'mx','linewidth',1);
% Start/End
figure(1);
    plot(X(1),Y(1),'go','linewidth',3);plot(X(end),Y(end),'ro','linewidth',3)
% Plot features  
xlabel('X Position [m]'); ylabel('Y Position [m]')
legend('odom Path','amcl estimation','goal','Start','End')
title('Smash Navigation')

%-----------------------------QUIVER PLOTS--------------------------------%

% Quiver Odom Plot
figure(2);
    U = LinearVelocity.*cos(Heading);
    V = LinearVelocity.*sin(Heading);
    ii = 1:20:length(X);
    quiver(X(ii),Y(ii),U(ii),V(ii)); grid on; hold on    
    
% amcl Orientation Plot
figure(2);
    amcl_U = 0.05*cos(amcl_Heading);
    amcl_V = 0.05*sin(amcl_Heading);
    ii = 1:1:length(amcl_X);
    quiver(amcl_X(ii),amcl_Y(ii),amcl_U(ii),amcl_V(ii)); grid on; hold on;

% Goals
figure(2);
    goal_U = 0.05*cos(goal_Heading);
    goal_V = 0.05*sin(goal_Heading);
    quiver(goal_X,goal_Y,goal_U,goal_V,'m-','linewidth',1); grid on; hold on;
    
% Start/End
plot(X(1),Y(1),'go','linewidth',3); hold on
plot(X(end),Y(end),'ro','linewidth',3); hold on
    
% Plot Features    
legend('odom Path','amcl estimation','goal','Start','End')
xlabel('X Position [m]'); ylabel('Y Position [m]')
title('Quiver Plot Smash Navigation')

    

