function h = plot_trajectory(theta0, s0, y0, D, lineSpec)
%PLOT_TRAJECTORY  Plot glider flight path

    if nargin < 5
        lineSpec = '-';
    end

    try
        sol = compute_trajectory(theta0, s0, y0, D);
    catch
        warning('Trajectory failed to integrate.');
        h = [];
        return
    end

    h = plot(sol(:,3), sol(:,4), lineSpec);
    hold on
end
