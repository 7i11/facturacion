-module(factura, [
                Id,
                OrdenId,
                Fecha::datetime(),
                CondicionPago::string(),
                Estatus::string()]).
-compile(export_all).
