function newstate = applyMove(state, move)
    % This function is for aBPruning algorithm to apply moves to possible
    % children states
    map = state.map;
    players = state.players;
    newstate = state;

    currentPlayer = state.currentPlayer;
    playerTargetLoc = move{1, :};
    playerID = currentPlayer;
    placeBlockLocation = move{2, :};

    [players, ~] = movePlayer(map, currentPlayer, players, playerTargetLoc);
    [map, ~] = placeBlock(playerID, map, placeBlockLocation, players);
    newstate.map = map;
    newstate.players = players;


end