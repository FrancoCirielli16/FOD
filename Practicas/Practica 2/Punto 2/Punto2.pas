{
  Se dispone de un archivo con información de los alumnos de la Facultad de Informática. 

Por cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).

Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:

a. Actualizar el archivo maestro de la siguiente manera:

i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.

ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.

b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.
   
   
}


program Punto2;

const valoralto=9999;

type alumno = record
	codigo:integer;
	nombre:string;
	apellido:string;
	cant_mat_final:integer;
	cant_mat_sin_final:integer;
end;

type detalle_mat = record
	codigo:integer;
	aprobo_mat:boolean;
	aprobo_final:boolean;
end;

type archivo=file of alumno;

type detalle=file of detalle_mat;


procedure leer(var arch:archivo; var dato:alumno);
begin
	if(not eof(arch))then 
		read(arch,dato)
	else 
		dato.codigo:=valoralto;
end;

procedure actualizar(var maestro:archivo;var det:detalle);
var
	alum:alumno;
	mat_detalle:detalle_mat;

	
begin
	reset(maestro);
	reset(det);
	leer(maestro,alum);
	while (alum.codigo<>valoralto)do
	begin
		read(det,mat_detalle);
		while(alum.codigo<>mat_detalle.codigo)do
		begin
			read(det,mat_detalle);
		end;
		if(mat_detalle.aprobo_mat)then
			alum.cant_mat_sin_final:=alum.cant_mat_sin_final+1;
		if(mat_detalle.aprobo_final)then
			alum.cant_mat_final:=alum.cant_mat_final+1;
		seek(maestro,filepos(maestro)-1);
		write(maestro,alum);
	end;
	close(maestro);
	close(det);
end;


procedure listar(var maestro:archivo);
var
	txt:Text;
	alum:alumno;
	nombre:string;
begin
	write('Elija el nombre del archivo: ');
	readln(nombre);
	assign(txt,nombre);
	rewrite(txt);
	reset(maestro);
	while(not eof(maestro))do
		begin
			read(maestro,alum);
			if(alum.cant_mat_sin_final>=4)then
				writeln(txt,'Codigo: ',alum.codigo,'nombre: ',alum.nombre,'apellido: ',alum.apellido,'cantidad de materias aprobadas sin final: ',alum.cant_mat_sin_final,'cantidad de materias aprobadas con final: ',alum.cant_mat_final);
		end;
	close(maestro);
	close(txt);
end;

var 
maestro:archivo;
det:detalle;
BEGIN
	assign(maestro,'maestro.data');
	assign(det,'detalle.data');
	actualizar(maestro,det);
	listar(maestro);
END.

