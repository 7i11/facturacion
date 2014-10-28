-module(orden_compra, [
                Id,
                ClienteId,
                VendedorId,
                Estatus::string()]).
-belongs_to(cliente).
-belongs_to_usuario(vendedor).
-has({orden_producto,many}).
-has({factura,1}).
-compile(export_all).
