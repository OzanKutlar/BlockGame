% disp("Setting player to be starter");
currentPlayer = 1;
while true
    %%% Ozan bunu fonksiyon yapabilir misin getPlayeMove(currentState) gibi
    % böylece if AI == 1 || 2 başka loopa girmesini sağlarız
    %yukarıda number of AI players'ı göstermek istedim.

    state.map = map;
    state.players = players;
    state.currentPlayer = currentPlayer;
    
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
    [bestMove, bestValue] = aBPruningFS(state, 3, -Inf, Inf, true);
    playerTargetLoc = bestMove.players(currentPlayer, :);

    [row, col] = find(map.heightMap - bestMove.map.heightMap);
    blockTargetLoc = [row, col];
    [players, ~] = movePlayer(map, currentPlayer, players, playerTargetLoc, true);
    [map, ~] = placeBlock(currentPlayer, map, blockTargetLoc, players, true);
    
    drawMap(map, players, colors, currentPlayer);

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
