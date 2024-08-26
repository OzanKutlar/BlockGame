function moveCount = moveCount(map, players, playerID) % map = heightmap, players = matrix of locations, playerID = 
    moveCount = 0;
    [mapRows, mapCols] = size(map.heightMap);  % Get the size of the map
    currentPos = players(playerID, :);  % Current position of the player
    disp([mapRows, mapCols])
    for i = [-1, 0, 1]
        for j = [-1, 0, 1]
            if(i == 0 && j == 0)
                continue
            end

            newPos = currentPos + [i, j];
            % Check if newPos is within bounds
            if newPos(1) >= 1 && newPos(1) <= mapRows && newPos(2) >= 1 && newPos(2) <= mapCols
                % Check if the height at the new position is not zero
                disp(map.heightMap(newPos(1), newPos(2)))
                if map.heightMap(newPos(1), newPos(2)) ~= 0
                    disp("height not 0")
                    [~, acception] = movePlayer(map, playerID, players, newPos, true); % false at the end is for verbose
                    if acception == true 
                        moveCount = moveCount + 1;
                    end
                end
            end
        end
    end
end