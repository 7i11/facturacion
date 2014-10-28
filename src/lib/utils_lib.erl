-module(utils_lib).

-export([ip_address/1,record_replace/2]).

ip_address(Req) ->
    ClientIp = case Req:header(x_forwarded_for) of
        undefined -> Req:peer_ip();
        IP when is_tuple(IP)-> IP;
        IP when is_list(IP) -> list_to_tuple(lists:map(fun erlang:list_to_integer/1, string:tokens(IP, ".")))
    end,
    string:join(lists:map(fun erlang:integer_to_list/1,tuple_to_list(ClientIp)), ".").

record_replace(Model,Req) ->
        Attributes = [X || X <- boss_record_lib:attribute_names(Model),X =/= id],
        AttributeTypes = boss_record_lib:attribute_types(Model),
        Data = lists:map(fun(X) ->
                Param = Req:post_param(atom_to_list(X)),
                Value = case proplists:get_value(X,AttributeTypes) of
                    string -> Param;
                    integer ->  try list_to_integer(Param) of Integer -> Integer catch _:_ -> Param end;
                    float ->  try list_to_float(Param) of Float -> Float catch _:_ -> Param end;
                    _ -> Param
                end,
                {X,Value}
                end,
        Attributes),
        [X || X <- Data, proplists:get_value(list_to_atom(lists:nth(1,io_lib:format("~s",lists:map(fun(Key) -> Key end, proplists:get_keys([X]))))),[X]) =/= []].
