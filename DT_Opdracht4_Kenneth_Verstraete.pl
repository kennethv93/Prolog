% main method
maglev(Stations,A,Z,Cost):-
	findall(X,maglev(Stations,A,Z,[],0,X),ListCosts),
	min_list(ListCosts, Cost).

% find paths without a switch
maglev(_,Z,Z,_,Cost,Cost):- !.
maglev(Stations,A,Z,H,AccCost,Cost):- 
	nextStation(Stations,A,N,H),
	maglev(Stations,N,Z,[A],AccCost,Cost).

% find paths with switching current beginstation (WERKT NIET DOOR
% NIET WERKENDE SWITCH)
maglev(Stations,A,Z,H,AccCost,Cost):- 
	nextStation(Stations,A,N,H),
	switch(A,station(NewA,NewZ,Rest)),
	maglev(N,Z,[A],AccCost,Cost).	 

% Get the next station
nextStation(Stations,A,Z,H):-
	member(station(A,Z,_),Stations),
	\+member(Z,H).
	
% Switch the current beginstation (WERKT NIET)
switch(station(A,Z,Other),Stations,[station(A,NewZ,[Z|NewOther])|Stations2]):-
	select(NewZ,Other,NewOther).
	select(station(A,Z,Other),Stations,Stations2).