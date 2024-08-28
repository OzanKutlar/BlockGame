function moves = getAllPossibleMoves(state, playerID)
    map = state.map;
    players = state.players;
    playerMoves = [];
    blockMoves = [];
    [mapRows, mapCols] = size(map.heightMap);  % Get the size of the map

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
                        playerMoves(end + 1,:) = newPos;
                    end
                end
            end
        end
    end
    %get possible bock placements for the newPlayers
    for k = [-2, -1, 0, 1, 2]
        for l = [-2, -1, 0, 1, 2]
            if(k == 0 && l == 0)
                continue
            end
            
            blockLocation = currentPos + [k, l];
            % Check if blockLocation is within bounds
            if blockLocation(1) >= 1 && blockLocation(1) <= mapRows && blockLocation(2) >= 1 && blockLocation(2) <= mapCols
                [~, moveAccepted] = placeBlock(playerID, map, blockLocation, newPlayers, false);
                if moveAccepted == true
                    blockMoves(end + 1,:) = blockLocation; %#ok<AGROW> 
                end
            end
        end
    end
    
    result = zeros(height(blockMoves) * height(playerMoves), 4); % Initialize an empty cell array for the result
    index = 1;   % Initialize an index for the result
    
    for i = 1:length(height(blockMoves))
        for j = 1:length(height(playerMoves))
            result(index, :) = horzcat(playerMoves(j, :), blockMoves(i, :)); % Combine elements from list1 and list2
            index = index + 1; % Increment the index
        end
    end
    
    disp("moves")

end