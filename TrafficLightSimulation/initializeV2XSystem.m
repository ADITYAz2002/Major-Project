% Initialization script for V2X system
clear; clc;

% Define V2X system parameters and initialize variables
trafficLight = struct('position', [10, 0], 'signal', 'Red');
vehicle = struct('position', [0, 0], 'speed', [1, 0], 'lane', 1);
