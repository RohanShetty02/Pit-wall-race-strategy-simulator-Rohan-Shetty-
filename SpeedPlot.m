%% Speed over distance: grip 1.5 vs 1.3
[t15, s, v15, vF15, vB15] = lapsim(1.5);
[t13, ~, v13]             = lapsim(1.3);

figure; hold on; grid on;

% Corner zone (250 m to 350 m)
yl = [0 85];
patch([250 350 350 250], [yl(1) yl(1) yl(2) yl(2)], [0.9 0.9 0.9], ...
      'EdgeColor','none','HandleVisibility','off');
text(300, 5, 'Corner (R = 50 m)', 'HorizontalAlignment','center');

% Faint forward and backward pass curves (optional, delete these two lines if cluttered)
plot(s, vF15, ':', 'Color',[0.6 0.6 0.6], 'DisplayName','Forward pass (accelerating)');
plot(s, vB15, '--','Color',[0.6 0.6 0.6], 'DisplayName','Backward pass (braking)');

% Final speed for both grip levels
plot(s, v15, 'LineWidth',2, 'DisplayName', sprintf('Grip 1.5, lap %.2f s', t15));
plot(s, v13, '--', 'LineWidth',2, 'DisplayName', sprintf('Grip 1.3, lap %.2f s', t13));

xlabel('Distance (m)'); ylabel('Speed (m/s)');
title('Speed around the 600 m lap');
legend('Location','south'); ylim(yl);