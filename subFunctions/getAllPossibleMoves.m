function moves = getAllPossibleMoves(map, players, maximizingPlayer)
    if maximizingPlayer
        playerID = 1;  % Assuming 'red' is the AI maximizing player
    else
        playerID = 2;  % Assuming 'blue' is the opponent
    end

    [mapRows, mapCols] = size(map.heightMap);  % Get the size of the map
    currentPos = players(playerID, :);  % Current position of the player
    for i = [-1, 0, 1]
        for j = [-1, 0, 1]
            if(i == 0 && j == 0)
                continue
            end

            newPos = currentPos + [i, j];
            % Check if newPos is within bounds
            if newPos(1) >= 1 && newPos(1) <= mapRows && newPos(2) >= 1 && newPos(2) <= mapCols
                % Check if the height at the new position is not zero           
                if map.heightMap(newPos(1), newPos(2)) ~= 0
                    [~, acception] = movePlayer(map, playerID, players, newPos, true); % false at the end is for verbose
                    if acception == true 
                        moves
                    end
                end
            end
        end
    end
end