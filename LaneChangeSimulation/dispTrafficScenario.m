function dispTrafficScenario(trafficLight, vehicle, currentTime)
    % Display the animated traffic scenario
    fprintf('\nTime: %d\n', currentTime);
    
    % Display traffic light signal
    fprintf('Traffic Light Signal: %s\n', trafficLight.signal);
    
    % Display vehicle lane and position
    fprintf('Vehicle Lane: %d, Position: %s\n', vehicle.lane, num2str(vehicle.position));
    
    % Add more information or visualization as needed
    fprintf('----------------------\n');
end
