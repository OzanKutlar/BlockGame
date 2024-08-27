function moveScore = moveScore(state, playerID) 

        %%% Hard coded for two  as it takes diff in heights

    map = state.map;
    players = state.players;
    % playerID = state.currentPlayer;
    moveScore = 0;
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
                    [~, acception] = movePlayer(map, playerID, players, newPos, false); % false at the end is for verbose
                    if acception == true 
                        % the moves importance can be attributed toa couple
                        % things: height difference gain or loss where gain
                        % where being higher is always better so 
                        moveScore = moveScore + 1 * min(map.heightMap(newPos(1), newPos(2)), 4);
                        % moveCount = moveCount + 1;
                    end
                end
            end
        end
    end
end