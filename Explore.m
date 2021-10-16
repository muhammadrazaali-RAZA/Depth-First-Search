
function [exp] = Explore(map,row,col)
    % Check if not explored before
    % Check if neighbor is in Visited_Frontier
    % if yes, skip the neighbor
    neighbor = sub2ind(size(map),row,col);
    if(map(neighbor) == 3)
        exp = false;
    else
        exp = true;
    end
end
