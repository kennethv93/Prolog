:- module(contestlib,
		  [sublist/2,
		  write_elements/1,
		  writeN/2,
		  for/3,
		  numlist/3,
		  int_width/2,
		  write_int/2,
		  map/3]).
		  
sublist([],[]).
sublist([X|R],[X|S]) :- sublist(R,S).
sublist([_|R],S) :- sublist(R,S).

write_elements([]).
write_elements([X|R]) :- write(X), writ_elements(R).

writeN(N,C) :-
	( N > 0 ->
		M is N - 1,
		write(C),
		writeN(M,C)
	;
		true
	).
	
for(I,I,J) :- I =< J.
for(K,I,J) :- I < J,
		I1 is I + 1,
		for(K,I1,J).
		
numlist(I,J,List) :-
	( I =< J ->
		List = [I|Rest],
		I1 is I + 1,
		numlist(I1,J,Rest)
	;
		List = []
	).

int_width(N,Width) :-
	( N > 9 ->
		M is N // 10,
		int_width(M,WidthM),
		Width is WidthM  + 1
	;
		Width = 1
	).
	
write_int(Int,Width) :-
	int_width(Int,WidthInt),
	Spaces is Width - WidthInt,
	writeN(Spaces,' '),
	write(Int).
	
map([],_,[]).
map([X|R],C,[CX|CR]) :-
	call(C,X,CX),
	map(R,C,CR).
