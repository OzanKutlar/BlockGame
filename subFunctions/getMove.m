function location = getMove(state, isAI)
    if(isAI)
        location = getAIMove(state);
        return;
    end
    while true
        moved = char(input("Please select a square to move your character to (Ex : B1) : ", 's'));
        moved = upper(moved);
        disp(strcat("You selected the square : ", moved));
        moved = char(moved); % Convert string to char array
        location = [moved(2) - '0', (moved(1) - 'A') + 1];
        if(any(location < 1))
            disp("You cannot go below the map limits.");
            continue;
        end
        if(any(location > size(state.map.heightMap)))
            disp("You cannot go above the map limits.")
            continue;
        end
        return;
    end


end