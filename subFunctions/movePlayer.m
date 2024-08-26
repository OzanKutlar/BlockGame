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