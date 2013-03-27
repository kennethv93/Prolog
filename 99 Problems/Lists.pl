% 1.01 ------------------------------------
my_last(X,[X,_]).
my_last(X,[_|L]) :- my_last(X,L).
% 1.03 ------------------------------------
element_at(X,[X|_],1).
element_at(X,[_|L],K) :-
	K > 1,
	J is K - 1,
	element_at(X,L,J).
% 1.04 ------------------------------------
nbelements([_],1).
nbelements([_|Xs],Nb) :-
	nbelements(Xs,Nb2),
	Nb is Nb2 + 1.
% 1.05 ------------------------------------
my_reverse(L1,L2) :- my_reverse(L1,L2,[]).

my_reverse([],L2,L2).
my_reverse([X|Y],L2,Acc) :-
	my_reverse(Y,L2,[X|Acc]).
% 1.06 -----------------------------------
ispalindrome(List) :-
	my_reverse(List,List).
% 1.07 -----------------------------------
my_flatten([],[]).
my_flatten(X,[X]) :- \+is_list(X).
my_flatten([X|Xs],List) :-
	my_flatten(X,Y), my_flatten(Xs,Ys),
	append(Y,Ys,List).
% 1.08 -----------------------------------
compress([],[]).
compress([X],[X]).
compress([X,X|Xs],Res) :-
	compress([X|Xs],Res).
compress([X,Y|Xs],[X|Res]) :-
	X \= Y, 
	compress([Y|Xs],Res).
% 1.09 ----------------------------------
pack(List,Res) :-
	pack(List,[],[],Res).

pack(X,[],[],[X]).
pack([X,X|Xs],Acc,Acc2,Res) :- 
	pack([X|Xs],[X|Acc],Acc2,Res).
pack([X,Y|Xs],Acc,Acc2,Res) :-
	X \= Y,
	pack([Y|Xs],[],[Acc2|[X|Acc]],Res).
pack([],_,Y,Y).
% 1.14 ---------------------------------
%dupli([],[]).
%dupli([X|Xs],[X,X|Y]) :-
%	dupli(Xs,Y).
% 1.15 ---------------------------------
dupli([],_,[]).
dupli([X|Xs],K,Res) :- 
	is_times(K,[X],Y),
	dupli(Xs,K,Ys),
	append(Y,Ys,Res).

is_times(0,[_],[]).
is_times(N,[X],Res) :-
	N > 0,
	append([X],Y,Res),
	M is N - 1, 
	is_times(M,[X],Y).
	

% 1.16 --------------------------------
drop(List,N,Y) :-
	drop(List,N,N,Y).
	
drop([X|Xs],N,K,[X|Y]) :-
	K > 1,
	J is K - 1,
	drop(Xs,N,J,Y).
	
drop([_|Xs],N,1,Y) :-
	drop(Xs,N,N,Y).

drop([],_,_,[]).
% 1.17 ------------------------------
split([X|Xs],K,[X|L1],L2) :-
	K > 0,
	K2 is K - 1,
	split(Xs,K2,L1,L2).
	
split(X,0,[],X).
% 1.18 -----------------------------
slice(List,I,K,L) :-
	length(List,Length),
	I2 is I - 1,
	length(L1,I2),
	append(L1,L2,List),
	append(L,L4,L2),
	I3 is Length - K,
	length(L4,I3).
% 1.19 ---------------------------
rotate(X,0,X).
rotate(List,N,X) :-
	(
	N > 0 ->
		split(List,N,L1,L2),
		append(L2,L1,X)
	;
		length(List,Length),
		I is Length + N,
		split(List,I,L1,L2),
		append(L2,L1,X)
	).
% 1.20 ------------------------
remove_at(X,List,N,R) :-
	element_at(X,List,N),
	N2 is N - 1,
	length(L1, N2),
	append(L1,[X|L2],List),
	append(L1,L2,R).
% 1.21 ------------------------
insert_at(X,List,N,L) :-
	remove_at(X,L,N,List).
% 1.22 ------------------------
range(B,B,[B]).
range(A,B,[A|Y]) :-
	A < B,
	A2 is A + 1,
	range(A2,B,Y).
% 1.23 ------------------------

% 1.24 ------------------------

% 1.25 ------------------------











