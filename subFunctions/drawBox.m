function drawBox(height, location, color)
    % Function to plot a 3D box with specified height and base location.
    % height: Height of the box.
    % location: 2D point (x, y) for the base corner of the box.

    % Extract location coordinates
    x0 = location(1);
    y0 = location(2);

    % Define the coordinates of the box
    x = [x0, x0 + 1, x0 + 1, x0, x0, x0 + 1, x0 + 1, x0]; % X-coordinates of the 8 corners
    y = [y0, y0, y0 + 1, y0 + 1, y0, y0, y0 + 1, y0 + 1]; % Y-coordinates of the 8 corners
    z = [height - 1, height - 1, height - 1, height - 1, height, height, height, height]; % Z-coordinates of the 8 corners

    % Create a figure and scatter the points
    % scatter3(x, y, z, 'filled');

    % Draw lines connecting the corners to form the edges of the box
    % Define the edges of the box using indices into the corners
    edges = [
        % Bottom face
        5 6; 6 7; 7 8; 8 5; % Top face
        1 5; 2 6; 3 7; 4 8  % Vertical edges
    ];

    % Plot each edge
    for i = 1:size(edges, 1)
        p = plot3(x(edges(i, :)), y(edges(i, :)), z(edges(i, :)), 'k-', 'LineWidth', 2);
        p.Color = color;
    end

    zlabel('Height');

    % Set axis limits for better visualization
    axis([x0-0.5, x0+1.5, y0-0.5, y0+1.5, 0, height+0.5]);
    
    % Add a grid for better visualization
    grid on;

    % Set the aspect ratio to be equal
    axis equal;
end
