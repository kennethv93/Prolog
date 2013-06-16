terras_tot_boom(b1,4).
terras_tot_boom(b2,4).
terras_tot_boom(b3,1).
terras_tot_boom(b4,6).
terras_tot_boom(b5,12).
boom_tot_boom(b1,b2,4).
boom_tot_boom(b2,b3,7).
boom_tot_boom(b2,b4,2).

emmer(5).
nodig(b1,2).
nodig(b2,2).
nodig(b3,3).
nodig(b4,2).
nodig(b5,5).

% OPGAVE 1
wandeling(P,L,S) :-
	findall(X,terras_tot_boom(X,_),LijstBomen),
	findall((Length,Pad),wandeling2(Pad,[t],Length,0,LijstBomen),ListPL),
	length(ListPL,S),
	sort(ListPL,[(L,P)|_]).
	
wandeling2(Pad,[X|Xs],Length,AccLength,[]) :-
	X = t, 
	Pad = [X|Xs],
	Length = AccLength.
	
wandeling2(Pad,[X|Xs],Length,AccLength,LijstBomen) :-
	X = t,
	LijstBomen \= [],
	terras_tot_boom(B,L),
	member(B,LijstBomen),
	AccLength2 is AccLength + L,
	delete(LijstBomen,B,LijstBomen2),
	wandeling2(Pad,[B|[X|Xs]],Length,AccLength2,LijstBomen2). 
	 
wandeling2(Pad,[X|Xs],Length,AccLength,LijstBomen) :-
	X \= t,
	(
		boom_tot_boom(X,B,L);
		boom_tot_boom(B,X,L)
	),
	member(B,LijstBomen),
	AccLength2 is AccLength + L,
	delete(LijstBomen,B,LijstBomen2),
	wandeling2(Pad,[B|[X|Xs]],Length,AccLength2,LijstBomen2).
	
wandeling2(Pad,[X|Xs],Length,AccLength,LijstBomen) :-
	X \= t,
	terras_tot_boom(X,L),
	AccLength2 is AccLength + L,
	wandeling2(Pad,[t|[X|Xs]],Length,AccLength2,LijstBomen).

% OPGAVE 2
	
water_geven(P,L) :-
	findall(X,terras_tot_boom(X,_),LijstBomen),
	findall((Length,Pad),(wandeling2(Pad,[t],Length,0,LijstBomen),isgoed(Pad)),LijstLP),
	sort(LijstLP,[(L,P)|_]),
	!.

isgoed([_|Xs]) :-
	splits(Xs,Lijst,[],[]),
	isgoed2(Lijst),
	!.
	
splits([t],Lijst,AccLijst,Acc) :-
	append(AccLijst,[Acc],Lijst).
	
splits([X|Xs],Lijst,AccLijst,Acc) :-
	X \= t,
	splits(Xs,Lijst,AccLijst,[X|Acc]).
	
splits([t|Xs],Lijst,AccLijst,Acc) :-
	append(AccLijst,[Acc],NewAccLijst),
	splits(Xs,Lijst,NewAccLijst,[]).

isgoed2([]).	
isgoed2([X|Xs]) :-
	waternodig(X,L,0),
	emmer(I),
	L =< I,
	isgoed2(Xs).

waternodig([],L,L).	
waternodig([X|Xs],L,Acc) :-
	nodig(X,Nodig),
	NewAcc is Acc + Nodig,
	waternodig(Xs,L,NewAcc).