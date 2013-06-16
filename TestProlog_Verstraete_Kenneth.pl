%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OPGAVE 1 NIVEAU 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
max_overeenkomst1(L1,L2,S,MaxLen) :-
	findall(X,max_overeenkomst(L1,L2,X,_),ListX),
	findall(X,max_overeenkomst(L1,L2,_,X),ListLen),
	max_list(ListLen,MaxLen),
	member(S,ListX),
	length(S,MaxLen).

max_overeenkomst(L1,L2,S1,Len) :-
	S1 = S2,
	length(L1,Length1),
	length(L2,Length2),
	between(1,Length1,I1),
	between(1,Length1,I2),
	I1 < I2,
	between(1,Length2,I3),
	between(1,Length2,I4),
	I3 < I4,
	slice(L1,I1,I2,S1),
	slice(L2,I3,I4,S2),
	length(S1,Len). 

slice(List,I,K,L) :-
	length(List,Length),
	I2 is I - 1,
	length(L1,I2),
	append(L1,L2,List),
	append(L,L4,L2),
	I3 is Length - K,
	length(L4,I3).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OPGAVE 2 NIVEAU 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
splits1([X|Xs],Woorden) :-
	X \= space,
	splits1(Xs,[X],[],Woorden).
	
splits1([X|Xs],Woorden) :-
	X = space,
	splits1(Xs,Woorden).
	
splits1([X|Xs],Acc1,Acc2,Woorden) :-
	X \= space, 
	append(Acc1,[X],NewAcc1), 
	splits1(Xs,NewAcc1,Acc2,Woorden).	

splits1([X|Xs],Acc1,Acc2,Woorden) :- 
	X = space,
	append(Acc2,[Acc1],NewAcc2), 
	splits1(Xs,[],NewAcc2,Woorden).

	   
splits1([],Acc1,Acc2,Woorden) :-
	append(Acc2,[Acc1],Woorden).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OPGAVE 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dijkstra(BIn,NIn,Doel,Afstand) :-
        (member(Doel-Afstand,BIn) ->
            true
        ;
            kieskleinste(NIn,Knoop,Afstand,NIn1),
            pasburenaan(Knoop,NIn1,NieuweIn),
            dijkstra([Knoop/Afstand|BIn],NieuweIn,Doel,Afstand)
        ).