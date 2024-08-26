function drawMap(map, players, colors) % not used for AI
    drawBox(map.heightMap(1, 1), [1, 1], colors(map.colorMap(1, 1) + 1)); % to int the draw func for matlab
    hold on
    for i = 1:height(map.heightMap) %to iterate for new moves
        for j = 1:width(map.heightMap)
            if(map.heightMap(i, j) == 0)
                continue;
            end
            drawBox(map.heightMap(i, j), [i, j], colors(map.colorMap(i, j) + 1));
        end
    end
    hold off
end
