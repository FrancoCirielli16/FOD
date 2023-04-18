{
 4. Dada la siguiente estructura:
type
reg_flor = record
nombre: String[45];
codigo:integer;
tArchFlores = file of reg_flor;
* 
Las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
número 0 en el campo código implica que no hay registros borrados y -N indica que el
próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.

a. Implemente el siguiente módulo:
Abre el archivo y agrega una flor, recibida como parámetro manteniendo la política descripta anteriormente

procedure agregarFlor (var a: tArchFlores ; nombre: string; codigo:integer);

b. Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que
considere necesario para obtener el listado.
   
   
}


program untitled;
const VALORALTO=9999;
type
reg_flor = record
	nombre: String[45];
	codigo:integer;
end;
type tArchFlores = file of reg_flor;


procedure agregarFlor (var a: tArchFlores ; nombre: string; codigo:integer);
var
	flor:reg_flor;
	indice:reg_flor;
begin
	reset(a);
	read(a,flor);
	if(flor.codigo<0)then
	begin
		seek(a,abs(flor.codigo));
		read(a,indice);
		seek(a,FilePos(a)-1);
		flor.codigo:=codigo;
		flor.nombre:=nombre;
		write(a,flor);
		seek(a,0);
		write(a,indice);
		writeln('SE AGREGO FLOR')
	end
	else
		writeln('NO HAY ESPACIO LIBRE');
	close(a);
end;

procedure leerFlores(var a: tArchFlores;var f:reg_flor);
begin
	if(not eof(a))then
		read(a,f)
	else
		f.codigo:=VALORALTO;
end;

procedure listar(var a: tArchFlores;var maestro:tArchFlores);
var
	f:reg_flor;
begin
	reset(a);
	assign(a,'lista-sin-eliminados'); 
	rewrite(maestro);
	leerFlores(a,f);
	while(f.codigo<>VALORALTO)do
	begin
		if(f.codigo>0)then
			write(maestro,f)
		else
			leerFlores(a,f)
	end;
	close(a);
	close(maestro);
end;


var
	a,maestro: tArchFlores;
	nombre:string;
	codigo:integer;
BEGIN
	assign(a,'flores');
	writeln('codigo: ');
	readln(codigo);
	writeln('nombre: ');
	readln(nombre);
	agregarFlor(a,nombre,codigo);
	listar(a,maestro);
END.

