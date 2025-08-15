function x = E2ICIpalboAZD_replating(x,args)
x(end - 1) = 1 - args.PAR(args.ind_apopratioT0);% alive cells
x(end) = args.PAR(args.ind_apopratioT0);% apoptosis cells
end