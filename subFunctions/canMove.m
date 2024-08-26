% This function checks if a player can make a move

function canMove = canMove(map, players, playerID) % map = heightmap, players = matrix of locations, playerID = 
    canMove = false;
    for i = [-1, 0, 1]
        for j = [-1, 0, 1]
            if(i == 0 && j == 0)
                continue
            end
            tempPlayer = players(playerID, :); % 2 by 1 location of player
            players = movePlayer(map, playerID, players, players(playerID, :) + [i, j]);
            if(any(players(playerID, :) ~= tempPlayer)) % any(players current pos ~= players old position)
                canMove = true;
                return;
            end
        end
    end
end