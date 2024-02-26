-module(main).
-export([list_heads/1, takewhile/2, iterate/3, integrate/2, main/1]).

% 1. Реализация функции list_heads
list_heads([]) -> [];
list_heads([H|T]) ->
    case H of
        [] -> list_heads(T);
        [X|_] -> [X | list_heads(T)];
        _ -> list_heads(T)
    end.

% 2. Реализация функции takewhile
takewhile(_Pred, []) -> [];
takewhile(Pred, [H|T]) ->
    case Pred(H) of
        true -> [H | takewhile(Pred, T)];
        false -> []
    end.

% 3. Реализация функции iterate
iterate(_F, 0, X) -> X;
iterate(F, N, X) ->
    iterate(F, N - 1, F(X)).

% 4. Реализация функции integrate
integrate(F, N) ->
    fun(A, B) ->
        Delta = (B - A) / N,
        Sum = (F(A) + F(B)) / 2 + lists:sum([F(A + Delta * I) || I <- lists:seq(1, N - 1)]),
        Result = Delta * Sum,
        Result
    end.

% Главная функция для тестирования
main(_) ->
    List1 = [[1,2,3], {true,3}, [4,5], []],
    io:format("list_heads: ~p~n", [list_heads(List1)]),

    Pred = fun(X) -> X < 10 end,
    List2 = [1,3,9,11,6],
    io:format("takewhile: ~p~n", [takewhile(Pred, List2)]),

    F1 = fun(X) -> {X} end,
    N1 = 2,
    Result1 = iterate(F1, N1, 1),
    io:format("iterate: ~p~n", [Result1]),

    F2 = fun(X) -> X end,
    N2 = 100,
    F3 = integrate(F2, N2),
    Result2 = F3(0, 1),
    io:format("integrate: ~p~n", [Result2]).
