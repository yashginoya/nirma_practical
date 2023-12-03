is_member(X, [X|_]).
is_member(X, [_|T]) :- is_member(X, T).

insert_beginning(X, L, [X|L]).

insert_end(X, [], [X]).
insert_end(X, [H|T], [H|Result]) :- insert_end(X, T, Result).

insert_at(X, 1, L, [X|L]).
insert_at(X, N, [H|T], [H|Result]) :-
    N > 1,
    N1 is N - 1,
    insert_at(X, N1, T, Result).



% is_member(3, [1, 2, 3, 4, 5]). -> ans = true

% insert_beginning(0, [1, 2, 3], Result). -> ans = [0, 1, 2, 3]

% insert_end(4, [1, 2, 3], Result). -> and = [1, 2, 3, 4]

% insert_at(2, 2, [1, 3, 4], Result). -> ans = [1, 2, 3, 4]

