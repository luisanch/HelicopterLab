eq_cov = cov(eq_ts(2:7,:)')
st_cov = cov(st_ts(2:7,:)')

eq_autc = autocorr(eq_ts(2:7,:)')
st_autc = autocorr(st_ts(2:7,:)')
% figure(1);
% plot(eq_ts(1,:), eq_ts(2,:), eq_ts(1,:), st_ts(2,:));
% plot(st_ts(1,:), st_ts(2,:));