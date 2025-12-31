function x = E2ICIpalboAZD_21_replating(x,args)
% This function resets the initial cell number each month, simulating the 
% replating done in the experiment.

x(end - 1) = 1 - args.PAR(args.ind_apopratioT0);% alive cells
x(end) = args.PAR(args.ind_apopratioT0);% apoptosis cells
end