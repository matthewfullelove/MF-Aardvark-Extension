function sol = compute_trajectory(theta0, s0, y0, D)
%COMPUTE_TRAJECTORY  Integrate glider equations until ground impact

    z0   = [theta0; s0; 0; y0];
    opts = odeset( ...
        'Events', @ground_event, ...
        'RelTol', 1e-6, ...
        'AbsTol', 1e-8 );

    [~, sol] = ode45(@(t,z) glider(t,z,D), [0 50], z0, opts);
end
