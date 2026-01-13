function [scenario, egoVehicle] = Block(blocks)
% Block: Simulation with one car and rectangular barricade blocks
% INPUT: blocks -> Nx4 array of [x, y, length, width]

%% Road parameters
roadLength = 100;  
roadWidth  = 8;   % wider 2-lane road
scenario   = drivingScenario('SampleTime', 0.04);

%% Road (2 lanes, horizontal)
road(scenario, [0 0 0; roadLength 0 0], ...
    'Lanes', lanespec([1 1]), 'Name', 'Road');

%% Ego vehicle
egoVehicle = vehicle(scenario, 'ClassID',1, 'Position',[0 0 0], ...
    'Name','EgoVehicle');

% Trajectory: straight at 10 m/s
numPoints    = 200;
xWaypoints   = linspace(0, roadLength, numPoints)';
yWaypoints   = zeros(numPoints,1);
zWaypoints   = zeros(numPoints,1);
waypointsEgo = [xWaypoints yWaypoints zWaypoints];
speedEgo     = 10*ones(numPoints,1);
smoothTrajectory(egoVehicle, waypointsEgo, speedEgo);

%% Figure
figure; 
hPlot = axes;
plot(scenario,'Parent',hPlot); 
hold on;

xlim([0 roadLength]);
ylim([-roadWidth roadWidth]);

%% Draw solid black barricades
numBlocks = size(blocks,1);
for k = 1:numBlocks
    x = blocks(k,1);
    y = blocks(k,2);
    L = blocks(k,3);
    W = blocks(k,4);

    % solid black rectangle with white outline
    rectangle('Position',[x-L/2, y-W/2, L, W], ...
              'FaceColor','k','EdgeColor','w','LineWidth',1.5);
end

%% Text Annotations
% Velocity display (right side, white)
velText = annotation('textbox',[0.8 0.9 0.2 0.05],...
    'String','Velocity: 0 m/s','EdgeColor','none',...
    'Color','w','FontSize',10,'FontWeight','bold');

% Barricade coordinates (left side, multiline)
barTextLines = cell(numBlocks+1,1);
barTextLines{1} = 'Barricades:';
for k = 1:numBlocks
    barTextLines{k+1} = sprintf('[x=%.1f, y=%.1f, L=%.1f, W=%.1f]', blocks(k,:));
end

barText = annotation('textbox',[0.05 0.7 0.25 0.2],...
    'String',barTextLines,...
    'EdgeColor','none','Color','w',...
    'FontSize',9,'FontWeight','bold');

%% Pathline
hPath = plot(nan,nan,'b-','LineWidth',1.5);

%% Simulation loop
egoLength = 4.5; egoWidth = 2.0;
maxSteps  = 500;

for i = 1:maxSteps
    if ~scenario.IsRunning
        break;
    end

    advance(scenario);
    pause(0.05);

    % Position
    egoPos = egoVehicle.Position(1:2);

    % Update path
    hPath.XData(end+1) = egoPos(1);
    hPath.YData(end+1) = egoPos(2);

    % Update velocity
    egoVel = norm(egoVehicle.Velocity);
    velText.String = sprintf('Velocity: %.1f m/s', egoVel);

    % Collision check
    for k = 1:numBlocks
        bx = blocks(k,1); by = blocks(k,2);
        L  = blocks(k,3); W  = blocks(k,4);
        if abs(egoPos(1)-bx) <= (egoLength+L)/2 && ...
           abs(egoPos(2)-by) <= (egoWidth+W)/2
            disp('⚠️ Collision with barricade! Simulation stopped.');
            return
        end
    end

    if egoPos(1) >= roadLength
        disp('✅ Ego Vehicle reached end of road. Simulation finished.');
        break;
    end
end
end
