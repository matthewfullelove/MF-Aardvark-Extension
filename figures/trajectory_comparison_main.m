%% Setup
close all

theta_good = -0.3461;
s_good     =  2.2407;

theta_high =  pi/6;
s_high     =  3;

y0 = 1;
D  = 0.25;

%% Figure 
figure('Units','inches','Position',[1 1 6 2.8],'Color','w');
hold on

%% Plot trajectories
h_opt = plot_trajectory(theta_good, s_good, y0, D, '-');
h_ang = plot_trajectory(theta_high, s_good, y0, D, '--');
h_spd = plot_trajectory(theta_good, s_high, y0, D, '-.');

set(h_opt,'LineWidth',2)
set(h_ang,'LineWidth',1.5)
set(h_spd,'LineWidth',1.5)

%% Axes & labels
axis equal
axis tight
ylim([0 3])

hx = xlabel('$x$','Interpreter','latex');
hy = ylabel('$y$','Interpreter','latex');

legend({'Optimal','High angle','High speed'}, ...
       'Location','northeast','FontSize',9, ...
       'Interpreter','latex')

set(gca,'FontSize',9,'Layer','top')
set([hx hy],'FontSize',12)

%% Export
exportgraphics(gcf,'trajectory_comparison.pdf', ...
    'ContentType','vector', ...
    'BackgroundColor','none');
