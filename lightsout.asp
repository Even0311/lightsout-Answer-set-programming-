#const size=5.
#const time_horizon=10.

xcoordinate(1..size).
ycoordinate(1..size).
time(0..time_horizon).
cell(X,Y) :- xcoordinate(X),ycoordinate(Y).

%auxiliary
this(cell(X,Y),cell(XX,YY)) :- cell(X,Y),cell(XX,YY),X = XX,Y = YY.
distance_one(cell(X,Y),cell(X+1,Y)):-cell(X,Y),cell(X+1,Y).
distance_one(cell(X,Y),cell(X,Y+1)):-cell(X,Y),cell(X,Y+1).
distance_one(cell(X,Y),cell(XX,YY)) :-distance_one(cell(XX,YY),cell(X,Y)).

%precondition
:- click(X,Y,T),not cell(X,Y),time(T).
%effect
on(X,Y,T + 1) :- on(X,Y,T),click(XX,YY,T),cell(X,Y),cell(XX,YY),not distance_one(cell(X,Y),cell(XX,YY)),not this(cell(X,Y),cell(XX,YY)),time(T).
on(X,Y,T + 1) :- cell(X,Y), click(X,Y,T),not on(X,Y,T),time(T).
on(X,Y,T + 1) :- cell(X,Y),cell(XX,YY), click(XX,YY,T),distance_one(cell(X,Y),cell(XX,YY)),not on(X,Y,T),time(T).

%generator
1 {click(X,Y,T):cell(X,Y)} 1 :- time(T).
%Goal
:- on(X,Y,time_horizon + 1),cell(X,Y).

#show click/3.