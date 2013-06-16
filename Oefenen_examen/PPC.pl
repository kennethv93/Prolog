:- use_module(contestlib,[for/3]).
% 1. Triplets
triplets([X,Y,Z]) :-
	digit(X),
	digit(Y),
	digit(Z),
	X \== Y,
	X \== Z,
	Y \== Z,
	Z > 0,
	(10*X + Y)*Z =:= (10*Y + Z)*X.
	
digit(Digit) :- for(Digit,0,9).