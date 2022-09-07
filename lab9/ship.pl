% Render the ship term as a nice table.
:- use_rendering(table,
		 [header(s('Ship', 'Leaves at', 'Carries', 'Chimney', 'Goes to'))]).

% Each ship is represented a term, s(S,L,Ca,Ch,G). A list of 5 such terms is a solution.
goes_PortSaid(Goes) :-
	ships(S),
	member(s(Goes,_,_,_,portSaid), S).

carries_tea(Carries) :-
	ships(S),
	member(s(Carries,_,tea,_,_), S).

ships(S) :- 
  length(S,5),
  ... % Rules 1 - 15
  member(s('Greek','Six','Coffee',_,_),S),
  HS=[_,_,s(_,_,_,'Black',_),_,_],
  member(s('English','Nine',_,_,_),S),
  HS=[s('French',_,_,'Blue',_), s(_,_,'Coffee',_,_),_,_,_],
  HS=[_,_,_,s(_,_,"Cocoa,_,_), s(_,_,_,_,'Marseille)],
  member(s('Brazilian',_,_,_,'Manila'),S),
  next(s(_,_,'Rice',_,_), s(_,_,_,'Green',_),S),
  member(s(_,'Five',_,_'Geona')S),
  HS=[_,_,_,s(_,_,_,_,'Marseille'), s('Spanish','Seven',_,_,_)],
  member(s(_,_,_,'Red','Hamburg')S),
  next=(s(_,'Seven',_,_,_), s(_,_'Corn',_,_),S),
  HS=[_,_,_,_,s(_,_,'Corn',_,_)],
  member(s(_,'Eight',_,'Black',_)S),
  HS=[_,_,_,s(_,_,'Rice',_,_),s(_,_,'Corn',_,_)],
  member(s(_,'Six',_,_,'Hamburg')S),
  member(s(_,_,_,_,portSaid),S).   % forces some ship to go to Port Said
  member(s(_,_,tea,_,_),S).        % forces some ship to carry tea



  

% Predicates for capturing relationships in a list of ships, Ls
next(A, B, Ls) :- append(_,[A,B|_],Ls).  % A and B are next to one another
left(A, B, Ls) :- append(A,B,_,_,Ls).  % A is to the left of B (and thus B is to the right of A)
border(A, Ls) :- append(_,_,_,A,Ls).   % A is on the border




--------------------
Ans

French	5:00	tea	blue	Genoa
Greek	6:00	coffee	red	Hamburg
Brazilian	8:00	cocoa	black	Manila
English	9:00	rice	white	Marseille
Spanish	7:00	corn	green	Port Said
