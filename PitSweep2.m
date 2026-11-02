best2 = inf;
for p1 = 1:48
    for p2 = p1+1:49
        t = raceTime([p1 p2]);
        if t < best2
            best2 = t; bestStops = [p1 p2];
        end
    end
end

fprintf('Best 2-stop: laps %d and %d, %.1f s\n', bestStops(1), bestStops(2), best2);
%t0 = raceTime([]);
%fprintf('No stop: %.1f s\n', t0);