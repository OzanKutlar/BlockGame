% isTerminal is set
% EXAMPLE INPUT: bestMove = alphaBetaPruning(currentState, 3, -Inf, Inf, true);
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

function bestMove = alphaBetaPruningFH(state, depth, alpha, beta, maximizingPlayer)
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

function isTerminal = isTerminalState(state)
    % Logic to check if the game is over
    % Return true if the game is over, otherwise false
    canMove = canMove(map, players, playerID);
    isTerminal = ~canMove;
end

function score = evaluateState(state)
    % Implement a heuristic evaluation function for the current state
    % This function should return a numerical value representing the desirability of the state
    score = 0;
    % Example logic (this should be adapted to your game)
    % score = someEvaluationFunction(state);
end

function children = generateChildren(state, maximizingPlayer)
    % Generate all possible children (next possible states) from the current state
    % This function should return a cell array of states
    children = {};
    % Example logic (this should be adapted to your game)
    % moves = getAllPossibleMoves(state, maximizingPlayer);
    % for each move
    %     newState = applyMove(state, move);
    %     children{end + 1} = newState;
    % end
end

% Example usage:
currentState = initializeGame();  % Function to initialize the game state
bestMove = alphaBetaPruning(currentState, 3, -Inf, Inf, true);  % Find the best move
