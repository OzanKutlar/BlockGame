clc;
clear;
clf;
map = struct('heightMap', [], 'colorMap', []);
state = struct('heightMap', [], 'colorMap', [], "players", []);
load map
addpath('.\subFunctions');

map.heightMap = heightMap;
map.colorMap = zeros(size(heightMap)); % before feeding to AI use +1 for layer
state.heightMap = heightMap;
state.colormap = map.colorMap;


players = zeros(2, 2); % since 2 people it is 2 by 2, for 3 it is 3 by 2
colors = ["black", "red", "blue"];

% set initial locations
players(1, :) = [1, 4]; % Red
players(2, :) = [4, 1]; % Blue
state.players = players;

% canMove(map, players, 1); % code check for canMove
winner = 0;
currentPlayer = 1;
while false
    disp("Please move your character : ")
    while true
        targetLoc = getInput();
        [players, accepted] = movePlayer(map, currentPlayer, players, targetLoc);
        if(accepted)
            break
        end
    end
    disp("Please place your block : ");
    while true
        targetLoc = getInput();
        [map, accepted] = placeBlock(playerID, map, location, players);
        if(accepted)
            break
        end
    end
    if(currentPlayer == height(players) + 1)
        currentPlayer = 0;
    end
    currentPlayer = currentPlayer + 1;
end
drawMap(map, players, colors);











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
