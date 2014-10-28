-module(producto, [
                Id,
                Nombre::string(),
                MarcaId,
                Precio::float(),
                Descripcion::string()]).
-belongs_to(marca).
-has({orden_producto,many}).
-compile(export_all).
