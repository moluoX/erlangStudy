-module(try_test).
-export([gen_ex/1, demo1/0, demo2/0, demo3/0]).

gen_ex(1)	-> a;
gen_ex(2)	-> throw(a);
gen_ex(3)	-> exit(a);
gen_ex(4)	-> {'EXIT', a};
gen_ex(5)	-> error(a).

demo1()	-> [catcher(I) || I <- [1,2,3,4,5]].

catcher(N)	->
	try gen_ex(N) of
		Val	-> {N, normal, Val}
	catch
		throw:X	-> {N, caught, thrown, X};
		exit:X	-> {N, caught, exited, X};
		error:X	-> {N, caught, error, X}
	end.

demo2()	->
	[{I, (catch gen_ex(I))} || I <- [1,2,3,4,5]].

demo3()	->
	try gen_ex(5)
	catch
		error:X -> {X, erlang:get_stacktrace()}
	end.
