-module(orden_producto, [
                Id,
                ProductoId,
                OrdenCompraId,
                Cantidad::integer()]).
-belongs_to(producto).
-belongs_to(orden_compra).
-compile(export_all).
