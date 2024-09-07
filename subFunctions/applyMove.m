function newstate = applyMove(state, move)
    % This function is for aBPruning algorithm to apply moves to possible
    % children states
    map = state.map;
    players = state.players;
    newstate = state;
    

    currentPlayer = state.currentPlayer;
    playerTargetLoc = move(1:2);
    playerID = currentPlayer;
    placeBlockLocation = move(3:4);

    [players, ~] = movePlayer(map, currentPlayer, players, playerTargetLoc, false);
    [map, ~] = placeBlock(playerID, map, placeBlockLocation, players, false);
    newstate.map = map;
    newstate.players = players;
    
    if(currentPlayer == height(players))
        currentPlayer = 0;
    end
    currentPlayer = currentPlayer + 1;
    newstate.currentPlayer = currentPlayer;
end