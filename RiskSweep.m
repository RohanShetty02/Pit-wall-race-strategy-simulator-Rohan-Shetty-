rng(1);
pitLoss   = 20;     % normal stop (s)
pitLossSC = 8;      % stop under a safety car (s)
pitLaps   = 1:49;

plan       = 21;                       % planned pit lap
planIdx    = find(pitLaps == plan);    % its position in the pitLaps list
fixedTotal = zeros(nRaces,1);          % result if you always stick to the plan
reactTotal = zeros(nRaces,1);          % result if you react to the safety car

base = zeros(size(pitLaps));
for j = 1:numel(pitLaps)
    base(j) = raceTime(pitLaps(j), [2 3]) - pitLoss;   % medium then hard, no stop cost
end

nRaces = 5000;
total  = zeros(nRaces, numel(pitLaps));
for r = 1:nRaces
    if rand < 0.5                 % 50% chance of a safety car this race
        sc = randi(48);           % random lap, 1 to 48
    else
        sc = 0;
    end
    loss = pitLoss * ones(size(pitLaps));
    if sc > 0
        loss(pitLaps >= sc & pitLaps <= sc+2) = pitLossSC;
    end

    fixedTotal(r) = base(planIdx) + loss(planIdx);

    pitUsed = plan;
    if sc > 03 && sc +2 < plan
        pitUsed = sc + 2;
    end
    k = find(pitLaps == pitUsed);
    reactTotal(r) = base(k) + loss(k);

    total(r,:) = base + loss;
end

fprintf('Fixed plan: %.2f s\n', mean(fixedTotal));
fprintf('Reactive:   %.2f s\n', mean(reactTotal));
fprintf('Gain from reacting: %.2f s per race\n', mean(fixedTotal) - mean(reactTotal));

avg = mean(total);
[bestAvg, idx] = min(avg);
fprintf('Best fixed pit lap on average: %d (%.1f s)\n', pitLaps(idx), bestAvg);

[~, hind] = min(total, [], 2);     % the best pit lap in hindsight, per race
figure; histogram(pitLaps(hind)); xlabel('Best pit lap in hindsight'); ylabel('Races');