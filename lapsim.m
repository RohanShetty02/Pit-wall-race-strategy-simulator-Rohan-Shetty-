function [lapTime, s, v, vF, vB] = lapsim(mu, aAcc)
    if nargin < 2, aAcc = 8; end

%% 1. Track and car settings (already done for you)
g      = 9.81;                   % m/s^2
ds     = 1;                      % m, step size along the track
s      = (0:ds:600)';            % distance along the track (column)
n      = numel(s);
R      = inf(n,1);               % corner radius at each step (inf = straight)
R(s >= 250 & s < 350) = 50;      % one 50 m radius corner from 250 m to 350 m
vmax   = 80;                     % m/s, top speed (power/drag limit, simplified)
aBrk   = 12;                     % m/s^2, max braking


%% 2. Speed limit at each step (YOUR TURN)
vCorner = sqrt(mu*g*R);  % On a straight R = inf, so the limit is vmax. (Cornering speed)
vlim = min(vmax, vCorner);                    % TODO: min of vmax and the cornering limit depending on if its in straights or corners respectively

%% 3. Forward pass: how fast can the car get to each point? (YOUR TURN)
% Start from vlim(1). At each step the car can reach at most
% v(i)^2 = v(i-1)^2 + 2*aAcc*ds;
vF = vlim;
for i = 2:n
    vF(i) = min(vlim(i), sqrt(vF(i-1)^2 + 2*aAcc*ds));               % TODO: min(vlim(i), sqrt(vF(i-1)^2 + 2*aAcc*ds))
end

%% 4. Backward pass: how fast can the car be and still brake in time? (YOUR TURN)
% Work from the end backwards. Same idea with aBrk:
% v(i)^2 = v(i+1)^2 + 2*aBrk*ds
vB = vlim;
for i = n-1:-1:1
    vB(i) = min(vlim(i), sqrt(vB(i+1)^2+2*aBrk*ds));               % TODO
end

%% 5. Final speed and lap time (YOUR TURN)
v = min(vF, vB);               % the lowest of the limits at each point
lapTime = sum(ds ./v);        % time = distance / speed, added up

end
