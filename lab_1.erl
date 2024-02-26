-module(main).
-export([main/1]).

% Функция seconds/3 для вычисления количества секунд с начала дня
seconds(Hours, Minutes, Seconds) ->
    Hours * 3600 + Minutes * 60 + Seconds.

% Функция min/1 для нахождения минимального элемента в списке
min(List) ->
    case List of
        [] -> erlang:error({empty_list});
        _  -> lists:min(List)
    end.

% Функция distinct/1 для проверки различности элементов в списке
distinct(List) ->
    distinct(List, []).

distinct([], _Seen) ->
    true;
distinct([X | Xs], Seen) ->
    case lists:member(X, Seen) of
        true -> false;
        false -> distinct(Xs, [X | Seen])
    end.

% Функция split_all/2 для разбиения списка на части длиной N
split_all(List, N) ->
    split_all(List, N, []).

split_all([], _, Acc) ->
    lists:reverse(Acc);
split_all(List, N, Acc) when length(List) > N -> % Добавляем проверку на длину списка
    {Split, Rest} = lists:split(N, List),
    split_all(Rest, N, [Split | Acc]);
split_all(Rest, _, Acc) -> % Если длина списка меньше или равна N, просто добавляем остаток в результат
    lists:reverse([Rest | Acc]).



% Функция sublist/3 для извлечения отрезка из списка
sublist(List, N, M) ->
    lists:sublist(List, N, M - N + 1).
    
% Функция intersect/2 для нахождения общих элементов двух списков
intersect(List1, List2) ->
    Intersection = lists:filter(fun(X) -> lists:member(X, List2) end, List1),
    lists:sort(Intersection).


is_date(1, 1, 2000) ->
  6;
is_date(D, M, Y)  when D /= 1  ->
  Today = (is_date(D-1, M, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 2, Y) ->
  Today = (is_date(31, 1, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 4, Y) ->
  Today = (is_date(31, 3, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 5, Y) ->
    Today = (is_date(30, 4, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 6, Y) ->
    Today = (is_date(31, 5, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 7, Y) ->
    Today = (is_date(30, 6, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 8, Y) ->
    Today = (is_date(31, 7, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 9, Y) ->
    Today = (is_date(31, 8, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 10, Y) ->
    Today = (is_date(30, 9, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 11, Y) ->
    Today = (is_date(31, 10, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 12, Y) ->
    Today = (is_date(30, 11, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 3, Y) when  Y rem 4 == 0 andalso (Y rem 100 /= 0 orelse Y rem 400 == 0) ->
    Today = (is_date(29, 2, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 3, Y) ->
    Today = (is_date(28, 2, Y)+1),
  Today rem 8 + Today div 8;
is_date(1, 1, Y) ->
    Today = (is_date(31, 12, Y-1)+1),
  Today rem 8 + Today div 8.

% Точка входа в программу
main(_) ->
    % Вызовы функций с примерами использования
    io:format("Seconds: ~p~n", [seconds(1, 2, 1)]),
    io:format("Min: ~p~n", [min([6,1,4])]),
    io:format("Distinct: ~p~n", [distinct([4,2,a,false])]),
    io:format("Split_all: ~p~n", [split_all([1, 2, 3, 4, 5], 3)]),
    io:format("Sublist: ~p~n", [sublist([1, 3, 4, 5, 6], 2, 4)]),
    io:format("Intersect: ~p~n", [intersect([1, 3, 2, 5], [2, 3, 4])]),
    io:format("Intersect: ~p~n", [intersect([1, 6, 5], [2, 3, 4])]),
    io:format("is_date: ~p~n", [is_date(1, 1, 2000)]),
    io:format("is_date: ~p~n", [is_date(1, 2, 2013)]).
