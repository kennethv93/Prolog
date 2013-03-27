:- use_module(test1maglev).

maglev(Stations,Start,End,Cost) :-
	findall(X,maglev(Stations,Start,End,0,X,[]),CostList),
	min_list(CostList,Cost). % builtin function in swi-prolog
	
maglev(_,End,End,Cost,Cost,_) :- !. % End case. The accumulated cost is the end cost.
maglev(Stations,Start,End,AccCost,Cost,History) :-
	next_station(Stations,Start,Next),
	% Avoid useless loops. Any switches done on the 2nd visit, could
	% already have been done on the 1st visit.
	\+ count(member(Start-Next,History),2),
	(
		% Try reaching the end without performing a switch on this station.	
		maglev(Stations,Next,End,AccCost,Cost,[Start-Next|History])
		;
		(
		% Try reaching the end while performing a switch on this station.
		switch(Stations,Start,NewStations),
		NewAccCost is AccCost + 1,
		maglev(NewStations,Next,End,NewAccCost,Cost,[Start-Next|History])
		)
	).

next_station([station(Start,Next,_)|_],Start,Next) :-!. % If station found, cut and return the next.
next_station([station(_,_,_)|Rest],Start,Next) :- % Else, try the next station.
	next_station(Rest,Start,Next).

switch([station(Station,_,Alternatives)|Rest], Station, [station(Station,NewNext,NewAlternatives)|Rest]) :-
	!, select(NewNext,Alternatives,NewAlternatives). % If station found, cut and perform switch.
switch([First|Rest], Station, [First|NewRest]) :- % Else, try the next station.
	switch(Rest,Station,NewRest).





/* Deze methode kan je gebruiken als de data al ingeladen is. */
maglevkost(Kost) :-
	findall(station(A,B,C),station(A,B,C),Stations),
	van_naar(Start,End),
	maglev(Stations,Start,End,Kost).