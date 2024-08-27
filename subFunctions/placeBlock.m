function [map, moveAccepted] = placeBlock(playerID, map, location, players, verbose)
    moveAccepted = false;
    if(map.heightMap(location(1), location(2)) == 0)
        % Player tried to place a block in the void.
        if(verbose)
            disp("Invalid Location");
        end
        return;
    end
    if(any(all(players(:, :) == location)))
        if(verbose)
            disp("Location is occupied.");
        end
        return;
    end
    moveAccepted = true;
    map.heightMap(location(1), location(2)) = map.heightMap(location(1), location(2)) + 1;
    map.colorMap(location(1), location(2)) = playerID;
end