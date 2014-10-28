-module(facturacion_migrateuser).
-compile(export_all).

init() ->
    User = usuario:new(id,"20144088","Orlando","Jimenez","04243565371","","19 de abril, gonzalito, intercomunal turmero maracay","till","0416e75191c8c657954c64f7f93d5c28"),
    case User:save() of
        {ok, SavedRecord} ->
            {ok, "usuario creado con exito"};
        {error, Errors} ->
            {Errors}
    end.
