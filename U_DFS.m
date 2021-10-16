function [Visited_Frontier] = U_DFS(ary,num,map)
    if (ary(num).u ~=0)
        if map(ary(num).u) ~=3
            Visited_Frontier = ary(num).u;
        else
            Visited_Frontier = 0;
        end
    else
        Visited_Frontier = 0;
    end
end