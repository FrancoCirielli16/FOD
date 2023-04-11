{
   
Se desea modelar la información necesaria para un sistema de recuentos de casos de 
covid para el ministerio de salud de la provincia de buenos aires.


Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad casos
activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.


El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad casos activos, cantidad casos
nuevos, cantidad recuperados y cantidad de fallecidos.


Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.



Para la actualización se debe proceder de la siguiente manera:


1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.

2. Idem anterior para los recuperados.

3. Los casos activos se actualizan con el valor recibido en el detalle.

4. Idem anterior para los casos nuevos hallados.


Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).
   
   
}


program punto6;
const 
DF = 3;
VALORALTO = 9999;

//información: código localidad,nombre localidad, código cepa, nombre cepa, cantidad casos activos, cantidad casos
//nuevos, cantidad recuperados y cantidad de fallecidos.

type maestro = record
	cod_localidad:integer;
	nombre_localidad:string;
	cod_cepa:integer;
	nombre_cepa:string;
	cant_casos_activos:integer;
	cant_casos_nuevos:integer;
	cant_recuperados:integer;
	cant_fallecidos:integer;
end;

type detalle = record
	cod_localidad:integer;
	cod_cepa:integer;
	cant_casos_activos:integer;
	cant_casos_nuevos:integer;
	cant_recuperados:integer;
	cant_fallecidos:integer;
end;

type archivo_detalle = file of detalle;

type archivo_maestro = file of maestro;

data = record
	d:detalle;
	f:archivo_detalle;
end;

detalles = array[1..DF]of data;


procedure leerD(var archivo:archivo_detalle; var d:detalle);
begin
	 if (not EOF(archivo))then
		read(archivo,d)
	else
		d.cod_localidad := VALORALTO;
end;

procedure inicializarDetalleN(var n_detalles:detalles);
var
	i:integer;
	aString:string;
begin
	for i:=1 to DF do
	begin
		Str (i,aString);
		assign (n_detalles[i].f,'detalle'+aString);
		reset(n_detalles[i].f);
		leerD(n_detalles[i].f,n_detalles[i].d);
	end;
end;

procedure cerrarDetalles(var n_detalles:detalles);
var
	i:integer;
begin
	for i:=1 to DF do
		close(n_detalles[i].f);
end;

procedure minimoDetalle(var n_detalles:detalles;var min:detalle);
var
	i,pos:integer;
begin
	min.cod_localidad:=VALORALTO;
	pos:=-1;
	for i:=1 to DF do
	begin
		if(n_detalles[i].d.cod_localidad<min.cod_localidad)then
		begin
			pos:=i;
			min:=n_detalles[i].d;
		end;
	end;
	if(pos=-1)then
		min.cod_localidad:=VALORALTO
	else
		leerD(n_detalles[pos].f,n_detalles[pos].d);
end;


{

Para la actualización se debe proceder de la siguiente manera:


1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.

2. Idem anterior para los recuperados.

3. Los casos activos se actualizan con el valor recibido en el detalle.

4. Idem anterior para los casos nuevos hallados.

}
procedure actualizarMaestro(var cant_localidades:integer);
var
	n_detalles:detalles;
	min,total:detalle;
	m:maestro;
	mae:archivo_maestro;
	total_casos_activos:integer;
begin
	cant_localidades:=0;
	inicializarDetalleN(n_detalles);
	Assign (mae,'maestro');
	reset(mae);
	read(mae,m);
	minimoDetalle(n_detalles,min);
	while(min.cod_localidad<>VALORALTO)do
	begin
		total.cod_localidad:=min.cod_localidad;
		total_casos_activos:=0;
		while(total.cod_localidad=min.cod_localidad)do
		begin
			total.cod_cepa:=min.cod_cepa;
			total.cant_fallecidos:=0;
			total.cant_recuperados:=0;
			while (total.cod_localidad=min.cod_localidad)and(total.cod_cepa=min.cod_cepa)do
			begin
				total.cant_fallecidos+=min.cant_fallecidos;
				total.cant_recuperados+=min.cant_recuperados;
				total.cant_casos_activos:=min.cant_casos_activos;
				total.cant_casos_nuevos:=min.cant_casos_nuevos;
				total_casos_activos:= total_casos_activos + min.cant_casos_activos;
				minimoDetalle(n_detalles,min);
			end;
			while (m.cod_localidad <> total.cod_localidad)or(m.cod_cepa <> total.cod_cepa) do
				read (mae,m);
			m.cant_fallecidos+=total.cant_fallecidos;
			m.cant_recuperados+=total.cant_recuperados;
			m.cant_casos_activos:=total.cant_casos_activos;
			m.cant_casos_nuevos:=total.cant_casos_nuevos;
			seek(mae,filepos(mae)-1);
			write(mae,m);
		end;
		if(total_casos_activos>=50)then
			cant_localidades+=1;
	end;
	close(mae);
	cerrarDetalles(n_detalles);
end;



var
	cant_localidades:integer;
BEGIN
	actualizarMaestro(cant_localidades);
	writeln(cant_localidades);
END.

