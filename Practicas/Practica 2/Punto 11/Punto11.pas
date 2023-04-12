{

11. 
A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
localidad, cantidad de alfabetizados y cantidad de encuestados.

Se pide realizar los módulos necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.

NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
pueden venir 0, 1 ó más registros por cada provincia.
   
}


program Punto11;
const
VALORALTO='zzzz';


type
	maestro=record
		nombre_p:string;
		total_a:integer;
		total_e:integer;
	end;
	
	detalle=record
		nombre_p:string;
		cod_l:integer;
		cant_a:integer;
		cant_e:integer;
	end;

type archivo_maestro= file of maestro;
type archivo_detalle=file of detalle;






procedure leerD(var d:archivo_detalle;var data:detalle);
begin
	if(not eof(d))then
		read(d,data)
	else
		data.nombre_p:='zzzz';
end;

procedure minimo(var r1,r2:detalle; var min:detalle; var det1,det2:archivo_detalle);
begin
	if(r1.nombre_p <= r2.nombre_p)then
		begin
			min:=r1;
			leerD(det1,r1);
		end
	else begin
		min:=r2;
		leerD(det2,r2);
	end;
end;

procedure actualizar(var maestro:archivo_maestro);
var
	r1,r2,min,actual:detalle;
	det1,det2:archivo_detalle;
	m:maestro;
	total_alf:integer;
	total_en:integer;
begin
	reset(maestro);
	assign(det1,'detalle1');
	assign(det2,'detalle2');
	reset(det1);
	reset(det2);
	leerD(det1,r1);
	leerD(det2,r2);
	minimo(r1,r2,min,det1,det2);
	while(min.nombre_p<>VALORALTO)do
	begin
		total_alf:=0;
		total_en:=0;
		actual.nombre_p:=min.nombre_p;
		while(min.nombre_p=actual.nombre_p)do
		begin
			total_alf:=total_alf+min.cant_a;
			total_en:=total_en+min.cant_e;
			minimo(r1,r2,min,det1,det2);
		end;
		read(maestro,m);
		while(actual.nombre_p<>m.nombre_p)do
		begin
			read(maestro,m);
		end;
		seek(maestro,filepos(maestro)-1);
		m.total_a:=m.total_a+total_alf;
		m.total_e:=m.total_e+total_en;
		write(maestro,m);
	end;
	close(maestro);
	close(det1);
	close(det2);
end;

var
	mae:archivo_maestro;
BEGIN
	assign(mae,'maestro');
	actualizar(mae);
END.

