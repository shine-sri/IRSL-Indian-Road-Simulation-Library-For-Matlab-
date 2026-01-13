function [scenario, egoVehicle] = Barricade(barricades, barricadeWidth)
% Barricade: Simulation with one car and striped barricades
% INPUT:
%   barricades -> Nx2 array of [x, y] positions
%   barricadeWidth -> width (vertical height in meters) of each barricade
%
% Road length: 100 m, 2 lanes
% Displays pathline, car velocity, and barricade coordinates
% The car stops if it collides with a barricade

%% Road parameters
roadLength = 100;  % meters
roadWidth  = 10;   % total width for 2 lanes
scenario   = drivingScenario('SampleTime', 0.04);

%% Road (horizontal, origin at bottom-left) - 2 lanes
road(scenario, [0 0 0; roadLength 0 0], ...
    'Lanes', lanespec([2 2]), 'Name', 'Road');

%% Barricade bounds check
numBarr = size(barricades,1);
for k = 1:numBarr
    x = barricades(k,1);
    y = barricades(k,2);
    if x < 0 || x > roadLength || y < -roadWidth/2 || y > roadWidth/2
        error('🚫 Barricade %d at (%.1f, %.1f) is outside the road limits!', k, x, y);
    end
end

%% Ego vehicle
egoVehicle = vehicle(scenario, 'ClassID',1,'Position',[0 0 0], ...
    'Mesh', driving.scenario.carMesh, 'Name','EgoVehicle');

%% Car trajectory (straight horizontal)
numPoints   = 200;
xWaypoints  = linspace(0, roadLength, numPoints)';
yWaypoints  = zeros(numPoints,1);
zWaypoints  = zeros(numPoints,1);
waypointsEgo = [xWaypoints yWaypoints zWaypoints];
speedEgo     = 10*ones(numPoints,1);  % constant 10 m/s
smoothTrajectory(egoVehicle, waypointsEgo, speedEgo);

%% Figure & plot scenario
figure;
hPlot = axes;
plot(scenario,'Parent',hPlot); 
hold on;

% Zoom to fit road
xlim([0 roadLength]);
ylim([-roadWidth roadWidth]);

% Draw barricades as striped rectangles (yellow-black stripes)
barLength   = 0.3;   % minimal horizontal length (meters)
numStripes  = 4;     % stripes per barricade
for k = 1:numBarr
    x = barricades(k,1);
    y = barricades(k,2);
    stripeH = barricadeWidth/numStripes;
    for s = 1:numStripes
        ypos = y - barricadeWidth/2 + (s-1)*stripeH;
        if mod(s,2)==1
            stripeColor = [1 1 0]; % yellow
        else
            stripeColor = [0 0 0]; % black
        end
        rectangle('Position',[x-barLength/2, ypos, barLength, stripeH], ...
            'FaceColor',stripeColor,'EdgeColor','k');
    end
end

% Pathline for ego vehicle (bright blue)
hPath = plot(nan,nan,'b-','LineWidth',2,'DisplayName','Ego Path');
hCar  = plot(nan,nan,'bo','MarkerFaceColor','b','MarkerSize',6);

% Velocity display
velocityText = annotation('textbox',[0.85 0.8 0.12 0.05],...
    'String','Velocity: 0 m/s','EdgeColor','none','Color',[1 1 1],...
    'FontSize',10,'FontWeight','bold');

% Barricade coordinates display
barTextStr = strings(numBarr,1);
for k = 1:numBarr
    barTextStr(k) = sprintf('Bar%d: (%.1f, %.1f)', k, barricades(k,1), barricades(k,2));
end
annotation('textbox',[0.02 0.8 0.25 0.05*numBarr],...
    'String', strjoin(barTextStr,'\n'),...
    'EdgeColor','none','Color',[1 1 1],...
    'FontSize',9,'FontWeight','normal');

%% Simulation loop
egoLength = 4.5; egoWidth = 2.0;
maxSteps  = 500;

for i = 1:maxSteps
    if ~scenario.IsRunning
        break;
    end

    advance(scenario);
    pause(0.05);

    % Current position
    egoPos = egoVehicle.Position(1:2);

    % Update pathline
    hPath.XData(end+1) = egoPos(1);
    hPath.YData(end+1) = egoPos(2);

    % Update car marker
    hCar.XData = egoPos(1);
    hCar.YData = egoPos(2);

    % Update velocity display
    egoVel = norm(egoVehicle.Velocity);
    velocityText.String = sprintf('Velocity: %.1f m/s', egoVel);

    % Collision check with barricades
    for k = 1:numBarr
        barPos = barricades(k,:);
        if abs(egoPos(1)-barPos(1)) <= (egoLength+barLength)/2 && ...
           abs(egoPos(2)-barPos(2)) <= (egoWidth+barricadeWidth)/2
            disp('⚠️ Collision with barricade! Simulation stopped.');
            return
        end
    end

    % Stop at end of road
    if egoPos(1) >= roadLength
        disp('✅ Ego Vehicle reached end of road. Simulation finished.');
        break;
    end
end
end
