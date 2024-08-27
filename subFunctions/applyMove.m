function newstate = applyMove(state, move)
    % This function is for aBPruning algorithm to apply moves to possible
    % children states
    map = state.map;
    players = state.players;
    newstate = state;

    movePlayer = move{1};
    placeBlock = move{2};
    currentPlayer = ;
    playerTargetLoc = ;
    playerID = ;
    placeBlockLocation = ;

    [players, ~] = movePlayer(map, currentPlayer, players, playerTargetLoc);
    [map, ~] = placeBlock(playerID, map, placeBlockLocation, players);
    newstate.map = map;
    newstate.players = players;


end