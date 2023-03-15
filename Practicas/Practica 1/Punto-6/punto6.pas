{
  
6. Agregar al menú del programa del ejercicio 5, opciones para:

a. Añadir uno o más celulares al final del archivo con sus datos ingresados por
teclado.

b. Modificar el stock de un celular dado.

c. Exportar el contenido del archivo binario a un archivo de texto denominado:”SinStock.txt”, con aquellos celulares que tengan stock 0.

NOTA: Las búsquedas deben realizarse por nombre de celular.
   
}



program Punto6;

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
	assign(txt,'celulares.txt');
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

//CARGA MAS CELULARES OPCION E
procedure cargar_Mas_Celulares(var C:archivo);
var
	celu:celular;
begin
	leerCelular(celu);
	reset(C);
	while celu.nombre <> 'fin' do
		begin
			seek(C,filesize(C));
			write(C,celu);
			leerCelular(celu);
		end;
	close(C);
end;


//MODIFICA EL STOCK DEL CELULAR QUE DESEES OPCION F
procedure modificarCelular(var C:archivo);
var
	celu:celular;
	nombre:string;
	stock:integer;
begin
	write('Ingresar el nombre del celular que queres modificar:');
	readln(nombre);
	reset(C);
	while not eof(C) do
		begin
			read(C,celu);
			if(celu.nombre = nombre)then
			begin
				write('Ingresa la cantidad de stock nuevo: ');
				readln(stock);
				celu.stock_disponible := celu.stock_disponible + stock;
				seek(C,filepos(C)-1);
				write(C,celu);
			end;
		end;
	close(C);
end;

//EXPORTA LOS CELULARES CON STOCK 0
procedure exportarCelus_Sin_Stock (var C:archivo);
var
	txt:Text;
	celu:celular;
begin
	assign(txt,'SinStock.txt');
	rewrite(txt);
	reset(C);
	while not eof(C)do
		begin
			read(C,celu);
			if(celu.stock_disponible = 0)then
				begin
					with celu do 
						writeln(txt,'codigo del celular: ',codigo_celular,'| nombre: ',nombre,'| marca: ',marca,'| descripcion: ',desc,'| precio: ',precio:1);
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
	writeln('E-Anadir uno o más celulares al final del archivo con sus datos ingresados por teclado');
	writeln('F-Modificar el stock de un celular dado');
	writeln('G-Exportar el contenido del archivo binario a un archivo de texto denominado:”SinStock.txt”, con aquellos celulares que tengan stock 0');
	writeln('H-Finalizar');
	readln(opcion);
	while opcion <> 'H' do
	begin
		case opcion of
			'A':cargar_archivo(C);
			'B':imprimirPorStocks(C);
			'C':listaDescUsuario(C);
			'D':exportarTxt(C);
			'E':cargar_Mas_Celulares(C);
			'F':modificarCelular(C);
			'G':exportarCelus_Sin_Stock(C);
		end;
		writeln('|--------------------------------------MENU-------------------------------------------|');
		writeln('A-Crear un archivo de celulares');
		writeln('B-Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock minimo');
		writeln('C-Mostrar en pantalla celulares con descripcion deseada por usuario.');
		writeln('D-Exportar el archivo creado');
		writeln('E-Anadir más celulares');
		writeln('F-Modificar el stock de un celular dado');
		writeln('G-Exportar el contenido del archivo denominado: SinStock.txt');
		writeln('H-Finalizar');
		readln(opcion);
	end;
end;

var 
	celulares:archivo;
BEGIN
	menu(celulares);
END.
