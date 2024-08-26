% This function checks if a player can make a move

function canMove = canMove(map, players, playerID) % map = heightmap, players = matrix of locations, playerID = 
    canMove = false;
    for i = [-1, 0, 1]
        for j = [-1, 0, 1]
            if(i == 0 && j == 0)
                continue
            end
            [~,acception] = movePlayer(map, playerID, players, players(playerID, :) + [i, j]);
            if acception == true
                canMove = true;
                return;
            end
        end
    end
end