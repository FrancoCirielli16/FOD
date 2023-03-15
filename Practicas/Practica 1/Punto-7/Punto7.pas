{
   7. Realizar un programa que permita:

a. Crear un archivo binario a partir de la información almacenada en un archivo de texto.
El nombre del archivo de texto es: “novelas.txt”

b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar
una novela y modificar una existente. Las búsquedas se realizan por código de novela.
NOTA: La información en el archivo de texto consiste en: código de novela, nombre,
género y precio de diferentes novelas argentinas. De cada novela se almacena la
información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente
información: código novela, precio, y género, y la segunda línea almacenará el nombre
de la novela.
   
   
}


program punto7;

Type novela = record
	codigo_novela:integer;
	nombre:string;
	genero:string;
	precio:real;
end;

Type archivo = file of novela; 

procedure leerNovela(var n:novela);
begin
	writeln('Para finalizar escribir en el nombre: fin');
	write('codigo de la novela:');
	readln(n.codigo_novela);
	write('nombre:');
	readln(n.nombre);
	write('genero:');
	readln(n.genero);
	write('precio:');
	readln(n.precio);
end;

//CARGA ARCHIVO DESDE EL TXT NOVELAS.TXT
procedure cargar_archivo(var N:archivo);
var
	nov:novela;
	txt:Text;
	nombre:string;
begin
	write('Elija el nombre del archivio que se va a crear:');
	readln(nombre);
	Assign(N,nombre);
	Assign(txt,'novelas.txt');
	rewrite(N);
	reset(txt);
	while not eof(txt)do
		begin
			readln(txt,nov.codigo_novela,nov.precio,nov.genero);
			readln(txt,nov.nombre);
			write(N,nov);
		end;
	close(N);
	close(txt);
end;


//CARGA MAS NOVELAS
procedure cargar_Mas_novelas (var N:archivo);
var
	nov:novela;
begin
	leerNovela(nov);
	reset(N);
	while(nov.nombre<>'fin')do
		begin
			seek(N,filesize(N));
			write(N,nov);
			leerNovela(nov);
		end;
	close(N);
end;

//MODIFICA LA NOVELAS QUE DESEES
procedure modificarNovela(var N:archivo);
var
	nov:novela;
	codigo_novela:integer;
begin
	write('Elija el codigo de la novela que quiere modificar:');
	readln(codigo_novela);
	reset(N);
	while (not eof(N))do
		begin
			read(N,nov);
			if (nov.codigo_novela = codigo_novela) then
				begin
					write('nombre:');
					readln(nov.nombre);
					write('precio:');
					readln(nov.precio);
					write('genero:');
					readln(nov.genero);
					seek(N,filepos(N)-1);
					write(N,nov);
				end;
		end;
end;

//MENU
procedure menu(var N:archivo);
var
	opcion:char;
begin
	writeln('|--------------------------------------MENU-------------------------------------------|');
	writeln('A-Crear archivo de novelas');
	writeln('B-Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock minimo');
	writeln('C-Listar en pantalla los celulares del archivo cuya descripcion contenga una cadena de caracteres proporcionada por el usuario.');
	writeln('D-Finalizar');
	readln(opcion);
	while opcion <> 'D' do
	begin
		case opcion of
			'A':cargar_archivo(N);
			'B':cargar_Mas_novelas(N);
			'C':modificarNovela(N);
		end;
		writeln('|--------------------------------------MENU-------------------------------------------|');
		writeln('A-Crear archivo de novelas');
		writeln('B-Cargar mas novelas al archivos');
		writeln('C-Modificar novela');
		writeln('D-Finalizar');
		readln(opcion);
	end;
end;

var
	novelas:archivo;
BEGIN
	menu(novelas);
END.

