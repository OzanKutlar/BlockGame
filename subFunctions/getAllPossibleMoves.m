function moves = getAllPossibleMoves(state, maximizingPlayer)
    map = state.map;
    players = state.players;
    moves = [];
    [mapRows, mapCols] = size(map.heightMap);  % Get the size of the map
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
                    [newPlayers, acception] = movePlayer(map, playerID, players, newPos, false); % false at the end is for verbose
                    if acception == true % If move is accepted add is to possible moves
                        playerMove = newPos;
                        
                        %get possible bock placements for the newPlayers
                        for k = [-1, 0, 1]
                            for l = [-1, 0, 1]
                                if(k == 0 && l == 0)
                                    continue
                                end
                                
                                blockLocation = newPos + [k, l];
                                % Check if blockLocation is within bounds
                                if blockLocation(1) >= 1 && blockLocation(1) <= mapRows && blockLocation(2) >= 1 && blockLocation(2) <= mapCols
                                    [~, moveAccepted] = placeBlock(playerID, map, blockLocation, newPlayers, false);
                                    if moveAccepted == true
                                        moves{end + 1} = [playerMove, blockLocation]; %#ok<AGROW> 
                                    end
                                end
                            end
                        end

                    end
                end
            end
        end
    end
end