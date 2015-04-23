-module(lib_misc).
-export([qsort/1, pythag/1, perms/1, odds_and_evens/1,
	 count_chars/1, sqrt/1]).

qsort([])			-> [];
qsort([Pivot|T])	->
	qsort([X || X <- T, X < Pivot])
	++ [Pivot] ++
	qsort([X || X <- T, X >= Pivot]).

pythag(N)	->
	[ {A,B,C} ||
		A <- lists:seq(1, N),
		B <- lists:seq(1, N),
		C <- lists:seq(1, N),
		A+B+C =< N,
		A*A+B*B =:= C*C
	].

perms([])	-> [[]];
perms(L)	-> [[H|T] || H<-L, T<-perms(L--[H])].

odds_and_evens(L)	-> odds_and_evens_acc(L, [], []).
odds_and_evens_acc([H|T], Odds, Evens)	-> 
	case H rem 2 of
		0 -> odds_and_evens_acc(T, Odds, [H|Evens]);
		1 -> odds_and_evens_acc(T, [H|Odds], Evens)
	end;
odds_and_evens_acc([], Odds, Evens)	->
	{lists:reverse(Odds), lists:reverse(Evens)}.

count_chars(Str)	-> count_chars(Str, #{}).

count_chars([H|T], X)	->
	case maps:find(H, X) of
		{ok, Val}	-> count_chars(T, maps:update(H, Val+1, X));
		error		-> count_chars(T, maps:put(H, 1, X))
	end;
count_chars([], X)		-> X.

sqrt(X) when X<0	-> error({squareRootNegativeArgument, X});
sqrt(X)	-> math:sqrt(X).
