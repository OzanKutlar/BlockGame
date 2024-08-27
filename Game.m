clc;
clear;
clf;
map = struct('heightMap', [], 'colorMap', []);
state = struct("map", [], "players", [], "turn", [], "blocksLeft", []);
load map
addpath('.\subFunctions');

map.heightMap = heightMap;
map.colorMap = zeros(size(heightMap)); % before feeding to AI use +1 for layer

% State structure holds the information of the game
% Such as player pos. color and height maps, blocks left, turn.
% The State is fundamental for editing during foresight for AI
state.map = map;
state.blocksLeft = zeros(2,2); %for each player we have their own blocks and black blocks
state.blocksLeft(1, :) = [15, 5]; % 1. column is the colored blocks 2. column is the black blocks
state.blocksLeft(2, :) = [15, 5];


players = zeros(2, 2); % since 2 people it is 2 by 2, for 3 it is 3 by 2
colors = ["black", "red", "blue"];

% set initial locations
players(1, :) = [1, 4]; % Red
players(2, :) = [4, 1]; % Blue
state.players = players;

% canMove(map, players, 1); % code check for canMove
winner = 0;
currentPlayer = 1;
state.turn = "redMove";
% The turns are the following:
Turns = ["redMove", "redPlaceBlock", "blueMove", "bluePlaceBlock"];
% drawMap(map, players, colors);
% return


while true
    
    %%% Ozan bunu fonksiyon yapabilir misin getPlayeMove(currentState) gibi
    % böylece if AI == 1 || 2 başka loopa girmesini sağlarız
    %yukarıda number of AI players'ı göstermek istedim.
    drawMap(map, players, colors);
    title(strcat("It is player ", colors(currentPlayer + 1), "'s turn."))
    % canMove(state, currentPlayer);

    while true
        targetLoc = getMove(state, false);
        [players, accepted] = movePlayer(map, currentPlayer, players, targetLoc, true);
        if(accepted)
            break
        end
    end

    drawMap(map, players, colors);
    title(strcat("It is player ", colors(currentPlayer + 1), "'s turn."))

    while true
        targetLoc = getBlockPlacement(state, false);
        [map, accepted] = placeBlock(currentPlayer, map, targetLoc, players, true);
        if(accepted)
            break
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
