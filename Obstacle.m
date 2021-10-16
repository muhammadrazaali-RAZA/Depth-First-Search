

function [obs] = Obstacle(map,input_map ,row,col)
    % skip if it’s an obstacle
    % for easy handling
    neighbor = sub2ind(size(map),row,col);
    if input_map(neighbor) == true % equivalent to input_map = true, so there is a wall
        obs= false;
    else
        obs= true;
    end
end
