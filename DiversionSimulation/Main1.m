% V2X MATLAB Project with Single Car (Text-Based Scenario)

% Simulation parameters
total_time = 12;        % Total simulation time (in seconds)
time_step = 0.5;        % Time step for simulation (in seconds)
car_speed = 10;         % Car speed (in meters per second)
road_length = 100;      % Total road length
obstruction_position = 80; % Position of the obstruction

% Simulation loop
for t = 0:time_step:total_time
    % Update car position
    car_position = car_speed * t;
    
    % Check if the car is within 5m range of the obstruction
    if abs(car_position - obstruction_position) <= 5
        disp(['Time: ' num2str(t) 's - Obstruction detected! Car stops. Traffic signal turns RED.']);
        break;
    else
        disp(['Time: ' num2str(t) 's - Car position: ' num2str(car_position) 'm']);
    end
    
    % Check if the car has reached the end of the road
    if car_position >= road_length
        disp(['Time: ' num2str(t) 's - End of road reached. Simulation terminated.']);
        break;
    end
end
