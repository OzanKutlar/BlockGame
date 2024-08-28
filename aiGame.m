disp("Setting player to be starter");
if(AIGoesFirst)
    currentPlayer = AIPlayerID;
else
    currentPlayer = mod(AIPlayerID + 1, height(players)) + 1; % Select the player after the AI to start
end
while true
    %%% Ozan bunu fonksiyon yapabilir misin getPlayeMove(currentState) gibi
    % böylece if AI == 1 || 2 başka loopa girmesini sağlarız
    %yukarıda number of AI players'ı göstermek istedim.

    state.map = map;
    state.players = players;
    
    drawMap(map, players, colors, currentPlayer);
    
    if(~canMove(state, currentPlayer))
        disp(strcat("Player ", upper(colors(currentPlayer + 1)), " has died!"));
        players(currentPlayer, :) = [];
        colors(currentPlayer + 1) = [];
        if(currentPlayer == height(players) + 1)
            currentPlayer = 1;
        end
    end
    
    if(height(players) == 1)
        disp("Game Over!");
        disp(strcat("Player ", upper(colors(currentPlayer + 1)), " has won!"));
        return;
    end
    
    if currentPlayer == AIPlayerID % check if it is AI move
        [bestState, bestValue] = aBPruningFS(state, AIDepth, -Inf, Inf, currentPlayer);
        disp(bestValue)
        if bestValue == -Inf
            disp("I know imma die soon")
        end
        playerTargetLoc = bestState.players(currentPlayer, :);

        [row, col] = find(map.heightMap - bestState.map.heightMap);
        blockTargetLoc = [row, col];
        

        [players, ~] = movePlayer(map, currentPlayer, players, playerTargetLoc, true);
        [map, ~] = placeBlock(currentPlayer, map, blockTargetLoc, players, true);
        state.map = map;
        state.players = players;
        
    else % Human move
        while true
            targetLoc = getMove(state, false);
            [players, accepted] = movePlayer(map, currentPlayer, players, targetLoc, true);
            if(accepted)
                break
            end
        end
    
        drawMap(map, players, colors, currentPlayer);
    
        while true
            targetLoc = getBlockPlacement(state, false);
            [map, accepted] = placeBlock(currentPlayer, map, targetLoc, players, true);
            if(accepted)
                break
            end
        end
    end
    if(currentPlayer == height(players))
        currentPlayer = 0;
    end
    currentPlayer = currentPlayer + 1;
end












function playGame()
    canMove = canMove(map, players, playerID);
    while canMove(map, players, playerID)
        % AI's turn
        bestMove = aBPruningFS(currentState, 3, -Inf, Inf, true);
        currentState = applyMove(currentState, bestMove);  % Apply the AI's move
        
        if isTerminalState(currentState)
            break;
        end
        
        % Opponent's turn (this could be a human player or another AI)
        % For simplicity, assume opponentMove is a function that gets the opponent's move
        opponentMove = getOpponentMove(currentState);
        currentState = applyMove(currentState, opponentMove);
    end
    
    disp('Game Over');
    % Display the final result or winner
end
