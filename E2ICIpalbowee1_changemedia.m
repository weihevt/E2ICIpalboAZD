function changemedia = E2ICIpalbowee1_changemedia(tspan)
% t unit: hours
changemedia1 = 3:7:tspan(end)/24;
changemedia2 = 7:7:tspan(end)/24;
changemedia = sort([changemedia1,changemedia2]);
changemedia = changemedia(changemedia*24 > tspan(1));
end