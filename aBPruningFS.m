
% EXAMPLE INPUT: bestMove = aBPruningFS(currentState, 3, -Inf, Inf, true);
function bestValue = aBPruningFS(state, depth, alpha, beta, maximizingPlayer) % Fail Soft alpha beta pruning algorithm
    % Check if the game is over or if we've reached the maximum depth
    if depth == 0 || isTerminalState(state)
        bestValue = evaluateState(state);
        return;
    end
    
    if maximizingPlayer
        bestValue = -Inf;
        children = generateChildren(state, maximizingPlayer);
        for i = 1:length(children)
            eval = alphaBetaPruning(children{i}, depth - 1, alpha, beta, false);
            bestValue = max(bestValue, eval);
            alpha = max(alpha, eval);
            if beta <= alpha
                break; % Beta cut-off
            end
        end
    else
        bestValue = Inf;
        children = generateChildren(state, maximizingPlayer);
        for i = 1:length(children)
            eval = alphaBetaPruning(children{i}, depth - 1, alpha, beta, true);
            bestValue = min(bestValue, eval);
            beta = min(beta, eval);
            if beta <= alpha
                break; % Alpha cut-off
            end
        end
    end
end

function bestMove = alphaBetaPruningFH(depth, alpha, beta, maximizingPlayer) %#ok<DEFNU> 
    % Check if the game is over or if we've reached the maximum depth
    if depth == 0 || isTerminalState(state)
        bestMove = evaluateState(state);
        return;
    end

    if maximizingPlayer
        maxEval = -Inf;
        children = generateChildren(state, maximizingPlayer);
        bestMove = [];
        for i = 1:length(children)
            eval = alphaBetaPruning(children{i}, depth - 1, alpha, beta, false);
            if eval > maxEval
                maxEval = eval;
                bestMove = children{i};
            end
            alpha = max(alpha, eval);
            if beta <= alpha
                break; % Beta cut-off
            end
        end
    else
        minEval = Inf;
        children = generateChildren(state, maximizingPlayer);
        bestMove = [];
        for i = 1:length(children)
            eval = alphaBetaPruning(children{i}, depth - 1, alpha, beta, true);
            if eval < minEval
                minEval = eval;
                bestMove = children{i};
            end
            beta = min(beta, eval);
            if beta <= alpha
                break; % Alpha cut-off
            end
        end
    end
end


function score = evaluateState(state)
    map = state.map;
    players = state.players;
    % Implement a heuristic evaluation function for the current state
    % This function should return a numerical value representing the desirability of the state
    % score = 0;
    moveCount1 = moveCount(map, players, 1);
    moveCount2 = moveCount(map, players, 2);
    score = moveCount1 - moveCount2;

end

function children = generateChildren(state, playTurn)
    % Generate all possible children (next possible states) from the current state
    % This function should return a cell array of states
    
    children = {};  % Initialize the cell array to hold child states
    
    % Determine which player's turn it is
    % made it so that there are actually four moves each round for the
    % algorithm to able to change the order if need be in the future
    if playTurn == "redMove"
        player = 1;  % Assuming 'red' is the AI maximizing player
    elseif playTurn == "redPlaceBlock"
    
    elseif playTurn == "bluePlaceBlock"
    else
        player = 'blueMove';  % Assuming 'blue' is the opponent
    end
    
    % Get all possible legal moves for the current player
    moves = getAllPossibleMoves(state, player);
    
    % Loop through each possible move
    for i = 1:length(moves)
        % Apply the move to the current state to generate a new state
        newState = applyMove(state, moves{i});
        
        % Add the new state to the list of children
        children{end + 1} = newState; %#ok<AGROW> 
    end
end


% Example usage:
currentState = initializeGame();  % Function to initialize the game state
bestMove = alphaBetaPruning(currentState, 3, -Inf, Inf, true);  % Find the best move
