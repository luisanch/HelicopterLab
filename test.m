syms l2 l3 e p vs vst vs0 je

eqn = ((l2 * cos(e)) + l3*(vst+vs0)*cos(p))/je == 0;

S = solve(eqn, vs0,'ReturnConditions',true);
