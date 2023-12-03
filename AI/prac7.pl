reverse([],[]).
reverse([Head|Tail],X):- reverse(Tail,Rev_X),
append(Rev_X,[Head],X).

pos_from_beg(Element, [Element|_], 1).
pos_from_beg(Element, [_|Tail], Position) :- pos_from_beg(Element, Tail, TailPosition), Position is TailPosition + 1.


pos_from_end(Element, List, Position) :- reverse(List, Reversed), pos_from_beg(Element, Reversed, Position).



% reverse([1,2,3,4,5],X) => ans  =>  X = [5, 4, 3, 2, 1]  %

%  pos_from_beg(4,[1,2,3,4,5],X) => ans => X = 4  %

%  pos_from_end(2,[1,2,3,4,5],X) => ans => X = 4 %