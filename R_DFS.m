
function [Visited_Frontier] = R_DFS(ary,num,map)
    temp = ary(num).r ;
    if temp ~= 0
        if map(temp) ~=3
            Visited_Frontier = ary(num).r;
        end
    else
        Visited_Frontier = 0;
    end
end
