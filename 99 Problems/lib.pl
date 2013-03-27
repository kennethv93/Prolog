pack([Head|Rest],Res) :-
	pack([Head|Rest],[],[],Res).
	
pack([Head|Rest],Acc,Acc2,Res) :-
	(member(Head,Acc) ->
		pack(Rest,[Head|Acc],Acc2,Res)
	;
		append2(Acc,Acc2,NewAcc),
		pack(Rest,[Head],NewAcc,Res)
		
	).
	
pack([],Acc,Acc2,Result) :-
	append2(Acc,Acc2,TssResult),
	reverse(TssResult,Result).
	
append2(L,R,New) :-
	length(L,Length),
	(Length = 0 ->
		append(L,R,New)
	;
		append([L],R,New)
	).