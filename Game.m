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
winner = 0;
currentPlayer = 1;
while true
    disp("Please move your character : ")
    while true
        targetLoc = getInput();
        [players, accepted] = movePlayer(map, currentPlayer, players, targetLoc);
        if(accepted)
            break
        end
    end
    disp("Please place your block : ");

    
end
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


function [players, moveAccepted] = movePlayer(map, playerID, players, location, displayMsg)
    player = players(playerID, :);
    moveAccepted = false;
    movementVector = abs(player - location);
    if(any(movementVector > 1))
        if(displayMsg)
            disp("Target out of range.");
        end
        return;
    end
    if(all(movementVector == 0))
        if(displayMsg)
            disp("You have to move.");
        end
        return;
    end
    if(any(all(players(:, :) == location)))
        if(displayMsg)
            disp("There is a player at the target");
        end
        return;
    end
    clear movementVector
    heightDifference = map.heightMap(location(1), location(2)) - map.heightMap(player(1), player(2));
    if(abs(heightDifference) > 1)
        if(displayMsg)
            disp("Too high");
        end
        return;
    end
    if(heightDifference == 1)
        if(map.colorMap(location(1), location(2)) ~= playerID && map.colorMap(location(1), location(2)) ~= 0)
            if(displayMsg)
                disp("Wrong Color");
            end
            return;
        end
    end
    clear heightDifference
    moveAccepted = true;
    players(playerID, :) = location; % the location checked is the new location for the player
end

function [map, moveAccepted] = placeBlock(playerID, map, location, players)
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