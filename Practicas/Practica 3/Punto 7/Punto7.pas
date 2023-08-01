{
7. Se cuenta con un archivo que almacena información sobre especies de aves en
vía de extinción, para ello se almacena: código, nombre de la especie, familia de ave,
descripción y zona geográfica. 

El archivo no está ordenado por ningún criterio. Realice
un programa que elimine especies de aves, para ello se recibe por teclado las especies a
eliminar. Deberá realizar todas las declaraciones necesarias, implementar todos los
procedimientos que requiera y una alternativa para borrar los registros. 

Para ello deberá implementar dos procedimientos, uno que marque los registros a borrar y posteriormente
otro procedimiento que compacte el archivo, quitando los registros marcados. Para
quitar los registros se deberá copiar el último registro del archivo en la posición del registro
a borrar y luego eliminar del archivo el último registro de forma tal de evitar registros
duplicados.
Nota: Las bajas deben finalizar al recibir el código 500000
   
}

program ejer7;

CONST 
valorAlto = 9999;

type
ave = record
	cod:integer;
	nom:string[50];
	fam:string[50];
	des:string[50];
	zona:string[50];
end;

archivo = file of ave;

procedure leer (var a:ave);
begin
	with a do begin
		write ('INGRESE CODIGO AVE: '); readln (cod);
		if (cod <> -1) then begin
			write ('INGRESE NOMBRE DE AVE: '); readln (nom);
			write ('INGRESE FAMILIA DE AVE: '); readln (fam);
			write ('INGRESE DESCRIPCION: '); readln (des);
			write ('INGRESE ZONA: '); readln (zona);
		end;
		writeln ('')
	end;
end;

procedure imprimir (a:ave);
begin
	with a do begin
		writeln ('CODIGO: ',cod,' NOMBRE: ',nom,' FAMILIA: ',fam,' ZONA: ',zona);
		writeln (' ');
	end;
end;

procedure leerArc (var arc_log:archivo; var dato:ave);
begin
	if not eof (arc_log) then
		read (arc_log,dato)
	else
		dato.cod := valorAlto;
end;

procedure crear (var mae:archivo);
var
n:ave;
begin
	rewrite (mae);
	leer (n);
	while (n.cod <> -1) do begin
		write (mae,n);
		leer(n);
	end;
	close (mae);
end;

procedure mostrar (var mae:archivo);
var
n:ave;
begin
	reset (mae);
	leerArc(mae,n);
	while (n.cod <> valorAlto) do begin
		imprimir (n);
		leerArc(mae,n);
	end;
	close (mae);
end;

procedure eliminar(var mae:archivo; cod:integer);
var
	a:ave;
	ok:boolean;
begin
	reset(mae);
	ok:= false;
	writeln ('');
	leerArc(mae,a);
	while(a.cod <> VALORALTO)and(not(ok))do
	begin
		if(a.cod = cod)then
		begin
			a.nom:='@Eliminado';
			seek(mae,filePos(mae)-1);
			write(mae,a);
			ok:=true;
		end;
		leerArc(mae,a);
	end;
	if(ok)then
		writeln('AVE ELIMINADA')
	else
		writeln('AVE NO ENCONTRADO');
end;


BEGIN
	
	
END.

