%?- allepaden([(a,y),(a,b),(b,y),(y,z),(y,x),(x,z)],a,z,L).
%   L = [[z, y, a], [z, x, y, a], [z, y, b, a], [z, x, y, b, a]].
%?- allepaden([(a,y),(a,b),(b,y),(y,z),(y,x),(x,z)],a,niks,L).
%   L = [].

allepaden(List,A,Z,L):-
	findall(X,allepaden2(List,A,Z,X),L).
	
allepaden2(List,A,Z,[A|Rest]):-
	member((A,B),List),
	allepaden2(List,B,Z,Rest).
	
allepaden2(List,A,Z,[Z]):- 
	member((A,Z),List). 