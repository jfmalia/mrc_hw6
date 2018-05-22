% LT Joshua Malia
% ME4823 - MRC
% Navigation via MATLAB using Action Server

clear;clc;

set_initialpose(0,0,0);

load goal_points.mat

for i = 1:length(goals)

    goal = goals(i,:)
    Current_Goal = fprintf('X = %.2f\nY = %.2f\nYAW = %.2f\n',goals(i,1),goals(i,2),goals(i,3))

    [client, goal_msg] = rosactionclient('/move_base');

    % Test connection
    if client.IsServerConnected == 1
        disp('Connected to Client')
    else
        waitForServer(client);
    end

    action_goal(goal,client,goal_msg)

end

disp('All Goals Complete')






