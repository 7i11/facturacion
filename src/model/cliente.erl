-module(cliente, [
                Id,
                Rif::string(),
                Nombre::string(),
                Telefono::integer(),
                Telefono2::integer(),
                Direccion::string()]).
-has({orden_compra,many}).
-compile(export_all).
