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




%3) Schrijf een merge sort/2
msort([],[]).
msort([L|R],Sorted):-
	split([],L,R).
	
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
		Len is LenRest + 1 . 

