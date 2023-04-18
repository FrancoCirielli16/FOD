{

Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de asistentes a un congreso a partir de la información obtenida por
teclado. 

Se deberá almacenar la siguiente información: nro de asistente, apellido y
nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.

Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño’.
   
}


program untitled;
const VALORALTO=9999;

type maestro = record
	nro_asistente:integer;
	AyN:string;
	email:string;
	telefono:integer;
	dni:integer;
end;

type archivo_maestro=file of maestro;

procedure leer(var a:maestro);
begin
	with a do
	begin
		write('Ingrese numero: ');
		readln(nro_asistente);
		if(nro_asistente<>-1)then
		begin
			write('apellido y nombre: ');
			readln(AyN);
			write('email: ');
			readln(email);
			write('telefono: ');
			readln(telefono);
			write('dni: ');
			readln(dni);
		end;
		writeln ('');
	end;
end;

procedure leerM(var mae:archivo_maestro;var data:maestro);
begin
	if(not eof(mae))then
		read(mae,data)
	else
		data.nro_asistente:=VALORALTO;
end;

procedure crear(var mae:archivo_maestro);
var
	a:maestro;
begin
	rewrite(mae);
	leer(a);
	while(a.nro_asistente<>-1)do
	begin
		write(mae,a);
		leer(a);
	end;
	close(mae);
end;

procedure eliminar(var mae:archivo_maestro);
var
	a:maestro;
begin
	reset(mae);
	leerM(mae,a);
	while(a.nro_asistente<>VALORALTO)do
	begin
		if(a.nro_asistente<1000)then
		begin
			a.AyN:='@Eliminado';
			seek(mae,FilePos(mae)-1);
			write(mae,a);
		end;
		leerM(mae,a);
	end;
end;

procedure imprimir(var mae:archivo_maestro);
var
	a:maestro;
begin
	reset(mae);
	leerM(mae,a);
	while(a.nro_asistente<>9999)do
	begin
		if(a.AyN<>'@Eliminado')then
		begin
			writeln('nro: ',a.nro_asistente);
			writeln('apellido y nombre: ',a.AyN);
			writeln('email: ',a.email);
			writeln('telefono: ',a.telefono);
			writeln('dni: ',a.dni);
		end;
		leerM(mae,a);
	end;
	close(mae);
end;

procedure imprimirALL(var mae:archivo_maestro);
var
	a:maestro;
begin
	reset(mae);
	read(mae,a);
	while(not eof(mae))do
	begin
		writeln('nro: ',a.nro_asistente);
		writeln('apellido y nombre: ',a.AyN);
		writeln('email: ',a.email);
		writeln('telefono: ',a.telefono);
		writeln('dni: ',a.dni);
		read(mae,a);
	end;
	close(mae);
end;

var
	mae:archivo_maestro;
BEGIN
	assign(mae,'maestro');
	//crear(mae);
	imprimirALL(mae);
	writeln('-------------------------------------------');
	eliminar(mae);
	imprimir(mae);
END.

