function [players, moveAccepted] = movePlayer(map, playerID, players, location, verbose)
    player = players(playerID, :);
    moveAccepted = false;
    movementVector = abs(player - location);
    if(any(movementVector > 1))
        if(verbose)
            disp("Target out of range.");
        end
        return;
    end
    if(all(movementVector == 0))
        if(verbose)
            disp("You have to move.");
        end
        return;
    end
    if(any(all((players(:, :) == location)')))
        if(verbose)
            disp("There is a player at the target");
        end
        return;
    end
    clear movementVector
    if(map.heightMap(location(1), location(2)) == 0)
        if(verbose)
            disp("You cannot move into the void");
        end
        return;
    end
    heightDifference = map.heightMap(location(1), location(2)) - map.heightMap(player(1), player(2));
    if(abs(heightDifference) > 1)
        if(verbose)
            disp("Too high");
        end
        return;
    end
    if(heightDifference == 1)
        if(map.colorMap(location(1), location(2)) ~= playerID && map.colorMap(location(1), location(2)) ~= 0)
            if(verbose)
                disp("Wrong Color");
            end
            return;
        end
    end
    clear heightDifference
    moveAccepted = true;
    players(playerID, :) = location; % the location checked is the new location for the player
end