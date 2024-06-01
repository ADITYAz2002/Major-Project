% V2X MATLAB Project - Moving Car Simulation with Traffic Signal Color Change

% Simulation parameters
road_length = 60;           % Total road length
car_speed = 10;             % Car speed (in meters per second)
obstruction_position = 50;  % Position of the obstruction
total_time = road_length-10/car_speed;            % Total simulation time (in seconds)
time_step = 0.1;            % Time step for simulation (in seconds)
car_position = 0;           % Initial position of the car
signal_position = 30;       % Position of the traffic signal



% Create the figure
figure_handle = figure;

% Initialize traffic signal color and car color
signal_color = 'green';
car_color = 'blue';

% Simulation loop
for t = 1:round(total_time / time_step)
    % Update car position
    car_position = min(car_position + car_speed * time_step, road_length);
    
    % Check if the car is within 5m range of the obstruction
    if abs(car_position - obstruction_position) <= 5
        disp('Obstruction detected! Car stops.');
        car_speed = 0; % Car stops
        signal_color = 'red'; % Change traffic signal color to red
    end
    
    % Check if the car has reached the end of the road
    if car_position >= road_length
        disp('End of road reached. Simulation terminated.');
        break;
    end
    
    % Plot results dynamically
    plot(car_position, 0, 'o', 'MarkerSize', 10, 'MarkerFaceColor', car_color); % Car
    hold on;
    
    % Plot signal and obstruction markers
    plot(signal_position, 0, 'o', 'MarkerSize', 10, 'MarkerFaceColor', signal_color); % Traffic Signal
    plot(obstruction_position, 0, 'xr', 'MarkerSize', 10, 'LineWidth', 2); % Obstruction
    
    % Adjust axis limits
    xlim([0 road_length]);
    
    xlabel('Position (m)');
    title('Moving Car Simulation with Signal Color Change');
    legend('Car', 'Traffic Signal', 'Obstruction');
    grid on;
    
    drawnow; % Update the figure
    
    % Pause to control the animation speed
    pause(time_step);
    
    % Clear previous car and signal markers
    if t > 1
        delete(findobj(gca, 'Type', 'line', 'Marker', 'o'));
    end
end
