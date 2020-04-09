function [pontos,S,phi1] = findOut(xx,p,S0)
	% - This function finds a solution for the p-median problem using
	%  Whitaker's algorithm.
	%
	% - d is the distance matrix of size nxm, where n is the number of users
	% and m is the number of facilities;
	% - p is the number of medians;
	% - S0 (optional) is the initial solution;
	% - S is the solution, the best set of p facilities found;
	% - phi1 is the nearest facility (in S) for each user;
	%
	% - We assume 1 <= p <= m

	if size(xx,1) == p
		centros = xx;
		return;
	end
	d = matriz_distancia(xx);


	[n,m] = size(d);
	%% Trivial cases
	if p == 1
		[~,S] = min(sum(d));
		phi1 = S;
		return;
	elseif p == m
		S = 1:m;
		phi1 = ones(n,1);
		for u = 1:n
			for f = 2:m
				if d(u,f) < d(u,phi1(u))
					phi1(u) = f;
				end
			end
		end
		return;
	elseif p >= n
		phi1 = ones(n,1);
		for u = 1:n
			for f = 2:m
				if d(u,f) < d(u,phi1(u))
					phi1(u) = f;
				end
			end
		end
		S = unique(phi1');
		len = length(S);
		S = [S,zeros(1,p-len)];
		f = 1;
		for l = len+1:p
			found = true;
			while found
				found = false;
				for s = 1:len
					if S(s)==f
						found = true;
						f = f + 1;
						break;
					end
				end
			end
			S(l) = f;
			f = f + 1;
		end
		return;
	end

	%% Initialization
	if nargin==3
		S = S0;
	else
		S = randperm(m,p);
	end
	binS = zeros(1,m);
	for pp = 1:p
		binS(S(pp)) = 1;
	end
	phi1 = zeros(n,1);
	phi2 = zeros(n,1);
	for u = 1:n
		if d(u,S(1)) < d(u,S(2))
			phi1(u) = S(1);
			phi2(u) = S(2);
		else
			phi2(u) = S(1);
			phi1(u) = S(2);
		end
		for pp = 3:p
			if d(u,S(pp)) < d(u,phi1(u))
				phi2(u) = phi1(u);
				phi1(u) = S(pp);
			elseif d(u,S(pp)) < d(u,phi2(u))
				phi2(u) = S(pp);
			end
		end
	end

	%% Algorithm
	v = zeros(1,size(d,2));
	while true
		bestProfit = -inf;
		for fi = 1:m % For each fi find best fr
			if binS(fi) == 1 % fi must not be in S
				continue;
			end
			w = 0;
			for pp = 1:p
				v(S(pp)) = 0;
			end
			for u = 1:n
				if d(u,fi) < d(u,phi1(u)) % Profit if fi is close enough to u
					w = w + d(u,phi1(u)) - d(u,fi);
				else                      % Loss if facility that is closest to u is removed
					v(phi1(u)) = v(phi1(u)) + min(d(u,fi),d(u,phi2(u))) - d(u,phi1(u));
				end
			end
			[vfr,id] = min(v(S));
			fr = S(id);
			profit = w - vfr;
			if profit > bestProfit % Save profit, fr and fi if fi and fr make the best profitable swap
				bestProfit = profit;
				bestFr = fr;
				bestFi = fi;
			end
		end
		if bestProfit <= 0 % If there's no more profitable swap
			% local minimum found
			break;
		else
			% Update S and binS
			binS(bestFr) = 0;
			binS(bestFi) = 1;
			for pp = 1:p
				if S(pp) == bestFr
					S(pp) = bestFi;
					break;
				end
			end
			% Update phi1 and phi2
			for u = 1:n
				if bestFr == phi1(u)    % If removing best facility for u
					if d(u,bestFi) < d(u,phi2(u))
						phi1(u) = bestFi;
					else
						phi1(u) = phi2(u);
						phi2(u) = bestFi;
						for pp = 1:p
							if S(pp) ~= phi1(u) && d(u,S(pp)) < d(u,phi2(u))
								phi2(u) = S(pp);
							end
						end
					end
				elseif bestFr == phi2(u) % If removing second best facility for u
					if d(u,bestFi) < d(u,phi1(u))
						phi2(u) = phi1(u);
						phi1(u) = bestFi;
					elseif d(u,bestFi) < d(u,phi2(u))
						phi2(u) = bestFi;
					else
						phi2(u) = bestFi;
						for pp = 1:p
							if S(pp) ~= phi1(u) && d(u,S(pp)) < d(u,phi2(u))
								phi2(u) = S(pp);
							end
						end
					end
				else                     % If removing any other facility
					if d(u,bestFi) < d(u,phi1(u))
						phi2(u) = phi1(u);
						phi1(u) = bestFi;
					elseif d(u,bestFi) < d(u,phi2(u))
						phi2(u) = bestFi;
					% else do nothing
					end
				end
			end
		end
	end
	pontos = xx(S,:);
end