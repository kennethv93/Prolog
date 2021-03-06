%%%%%%%%%%%%%%%%
%% ListLength %%
%%%%%%%%%%%%%%%%
	listlength([],0).
	listlength([ _ | Rest ],Len) :-
		listlength(Rest,LenRest),
		Len is LenRest + 1.

/*
1) maak_boom/2

	arg1: gesloten lijst met getallen; input
	arg2: gebalanceerde boom die alle getallen uit arg1 bevat in prefix orde
*/

	% BASE CASES 
		% Boom met geen elementen
			maak_boom([],leeg):-!.
			
		% Boom met 1 element
			maak_boom(X,B):-
				listlength(X,1),
				B = boom(leeg,leeg,Y),
				X = [Y|_],
				!.
		
		% Boom met 2 elementen (voor de uitvoer zoals in het voorbeeld
		% te bekomen)
			maak_boom(X,B):-
				listlength(X,2),
				B = boom(leeg,boom(leeg,leeg,Y),Z),
				X = [Z|Rest],
				Rest = [Y|_],
				!.
	
	% COMPLEX CASE
		maak_boom(X,B):-
			B = boom(L,R,Root),
			X = [Root|Rest],
			split(Rest,Left,Right),
			maak_boom(Left,L),
			maak_boom(Right,R),
			!.

/*
2) verzamel_waarden/2

 arg1: gegeven boom
 arg2: output: lijst van waarden in de boom, in de infix orde

Probeer dit met en zonder findall/3.
*/

% ZONDER FINDALL

	% BASE CASES
		verzamel_waarden(leeg,[]):-!.
			
		verzamel_waarden(boom(leeg,leeg,X),[X]):-!.
	
	% COMPLEX CASE
		verzamel_waarden(boom(L,R,X),Waarden):-
			verzamel_waarden(L,WaardenL),
			verzamel_waarden(R,WaardenR),
			Waarden1 = WaardenL,
			append(Waarden1,[X],Waarden2),
			append(Waarden2,WaardenR,Waarden),
			
			% Waarden1 = WaardenL overbodig
			% app(WaardenL,[X|WR],W) ipv 2 append
		!.

% MET FINDALL

	% definiëren boom-predicaat
		boom(leeg,leeg,_).
	
	% BASE CASES
		verzamel_waarden_findall(leeg,[]):-!.
		
		verzamel_waarden_findall(boom(leeg,leeg,X),Waarden):-
			findall(X,boom(leeg,leeg,X),Waarden),
		!.
	
	% COMPLEX CASE
		verzamel_waarden_findall(boom(L,R,X),Waarden):-
			verzamel_waarden_findall(L,WaardenL),
			verzamel_waarden_findall(R,WaardenR),
			Waarden1 = WaardenL,
			append(Waarden1,[X],Waarden2),
			append(Waarden2,WaardenR,Waarden),
			!.

/*
3) Schrijf een merge sort/2
*/

% merge sort
	mergesort([],[]):-!.
	mergesort(X,X):-
		listlength(X,1),
		!.
		
	mergesort(List,Sorted):-
		List \= [],
		split(List,L,R),
		mergesort(L,SortedL),
		mergesort(R,SortedR),
		merge_(SortedL,SortedR,Sorted),
		!.

% splitting
	split(List,L,R):-
		listlength(List,Length),
		(
		0 is Length mod 2 ->
			append(L,R,List),
			M is Length/2,
			listlength(L,M)
		;
			append(L,R,List),
			listlength(L,N),
			Length is 2*N-1
		),
		!.

% merging
	%merge_([],[],[]):-!.
	merge_(X,[],X):-!.
	merge_([],X,X):-!.
	
	merge_(X,Y,Result):-
		%X\=[],
		%Y\=[],
		X = [XHead|XRest],
		Y = [YHead|YRest],
		(
		XHead < YHead ->
			merge_(XRest,Y,MergeResult),
			append([XHead],MergeResult,Result)
		;
			merge_(X,YRest,MergeResult2),
			append([YHead],MergeResult2,Result)
		),
		!.