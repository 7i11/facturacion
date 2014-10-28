-module(marca, [
                Id,
                Nombre::string(),
                Descripcion::string()]).
-has({producto,many}).
-compile(export_all).
