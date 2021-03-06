
%% Test V, X1, X2

% Expect that optimal groundwater pumping either increases or does not changes as
% t increases
for i = 1:length(s_pop)
    for j = 1:length(s_growth)
       for t = 2:N
        diff = X1(:,:,i,j,t) - X1(:,:,i,j,t-1);
        index = diff < 0;
            if sum(sum(index)) > 0
                error(['Invalid GW action, pumping does not monotonically increase at time ' num2str(t)])
            end
        end
    end
end

% Expect that V monotonically decreases as GW state increases (expected cost
% decreases with more groundwater available)
for i = 1:length(s_pop)
    for j = 1:length(s_growth)
        for k = i:length(s_expand)
            for t = 1:N
                for gw = 2:length(s_gw)
                    diff = V(gw-1,k,i,j,t) - V(gw,k,i,j,t);
                    index = diff < 0;
                        if sum(sum(index)) > 0
                            error(['Invalid GW action, pumping does not monotonically increase at gw state ' num2str(t)])
                        end
                end
            end
        end
    end
end

% Expect that V should never have Inf value because one of the available
% actions will be better than that
indexCountInf = find(V == Inf);
sumInf = sum(sum(sum(sum(sum(indexCountInf)))));
if sumInf > 0
    error('V has Inf values, did not choose an optimal action')
end



% Expect that V is always lower (cheaper) with desalination expanded,
% holding everything else the same

