
function [Visited_Frontier] = D_DFS(ary,num,map)
    %DFS-Algo which Rules Used on Searching
    Visited_Frontier = 0;
    temp = ary(num).d ;
    if temp ~= 0
        if map(temp) ~=3
            Visited_Frontier = ary(num).d;
        end
    else
        Visited_Frontier = 0;
    end
end

