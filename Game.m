clc;
clear;
clf;
map = struct('heightMap', [], 'colorMap', []);
state = struct("map", [], "players", [], "currentPlayer", [], "blocksLeft", []);
load map
addpath('.\subFunctions');

map.heightMap = heightMap;
map.colorMap = zeros(size(heightMap)); % before feeding to AI use +1 for layer

% State structure holds the information of the game
% Such as player pos. color and height maps, blocks left, turn.
% The State is fundamental for editing during foresight for AI
AIDepth = 4;
state.map = map;
state.blocksLeft = zeros(2,2); %for each player we have their own blocks and black blocks
state.blocksLeft(1, :) = [15, 5]; % 1. column is the colored blocks 2. column is the black blocks
state.blocksLeft(2, :) = [15, 5];


players = zeros(2, 2); % since 2 people it is 2 by 2, for 3 it is 3 by 2
colors = ["black", "red", "blue"];

% set initial locations
players(1, :) = [1, 4]; % Red % Assuming 'red' is the AI maximizing player
players(2, :) = [4, 1]; % Blue
state.players = players;

% canMove(map, players, 1); % code check for canMove
winner = 0;
currentPlayer = 1;
state.currentPlayer = 1; 

% drawMap(map, players, colors);
% return


drawMap(map, players, colors, currentPlayer);

x = input("Play against AI? Y/N [Y] : ", 's');
if(isempty(x))
    x = "Y";
end
if(x == "Y")
    aiGame;
end
if(x == "N")
    aiOnlyGame;
end

