clc;
clear;
clf;
map = struct('heightMap', [], 'colorMap', []);
load map

map.heightMap = heightMap;
map.colorMap = zeros(size(heightMap)); % before feeding to AI use +1 for layer



players = zeros(2, 2); % since 2 people it is 2 by 2, for 3 it is 3 by 2
colors = ["black", "red", "blue"];

players(1, :) = [4, 7];
players(2, :) = [7, 4]; % int locations set

% canMove(map, players, 1); % code check for canMove
drawMap(map, players, colors);


function drawMap(map, players, colors) % not used for AI
    drawBox(map.heightMap(1, 1), [1, 1], colors(map.colorMap(1, 1) + 1)); % to int the draw func for matlab
    hold on
    for i = 1:height(map.heightMap) %to iterate for new moves
        for j = 1:width(map.heightMap)
            if(map.heightMap(i, j) == 0)
                continue;
            end
            drawBox(map.heightMap(i, j), [i, j], colors(map.colorMap(i, j) + 1));
        end
    end
    hold off
end


function players = movePlayer(map, playerID, players, location)
    player = players(playerID, :);
    movementVector = abs(player - location);
    if(any(movementVector > 1))
        disp("Target out of range.");
        return;
    end
    if(all(movementVector == 0))
        disp("You have to move.");
        return;
    end
    if(any(all(players(:, :) == location)))
        disp("There is a player at the target");
        return;
    end
    clear movementVector
    heightDifference = map.heightMap(location(1), location(2)) - map.heightMap(player(1), player(2));
    if(abs(heightDifference) > 1)
        disp("Too high");
        return;
    end
    if(heightDifference == 1)
        if(map.colorMap(location(1), location(2)) ~= playerID && map.colorMap(location(1), location(2)) ~= 0)
            disp("Wrong Color");
            return;
        end
    end
    clear heightDifference
    players(playerID, :) = location; % the location checked is the new location for the player
end

function map = placeBlock(playerID, map, location, players)
    if(map.heightMap(location(1), location(2)) == 0)
        % Player tried to place a block in the void.
        disp("Invalid Location");
        return;
    end
    if(any(any(players(:, :) == location)))
        disp("Location is occupied.");
        return;
    end
    map.heightMap(location(1), location(2)) = map.heightMap(location(1), location(2)) + 1;
    map.colorMap(location(1), location(2)) = playerID;
    disp("Block Placed Successfully.");
end

function playGame()
    canMove = canMove(map, players, playerID)
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
