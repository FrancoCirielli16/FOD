{

Suponga que usted es administrador de un servidor de correo electrónico. En los logs
del mismo (información guardada acerca de los movimientos que ocurren en el server) que
se encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información:

nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. Diariamente el
servidor de correo genera un archivo con la siguiente información: nro_usuario,
cuentaDestino, cuerpoMensaje. 

Este archivo representa todos los correos enviados por los
usuarios en un día determinado. Ambos archivos están ordenados por nro_usuario y se
sabe que un usuario puede enviar cero, uno o más mails por día.
* 
a- Realice el procedimiento necesario para actualizar la información del log en
un día particular.Defina las estructuras de datos que utilice su procedimiento.

b- Genere un archivo de texto que contenga el siguiente informe dado un archivo
detalle de un día determinado:

nro_usuarioX…………..cantidadMensajesEnviados………….

nro_usuarioX+n………..cantidadMensajesEnviados

Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que
existen en el sistema
   
   
}


program Punto13;
const VALORALTO=9999;

type maestro=record
	nro_usuario:integer;
	nombre_usuario:string;
	nombre:string;
	cantidadMailEnviados:integer;
end;

type detalle=record
	nro_usuario:integer;
	cuentaDestino:string;
	cuerpoMensaje:string;
end;

archivo_maestro=file of maestro;
archivo_detalle=file of detalle;

procedure leerD(var d:archivo_detalle;var data:detalle);
begin
	if(not eof(d))then
		read(d,data)
	else
		data.nro_usuario:=VALORALTO;
end;


procedure actualizar(var mae:archivo_maestro);
var
	m:maestro;
	detalles:archivo_detalle;
	d:detalle;
	nro_actual,mensajes_total:integer;
begin
	assign(detalles,'detalle');
	reset(detalles);
	reset(mae);
	leerD(detalles,d);
	read(mae,m);
	while(d.nro_usuario<>VALORALTO)do
	begin
		nro_actual:=d.nro_usuario;
		mensajes_total:=0;
		while(d.nro_usuario=nro_actual)do
		begin
			mensajes_total:=mensajes_total+1;
			leerD(detalles,d);
		end;
		read(mae,m);
		while(m.nro_usuario<>nro_actual)do
		begin
			read(mae,m);
		end;
		seek(mae,filepos(mae)-1);
		m.cantidadMailEnviados+=mensajes_total;
		write(mae,m);
	end;
	close(mae);
	close(detalles);
end;

procedure exportarTxt(var mae:archivo_maestro);
var
	txt:Text;
	m:maestro;
begin
	reset(mae);
	assign(txt,'info.txt'); 
	rewrite(txt);
	read(mae,m);
	while(not eof(mae))do
	begin
		with m do 
		begin
			writeln(txt,nro_usuario,'…………',cantidadMailEnviados);
		end;
	end;
end;
var
	mae:archivo_maestro;
BEGIN
	assign(mae,'maestro');
	reset(mae);
	actualizar(mae);
	exportarTxt(mae);
END.

