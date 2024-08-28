function drawMap(map, players, colors, currentPlayer) % not used for AI
    originalView = get(gca, 'View');
    drawBox(map.heightMap(1, 1), [1, 1], colors(map.colorMap(1, 1) + 1)); % to int the draw func for matlab
    hold on
    for i = 1:height(map.heightMap) %to iterate for new moves
        for j = 1:width(map.heightMap)
            if(map.heightMap(i, j) == 0)
                continue;
            end
            drawBox(map.heightMap(i, j), [i, j], colors(map.colorMap(i, j) + 1));
            % drawnow
        end
    end
    for i = 1:height(players)
        scatter3(players(i, 1) + 0.5, players(i, 2) + 0.5, map.heightMap(players(i, 1), players(i, 2)) + 0.1, 150, colors(i + 1), 'filled');
        drawnow
    end
    yticks(1.5:width(map.heightMap) + 0.5);
    yticklabels(char('A' + (1:width(map.heightMap)) - 1)');
    xticks(1.5:height(map.heightMap) + 0.5);
    xticklabels((1:height(map.heightMap)));
    
    % Add these lines to set the view
    azimuth = -35; % Customize these values as needed
    elevation = 80; 
    view(azimuth, elevation); % Apply the view angles
    title(strcat("It is player ", upper(colors(currentPlayer + 1)), "'s turn."))
    hold off
end
