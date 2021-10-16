clear;
close all;

%Create a 10x5 map filled with zeros (empty cells)
map = false(10,05);
% Mark obstacles (fill the cells by setting them to 1)
map(1:10,1) = true;
map(2,3) = true;
map(3,3) = true;
map(1,5) = true;
map(10,1:3) = true;

%Assign start (green) and goal (yellow) nodes
start_coords = [7,4];
goal_coords = [3,2];


% We want to draw the map everytime we run the code. If we don't, set to false
drawMapEveryTime = true;
 
% Apply DFS
[route, step] = DFS_Grid(map,start_coords,goal_coords,drawMapEveryTime);

