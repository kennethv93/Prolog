m(N,M) :-
	findall(wit,between(1,N,_),Witten),
	findall(zwart,between(1,M,_),Zwarten),
	append(Witten,[leeg|Zwarten],Alles),
	append(Zwarten,[leeg|Witten],Omgekeerd),
	schuif(Alles,Omgekeerd).
	
schuif(In,Doel) :-
	(In == Doel ->
		true
	;
		schuif1(In,NewIn),
		schuif(NewIn,Doel)
	).
	
schuif1(In,Out) :-
	once(append(L,[wit,leeg|R],In)),
	append(L,[leeg,wit|R],Out).
schuif1(In,Out) :-
	once(append(L,[leeg,zwart|R],In)),
	append(L,[zwart,leeg|R],Out).
schuif1(In,Out) :-
	once(append(L,[wit,zwart,leeg|R],In)),
	append(L,[leeg,zwart,wit|R],Out).
schuif1(In,Out) :-
	once(append(L,[leeg,wit,zwart|R],In)),
	append(L,[zwart,wit,leeg|R],Out).
%	
%	
%m(N,M) :-
%	findall(wit,between(1,N,_),Witten),
%	findall(zwart,between(1,M,_),Zwarten),
%	append(Witten,[leeg|Zwarten],Alles),
%	append(Zwarten,[leeg|Witten],Omgekeerd),
%	schuif(s(Witten,Zwarten),s(Zwarten,Witten)).
%	
%schuif(In,Doel) :-
%	(In == Doel ->
%		true
%	;
%		schuif1(In,NewIn),
%		schuif(NewIn,Doel)
%	).
%	
%schuif1(s([wit|L],R),s(L,[wit|R])).
%schuif1(s(L[zwart|R]),s([zwart|L],R)).
%schuif1(s([zwart,wit|R],L),s(R,[zwart,wit|L])).