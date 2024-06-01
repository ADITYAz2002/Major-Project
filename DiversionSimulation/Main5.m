% V2X MATLAB Project - Moving Car Simulation with Traffic Signal Color Change

% Simulation parameters
road_length = 65;           % Total road length
car_speed = 10;             % Car speed (in meters per second)
obstruction_position = 60;  % Position of the obstruction
total_time = 1.5 * road_length / car_speed; % Total simulation time (in seconds) with an additional second
time_step = 0.1;            % Time step for simulation (in seconds)
car_position = 0;           % Initial position of the car
signal_position = 30;       % Position of the traffic signal
range = 4;                  % Range of detection

% Create the figure
figure_handle = figure;

% Initialize traffic signal color and car color
signal_color = 'green';
car_color = 'blue';

% Flags to check if obstruction is detected and if the second car should start
obstruction_detected = false;
second_car_started = false;
second_car_stopped_message_displayed = false; % Flag to track message display

% Initialize the second car
second_car_position = 0;
second_car_color = 'yellow'; % Color of the second car
second_car_speed_x = 10;     % Speed of the second car in x-axis
second_car_speed_y = 5;      % Speed of the second car in y-axis

% Simulation loop
for t = 1:round(total_time / time_step)
    % Update car position
    car_position = min(car_position + car_speed * time_step, road_length);
    
    % Check if the car is within range of the obstruction
    if abs(car_position - obstruction_position) <= range && ~obstruction_detected
        disp('Obstruction detected! First Car stops.');
        car_speed = 0; % Car stops
        signal_color = 'red'; % Change traffic signal color to red
        obstruction_detected = true; % Set the flag to true
        second_car_started = true; % Start the second car
    elseif car_position >= signal_position - range && car_position < signal_position && ~strcmp(signal_color, 'green')
        disp('Signal is not green! First Car stops.');
        car_speed = 0; % Car stops
    elseif obstruction_detected
        disp('Signal: Divert'); % Display diversion message
    else
        disp(['Signal: ' signal_color]); % Display signal color when obstruction is not detected
    end
    
    % Update second car position if it has started
    if second_car_started
        if signal_color == "red" && abs(second_car_position - signal_position) <= range && ~second_car_stopped_message_displayed
            % Second car detects red signal and stops moving in x-axis
            disp('Second car stops at the red signal.');
            second_car_stopped_message_displayed = true; % Set the flag to true
            second_car_speed_x = 0; % Second car stops in x-axis
        end
        
        % Move the second car in x-axis if it hasn't stopped
        if second_car_speed_x > 0
            second_car_position = min(second_car_position + second_car_speed_x * time_step, road_length);
        end
        
        % Move the second car in y-axis if it has stopped in x-axis
        if second_car_speed_x == 0
            second_car_position = min(second_car_position + second_car_speed_y * time_step, signal_position);
        end
    end
    
    % Check if the car has reached the end of the road
    if car_position >= road_length && ~second_car_started
        disp('End of road reached. Simulation terminated.');
        break;
    elseif car_position >= road_length + 1 && second_car_started
        disp('Simulation ended 1 second after the second car has stopped.');
        break;
    end
    
    % Plot results dynamically
    plot(car_position, 0, 'o', 'MarkerSize', 10, 'MarkerFaceColor', car_color); % Car
    hold on;
    
    % Plot signal and obstruction markers
    plot(signal_position, 0, 'o', 'MarkerSize', 10, 'MarkerFaceColor', signal_color); % Traffic Signal
    plot(obstruction_position, 0, 'xr', 'MarkerSize', 10, 'LineWidth', 2); % Obstruction
    
    % Plot second car if it has started
    if second_car_started
        plot(0, second_car_position, 'o', 'MarkerSize', 10, 'MarkerFaceColor', second_car_color); % Second Car
    end
    
    % Adjust axis limits
    xlim([0 road_length]);
    ylim([-road_length, road_length]);
    
    xlabel('Position on the road (m)'); % Label for the x-axis
    ylabel('Position on diverted road (m)'); % Label for the y-axis
    
    title('Moving Car Simulation with Traffic Signal Color Change');
    
    if second_car_started
        legend('Car', 'Traffic Signal', 'Obstruction', 'Second Car');
    else
        legend('Car', 'Traffic Signal', 'Obstruction');
    end
    
    grid on;
    
    drawnow; % Update the figure
    
    % Pause to control the animation speed
    pause(time_step);
    
    % Clear previous car and signal markers
    if t > 1
        delete(findobj(gca, 'Type', 'line', 'Marker', 'o'));
    end
end
