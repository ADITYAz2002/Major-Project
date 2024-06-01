% simulateTrafficScenario.m

function simulateTrafficScenario
    % Simulation parameters
    totalTime = 150; % Change the total time as needed
    timeStep = 1;   % Change the time step as needed

    % Create video writer object
    videoFile = 'traffic_simulation.avi';
    v = VideoWriter(videoFile);
    open(v);

    % Initialize vehicle and traffic light
    vehicle.position = 0;
    vehicle.lane = 1;
    trafficLight.position = 10;
    trafficLight.signal = 'Red';

    for time = 1:timeStep:totalTime
        % Simulate the traffic scenario and update vehicle, trafficLight, etc.
        [vehicle, trafficLight] = updateTrafficScenario(vehicle, trafficLight, time);

        % Plot the current state
        plotState(vehicle, trafficLight, time);

        % Capture the frame for the video
        frame = getframe(gcf);
        writeVideo(v, frame);
    end

    % Close the video writer object
    close(v);
end

function [vehicle, trafficLight] = updateTrafficScenario(vehicle, trafficLight, time)
    % Update traffic light signal (for example, change to green after some time)
    if time > 80 && time <= 120
        trafficLight.signal = 'Green';
    else
        trafficLight.signal = 'Red';
    end

    % Update vehicle position (for example, move forward)
    vehicle.position = vehicle.position + 0.1;

    % Print debug information
    fprintf('Time: %d\nTraffic Light Signal: %s\nVehicle Lane: %d, Position: %.1f\n----------------------\n', ...
        time, trafficLight.signal, vehicle.lane, vehicle.position);
end

function plotState(vehicle, trafficLight, time)
    % Plotting code
    clf; % Clear the current figure

    % Plot the vehicle as a smaller blue rectangle
    rectangle('Position', [vehicle.position, 0.25, 0.5, 0.5], 'FaceColor', 'blue', 'EdgeColor', 'none');
    hold on;

    % Plot the traffic light
    trafficLightColor = getColor(trafficLight.signal);
    plot(trafficLight.position, 0.5, 'o', 'MarkerSize', 10, 'MarkerFaceColor', trafficLightColor, 'MarkerEdgeColor', 'none');

    % Customize the plot
    xlim([0, 15]);
    ylim([0, 1]);
    xlabel('Position');
    ylabel('Lane');

    title(['Traffic Simulation at Time: ' num2str(time)], 'FontSize', 14);
    grid on;

    drawnow; % Update the plot
end

function color = getColor(signal)
    % Helper function to map traffic light signal to color
    if strcmp(signal, 'Red')
        color = 'red';
    else
        color = 'green';
    end
end
