names  = {'Soft','Medium','Hard'};
totals = zeros(1,49);
for a = 1:3
    for b = 1:3
        if a == b, continue, end        % skip same-compound pairs
        for p = 1:49
            totals(p) = raceTime(p, [a b]);
        end
        [best, idx] = min(totals);
        fprintf('%s to %s: pit lap %d, %.1f s\n', names{a}, names{b}, idx, best);
    end
end