
% EXAMPLE INPUT: [bestMove, bestValue] = aBPruningFS(state, 1, -Inf, Inf, true);
function [bestState, bestValue] = aBPruningFS(state, depth, alpha, beta, maximizingPlayer) % Fail Soft alpha beta pruning algorithm
    % Check if the game is over or if we've reached the maximum depth
    if depth == 0 || isTerminalState(state)
        bestValue = evaluateState(state);
        bestState = state;  % No move to make since it's a terminal state or depth limit reached
        % disp("game is over or if we've reached the maximum depth")
        return;
    end
    
    bestState = [];  % Initialize bestMove as an empty array

    if maximizingPlayer
        bestValue = -Inf;
        children = generateChildren(state, maximizingPlayer);
        removedChildren = 0;
        for i = 1:length(children)
            i = i - removedChildren;
            if(isempty(children(i)))
                children(i) = [];
                removedChildren = removedChildren + 1;
                continue;
            end

            [~, eval] = aBPruningFS(children(i), depth - 1, alpha, beta, false);
            children(i).score = eval;
            if eval >= bestValue

                if(eval ~= bestValue || 1 < 0.5)
                    bestValue = eval;
                    bestState = children(i);
                end
            end
            alpha = max(alpha, eval);
            if beta <= alpha
                break; % Beta cut-off
            end
        end
    else
        bestValue = Inf;
        children = generateChildren(state, maximizingPlayer);
        for i = 1:length(children)
            [~, eval] = aBPruningFS(children(i), depth - 1, alpha, beta, true);
            if eval < bestValue
                bestValue = eval;
                bestState = children(i);
            end
            beta = min(beta, eval);
            if beta <= alpha
                break; % Alpha cut-off
            end
        end
    end
end

% function bestMove = alphaBetaPruningFH(depth, alpha, beta, maximizingPlayer) %#ok<DEFNU> 
%     % Check if the game is over or if we've reached the maximum depth
%     if depth == 0 || isTerminalState(state)
%         bestMove = evaluateState(state);
%         return;
%     end
% 
%     if maximizingPlayer
%         maxEval = -Inf;
%         children = generateChildren(state, maximizingPlayer);
%         bestMove = [];
%         for i = 1:length(children)
%             eval = alphaBetaPruning(children(i), depth - 1, alpha, beta, false);
%             if eval > maxEval
%                 maxEval = eval;
%                 bestMove = children(i);
%             end
%             alpha = max(alpha, eval);
%             if beta <= alpha
%                 break; % Beta cut-off
%             end
%         end
%     else
%         minEval = Inf;
%         children = generateChildren(state, maximizingPlayer);
%         bestMove = [];
%         for i = 1:length(children)
%             eval = alphaBetaPruning(children(i), depth - 1, alpha, beta, true);
%             if eval < minEval
%                 minEval = eval;
%                 bestMove = children(i);
%             end
%             beta = min(beta, eval);
%             if beta <= alpha
%                 break; % Alpha cut-off
%             end
%         end
%     end
% end


function score = evaluateState(state)
    map = state.map;
    players = state.players;
    playerID = state.playerTurn;
    % Implement a heuristic evaluation function for the current state
    % This function should return a numerical value representing the desirability of the state
    % score = 0;
    moveScoreOwn = moveScoreV1(state, playerID) * (height(players) - 1);
    moveCountOwn = moveCount(state, playerID);
    moveScoreOthers = 0;
    killed = 0;
    for i = 1:height(players)
        if(i == playerID)
            continue;
        end
        otherPlayerScore = otherPlayerMoveScoreV1(state, i);
        otherPlayerMoveCount = moveCount(state, i);
        if(otherPlayerMoveCount == 0)
            killed = killed + 1;
        end
        moveScoreOthers = moveScoreOthers + otherPlayerScore;
    end
    score = moveScoreOwn - moveScoreOthers;
    if(killed ~= 0)
        score = killed + Inf; % very high since 1 kill enough for the game to end
    end
    if moveCountOwn == 0
        score = -Inf;
    end
end

function children = generateChildren(state, playTurn)
    % Generate all possible children (next possible states) from the current state
    % This function should return a cell array of states
    playerID = state.currentPlayer;
    % Determine which player's turn it is
    % made it so that there are actually four moves each round for the
    % algorithm to able to change the order if need be in the future
    if playTurn == true
        player = 1;  % Assuming 'red' is the AI maximizing player
    else
        player = 2;
    end
    
    % Get all possible legal moves for the current player
    moves = getAllPossibleMoves(state, player);

    children(height(moves) + 1) = state;

    % Loop through each possible move
    for i = 1:height(moves)
        % Apply the move to the current state to generate a new state
        newState = applyMove(state, moves(i, :));
        
        % Add the new state to the list of children
        children(i) = newState;
    end
end

