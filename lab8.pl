-------------------------------part1-------------------------------

deal([],[],[]).
deal([X|XS],[X|YS],ZS) :- deal(XS,ZS,YS).

merge([],Y,Y).
merge(Y,[],Y).
merge([X|XS],[Y|YS],[Z|ZS]) :- X=<Y ->  X=Z, merge(XS,[Y|YS],ZS).
merge([X|XS],[Y|YS],[Z|ZS]) :- X>Y ->  Y=Z, merge([X|XS],YS,ZS).

ms([],[]).
ms([X],[X]).
ms(Y,Z) :-deal(Y,ZS,YS), ms(ZS,X),ms(YS,X2), merge(X,X2,Z).

cons(P, nil, snoc(nil,P)).
cons(P, snoc(Y,Z), snoc(PX,Z)) :- cons(Z, Y, PX).

toBLIst([],nil).
toBList([X|XS],Y). :- toBList(XS,V), cons(X,V,Y).

snoc(X,Y).
snoc(X,[Z],Y).

fromBList(nil,[]).
fromBList(snoc(nil,E),E).
fromBList(snoc(BL,N),Res) :-  fromBList(BL,List),snoc(List,N,Res).

num_empties(empty,1).
num_empties(node(_,L,R),Res) :- num_empties(L,R1),num_empties(R,R2), Res is R1+R2.

num_nodes(empty,0).
num_nodes(node(_,L,R),Res) :- num_nodes(L,R1),num_nodes(R,R2), Res is R1+R2+1.

insert_left(A,Empty,node(A,Empty,Empty)).
insert_left(A,node(B,C,D),node(b,BC,D)) :-insert_left(A,C,BC).

insert_right(A,Empty,node(A,Empty,Empty)).
insert_right(A,node(B,L,R),node(B,L,BR)) :-insert_right(A,R,AR).

sum_nodes(empty,0).
sum_nodes(node(E,L,R),Res) :- sum_nodes(L,Num2),sum_nodes(R,Num3), Res is E+Num2+Num3.


inorder(empty,[]).
inorder(node(E,empty,empty),[E]).
inorder(node(E,L,R),Res) :- inorder(L,List1),inorder(R,List2),append(List1,[E],FH),append(FH,List2,Res).

num_elts(T,N) :- neh([T],0,N).
neh([],A,A).
neh([leaf(_)|Ts],A,N) :- AE is A+1, neh(Ts,AE,N).
neh([node2(_,L,R)|Ts],A,N) :- AE is A+1, neh([L,R|Ts],AE,N). 

sum_nodes2(leaf(E),E).
sum_nodes2(node2(E,L,R),Res) :- sum_nodes2(L,R1),sum_nodes2(R,R2), Res is E+R1+R2.

inorder2(leaf(E),[E]).
inorder2(node2(E,L,R),Res) :- inorder2(L,List1),inorder2(R,List2),append(List1,[E],FH),append(FH,List2,Res).

conv21(leaf(E),node(E,empty,empty)).
conv21(node2(E,L,R),node(E,L2,R2)) :- conv21(L,L2),conv21(R,R2).

----------------------PART2----------------------------

oBList_it(L,Res) :- ltob(L,nil,Res).
ltob([],A,A).
ltob([X],A,snoc(A,X)).
ltob(L,A,snoc(A2,C)) :- last(L,C), append(InitL,[C],L),ltob(InitL,A,A2).

fromBList_it(A,Res) :- btol(A,[],Res).
btol(nil,L,L).
btol(snoc(A,E),L,Res) :- btol(A,L,L2),append(L2,[E],Res). 

sum_nodes_it(T, N) :- sum_help([T], 0, N).
sum_help([], A, A).
sum_help([empty|Ts], A, N) :- sum_help(Ts, A, N).
sum_help([node(E,L,R)|Ts], A, N) :- AE is A + E, sum_help([L,R|Ts], AE, N).

num_empties_it(T,N) :- nempt_help([T],0,N).
nempt_help([],A,A).
nempt_help([empty|Ts],A,N) :- AE is A+1, nempt_help(Ts,AE,N).
nempt_help([node(_,L,R)|Ts],A,N) :- nempt_help([L,R|Ts],A,N).

num_nodes_it(T,N) :- numn_help([T],0,N).
numn_help([],A,A).
numn_help([empty|Ts],A,N) :- numn_help(Ts,A,N).
numn_help([node(_,L,R)|Ts],A,N) :- AE is A+1, numn_help([L,R|Ts],AE,N).

sum_nodes2_it(T,N) :- sum_help2([T],0,N).
sum_help2([],A,A).
sum_help2([leaf(E)|Ts],A,N) :- AE is A+E, sum_help2(Ts,AE,N).
sum_help2([node2(E,L,R)|Ts],A,N) :- AE is A+E, sum_help2([L,R|Ts],AE,N).

inorder2_it(T,Res) :- inord([T],[],Res).
inord([],L,L).
inord([leaf(E)|Ts],L,Res) :- append([E],L,Ls), inord(Ts,Ls,Res).
inord([node2(E,L,R)|Ts],L0,Res) :- append([R],[leaf(E)],L1),append(L1,[L],L2),append(L2,Ts,Ls),inord(Ls,L0,Res).

toBList_it(L,Res) :- tob(L,nil,Res).
tob([],A,A).
tob([X],A,snoc(A,X)).
tob(L,A,snoc(A2,C)) :- last(L,C), append(InitL,[C],L),ltob(InitL,A,A2).

fromBList_it(A,Res) :- btol(A,[],Res).
btol(nil,L,L).
btol(snoc(A,E),L,Res) :- btol(A,L,L2),append(L2,[E],Res). 

sum_nodes_it(T, N) :- sum_help([T], 0, N).
sum_help([], A, A).
sum_help([empty|Ts], A, N) :- sum_help(Ts, A, N).
sum_help([node(E,L,R)|Ts], A, N) :- AE is A + E, sum_help([L,R|Ts], AE, N).

num_empties_it(T,N) :- nempt_help([T],0,N).
nempt_help([],A,A).
nempt_help([empty|Ts],A,N) :- AE is A+1, nempt_help(Ts,AE,N).
nempt_help([node(_,L,R)|Ts],A,N) :- nempt_help([L,R|Ts],A,N).

num_nodes_it(T,N) :- numn_help([T],0,N).
numn_help([],A,A).
numn_help([empty|Ts],A,N) :- numn_help(Ts,A,N).
numn_help([node(_,L,R)|Ts],A,N) :- AE is A+1, numn_help([L,R|Ts],AE,N).

sum_nodes2_it(T,N) :- sum_help2([T],0,N).
sum_help2([],A,A).
sum_help2([leaf(E)|Ts],A,N) :- AE is A+E, sum_help2(Ts,AE,N).
sum_help2([node2(E,L,R)|Ts],A,N) :- AE is A+E, sum_help2([L,R|Ts],AE,N).

inorder2_it(T,Res) :- inord([T],[],Res).
inord([],L,L).
inord([leaf(E)|Ts],L,Res) :- append([E],L,Ls), inord(Ts,Ls,Res).
inord([node2(E,L,R)|Ts],L0,Res) :- append([R],[leaf(E)],L1),append(L1,[L],L2),append(L2,Ts,Ls),inord(Ls,L0,Res).

-------------------------extra---------------------------

all_child_leaves(empty,false).
all_child_leaves(node(_,empty,empty),true).
all_child_leaves(node(_,_,empty),false).
all_child_leaves(node(_,empty,_),false).
all_child_leaves(node(_,L,R),Res) :- all_child_leaves(L,Res), all_child_leaves(R,Res).

conv12(empty,nothing).
conv12(node(E,empty,empty),just(leaf(E))).
conv12(node(_,empty,_),nothing).
conv12(node(_,_,empty),nothing).
conv12(node(E,L,R),Res) :- all_child_leaves(L,All),all_child_leaves(R,All), All == true ->  conv(L,NL), conv(R,NR), Res = just(node2(E,NL,NR));
    Res = nothing.
conv(node(E,empty,empty),leaf(E)).
conv(node(E,L,R),node2(E,NL,NR)) :- conv(L,NL),conv(R,NR).

bst(empty,true).
bst(node(_,empty,empty),true).
bst(node(E,L,R),Res) :- bsth(L,E,Res1), bsth(R,E,Res2), Res1 == "LT", Res2 == "GT", Res=true,bst(L,Res),bst(R,Res);
    Res=false.

bsth(empty,_,"GT").
bsth(node(E,_,_),X,Res) :-	E>X	->  Res = "GT".
bsth(node(E,_,_),X,Res) :- 	E==X ->  Res = "EQ".
bsth(node(E,_,_),X,Res) :-	E<X ->  Res = "LT".

bst2(leaf(_),true).
bst2(node2(E,L,R),Res) :- bsth2(L,E,Res1),bsth2(R,E,Res2), Res1 == "LT", Res2 == "GT", Res=true, bst2(L,Res),bst2(R,Res);
    Res=false.
bsth2(leaf(E),X,Res) :- E>X	->  Res = "GT".
bsth2(leaf(E),X,Res) :- E==X ->  Res = "EQ".
bsth2(leaf(E),X,Res) :- E<X	->  Res = "LT".
bsth2(node2(E,_,_),X,Res) :- E>X	->  Res = "GT".
bsth2(node2(E,_,_),X,Res) :- E==X ->  Res = "EQ".
bsth2(node2(E,_,_),X,Res) :- E<X	->  Res = "LT".
