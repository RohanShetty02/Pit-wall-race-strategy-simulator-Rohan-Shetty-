med = [2 2 2 2];

base0 = raceTime([], med, 0);            % no stop

base1 = inf;                              % best one stop, zero cost
for p = 1:49
    t = raceTime(p, med, 0);
    if t < base1, base1 = t; end
end

base2 = inf;                              % best two stops, zero cost
for p1 = 1:48
    for p2 = p1+1:49
        t = raceTime([p1 p2], med, 0);
        if t < base2, base2 = t; end
    end
end

L = 0:1:30;                               % cost of one stop (s)
figure;
plot(L, base0*ones(size(L)), '--', 'LineWidth', 1.5); hold on;
plot(L, base1 + L,   '-', 'LineWidth', 1.5);
plot(L, base2 + 2*L, '-', 'LineWidth', 1.5);
cross = base1 - base2;                    % cost where 2 stops stop paying
xline(cross, ':', sprintf('%.1f s', cross), 'LabelVerticalAlignment', 'bottom');
xline(20, '-', 'Race pit loss (20 s)', 'LabelVerticalAlignment', 'bottom');
hold off; grid on;
legend('No stop', 'One stop', 'Two stops', 'Location', 'northwest');
xlabel('Cost of one pit stop (s)');
ylabel('Best race time (s)');
title('Best race time against pit stop cost, for 0, 1 and 2 stops');
exportgraphics(gcf, 'stops_vs_stop_cost.png', 'Resolution', 300);
fprintf('Two stops beat one stop below %.1f s per stop\n', cross);
fprintf('One stop beats no stop below %.1f s per stop\n', base0 - base1);