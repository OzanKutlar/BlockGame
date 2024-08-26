function moveCount = moveCount(map, players, playerID) % map = heightmap, players = matrix of locations, playerID = 
    moveCount = 0;
    for i = [-1, 0, 1]
        for j = [-1, 0, 1]
            if(i == 0 && j == 0)
                continue
            end
            tempPlayer = players(playerID, :); % 2 by 1 location of player
            players = movePlayer(map, playerID, players, players(playerID, :) + [i, j]);
            if(any(players(playerID, :) ~= tempPlayer)) % any(players current pos ~= players old position)
                moveCount = moveCount + 1;
            end
        end
    end
end