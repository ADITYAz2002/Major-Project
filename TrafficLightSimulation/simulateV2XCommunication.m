function trafficLight = simulateV2XCommunication(communicationRange, vehicle, trafficLight)
    % Calculate the distance to the traffic light
    distanceToTrafficLight = norm(vehicle.position - trafficLight.position);

    % Check if the vehicle is within the communication range
    if distanceToTrafficLight <= communicationRange
        % Update the signal to 'Green' if conditions are met
        trafficLight.signal = 'Green';
    else
        % Keep the signal 'Red' if the vehicle is outside the communication range
        trafficLight.signal = 'Red';
    end
end
