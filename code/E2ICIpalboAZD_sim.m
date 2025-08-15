function [tout,simout,xout,mse_use] = E2ICIpalboAZD_sim(x0,tspan,treat,args)
% Function to simulate various treatment conditions.
tstart = tspan(1);
tspan = tspan - tstart;
tout = nan(tspan(end)+1,1);
xout = nan(tspan(end)+1,args.Numvariable);
simout = nan;
changemedia = E2ICIpalboAZD_changemedia(tspan);

t_begin = tspan(1);

if ~isempty(changemedia)
    for i = 1 : numel(changemedia)
        t_end = changemedia(i) * 24;
        tspan_i = t_begin:1:t_end;
        lastwarn('');
        ta = tic;
        option = odeset('Events',@(t,x)child_myeventfunction(t,x,ta),...
                        'RelTol',args.RelTolval,...
                        'AbsTol',args.AbsTolval);
        [t,x] = args.odefun(@(t,X)E2ICIpalboAZD_model(t,X,treat,args.PAR),tspan_i,x0,option);
        [warnMsg,~] = lastwarn;
        if child_check(x,t,warnMsg,tspan_i,args)
           mse_use = args.mse_error;return;
        else
            mse_use = nan;
        end
        [tout,xout] = child_assign(t,x,tout,xout);
        % update
        x0 = x(end,:);
        x0(args.E2mediaindex) = treat.E2in;
        t_begin = t(end);
    end
    if t(end) < tspan(end)
       tspan_i = t(end):1:tspan(end);
       lastwarn('');
       ta = tic;
       option = odeset('Events',@(t,x)child_myeventfunction(t,x,ta),...
                       'RelTol',args.RelTolval,...
                       'AbsTol',args.AbsTolval);
       [t,x] = args.odefun(@(t,X)E2ICIpalboAZD_model(t,X,treat,args.PAR),tspan_i,x0,option);
       [warnMsg,~] = lastwarn;
       if child_check(x,t,warnMsg,tspan_i,args)
           mse_use = args.mse_error;return;
       else
           mse_use = nan;
       end
       [tout,xout] = child_assign(t,x,tout,xout);
    end
else
    tspan_i = tspan(1):1:tspan(end);
    lastwarn('');
    ta = tic;
    option = odeset('Events',@(t,x)child_myeventfunction(t,x,ta),...
                    'RelTol',args.RelTolval,...
                    'AbsTol',args.AbsTolval);
    [tout,xout] = args.odefun(@(t,X)E2ICIpalboAZD_model(t,X,treat,args.PAR),tspan_i,x0,option);
    [warnMsg,~] = lastwarn;
    if child_check(xout,tout,warnMsg,tspan_i,args)
        mse_use = args.mse_error;return;
    else
        mse_use = nan;
    end
end
simout = E2ICIpalboAZD_assignval(xout,args);
tout = tout+tstart;
end

function [values,isterminal,direction] = child_myeventfunction(t,~,t1)
% This function was originally intended to set a time limit for running
% simulations with particularly poor parameter sets during optimization.
% However, it may not be implemented correctly and the therefore does not
% function as intended.
values(1) = t;
% tlong = toc(t1);
values(2) = toc(t1) < 5.0; % seconds
isterminal = true(size(values));
direction = zeros(size(values));
end

function flag_err = child_check(x,t,warnMsg,tspan_i,args)
if ~isreal(x) ||...
   ~isempty(warnMsg) ||...
   max(t) < tspan_i(end) ||...
   max(x(end,args.ind_max) > args.maxconcentration) ||...
   min(x(end,:)) < args.minconcentration
   flag_err = true;
else
   flag_err = false;
end
end

function [tout, xout] = child_assign(t,x,tout,xout)
pos = t(1)+1;
tout(pos:t(end)+1) = t;
xout(pos:t(end)+1,:) = x;
end