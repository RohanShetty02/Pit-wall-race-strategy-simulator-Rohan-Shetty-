pitLaps = 1:49;
totals  = zeros(size(pitLaps));
for j = 1:numel(pitLaps)
    totals(j) = raceTime(pitLaps(j));
end
[best, idx] = min(totals);
fprintf('Best pit lap: %d, race time %.1f s\n', pitLaps(idx), best);
figure;
plot(pitLaps, totals, '-', 'LineWidth', 1.5);
hold on;
plot(pitLaps(idx), best, 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
hold off;
grid on;
xlabel('Pit lap');
ylabel('Race time (s)');
title('Race time against pit lap (medium tyres, one stop)');
exportgraphics(gcf, 'pit_window_curve.png', 'Resolution', 300);
