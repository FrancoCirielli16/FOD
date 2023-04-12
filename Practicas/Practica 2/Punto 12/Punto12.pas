{

La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio de
la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se
realizan al sitio.

La información que se almacena en el archivo es la siguiente: año, mes, dia, idUsuario y
tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado por los
siguientes criterios: año, mes, dia e idUsuario.

Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará
el año calendario sobre el cual debe realizar el informe. 

El mismo debe respetar el formato mostrado a continuación:
	Año : ---
	Mes:-- 1
	día:-- 1
	idUsuario 1 Tiempo Total de acceso en el dia 1 mes 1
	--------
	idusuario N Tiempo total de acceso en el dia 1 mes 1
	Tiempo total acceso dia 1 mes 1
	-------------
	día N
	idUsuario 1 Tiempo Total de acceso en el dia N mes 1
	--------
	idusuario N Tiempo total de acceso en el dia N mes 1
	Tiempo total acceso dia N mes 1
	Total tiempo de acceso mes 1
	------
	Mes 12
	día 1
	idUsuario 1 Tiempo Total de acceso en el dia 1 mes 12
	--------
	idusuario N Tiempo total de acceso en el dia 1 mes 12
	Tiempo total acceso dia 1 mes 12
	-------------
	día N
	idUsuario 1 Tiempo Total de acceso en el dia N mes 12
	--------
	idusuario N Tiempo total de acceso en el dia N mes 12
	Tiempo total acceso dia N mes 12
	Total tiempo de acceso mes 12
	Total tiempo de acceso año

Se deberá tener en cuenta las siguientes aclaraciones:
- El año sobre el cual realizará el informe de accesos debe leerse desde teclado.
- El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año
no encontrado”.
- Debe definir las estructuras de datos necesarias.
- El recorrido del archivo debe realizarse una única vez procesando sólo la información
necesaria.
   
}


program Punto12;
const
VALORALTO=2023;
//la siguiente: año, mes, dia, idUsuario y tiempo de acceso al sitio de la organización. 

type
a = 2000..2023;
me = 1..12;
d = 1..31;

type maestro=record
	anio:a;
	mes:me;
	dia:d;
	idUsuario:integer;
	tiempo:integer;
end;

type archivo_maestro=file of maestro;

procedure leerMaestro(var m:archivo_maestro;var data:maestro);
begin
	if (not eof(m))then
		read(m,data)
	else
		data.anio:=VALORALTO;
end;


procedure mostrar (var mae:archivo_maestro; anio:a);
var
m,actual:maestro;
total,totalMes,totalDia,totalId:real;
ok:boolean;
begin
	ok:= false;
	reset (mae);
	leerMaestro (mae,m);
	while (m.anio <> VALORALTO) and (m.anio <> anio) do 
		leerMaestro (mae,m);
	
	total:= 0;
	while (m.anio = anio) do begin
		ok:= true;
		actual.mes:= m.mes;
		writeln ('Mes:-- ',m.mes);
		totalMes:= 0;
		while (m.anio = anio) and (m.mes = actual.mes) do begin
			actual.dia:= m.dia;
			writeln ('Dia:-- ',m.dia);
			totalDia:= 0;
			while (m.anio = anio) and (m.mes = actual.mes) and (m.dia = actual.dia) do begin
				actual.idUsuario:= m.idUsuario;
				totalId:= 0;
				while (m.anio = anio) and (m.mes = actual.mes) and (m.dia = actual.dia) and (m.idUsuario = actual.idUsuario) do begin
					totalId+= m.tiempo;
					leerMaestro(mae,m);
				end;
				writeln ('idUsuario ',actual.idUsuario,' Tiempo Total de acceso en el dia ',actual.dia,' mes ',actual.mes);
				writeln ('	',totalId:2:2);
				writeln ('');
				totalDia+= totalId;
			end;
			writeln ('Tiempo total acceso dia ',actual.dia ,' mes ',actual.mes);
			writeln ('	',totalDia:2:2);	
			writeln ('');
			totalMes+= totalDia;
		end; 
		writeln ('Total tiempo de acceso mes ',actual.mes);
		writeln ('	',totalMes:2:2);
		writeln ('');
		total+= totalMes;
	end;
	if (ok)	then begin
		writeln ('Total tiempo de accesos anio');
		writeln ('	',total:2:2);
	end
	else
		writeln ('Anio no encontrado.');
end;

var
	anio:a;
	m:archivo_maestro;
BEGIN
	assign (m,'maestro');
	write ('INGRESE ANIO: ');
	readln(anio);
	writeln ('');
	mostrar(m,anio)
END.

