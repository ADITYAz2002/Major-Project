function trafficLight = updateTrafficSignal(trafficLight, vehicle)
    % Your logic to update the traffic signal based on V2X communication
    
    % Set the communication range
    communicationRange = 2.0; % Adjust the communication range as needed
    
    % Calculate the distance to the traffic light
    distanceToTrafficLight = norm(vehicle.position - trafficLight.position);
    
    % Print debug information
    fprintf('Distance to Traffic Light: %f\n', distanceToTrafficLight);
    
    % Check if the vehicle is within the communication range
    if distanceToTrafficLight <= communicationRange
        % Update the signal to 'Green' if conditions are met
        trafficLight.signal = 'Green';
    else
        % Keep the signal 'Red' if the vehicle is outside the communication range
        trafficLight.signal = 'Red';
    end
end
