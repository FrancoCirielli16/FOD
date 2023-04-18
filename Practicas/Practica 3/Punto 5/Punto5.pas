{
5. Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo:

Abre el archivo y elimina la flor recibida como parámetro manteniendo
la política descripta anteriormente
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
   
   
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

procedure eliminarFlor (var a: tArchFlores);
var
	f,indice:reg_flor;
	codigo:integer;
	ok:boolean;
begin
	reset(a);
	write ('INGRESE CODIGO DE LA FLOR QUE DESEA ELIMINAR: '); readln (codigo);
	leerFlores(a,indice);
	leerFlores(a,f);
	ok:=false;
	while(f.codigo=VALORALTO)and(not(ok))do
	begin
		if(f.codigo=codigo)then
		begin
			ok:=true;
			f.codigo:=indice.codigo;
			seek(a,FilePos(a)-1);
			indice.codigo:=FilePos(a)*-1;
			write(a,f);
			seek(a,0);
			write(a,indice);
		end
		else
			leerFlores(a,f);
	end;
	close(a);
	if (ok) then 
		writeln ('FLOR ELIMINADA')
	else
		writeln ('NO SE ENCONTRO FLOR');
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

