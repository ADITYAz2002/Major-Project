% V2X MATLAB Project

% Simulation parameters
total_time = 12;        % Total simulation time (in seconds)
time_step = 0.1;        % Time step for simulation (in seconds)
car_speed = 10;         % Car speed (in meters per second)
car_position = 0;       % Initial position of the car
signal_position = 50;   % Position of the traffic signal
obstruction_position = 80; % Position of the obstruction
road_length = 100;      % Total road length

% Initialize arrays to store data for plotting
time_array = 0:time_step:total_time;
car_position_array = zeros(size(time_array));
signal_color_array = cell(size(time_array));

% Simulation loop
for t = 1:length(time_array)
    % Update car position
    car_position = car_position + car_speed * time_step;
    
    % Check if the car is within 5m range of the obstruction
    if abs(car_position - obstruction_position) <= 5
        disp('Obstruction detected! Car stops.');
        car_speed = 0; % Car stops
        signal_color = 'red'; % Change traffic signal color to red
    else
        signal_color = 'green'; % Default signal color
    end
    
    % Check if the car has reached the end of the road
    if car_position >= road_length
        disp('End of road reached. Simulation terminated.');
        break;
    end
    
    % Store current car position and signal color for plotting
    car_position_array(t) = car_position;
    signal_color_array{t} = signal_color;
end

% Plot results
figure;
yyaxis left;
plot(time_array, car_position_array, 'LineWidth', 2);
ylabel('Car Position (m)');

yyaxis right;
for t = 1:length(time_array)
    if strcmp(signal_color_array{t}, 'red')
        plot(time_array(t), signal_position, 'or', 'MarkerSize', 10, 'MarkerFaceColor', 'red');
    else
        plot(time_array(t), signal_position, 'og', 'MarkerSize', 10, 'MarkerFaceColor', 'green');
    end
    hold on;
end

% Plot obstruction marker
plot(obstruction_position, 0, 'xm', 'MarkerSize', 10, 'LineWidth', 2);

ylabel('Traffic Signal Position (m)');

xlabel('Time (s)');
title('V2X Simulation');
legend('Car Position', 'Traffic Signal', 'Obstruction');
grid on;
