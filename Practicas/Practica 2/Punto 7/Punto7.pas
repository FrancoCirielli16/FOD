{

El encargado de ventas de un negocio de productos de limpieza desea administrar el
stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos

los productos que comercializa. De cada producto se maneja la siguiente información:
código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.

Diariamente se genera un archivo detalle donde se registran todas las ventas de productos
realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas.

Se pide realizar un programa con opciones para:

a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:

● Ambos archivos están ordenados por código de producto.

● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del archivo detalle.

● El archivo detalle sólo contiene registros que están en el archivo maestro.

b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
stock actual esté por debajo del stock mínimo permitido.
   
}


program Punto7;
const VALORALTO=9999;

type 

producto = record
	codigo:integer;
	nombre:string;
	precio:real;
	stock:integer;
	stock_min:integer;
end;

type detalle = record
	codigo:integer;
	cant_vendida:integer;
end;

type archivo_detalle = file of detalle;

type maestro = file of producto;

procedure leerD(var archivo:archivo_detalle; var p:detalle);
begin
	if(not eof(archivo))then
		read(archivo,p)
	else
		p.codigo:=VALORALTO;
end;

procedure leerM(var archivo:maestro; var m:producto);
begin
	if(not eof(archivo))then
		read(archivo,m)
	else
		m.codigo:=VALORALTO;
end;

procedure actualizarMaestro(var archivo_maestro:maestro);
var
	venta:detalle;
	p:producto;
	detalles:archivo_detalle;
	codigo_actual:integer;
begin
	assign(detalles,'detalle1');
	reset(detalles);
	reset(archivo_maestro);
	leerM(archivo_maestro,p);
	leerD(detalles,venta);
	while(venta.codigo<>VALORALTO)do
	begin
		codigo_actual:=venta.codigo;
		while(venta.codigo = codigo_actual)do
		begin
			p.stock := p.stock - venta.cant_vendida;
			leerD(detalles,venta);
		end;
		seek(archivo_maestro,filepos(archivo_maestro)-1);
		write(archivo_maestro,p);
		leerM(archivo_maestro,p);
	end;
	close(archivo_maestro);
	close(detalles);
end;

procedure exportarTxt(var archivo_maestro:maestro);
var
	txt:Text;
	p:producto;
begin
	assign(txt,'stock_minimo.txt');
	rewrite(txt);
	reset(archivo_maestro);
	while(not eof(archivo_maestro))do
	begin
		read(archivo_maestro,p);
		if(p.stock<p.stock_min)then
		begin
			writeln(txt,'Codigo: ',p.codigo,' Nombre: ',p.nombre);
			writeln(txt,'Precio: ',p.precio,' Stock: ',p.stock,' Stock minimo: ',p.stock_min);
		end;
	end;
	close(txt);
	close(archivo_maestro);
end;

var
	archivo_maestro:maestro;
BEGIN
	assign(archivo_maestro,'maestro');
	actualizarMaestro(archivo_maestro);
	exportarTxt(archivo_maestro);
END.
