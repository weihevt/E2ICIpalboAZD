function [tout,simout,xout] = E2ICIpalbowee1_sim(x0,tspan,treat,args)
tstart = tspan(1);
tspan = tspan - tstart;
tout = nan(tspan(end)+1,1);
xout = nan(tspan(end)+1,args.Numvariable);
changemedia = E2ICIpalbowee1_changemedia(tspan);
option = odeset('RelTol',args.RelTolval,'AbsTol',args.AbsTolval);
t_begin = tspan(1);

if ~isempty(changemedia)
    for i = 1 : numel(changemedia)
        t_end = changemedia(i) * 24;
        tspan_i = t_begin:1:t_end;
        [t,x] = args.odefun(@(t,X)E2ICIpalbowee1_model(t,X,treat,args.PAR),tspan_i,x0,option);
        [tout,xout] = child_assign(t,x,tout,xout);
        % update
        x0 = x(end,:);
        x0(args.E2mediaindex) = treat.E2in;
        t_begin = t(end);
    end
    if t(end) < tspan(end)
       tspan_i = t(end):1:tspan(end);
       [t,x] = args.odefun(@(t,X)E2ICIpalbowee1_model(t,X,treat,args.PAR),tspan_i,x0,option);
       [tout,xout] = child_assign(t,x,tout,xout);
    end
else
    tspan_i = tspan(1):1:tspan(end);
    [tout,xout] = args.odefun(@(t,X)E2ICIpalbowee1_model(t,X,treat,args.PAR),tspan_i,x0,option);
end
simout = E2ICIpalbowee1_assignval(xout,args);
tout = tout+tstart;
end


function [tout, xout] = child_assign(t,x,tout,xout)
pos = t(1)+1;
tout(pos:t(end)+1) = t;
xout(pos:t(end)+1,:) = x;
end