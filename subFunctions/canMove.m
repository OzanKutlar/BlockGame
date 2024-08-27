% This function checks if a player can make a move

function canMove = canMove(state, playerID) % map = heightmap, players = matrix of locations, playerID = 
    map = state.map;
    players = state.players;
    canMove = false;
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
                    [~,acception] = movePlayer(map, playerID, players, players(playerID, :) + [i, j], false);
                    if acception == true
                        canMove = true;
                        return;
                    end
                end
            end
        end
    end
end