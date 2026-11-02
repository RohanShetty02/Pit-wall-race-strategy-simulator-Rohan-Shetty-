rng(1);
nRaces = 5000;
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

gain = fixedTotal - reactTotal;          % seconds saved in each race
applied = gain > 0.001;                  % races where reacting changed something

figure;
histogram(gain(applied), 'BinWidth', 0.5);
grid on;
xlabel('Race time saved by reacting (s)');
ylabel('Number of races');
title('Race time saved by reacting to a safety car (races where it applied)');
text(0.03, 0.95, sprintf('%.0f%% of races: no gain\n%.0f%% of races: mean gain %.1f s', ...
    100*(1-mean(applied)), 100*mean(applied), mean(gain(applied))), ...
    'Units', 'normalized', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top');
exportgraphics(gcf, 'safety_car_gain.png', 'Resolution', 300);

avg = mean(total);
[bestAvg, idx] = min(avg);
fprintf('Best fixed pit lap on average: %d (%.1f s)\n', pitLaps(idx), bestAvg);

[~, hind] = min(total, [], 2);     % the best pit lap in hindsight, per race
figure; histogram(pitLaps(hind)); xlabel('Best pit lap in hindsight'); ylabel('Races');

figure; histogram(pitLaps(hind), 'BinWidth', 1);
grid on;
xlabel('Best pit lap in hindsight'); ylabel('Number of races');
title('Best pit lap once the safety car is known, 5,000 races');
exportgraphics(gcf, 'best_pit_lap_hindsight.png', 'Resolution', 300);
