%% Setup
thisFile = mfilename('fullpath');
thisDir  = fileparts(thisFile);
addpath(fullfile(thisDir,'..','src'));

% close all; clc;

%% Parameters
y0 = 1;
D  = 0.25;

% Fixed initial speed (use optimal value from heatmap)
s0 = 2.2610;

% Angle sweep (radians for computation)
thetaVals = linspace(-0.8, 0.4, 200);
ranges    = NaN(size(thetaVals));

%% Compute range for each angle
for k = 1:numel(thetaVals)
    sol = compute_trajectory(thetaVals(k), s0, y0, D);
    ranges(k) = sol(end,3);   % horizontal distance at impact
end

%% Locate maximum
[maxRange, idx] = max(ranges, [], 'omitnan');
thetaOpt = thetaVals(idx);

%% Convert to degrees for plotting
thetaDeg    = rad2deg(thetaVals);
thetaOptDeg = rad2deg(thetaOpt);

%% Plot
figure('Units','inches','Position',[1 1 4.5 2.52]);

plot(thetaDeg, ranges, 'k-', 'LineWidth', 1.6)
hold on

% Dashed vertical line at optimum
xline(thetaOptDeg, '--', ...
    'LineWidth', 1.2, ...
    'Color', [0 0 0 0.6]);

% Mark optimum with a black cross
plot(thetaOptDeg, maxRange, 'kx', ...
    'MarkerSize', 8, ...
    'LineWidth', 1.6);

% Axes formatting
set(gca, ...
    'Box','off', ...
    'TickDir','out', ...
    'FontSize',9,...
    'Layer','top')

xlabel('Initial angle $\theta_0$ (degrees)', ...
       'Interpreter','latex', 'FontSize',12)
ylabel('Horizontal range', ...
       'Interpreter','latex', 'FontSize',12)

axis padded
xlim([-45 25])
ylim([ranges(end) maxRange + 0.2])

%% Export 
exportgraphics(gcf, 'distance_vs_angle.pdf', ...
     'ContentType','vector', ...
     'BackgroundColor','none');

