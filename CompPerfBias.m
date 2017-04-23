function p=CompPerfBias(beta,x);
%%% predicted percentage of "larger" responses in a comparison task
%%% given the log ratio of the numbers, and TWO parameters : a weber
%%% fraction beta(1) and a bias beta(2)

%% sample must be outside of the -crit, crit interval
p = 100* (normcdf(x,beta(2),beta(1)));