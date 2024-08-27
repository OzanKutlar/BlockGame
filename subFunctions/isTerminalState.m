function isTerminal = isTerminalState(state)
    % Logic to check if the game is over
    % Return true if the game is over, otherwise false
    canMove1 = canMove(state, 1);
    canMove2 = canMove(state, 2);
    isTerminal = ~(canMove1 | canMove2);
end