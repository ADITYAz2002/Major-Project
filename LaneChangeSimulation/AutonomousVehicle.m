classdef AutonomousVehicle
    properties
        Position
        Speed
        Lane
    end
    
    methods
        function obj = AutonomousVehicle(position, speed, lane)
            if nargin == 3
                obj.Position = position;
                obj.Speed = speed;
                obj.Lane = lane;
            else
                error('Invalid number of input arguments');
            end
        end

        function MoveForward(obj, timeStep)
            % Update position based on speed and time
            obj.Position = obj.Position + obj.Speed * timeStep;
        end

        function ChangeLane(obj, newLane)
            obj.Lane = newLane;
        end
    end
end
