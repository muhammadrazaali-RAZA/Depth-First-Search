function [route,n] = DFS_Grid(input_map,start_coords,goal_coords,drawMapEveryTime)
% Run DFS algorithm on a grid
    % Inputs:
    %   input_map: a logical array where the freespace cells are false or 0
    %   and the obstacles are true or 1
    %   start_coords and goal_coords: coordinates of the start and goal cells
    %   respectively, the first entry is the row and the second is the column
    % Output:
    %   route: an array containing the linear indices of the cells along
    %   the shortest route found by DFS from start to goal or an empty
    %   array if there is no route. This is a single dimensional vector
    %   numExpanded: returns the total number of nodes expanded during
    %   search. Goal is not counted as an expanded node
    
    % Set up color map for display
    % 1 - white - clear cell
    % 2 - black - obstacle
    % 3 - red - explored
    % 4 - blue - in the frontier
    % 5 - green - start
    % 6 - yellow - goal
    %       R G B
    cmap = [1 1 1; ...   % white
            0 0 0; ...   % black
            1 0 0; ...   % red
            0 0 1; ...   % blue
            0 1 0; ...   % green
            1 1 0; ...   % yellow
            0.5 0.5 0.5];% gray
    
    colormap(cmap);
        
    [nrows,ncols] = size(input_map);
    
    % map - a table that keeps track of the status of each grid cell
    map = zeros(nrows,ncols);
    
    %map(nrows,ncols)     % For any element in input_map = 0, mark in white as an empty cell
    % Mark obstacle cells in black
    map(1:10,1) = 2;
    map(2,3) = 2;
    map(3,3) = 2;
    map(1,5) = 2;
    map(10,1:3) = 2;
    
    % Generate linear indices of start and goal nodes
    start_node  = sub2ind(size(map), start_coords(1), start_coords(2));
    goal_node   = sub2ind(size(map), goal_coords(1), goal_coords(2));
    
    map(start_node) =  6;   % mark start node with green
    map(goal_node)  =  5;    % mark goal node with yellow
    
    % Keep track of number of nodes expanded
    
    % Define visited frontier
    Visited_Frontier = start_node; % it includes initially the start node
    
    % Define the frontier stack. Use the CStack function by downloading from: https://www.mathworks.com/matlabcentral/fileexchange/28922-list-queue-stack
    ary = struct('l',0,'d',13,'r',0,'u',12,'pre',0);
    n=0;
    % Main Loop
    while true
        n= n+1;
        % Draw Frontier_node map
        map(Visited_Frontier) = 6;    %start node
        map(goal_node)  = 5;   % goal node
        % make drawMapEveryTime = true if you want to see how the nodes are
        % expanded on the grid
        if (drawMapEveryTime)
            pause(0.5)  % pause to show the mapping steps
            image(1.5,1.5,map)
            grid on; % show grid
            axis image;
            drawnow;
        end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Get the frontier node (top of the stack) without removing it
        Frontier_node = Visited_Frontier; % get frontier node  - stack.top only reads top of stack
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Update map by marking explored node in Frontier by red
        map(Visited_Frontier) = 3;
        if (drawMapEveryTime)
            pause(0.5)
            image(1.5,1.5,map)
            grid on; % show grid
            axis image;
            drawnow;
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         % If frontier node is goal, we're done
       
        [map,ary,fnd] = search(n,ary,input_map,map,Visited_Frontier,goal_node);
        
        if fnd
            disp("WE got Goal");
            disp(goal_node);
            n=n-1;
            while n
                disp(Visited_Frontier);
                map(Visited_Frontier) = 7;
                Visited_Frontier = ary(n).pre;
                n = n-1 ;
                if Visited_Frontier+1 == start_node || Visited_Frontier-1 == start_node || Visited_Frontier+10 == start_node || Visited_Frontier-10 == start_node
                    disp(Visited_Frontier);
                    disp(start_node);
                    map(Visited_Frontier) = 7;
                    map(start_node) = 6 ;
                    map(goal_node) = 5 ;
                    break;
                end
            end
            if (drawMapEveryTime)
                pause(0.5)
                image(1.5,1.5,map)
                grid on; % show grid
                axis image;
                drawnow;
            end
            break;
        elseif (Frontier_node == goal_node)
            disp("WE got Goal");
            break;
        end
        
        
        
        if (drawMapEveryTime)
            pause(0.5)
            image(1.5,1.5,map)
            grid on; % show grid
            axis image;
            drawnow;
        end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Well, the neighbor has passed all the tests and is a valid
        % candidate to be a frontier node

        % Update exploration number of steps
        ary(n).pre = Visited_Frontier;
        
        %% move to up 
        [Visited_Frontier] = U_DFS(ary,n,map);
        if Visited_Frontier == 0
            [Visited_Frontier] = check(ary,n-1,map,2);
        end
        %% move to left
        temp = ary(n).l;
        if Visited_Frontier == 0
            if temp
                if (map(temp)~= 3)
                    Visited_Frontier = temp;
                end
            end
        end
        %% move to down    
        if Visited_Frontier == 0
            [Visited_Frontier] = D_DFS(ary,n,map);
            if Visited_Frontier == 0
                [Visited_Frontier] = check(ary,n-1,map,1);
            end
            if Visited_Frontier == 0
                [Visited_Frontier] = R_DFS(ary,n,map);
            end
        end
        
        
        if Visited_Frontier == 0
            disp("Due to alot running, Agent got dead");
            break;
        end


        neighbor = Visited_Frontier;  % update visited frontier
        route = neighbor;

        % Update the map color
        if (map(neighbor) ~= goal_node) % if it's not the goal
            map(neighbor) = 4;   % mark neighbor with blue (to be explored)
        end

        % Nodes are expanded on the grid
        if (drawMapEveryTime)
            pause(0.5)
            image(1.5,1.5,map)
            grid on; % show grid
            axis image;
            drawnow;
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % We need to break once we push a new neighbor into the stack
            % Do not explore other neighbors
            %break;           
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        
        
end     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
