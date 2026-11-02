function total = raceTime(pitLaps, comp, pitLoss)    % comp = [1 3] means soft, then hard
if nargin < 2, comp = [2 2 2 2]; end % default: medium everywhere, % s lost driving through the pit lane (pitLoss)
if nargin < 3, pitLoss = 20; end


    nLaps   = 50;
    tyreMu0 = [1.55 1.50 1.45];     % soft, medium, hard: starting grip
    tyreKmu = [0.025 0.015 0.010];  % soft, medium, hard: grip lost per lap
    mEmpty = 800;           % kg, car without fuel
    fuel0  = 100;           % kg at the start
    burn   = fuel0/nLaps;   % kg burned per lap



    lap = (1:nLaps)';

    age = lap;
    for p = pitLaps
        age(lap > p) = lap(lap > p) - p;
    end
  
    stint = 1 + sum(lap > pitLaps(:)', 2);

    T = zeros(nLaps,1);
    for i = 1:nLaps
        s  = stint(i);
        c  = comp(s);                      % compound number for this stint
        m  = mEmpty + fuel0 - burn*(i-1);    % mass at the start of this lap
        aA = 8 * mEmpty/m;                    % acceleration at this mass
        mRef = mEmpty + fuel0/2;
        mu = tyreMu0(c) - tyreKmu(c)*age(i)*(m/mRef);
        T(i) = lapsim(mu, aA);
    end

    T(pitLaps) = T(pitLaps) + pitLoss;
    total = sum(T);
end