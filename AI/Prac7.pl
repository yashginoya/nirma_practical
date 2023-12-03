man(yash).
man(sahil).
man(ram).
man(johnSnow).
man(tyrion).
man(magnus).
      
woman(sansa).
woman(ganga).
woman(jamna).
woman(arya).
woman(cersei).
woman(botez).

mother(sansa,yash).
mother(sansa,sahil).
mother(sansa,ganga).
mother(sansa,jamna).
mother(arya,tyrion).
mother(arya,ram).
mother(cersei,magnus).
mother(cersei,botez).

father(ram,yash).
father(ram,sahil).
father(ram,ganga).
father(ram,jamna).
father(tyrion,magnus).
father(tyrion,botez).
father(johnSnow,tyrion).
father(johnSnow,ram).

husband(ram,sansa).
husband(johnSnow,arya).
husband(tyrion,cersei).

wife(sansa,ram).
wife(arya,johnSnow).
wife(cersei,tyrion).


brother(X,Y) :- man(X),(father(P,X),father(P,Y)) ; (mother(Q,X),mother(Q,Y)) , not(X=Y).
sister(X,Y) :- woman(X), ((father(P,X),father(P,Y)) ; (mother(Q,X),mother(Q,Y))) , not(X=Y).
grandfather(X,Y) :- man(X) , father(P,Y),father(X,P),not(X=Y).
grandmother(X,Y) :- woman(X) , father(P,Y),mother(X,P),not(X=Y).
uncle(X,Y):- man(X),father(P,Y),brother(P,X),not(x=Y).
aunty(X,Y) :- woman(X) , uncle(P,Y),wife(X,P) ,not(X=Y).
cousin(X,Y) :- (grandfather(P,X),grandfather(P,Y)) ; (grandmother(Q,X),grandmother(Q,Y)),not(X=Y).


