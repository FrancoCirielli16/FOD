{2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.}

program Punto2;
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

function menores (var N:archivo):integer;
var
	nro,cantidad:integer;
begin
	cantidad:=0;
	reset(N);
	while not eof(N)do
		begin 
			read(N,nro);
			if(nro < 1500) then
				cantidad:= cantidad + 1;
		end;
	close(N);
	menores:= cantidad;		
end;

function promedio (var N:archivo):real;
var
	nro,suma:integer;
begin
	suma:=0;
	reset(N);
	while not eof(N)do
		begin 
			read(N,nro);
			suma:=suma+nro;
		end;
	promedio:= suma/FileSize(N);	
	close(N);
end;

procedure imprimir (var N:archivo);
var
	nro:integer;
begin
	reset(N);
	while not eof(N) do
		begin
			read(N,nro);
			writeln(nro);
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
	imprimir(numeros);
	writeln('Cantidad de numeros menores a 1500:',menores(numeros));
	writeln('Promedio:',promedio(numeros):2);
END.

