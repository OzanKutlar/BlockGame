function moveScore = moveScoreV1(state, playerID) 

        %%% Hard coded for two  as it takes diff in heights

    map = state.map;
    players = state.players;
    % playerID = state.currentPlayer;
    [mapRows, mapCols] = size(map.heightMap);  % Get the size of the map
    currentPos = players(playerID, :);  % Current position of the player
    currentPosHeight = map.heightMap(currentPos(1), currentPos(2));
    moveScore = currentPosHeight;
    otherPlayerPos = players(3 - playerID, :);
    otherPlayerHeight = map.heightMap(otherPlayerPos(1), otherPlayerPos(2));

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

                        newPosHeight = map.heightMap(newPos(1), newPos(2));

                        % if there is a valid move: + 1

                        % the moves importance can be attributed to a couple
                        % things: height difference gain or loss where being 
                        % higher is always better: ot height but height
                        % diff important!
                        heightDiff = newPosHeight - 1*otherPlayerHeight;
                        heightScore = -((heightDiff - 2).^2)./2 + heightDiff./2 + 3;

                        
                        moveScore = moveScore + 2 + 0.2 * heightScore;
                        % moveCount = moveCount + 1;
                    end
                end
            end
        end
    end
end