-module(mylists).
-export([sum/1, map/2, filter/2, filter1/2]).

sum([H|T])	-> H + sum(T);
sum([])		-> 0.

map(_, [])		-> [];
map(F, [H|T])	-> [F(H)|map(F, T)].

filter(P, [])		-> [];
filter(P, [H|T])	->
	case P(H) of
		true	-> [H|filter(P, T)];
		false	-> filter(P, T)
	end.

filter1(P, [])		-> [];
filter1(P, [H|T])	-> filter2(P(H), P, H ,T).

filter2(true, P, H, T)	-> [H|filter1(P, T)];
filter2(false, P, H, T)	-> filter1(P, T).