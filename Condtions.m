function [con] = Condtions(row,col)
    % Check if neighbor is inside the maps
    if (row < 1 || row > 10) % if row outside the map
        con = false;
    elseif (col < 1 || col > 5) % if column outside the map
        con = false;
    else
        con = true;
    end
end