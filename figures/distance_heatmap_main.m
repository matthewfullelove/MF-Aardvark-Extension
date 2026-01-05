%% Setup
thisFile = mfilename('fullpath');
thisDir  = fileparts(thisFile);
addpath(fullfile(thisDir,'..','src'));

%close all; clc;

%% Parameters
y0 = 1;
D  = 0.25;

thetaGrid = linspace(-pi/2, pi/2, 60);
sGrid     = linspace(0.2, 4, 60);

tic
%% Compute distances for grid
distances = NaN(length(sGrid), length(thetaGrid));

for j = 1:numel(thetaGrid)
    for i = 1:numel(sGrid)
        sol = compute_trajectory(thetaGrid(j), sGrid(i), y0, D);
        distances(i,j) = sol(end,3);
    end
end
disp(toc)
%% Locate optimum
[maxDist, idx] = max(distances(:), [], 'omitnan');
[iBest, jBest] = ind2sub(size(distances), idx);

theta0_best = thetaGrid(jBest);
s0_best     = sGrid(iBest);

%% Plot heatmap
figure('Units','inches','Position',[1 1 5 2.8]);

imagesc(thetaGrid, sGrid, distances)
set(gca,'YDir','normal')

colormap(parula)
cb = colorbar;
cb.Label.FontSize = 9;
cb.TickDirection = 'out';
cb.LineWidth = 0.6;
cb.Label.String = 'Horizontal range';
cb.Label.Interpreter = 'latex';
cb.Label.FontSize = 9;

% Colour scaling
valid = distances(~isnan(distances));
clim(prctile(valid, [5 95]))

hold on

%% Mark optimal launch conditions
% White outline
plot([theta0_best theta0_best], ylim, ...
     'Color', [1 1 1 0.45], ...
     'LineWidth', 2.6)

plot(xlim, [s0_best s0_best], ...
     'Color', [1 1 1 0.45], ...
     'LineWidth', 2.6)

% Black centre line
plot([theta0_best theta0_best], ylim, ...
     'Color', [0 0 0 0.8], ...
     'LineWidth', 1.2)

plot(xlim, [s0_best s0_best], ...
     'Color', [0 0 0 0.8], ...
     'LineWidth', 1.2)

set(gca,'FontSize',9,'Layer','top')

%% Formatting 
xlabel('Initial angle $\theta_0$ (rad)','FontSize',12','Interpreter','latex')
ylabel('Initial speed $s_0$','FontSize',12','Interpreter','latex')

axis tight


%% Report optimal initial conditions
fprintf('\nOptimal launch conditions:\n');
fprintf('  theta0 = %.4f rad (%.2f deg)\n', ...
        theta0_best, rad2deg(theta0_best));
fprintf('  s0     = %.4f\n', s0_best);
fprintf('  dist   = %.4f\n', maxDist);

%% Export
exportgraphics(gcf, 'distance_heatmap.pdf', ...
    'ContentType','vector', ...
    'BackgroundColor','none');