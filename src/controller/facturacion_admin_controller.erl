-module(facturacion_admin_controller, [Req]).
-compile(export_all).
-default_action(index).
-define(RECORDS_PER_PAGE, 8).

before_(_) ->
    user_lib:require_login(Req).

index('GET', [], Usuario) ->
    {ok,[{usuario,Usuario}]}.

notfound('GET', []) ->
    {render_other,[{action,"404"}]}.
    
error500('GET', []) ->
    {render_other,[{action,"500"}]}.


delete('GET', [RecordId], Usuario) ->
    {ok, [{record, boss_db:find(RecordId)},{usuario,Usuario}]};

    
delete('POST', [RecordId], Usuario) ->
    Type = boss_db:type(RecordId),
    boss_db:delete(RecordId),
    Action = atom_to_list(Type) ++ "_list",
    {redirect, [{action, Action}]}.

marca_list('GET', [], Usuario) ->
    Records = boss_db:find(marca,[]),
    {render_other,[{action, "marca/marca_list"}],[{records, Records},{usuario,Usuario}],[{"Cache-Control", "no-cache"}]}.

marca_create(Method, [], Usuario) ->
    Model = marca,
    case Method of
        'GET' ->
            {render_other, [{action, "marca/marca_create"}],[{usuario,Usuario}]};
        
        'POST' ->
            Data = utils_lib:record_replace(Model,Req),
            Record = boss_record:new(Model,Data),
            case Record:save() of
                {ok, SavedRecord} ->
                    {redirect, [{action, "marca_list"}]};
                {error, Errors} ->
                    {render_other, [{action, "marca/marca_create"}], [{errors, Errors}, {record, Record},{usuario,Usuario}]}
            end
    end.

marca_edit(Method, [RecordId], Usuario) ->
    case Method of
        'GET' ->
            Record = boss_db:find(RecordId),
            {render_other, [{action, "marca/marca_edit"}], [{record, Record},{usuario,Usuario}]};
        'POST' ->
            Record = boss_db:find(RecordId),
            Data = utils_lib:record_replace(boss_db:type(RecordId),Req),
            UpdateRecord = Record:set(Data),
            case UpdateRecord:save() of
                {ok, SavedRecord} ->
                    {redirect, [{action, "marca_list"}]};
                {error, Errors} ->
                    {render_other, [{action, "marca/marca_edit"}], [{errors, Errors}, {record, UpdateRecord},{usuario,Usuario}]}
            end
    end.

producto_list('GET', [], Usuario) ->
    Records = boss_db:find(producto,[]),
    {render_other,[{action, "producto/producto_list"}],[{records, Records},{usuario,Usuario}],[{"Cache-Control", "no-cache"}]}.

producto_create(Method, [], Usuario) ->
    Model = producto,
    Marcas = boss_db:find(marca,[]),
    case Method of
        'GET' ->
            {render_other, [{action, "producto/producto_create"}],[{marcas,Marcas},{usuario,Usuario}]};
        'POST' ->
            Data = utils_lib:record_replace(Model,Req),
            Record = boss_record:new(Model,Data),
            case Record:save() of
                {ok, SavedRecord} ->
                    {redirect, [{action, "producto_list"}]};
                {error, Errors} ->
                    {render_other, [{action, "producto/producto_create"}], [{errors, Errors}, {record, Record},{marcas,Marcas},{usuario,Usuario}]}
            end
    end.

producto_edit(Method, [RecordId], Usuario) ->
    Marcas = boss_db:find(marca,[]),
    case Method of
        'GET' ->
            Record = boss_db:find(RecordId),
            {render_other, [{action, "producto/producto_edit"}], [{record, Record},{marcas,Marcas},{usuario,Usuario}]};
        'POST' ->
            Record = boss_db:find(RecordId),
            Data = utils_lib:record_replace(boss_db:type(RecordId),Req),
            UpdateRecord = Record:set(Data),
            case UpdateRecord:save() of
                {ok, SavedRecord} ->
                    {redirect, [{action, "producto_list"}]};
                {error, Errors} ->
                    {render_other, [{action, "producto/producto_edit"}], [{errors, Errors}, {record, UpdateRecord}, {marcas, Marcas},{usuario,Usuario}]}
            end
    end.

cliente_list('GET', [], Usuario) ->
    Records = boss_db:find(cliente,[]),
    {render_other,[{action, "cliente/cliente_list"}],[{records, Records},{usuario,Usuario}],[{"Cache-Control", "no-cache"}]}.

cliente_create(Method, [], Usuario) ->
    Model = cliente,
    case Method of
        'GET' ->
            {render_other, [{action, "cliente/cliente_create"}],[{usuario,Usuario}]};
        'POST' ->
            Data = utils_lib:record_replace(cliente,Req),
            Record = boss_record:new(Model,Data),
            case Record:save() of
                {ok, SavedRecord} ->
                    {redirect, [{action, "cliente_list"}]};
                {error, Errors} ->
                    {render_other, [{action, "cliente/cliente_create"}], [{errors, Errors}, {record, Record},{usuario,Usuario}]}
            end
    end.

cliente_edit(Method, [RecordId], Usuario) ->
    case Method of
        'GET' ->
            Record = boss_db:find(RecordId),
            {render_other, [{action, "cliente/cliente_edit"}], [{record, Record},{usuario,Usuario}]};
        'POST' ->
            Record = boss_db:find(RecordId),
            Data = utils_lib:record_replace(boss_db:type(RecordId),Req),
            UpdateRecord = Record:set(Data),
            case UpdateRecord:save() of
                {ok, SavedRecord} ->
                    {redirect, [{action, "cliente_list"}]};
                {error, Errors} ->
                    {render_other, [{action, "cliente/cliente_edit"}], [{errors, Errors}, {record, UpdateRecord},{usuario,Usuario}]}
            end
    end.
