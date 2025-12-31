function ind = E2ICIpalboAZD_09_onesteadystate(args)
% This function checks whether two initial values—zero and a positive one 
% result in the same steady state rather than distinct ones.

x0 = zeros(args.Numvariable,1);
x0(args.E2mediaindex) = args.ValE2normal;
x0 = E2ICIpalboAZD_21_replating(x0,args);

tspan = [0,24 * 60];
[~,~,xinitial_1,mse_use] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_non,args);
if ~isnan(mse_use)
    ind = false;return;
end
initial_1 = xinitial_1(end,:);
initial_1(initial_1 < 0) = 0;
%% positive initial
x0 = 5 * ones(args.Numvariable,1);
x0(args.ind_reset) = 0;
x0(args.E2mediaindex) = args.ValE2normal;
x0 = E2ICIpalboAZD_21_replating(x0,args);
[~,~,xinitial_2,mse_use] = E2ICIpalboAZD_29_sim(x0,tspan,args.treat_non,args);
if ~isnan(mse_use)
    ind = 0;return;
end
initial_2 = xinitial_2(end,:);
initial_2(initial_2 < 0) = 0;
% test all the steady states are the same
ind = false;

if ~all(ismembertol(initial_1(args.ind_max)',initial_2(args.ind_max)',args.similartolerance))
    disp('2 steadystate.')
    ind = true;
end
end