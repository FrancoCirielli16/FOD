
{Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.}

program Punto1;
Type archivo = file of integer;
var numeros:archivo;

procedure carga (var N:archivo);
var
	nro:integer;
begin
	writeln('Elija el numero que quiere agregar al archivo');
	read(nro);
	while nro <> 30000 do 
		begin
			write(N,nro);
			read(nro);
		end;
	close(N);
end;
var 
	nombre:string;
BEGIN
	writeln('Elija el nombre del archivo');
	read(nombre);
	Assign(numeros,nombre);
	rewrite(numeros);
	carga(numeros);
END.

