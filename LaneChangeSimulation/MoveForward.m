function MoveForward(vehicle, timeStep)
    vehicle.Position = vehicle.Position + vehicle.Speed * timeStep;
end
