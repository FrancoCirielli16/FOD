
{8. Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
cliente.
Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la
empresa.
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
mes, día y monto de la venta.
El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras}
program ejer8;

CONST 
VALORALTO =9999;

type

cliente = record
	codigo:integer;
	NyA: string;
	anio: integer;
	mes: 1..12;
	dia: 1..31;
	montoV:real;
end;

maestro = file of cliente;

procedure imprimirCliente (c:cliente);
begin
	with c do begin
		writeln ('|CODIGO: ',codigo);
		writeln ('|NOMBRE Y APELLIDO: ',NyA);
	end;
end;

procedure leer (var arc_maestro:maestro; var dato:cliente);
begin
	if not eof (arc_maestro) then
		read (arc_maestro,dato)
	else
		dato.codigo:= VALORALTO;
end;

procedure reporte (var arc_maestro:maestro);
var
c,actual:cliente;
totalmes,totalanio,total:real;
begin
	reset (arc_maestro);
	leer (arc_maestro,c);
	total:= 0;
	while (c.codigo <> valorAlto) do begin
		imprimirCliente(c);
		actual.codigo:= c.codigo;
		while (c.codigo = actual.codigo) do begin
			writeln ('ANIO: ',c.anio);
			actual.anio:= c.anio;
			totalanio:= 0;
			while (c.codigo = actual.codigo)  and (c.anio = actual.anio) do begin
				writeln ('MES: ',c.mes);
				actual.mes:= c.mes;
				totalmes:= 0;
				while (c.codigo = actual.codigo)  and (c.anio = actual.anio) and (c.mes = actual.mes) do begin
					writeln ('DIA: ',c.dia);
					writeln ('MONTO: ',c.montoV:1:1);
					totalmes:= totalmes + c.MontoV;
					leer (arc_maestro,c);
				end;
				writeln ('TOTAL MES: ',totalMes:1:1);
				totalanio:= totalanio + totalmes;
			end;
			writeln ('TOTAL ANIO: ',totalanio:1:1);
			total:= total + totalanio;
		end;
	end;
	writeln ('TOTAL EMPRESA: ',total:1:1);
	close (arc_maestro);
end;

var
arc_maestro: maestro;
begin
	Assign (arc_maestro,'maestro');
	reporte (arc_maestro);
end.
