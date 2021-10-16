function [map,ary,fnd] = search(n,ary,input_map,map,node,goal_node)

    % Expand node by exploring children nodes (neighbors)

    % Compute row, column coordinates of Frontier_node node
    [i,j] = ind2sub(size(map),node);

    % Visit each neighbor of the Frontier_node node and update the map,
    % stack. A neighbor is not valid if already explored or if it's a
    % wall. If current node cannot be expanded into new nodes, then pop
    % out from stack

    % Visit every neighbor of the Frontier_node node
    ary(n).pre = 0;
    fnd = 0;
    
    % up
    row = i-1; col = j;
    [con] = Condtions(row,col);
    if con
        [obs] = Obstacle(map,input_map ,row,col);
    else
        obs = false;
    end
    if con && obs
        [exp] = Explore(map,row,col);
    else
        exp = false;
    end
    if con && obs && exp
        ary(n).u = sub2ind(size(map),row,col);
        map(ary(n).u) = 4;
        if ary(n).u == goal_node
            fnd = 1;
        end
    else
        ary(n).u = 0;
    end
    
    % Left (Start with left before right)
    [i,j] = ind2sub(size(map),node);
    row  = i; col = j-1;
    [con] = Condtions(row,col);
    if con
        [obs] = Obstacle(map,input_map ,row,col);
    else
        obs = false;
    end
    if con && obs
        [exp] = Explore(map,row,col);
    else
        exp = false;
    end
    if con && obs && exp
        ary(n).l = sub2ind(size(map),row,col);
        map(ary(n).l) = 4;
        if ary(n).l == goal_node
            fnd = 1;
        end
    else
        ary(n).l = 0;
    end
    
    
    % Right
    [i,j] = ind2sub(size(map),node);
    row = i; col  = j+1;
    [con] = Condtions(row,col);
    if con
        [obs] = Obstacle(map,input_map ,row,col);
    else
        obs = false;
    end
    if con && obs
        [exp] = Explore(map,row,col);
    else
        exp = false;
    end
    if con && obs && exp
        ary(n).r = sub2ind(size(map),row,col);
        map(ary(n).r) = 4;
        if ary(n).r == goal_node
            fnd = 1;
        end
    else
        ary(n).r = 0;
    end
    
    
    % down
    [i,j] = ind2sub(size(map),node);
    row = i+1; col = j;
    [con] = Condtions(row,col);
    if con
        [obs] = Obstacle(map,input_map ,row,col);
    else
        obs = false;
    end
    if con && obs
        [exp] = Explore(map,row,col);
    else
        exp = false;
    end
    if con && obs && exp
        ary(n).d = sub2ind(size(map),row,col);
        map(ary(n).d) = 4;
        if ary(n).d == goal_node
            fnd = 1;
        end
    else
        ary(n).d = 0;
    end
    
end

