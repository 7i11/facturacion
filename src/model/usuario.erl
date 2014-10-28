-module(usuario, [Id,
                  Cedula,
                  Nombre,
                  Apellido,
                  Telefono,
                  Telefono2,
                  Direccion,
                  Username, 
                  PasswordHash
                 ]).
-has({orden_compra,many}).
-compile(export_all).
-define(SECRET_STRING, "@#RFCVW@$#V4@$T&Ij").

session_identifier() ->
    mochihex:to_hex(erlang:md5(?SECRET_STRING ++ Id)).

check_password(Password) ->
    Salt = mochihex:to_hex(erlang:md5(Username)),
    user_lib:hash_password(Password, Salt) =:= PasswordHash.

login_cookies() ->
    [ mochiweb_cookies:cookie("user_id", Id, [{path, "/"}]),
        mochiweb_cookies:cookie("session_id", session_identifier(), [{path, "/"}]) ].

