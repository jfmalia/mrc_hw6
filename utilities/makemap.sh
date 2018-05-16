roslaunch turtlebot3_slam turtlebot3_slam.launch &
roslaunch turtlebot3_nps teleop.launch &
rosrun rviz rviz -d `rospack find turtlebot3_slam`/rviz/turtlebot3_slam_custom.rviz

