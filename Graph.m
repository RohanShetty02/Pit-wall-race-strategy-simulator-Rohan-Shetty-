orders = {'Soft→Medium','Medium→Soft','Soft→Hard','Hard→Soft','Medium→Hard','Hard→Medium'};
times  = [729.1 729.0 725.9 725.7 722.9 722.8];

figure;
barh(times, 'FaceColor', [0.2 0.45 0.75]);
set(gca, 'YTick', 1:6, 'YTickLabel', orders, 'YDir', 'reverse');
xlim([720 731]);
grid on;
xlabel('Race time (s)');
title('Best one-stop race time for each tyre order');
exportgraphics(gcf, 'tyre_order_comparison.png', 'Resolution', 300);