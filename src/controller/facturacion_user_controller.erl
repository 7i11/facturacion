-module(facturacion_user_controller, [Req]).
-compile(export_all).
-default_action(login).

login('GET', []) ->
    {ok, [{redirect, Req:header(referer)}]};

login('POST', []) ->
    Username = Req:post_param("username"),
    case boss_db:find(usuario, [{username, Username}], [{limit,1}]) of
        [Usuario] ->
            case Usuario:check_password(Req:post_param("password")) of
                true ->
                    {redirect, proplists:get_value("redirect",
                        Req:post_params(), "/"), Usuario:login_cookies()};
                false ->
                    {ok, [{error, "Bad name/password combination"}]}
            end;
        [] ->
            {ok, [{error, "No User named " ++ Username}]}
    end.

logout('GET', []) ->
    {redirect, "/user/login",
        [mochiweb_cookies:cookie("user_id", "", [{path, "/"}]),
            mochiweb_cookies:cookie("session_id", "", [{path, "/"}]) ]}.
