function [position,isterminal,direction] = ground_event(~,z)
    position = z(4); % The value that we want to be zero
    isterminal = 1;  % Halt integration 
    direction = -1;   % The zero has to be approached from above
end