{
   6. Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado
con la información correspondiente a las prendas que se encuentran a la venta. De
cada prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y
precio_unitario. Ante un eventual cambio de temporada, se deben actualizar las prendas
a la venta. 


Para ello reciben un archivo conteniendo: cod_prenda de las prendas que
quedarán obsoletas. Deberá implementar un procedimiento que reciba ambos archivos
y realice la baja lógica de las prendas, para ello deberá modificar el stock de la prenda
correspondiente a valor negativo.

Por último, una vez finalizadas las bajas lógicas, deberá efectivizar las mismas
compactando el archivo. Para ello se deberá utilizar una estructura auxiliar, renombrando
el archivo original al finalizar el proceso.. Solo deben quedar en el archivo las prendas
que no fueron borradas, una vez realizadas todas las bajas físicas.
   
}


program untitled;
const VALORALTO = 9999;

Type prenda = record
	cod_prenda:integer;
	descripcion:string;
	colores:string;
	tipo_prenda:string;
	stock:integer;
	precio:integer;
end;

Type maestro = file of prenda;
Type archivo = file of integer;

procedure leerM(var mae:maestro; var p:prenda);
begin
	if(not eof(mae))then
		read(mae,p)
	else
		p.cod_prenda:=VALORALTO;
end;

procedure bajas_logicas(var mae:maestro; var a:archivo);
var
	p:prenda;
	cod:integer;
begin
	reset(mae);
	reset(a);
	read(mae,p);
	read(a,cod);
	while(p.cod_prenda<>VALORALTO)do
	begin
		seek(a,0);
		while(p.cod_prenda<>VALORALTO)and(p.cod_prenda<>cod)do
			leerM(mae,p);
		if(p.cod_prenda=cod)then
		begin
			p.stock:=p.stock*-1;
			seek(a,filePos(a)-1);
			write(mae,p);
		end;
		leerM(mae,p);
	end;
	close(mae);
	close(a);
end;

procedure compactar(var mae:maestro;var archivo_final:maestro);
var
	p:prenda;
begin
	reset(mae);
	rewrite(archivo_final);
	leerM(mae,p);
	while(not eof(mae))do
	begin
		if (p.stock >= 0) then begin
			write (archivo_final,p);
		end;
		leerM(mae,p);
	end;
		
end;

var
	mae:maestro;
	codigos:archivo;
	aux:maestro;
BEGIN
	Assign (mae,'maestro');
	Assign (codigos,'detalle');
	Assign (aux,'aux');
	bajas_logicas(mae,codigos);
	compactar(mae,aux);
	erase (mae);
	rename(aux,'maestro');
END.

