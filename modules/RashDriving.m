function [scenario, egoVehicle] = RashDriving()
% RashDriving: horizontal ego vehicle with smooth random curve
% Other vehicle: vertical straight path with variable speed
% Stops on collision or when other vehicle reaches destination
% Includes: Manual Pathlines + Velocities in figure corner

%% Create scenario
scenario = drivingScenario('SampleTime', 0.04);

%% Roads
road(scenario, [150 24.2 0; 54 24.2 0], 'Lanes', lanespec([2 2]), 'Name', 'Road');   % horizontal
road(scenario, [105 75 0; 105 -20 0], 'Lanes', lanespec([2 2]), 'Name', 'Road1');   % vertical

%% Ego vehicle (horizontal, smooth random curve)
egoVehicle = vehicle(scenario, 'ClassID',1,'Position',[56 24.2 0], ...
    'Mesh', driving.scenario.carMesh, 'Name','egoVehicle');

numControlPoints = 8;   
xControl = linspace(56, 135, numControlPoints);
laneCenterY = 24.2;
laneHalfWidth = 2.0;

rng('shuffle');
yControl = laneCenterY + (rand(1,numControlPoints)-0.5)*2*laneHalfWidth;

numPoints = 300;  
xInterp = linspace(56, 135, numPoints);
yInterp = spline(xControl, yControl, xInterp)';
zInterp = zeros(numPoints,1);
waypointsEgo = [xInterp' yInterp zInterp];

speedEgo = (5 + 10*rand)*ones(numPoints,1);
smoothTrajectory(egoVehicle, waypointsEgo, speedEgo);

%% Other vehicle (vertical, straight) with variable speed
otherVehicle = vehicle(scenario, 'ClassID',1,'Position',[105 73 0], ...
    'Mesh', driving.scenario.carMesh, 'Name','otherVehicle');

waypointsOther = [105 73 0; 105 -20 0];  
speedOther = 8 + 4*rand(2,1);            
smoothTrajectory(otherVehicle, waypointsOther, speedOther);

%% Vehicle sizes for bounding-box collision
egoLength = 4.5; egoWidth = 2.0;
otherLength = 4.5; otherWidth = 2.0;

%% Run simulation
figure;
hPlot = axes; 
plot(scenario,'Parent',hPlot);
hold on;

% Path handles
hEgoPath = plot(nan,nan,'b-','LineWidth',1.5,'DisplayName','Ego Path');
hOtherPath = plot(nan,nan,'r-','LineWidth',1.5,'DisplayName','Other Path');

% Create fixed corner text for velocities
egoSpeedText = annotation('textbox',[0.75 0.9 0.2 0.05],...
    'String','Rash vehicle: 0 m/s','EdgeColor','none','Color',[0.3 0.7 1],'FontSize',10,'FontWeight','bold');
otherSpeedText = annotation('textbox',[0.75 0.85 0.2 0.05],...
    'String','Other: 0 m/s','EdgeColor','none','Color',[1 0.4 0.7],'FontSize',10,'FontWeight','bold');

maxSteps = 500;
for i = 1:maxSteps
    if ~scenario.IsRunning
        break;
    end

    advance(scenario);
    pause(0.05);

    % Current positions
    egoPos = egoVehicle.Position(1:2);
    otherPos = otherVehicle.Position(1:2);

    % Update paths
    hEgoPath.XData(end+1) = egoPos(1);
    hEgoPath.YData(end+1) = egoPos(2);
    hOtherPath.XData(end+1) = otherPos(1);
    hOtherPath.YData(end+1) = otherPos(2);

    % Current speeds
    egoVel = norm(egoVehicle.Velocity);       % m/s
    otherVel = norm(otherVehicle.Velocity);   % m/s

    % Update fixed corner text
    egoSpeedText.String   = sprintf('Rash vehicle: %.1f m/s', egoVel);
    otherSpeedText.String = sprintf('Other: %.1f m/s', otherVel);

    % Collision check
    if abs(egoPos(1) - otherPos(1)) <= (egoLength+otherLength)/2 && ...
       abs(egoPos(2) - otherPos(2)) <= (egoWidth+otherWidth)/2
        disp('⚠️ Collision detected! Simulation stopped.');
        break;
    end

    % Stop if other vehicle reaches destination
    egoDestination = [135 yInterp(end) 0];   % ego vehicle final waypoint
otherDestination = [105 -20 0];          % other vehicle final waypoint

% Inside the simulation loop:
if norm(otherPos - otherDestination(1:2)) < 0.5
    disp('✅ Other Vehicle reached destination. Simulation finished.');
    break;
end

if norm(egoPos - egoDestination(1:2)) < 0.5
    disp('✅ Rash Vehicle reached destination. Simulation finished.');
    break;
end
end

end
