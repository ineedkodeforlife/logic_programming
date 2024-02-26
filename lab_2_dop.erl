-module(main).
-export([main/1]).

% 5. Реализация функции for
for_loop(Init, _Cond, _Step, _Body) when Init > 5 ->
    ok;
for_loop(Init, Cond, Step, Body) ->
    Body(Init),
    for_loop(Step(Init), Cond, Step, Body).

% 6. Реализация функции sortBy (сортировка слиянием)
merge([], L, _Comparator) -> L;
merge(L, [], _Comparator) -> L;
merge([H1|T1], [H2|T2], Comparator) ->
    case Comparator(H1, H2) of
        less -> [H1 | merge(T1, [H2|T2], Comparator)];
        equal -> [H1 | merge(T1, T2, Comparator)];
        greater -> [H2 | merge([H1|T1], T2, Comparator)]
    end.

split([], Acc1, Acc2) -> {Acc1, Acc2};
split([X], Acc1, Acc2) -> {lists:reverse([X|Acc1]), Acc2};
split([X,Y|T], Acc1, Acc2) -> split(T, [X|Acc1], [Y|Acc2]).

% 5. Реализация функции for 
for_loop2(Init, Cond, Step, Body) ->
    case Cond(Init) of
        true ->
            Body(Init),
            for_loop2(Step(Init), Cond, Step, Body);
        false ->
            ok
    end.

% 6. Реализация функции sortBy 
sort_by(Comparator, List) ->
    case List of
        [] -> [];
        [_] -> List;
        _ ->
            {L1, L2} = split(List, [], []),
            merge(sort_by(Comparator, L1), sort_by(Comparator, L2), Comparator)
    end.

main(_) ->
    % Примеры использования всех функций
    io:format("Running for/4 function:~n"),
    for_loop(1, fun(I) -> I =< 5 end, fun(I) -> I + 1 end, fun(I) -> io:format("~p~n", [I]) end),

    io:format("Running for_loop2/4 function:~n"),
    for_loop2(1, fun(I) -> I =< 5 end, fun(I) -> I + 1 end, fun(I) -> io:format("~p~n", [I]) end),

    io:format("Running sort_by/2 function:~n"),
    List = [5, 3, 8, 1, 9, 2],
    Comparator = fun(X, Y) ->
        case X < Y of
            true -> less;
            false -> greater
        end
    end,
    SortedList = sort_by(Comparator, List),
    io:format("Sorted list: ~p~n", [SortedList]).
