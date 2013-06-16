% 1.01
my_last(X,[X]).
my_last(X,[_|T]) :-
	my_last(X,T),
	!.
	
% 1.02
my_lastb1(X,[X,_]).
my_lastb1(X,[_|T]) :-
	my_lastb1(X,T),
	!.
	
% 1.03
element_at(X,[X|_],1).
element_at(X,[_|T],K) :-
	NewK is K - 1,
	element_at(X,T,NewK),
	!.
	
% 1.04
sizelist([_|Xs],Size) :-
	size2(Xs,Size,1).
	
size2([],Size,Size).
size2([_|Xs],Size,Acc) :-
	NewAcc is Acc + 1,
	size2(Xs,Size,NewAcc).
	
% 1.05
reverselist([X],[X]).
reverselist([X|Xs],Result) :-
	append(ReversedXs,[X],Result),
	reverselist(Xs,ReversedXs),
	!.
	 
% 1.06
ispalindrome(X) :-
	reverselist(X,R),
	X = R.
	
% 1.07
my_flatten(X,[X]) :- \+is_list(X).
my_flatten([],[]).
my_flatten([X|Xs],R) :-
	append(RX,RXs,R),
	my_flatten(X,RX),
	my_flatten(Xs,RXs),
	!.
	
% 1.08
compress([],[]).
compress([X],[X]).
compress([X,X|Xs],R) :-
	compress([X|Xs],R),
	!.
compress([X,Y|Xs],[X|R]) :-
	X \= Y,
	compress([Y|Xs],R),
	!.
	
% 3.01
and(A,B) :-
	A = true,
	B = true.

or(A,B) :-
	and(A,B),!.
	
or(A,B) :-
	A = true,
	B = false,!.
	
or(A,B) :-
	A = false,
	B = true,!.







	
	
	
	