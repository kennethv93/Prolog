%Schrijf 3 predicaten die werken op bomen en lijsten - de representatie
%van bomen volgt daarbij die gezien in de les van 21 februari.

%1) maak_boom/2
%
%   arg1: gesloten lijst met getallen; input
%   arg2: gebalanceerde boom die alle getallen uit arg1 bevat in prefix orde
%
%
%voorbeeld:
%
%?- maak_boom([1,2,3,4,5],B).
%
%B = boom(boom(leeg,boom(leeg,leeg,3),2),boom(leeg,boom(leeg,leeg,5),4),1)

maak_boom(X,B):-
	listlength(X,1),
	B = boom(leeg,leeg,Y),
	X = [Y|_],
	!.

maak_boom(X,B):-
	listlength(X,2),
	B = boom(leeg,boom(leeg,leeg,Y),Z),
	X = [Z|Rest],
	Rest = [Y|_],
	!.

maak_boom(X,B):-
	listlength(X,3),
	B = boom(Y,W,Z),
	X = [Z|Rest],
	Rest = [Y|Rest2],
	Rest2 = [W|_],
	!.
	
maak_boom(X,B):-
	B = boom(L,R,Root),
	X = [Root|Rest],
	split(Rest,Left,Right),
	maak_boom(Left,L),
	maak_boom(Right,R).

%2) verzamel_waarden/2
%
%   arg1: gegeven boom
%   arg2: output: lijst van waarden in de boom, in de infix orde
%
%verzamel_waarden(boom(boom(leeg,boom(leeg,leeg,3),2),boom(leeg,boom(leeg,leeg,5),4),1),Waarden).
%
%
%?- verzamel_waarden(boom(boom(leeg,boom(leeg,leeg,3),2),boom(leeg,boom(leeg,leeg,5),4),1),Waarden).
%
%Waarden = [2,3,1,4,5]
%
%
%Probeer dit met en zonder findall/3.
verzamel_waarden(leeg,Waarden):-
	Waarden = [],
	!.
verzamel_waarden(boom(leeg,leeg,X),Waarden):-
	Waarden = [X].

verzamel_waarden(boom(L,R,X),Waarden):-
	verzamel_waarden(L,WaardenL),
	verzamel_waarden(R,WaardenR),
	Waarden1 = WaardenL,
	append(Waarden1,[X],Waarden2),
	append(Waarden2,WaardenR,Waarden),
	!. 


%3) Schrijf een merge sort/2
msort(X,X):-
	listlength(X,1),
	!.
msort(List,Sorted):-
	split(List,L,R),
	msort(L,S1),
	msort(R,S2),
	merge(S1,S2,Sorted).

split([],[],[]).
split(List,L,R):-
	listlength(List,K),
	(
	0 is K mod 2 ->
		append(L,R,List),
		M is K/2,
		listlength(L,M)
	;
		append(L,R,List),
		listlength(L,N),
		K is 2*N-1
	).

listlength([],0).
listlength([ _ | Rest ],Len) :-
		listlength(Rest,LenRest),
		Len is LenRest + 1.