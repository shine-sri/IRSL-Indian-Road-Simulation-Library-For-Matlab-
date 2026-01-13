% Test the RashDriving function

try
    % Create the scenario and ego vehicle
    [scenario, egoVehicle] = irsl.RashDriving();

    % Check scenario exists
    assert(~isempty(scenario) && isa(scenario, 'drivingScenario'));

    % Plot the scenario for visual confirmation
    figure;
    plot(scenario);

    % Advance a few steps to see motion
    for i = 1:20
        advance(scenario);
        pause(0.05); % slow down so you can see animation
    end

    disp('✅ Scenario ran successfully.');
catch ME
    disp('❌ Test failed:');
    disp(ME.message);
end
