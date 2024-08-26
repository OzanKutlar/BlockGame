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