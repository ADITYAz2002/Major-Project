% Parameters
timeStep = 0.25;               % Simulation time step in seconds
simulationDuration = 30;      % Duration of the simulation in seconds
overtakeTriggerTimeStart = 3;  % Overtake triggered after 3 seconds
overtakeTriggerTimeEnd = 20;   % Overtake triggered until 20 seconds
overtakeSpeed = 1.5;             % Speed of the overtaking vehicle
communicationRange = 7;       % Communication range in units

% Initialize vehicles
vehicle1 = struct('position', [0, 0], 'speed', [1, 0], 'acceleration', [0, 0], 'lane', 1);
vehicle2 = struct('position', [0, 1], 'speed', [1, 0], 'acceleration', [0, 0], 'lane', 2);

% Initialize figure for animation
figure;
axis([-5 55 -1 2]); % Set the axis limits based on your scenario
hold on;

% Create road markings
for x = 0:5:50
    plot([x x], [-1 2], 'k', 'LineWidth', 0.5);
end

% Create road borders
plot([-5 -5 55 55 -5], [-1 2 2 -1 -1], 'k', 'LineWidth', 2);

% Create animated cars for vehicles
car1 = rectangle('Position', [vehicle1.position(1)-0.4, vehicle1.position(2)-0.2, 0.8, 0.4], 'Curvature', 0.2, 'FaceColor', 'r');
car2 = rectangle('Position', [vehicle2.position(1)-0.4, vehicle2.position(2)-0.2, 0.8, 0.4], 'Curvature', 0.2, 'FaceColor', 'b');

% Create a VideoWriter object
videoFile = VideoWriter('overtaking_animation_realistic_v2x.mp4', 'MPEG-4');
videoFile.FrameRate = 10; % Adjust the frame rate as needed
open(videoFile);

% Display headings for the table
fprintf('-----------------------------------------------------------------------------\n');
fprintf('|  Time (s)  | Vehicle | Position          | Speed (units/s) | Acceleration |\n');
fprintf('-----------------------------------------------------------------------------\n');

% Simulation loop
for time = 0:timeStep:simulationDuration
    % Move vehicles forward
    vehicle1.position = vehicle1.position + vehicle1.speed * timeStep;
    vehicle2.position = vehicle2.position + vehicle2.speed * timeStep;

    % Check if overtaking is triggered
    if time >= overtakeTriggerTimeStart && time <= overtakeTriggerTimeEnd
        % Overtake logic: Increase speed of vehicle1 (overtaking vehicle)
        vehicle1.speed = [overtakeSpeed, 0];
    else
        % Reset speed to normal if not overtaking
        vehicle1.speed = [1, 0]; % Assuming the normal speed is 1 unit/s
    end

    % Update acceleration (for demonstration purposes)
    vehicle1.acceleration = [rand(), 0]; % Random acceleration
    vehicle2.acceleration = [rand(), 0]; % Random acceleration

    % Display current state in a single table
    fprintf('| %-10.1f | %-7s | %-16s | %-15s | %-12s |\n', time, 'Vehicle 1', num2str(vehicle1.position), num2str(norm(vehicle1.speed)), num2str(norm(vehicle1.acceleration)));
    fprintf('|            | %-7s | %-16s | %-15s | %-12s |\n', 'Vehicle 2', num2str(vehicle2.position), num2str(norm(vehicle2.speed)), num2str(norm(vehicle2.acceleration)));

    % V2X Communication
    distance = norm(vehicle1.position - vehicle2.position);
    if distance <= communicationRange
        % Exchange data
        vehicle1.positionBroadcast = vehicle1.position;
        vehicle1.speedBroadcast = vehicle1.speed;
        vehicle1.accelerationBroadcast = vehicle1.acceleration;
        vehicle1.laneBroadcast = vehicle1.lane;

        vehicle2.positionBroadcast = vehicle2.position;
        vehicle2.speedBroadcast = vehicle2.speed;
        vehicle2.accelerationBroadcast = vehicle2.acceleration;
        vehicle2.laneBroadcast = vehicle2.lane;

        % Display communication data in the same table
        fprintf('-----------------------------------------------------------------------------\n');
        fprintf('|            | Broadcast| %-16s | %-15s |               |\n', num2str(vehicle1.positionBroadcast), num2str(norm(vehicle1.speedBroadcast)));
        fprintf('|            |          | %-16s | %-15s |               |\n', num2str(vehicle2.positionBroadcast), num2str(norm(vehicle2.speedBroadcast)));
        fprintf('-----------------------------------------------------------------------------\n');
    end

    % Update animated cars with realistic motion
    set(car1, 'Position', [vehicle1.position(1)-0.4, vehicle1.position(2)-0.2, 0.8, 0.4]);
    set(car2, 'Position', [vehicle2.position(1)-0.4, vehicle2.position(2)-0.2, 0.8, 0.4]);

    drawnow limitrate; % Update the plot and limit the rate of updates

    % Write each frame to the video file
    writeVideo(videoFile, getframe(gcf));
end

% Close the video file
close(videoFile);
hold off;
