determiner(S,P1,P2,[every|X],X,all(S,imply(P1,P2))).
determiner(S,P1,P2,[a|X],X,exists(S,and(P1,P2))).

noun(N,[man|X],X,man(N)).
noun(N,[woman|X],X,woman(N)).
noun(N,[child|X],X,child(N)).

name([john|X],X,john()).
name([mary|X],X,mary()).
name([luke|X],X,luke()).

transVerb(S,O,[loves|X],X,loves(S,O)).
transVerb(S,O,[knows|X],X,knows(S,O)).

intransVerb(S,[lives|X],X,lives(S)).
intransVerb(S,[runs|X],X,runs(S)).

sentence(X0,X,P) :- nounPhrase(N,P1,X0,X1,P),verbPhrase(N,X1,X,P1).

nounPhrase(N,P1,X0,X,P) :- determiner(N,P2,P1,X0,X1,P),noun(N,X1,X2,P3),relClause(N,P3,X2,X,P2).
nounPhrase(N,P1,X0,X,P1) :- name(X0,X,N).
    
verbPhrase(S,X0,X,P) :- transVerb(S,O,X0,X1,P1), nounPhrase(O,P1,X1,X,P).
verbPhrase(S,X0,X,P) :- intransVerb(S,X0,X,P).

relClause(S,P1,[who|X1],X,and(P1,P2)) :- verbPhrase(S,X1,X,P2). 
relClause(S,P1,[who|X1],X,and(P1,P2)) :- name(X1,X0,N),transVerb(N,S,X0,X,P2).
relClause(S,P1,X,X,P1). 

% input = sentence([every,man,who,loves,a,child,knows,a,woman,who,lives],[],P).
% output = P = all(_1752, imply(and(man(_1752), exists(_1774, and(child(_1774), loves(_1752, _1774)))), exists(_1796, and(and(woman(_1796), lives(_1796)), knows(_1752, _1796)))))
% output = P = all(X,imply(and(man(X),exists(Y,and(child(Y),loves(X,Y)))),exists(Z,and(and(woman(Z),lives(Z),knows(X,Y)))).
% 

% input = sentence([a,man,who,loves,a,woman,who,knows,every,child,knows,luke],[],P).
% output = P = exists(_1758, and(and(man(_1758), exists(_1780, and(and(woman(_1780), all(_1802, imply(child(_1802), knows(_1780, _1802)))), loves(_1758, _1780)))), knows(_1758, luke())))
% output = P = exists(X,and(and(man(X),exists(Y,and(and(woman(Y),all(Z,imply(child(Z),knows(N,Z)))),loves(X,Y)))),knows(X,luke()))).

% input = sentence([every,man,who,knows,every,woman,who,luke,loves,runs],[],P).
% output = P = all(_1746, imply(and(man(_1746), all(_1768, imply(and(woman(_1768), loves(luke(), _1768)), knows(_1746, _1768)))), runs(_1746))).
% output = p = all(X,imply(and(man(X),all(Y, imply(and(woman(Y), loves(luke,Y)), konws(X,Y)))), runs(X))).

% input = sentence([every,man,who,knows,every,woman,who,loves,luke,runs],[],P).
% output = P = all(_1730, imply(and(man(_1730), all(_1752, imply(and(woman(_1752), loves(_1752, luke())), knows(_1730, _1752)))), runs(_1730)))
% output = P = all(X,imply(and(man(X), all(Y,imply(and(woman(Y), loves(Y,luke())),knows(Z,Y)))).