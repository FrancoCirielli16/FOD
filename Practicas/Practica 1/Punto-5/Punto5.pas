{
5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripción, marca, precio, stock mínimo y el stock disponible.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo. El archivo de texto generado
podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que
debería respetar el formato dado para este tipo de archivos en la NOTA 2.
}


program Punto5;

Type celular = record
	codigo_celular:integer;
	nombre:string;
	descripcion:string;
	marca:string;
	precio:real;
	stock_minimo:integer;
	stock_disponible:integer;
end;

Type archivo = file of celular;

procedure leerCelular(var c:celular);
	begin
		write('codigo del celular:');
		readln(c.codigo_celular);
		write('nombre:');
		readln(c.nombre);
		write('descripcion:');
		readln(c.descripcion);
		write('marca:');
		readln(c.marca);
		write('precio:');
		readln(c.precio);
		write('stock minimo:');
		readln(c.stock_minimo);
		write('stock disponible:');
		readln(c.stock_disponible);
	end;

procedure cargar_archivo(var C:archivo);
var
	celu:celular;
begin
	leerCelular(celu);
	rewrite(C);
	while celu.nombre <> 'fin' do
		begin
			write(C,celu);
			leerCelular(celu);
		end;
end;

procedure imprimirCelular(c:celular);
begin
	writeln('codigo del celular:',c.codigo_celular);
	writeln('nombre:',c.nombre);
	writeln('descripcion:',c.descripcion);
	writeln('marca:',c.marca);
	writeln('precio:',c.precio:2);
	writeln('stock minimo:',c.stock_minimo);
	writeln('stock disponible:',c.stock_disponible);
	writeln(' ');
end;

procedure imprimirPorStocks(var C:archivo);
var 
	celu:celular;
begin
	reset(C);
	while not eof(C)do
		begin
			read(C,celu);
			if(celu.stock_disponible<celu.stock_minimo)then
				imprimirCelular(celu);
		end;
	close(C);
end;


procedure exportarTxt (var C:archivo);
var
	txt:Text;
	celu:celular;
begin
	assign(txt,'celulares.txt');
	rewrite(txt);
	reset(C);
	while not eof(C)do
		begin
			read(C,celu);
			with celu do
				writeln(txt,' ',codigo_celular,' ',precio:2,' ',marca,' ',stock_minimo,' ',stock_disponible);
		end;
	writeln('________Exportado crack_______');
	close(C);
	close(txt);
end;

procedure menu(var C:archivo);
var
	opcion:char;
begin
	writeln('|--------------------------------------MENU-------------------------------------------|');
	writeln('A-Crear un archivo de celulares');
	writeln('B-Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock minimo');
	writeln('C-Listar en pantalla los celulares del archivo cuya descripcion contenga una cadena de caracteres proporcionada por el usuario.');
	writeln('D-Exportar el archivo creado');
	writeln('E-Finalizar');
	readln(opcion);
	while opcion <> 'E' do
	begin
		case opcion of
			'A':cargar_archivo(C);
			'B':imprimirPorStocks(C);
			'C':writeln('C');
			'D':exportarTxt(C);
		end;
		writeln('|--------------------------------------MENU-------------------------------------------|');
		writeln('A-Crear un archivo de celulares');
		writeln('B-Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo');
		writeln('C-Listar en pantalla los celulares del archivo cuya descripcion contenga una cadena de caracteres proporcionada por el usuario.');
		writeln('D-Exportar el archivo creado');
		writeln('E-Finalizar');
		readln(opcion);
	end;
end;

var 
	celulares:archivo;
	nombre:string;
BEGIN
	writeln('Elija el nombre del archivo');
	readln(nombre);
	Assign(celulares,nombre);
	menu(celulares);
END.

