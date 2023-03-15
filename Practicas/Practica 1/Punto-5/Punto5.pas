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
	desc:string;
	marca:string;
	precio:real;
	stock_minimo:integer;
	stock_disponible:integer;
end;

Type archivo = file of celular;

//SOLICITA DATOS DEL CELULAR
procedure leerCelular(var c:celular);
	begin
		writeln('Para finalizar escribir en el nombre: fin');
		write('codigo del celular:');
		readln(c.codigo_celular);
		write('nombre:');
		readln(c.nombre);
		write('descripcion:');
		readln(c.desc);
		write('marca:');
		readln(c.marca);
		write('precio:');
		readln(c.precio);
		write('stock minimo:');
		readln(c.stock_minimo);
		write('stock disponible:');
		readln(c.stock_disponible);
	end;


//CREACION DEL ARCHIVO OPCION A
procedure cargar_archivo(var C:archivo);
var
	celu:celular;
	txt:Textfile;
	nombre:string;
begin
	writeln('Elija el nombre del archivo');
	readln(nombre);
	Assign(C,nombre);
	Assign(txt,'celulares.txt');
	rewrite(C);
	reset(txt);
	while (not eof(txt)) do
		begin
			readln(txt,celu.codigo_celular, celu.precio, celu.marca);
			readln(txt,celu.stock_disponible, celu.stock_minimo, celu.desc);
			readln(txt,celu.nombre);
			write(C, celu);
		end;
	writeln('Archivo cargado');
	close(txt);
	close(C);
end;

//PROCESO PARA NO REPETIR CODIGO
procedure imprimirCelular(c:celular);
begin
	writeln('codigo del celular:',c.codigo_celular);
	writeln('nombre:',c.nombre);
	writeln('descripcion:',c.desc);
	writeln('marca:',c.marca);
	writeln('precio:',c.precio:2);
	writeln('stock minimo:',c.stock_minimo);
	writeln('stock disponible:',c.stock_disponible);
	writeln(' ');
end;

//IMPRIME SI EL STOCK MINIMO ES MAYOR AL STOCK DISPONIBLE OPCION B
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

//IMPRIME EL CELULAR CON LA DESCRIPCION QUE VOS DESEAS OPCION C
procedure listaDescUsuario(var C:archivo);
var
	celu:celular;
	desc:string[20];
begin
	reset(C);
	writeln('Ingrese una descripcion: ');
	readln(desc);
	desc:=Concat('',desc);
	while not eof(C)do
		begin
			read(C,celu);
			if(celu.desc = desc)then
				imprimirCelular(celu);
		end;
	close(C);
end;

//EXPORTA TODO EL ARCHIVO OPCION D
procedure exportarTxt (var C:archivo);
var
	txt:Text;
	celu:celular;
begin
	assign(txt,'celularesExportados.txt');
	rewrite(txt);
	reset(C);
	while not eof(C)do
		begin
			read(C,celu);
			with celu do
				begin
					writeln(txt,' codigo del celular:  ',codigo_celular,'| nombre: ',nombre,'| descripcion: ',desc,'  |  ');
					writeln(txt,' marca: ',marca,'| stock minimo:  ',stock_minimo,'| stock disponible:  ',stock_disponible,'|  precio: ',precio:1);
				end;
		end;
	writeln('________Exportado crack_______');
	close(C);
	close(txt);
end;

//MENU
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
			'C':listaDescUsuario(C);
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
BEGIN
	menu(celulares);
END.

