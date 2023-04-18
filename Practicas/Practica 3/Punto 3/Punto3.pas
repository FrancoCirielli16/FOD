{

Realizar un programa que genere un archivo de novelas filmadas durante el presente
año. De cada novela se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:

a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
utiliza la técnica de lista invertida para recuperar espacio libre en el
archivo. Para ello, durante la creación del archivo, en el primer registro del
mismo se debe almacenar la cabecera de la lista. Es decir un registro
ficticio, inicializando con el valor cero (0) el campo correspondiente al
código de novela, el cual indica que no hay espacio libre dentro del
archivo.

b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
inciso a., se utiliza lista invertida para recuperación de espacio. En
particular, para el campo de ´enlace´ de la lista, se debe especificar los
números de registro referenciados con signo negativo, (utilice el código de
novela como enlace).Una vez abierto el archivo, brindar operaciones para:

i. Dar de alta una novela leyendo la información desde teclado. Para
esta operación, en caso de ser posible, deberá recuperarse el
espacio libre. Es decir, si en el campo correspondiente al código de
novela del registro cabecera hay un valor negativo, por ejemplo -5,
se debe leer el registro en la posición 5, copiarlo en la posición 0
(actualizar la lista de espacio libre) y grabar el nuevo registro en la
posición 5. Con el valor 0 (cero) en el registro cabecera se indica
que no hay espacio libre.

ii. Modificar los datos de una novela leyendo la información desde
teclado. El código de novela no puede ser modificado.

iii. Eliminar una novela cuyo código es ingresado por teclado. Por
ejemplo, si se da de baja un registro en la posición 8, en el campo
código de novela del registro cabecera deberá figurar -8, y en el
registro en la posición 8 debe copiarse el antiguo registro cabecera.

c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
proporcionado por el usuario.

}


program Punto3;
const VALORALTO=9999;

{Realizar un programa que genere un archivo de novelas filmadas durante el presente
año. De cada novela se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:}


type novela=record
	codigo:integer;
	genero:string;
	nombre:string;
	duracion:real;
	director:string;
	precio:real;
end;

type maestro=file of novela;


{
a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
utiliza la técnica de lista invertida para recuperar espacio libre en el
archivo. Para ello, durante la creación del archivo, en el primer registro del
mismo se debe almacenar la cabecera de la lista. Es decir un registro
ficticio, inicializando con el valor cero (0) el campo correspondiente al
código de novela, el cual indica que no hay espacio libre dentro del
archivo.
}
procedure leerNovela(var n:novela);
begin
	write('codigo: ');
	readln(n.codigo);
	if(n.codigo<>-1)then
	begin
		writeln('genero: ');
		readln(n.genero);
		writeln('nombre: ');
		readln(n.nombre);
		writeln('duracion');
		readln(n.duracion);
		writeln('director');
		readln(n.director);
		writeln('precio');
		readln(n.precio);
	end;
end;

procedure crearMae(var archivo_maestro:maestro);
var
	n:novela;
begin
	rewrite(archivo_maestro);
	n.codigo:=0;
	write(archivo_maestro,n);
	while(n.codigo<>-1)do
	begin
		leerNovela(n);
		write(archivo_maestro,n);
	end;
end;

procedure leerM(var archivo_maestro:maestro;var n:novela);
begin
	if(not eof(archivo_maestro))then
		read(archivo_maestro,n)
	else
		n.codigo:=VALORALTO;
end;

procedure imprimir (n:novela);
begin
	with n do begin
		writeln ('|CODIGO: ',codigo,'|GENERO: ',genero,'|NOMBRE: ',nombre,'|DURACION: ',duracion,' |DIRECTOR: ',director,'|PRECIO: ',precio:0:2);
		writeln ('');
	end;
end;

procedure mostrarPantalla (var archivo_maestro:maestro);
var
	n:novela;
begin
	seek (archivo_maestro,1);
	leerM(archivo_maestro,n);
	while (n.codigo <> VALORALTO) do begin
		imprimir (n);
		leerM(archivo_maestro,n);
	end;
end;

{b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
inciso a., se utiliza lista invertida para recuperación de espacio. En
particular, para el campo de ´enlace´ de la lista, se debe especificar los
números de registro referenciados con signo negativo, (utilice el código de
novela como enlace).Una vez abierto el archivo, brindar operaciones para:}

procedure darAlta(var archivo_maestro:maestro);
var
	indice,n:novela;
begin
	leerM(archivo_maestro,n);
	if(n.codigo<0)then
	begin
		seek(archivo_maestro,abs(n.codigo));
		read(archivo_maestro,indice);
		seek(archivo_maestro,FilePos(archivo_maestro)-1);
		leerNovela(n);
		write(archivo_maestro,n);
		seek(archivo_maestro,0);
		write(archivo_maestro,indice);
	end
	else
	begin
		seek(archivo_maestro,FileSize(archivo_maestro));
		leerNovela(n);
		write(archivo_maestro,n);
	end;
end;

{ii. Modificar los datos de una novela leyendo la información desde
teclado. El código de novela no puede ser modificado.}

procedure modificar(var archivo_maestro:maestro);
var
	n:novela;
	codigo_novela:integer;
begin
	writeln('Ingrese el codigo de la novela que desea cambiar');
	readln(codigo_novela);
	leerM(archivo_maestro,n);
	while(n.codigo<>VALORALTO)do
	begin
		if(n.codigo=codigo_novela)then
		begin
			writeln('genero: ');
			readln(n.genero);
			writeln('nombre: ');
			readln(n.nombre);
			writeln('duracion');
			readln(n.duracion);
			writeln('director');
			readln(n.director);
			writeln('precio');
			readln(n.precio);
			seek(archivo_maestro,FilePos(archivo_maestro)-1);
		end;
		leerM(archivo_maestro,n);
	end;
end;

{iii. Eliminar una novela cuyo código es ingresado por teclado. Por
ejemplo, si se da de baja un registro en la posición 8, en el campo
código de novela del registro cabecera deberá figurar -8, y en el
registro en la posición 8 debe copiarse el antiguo registro cabecera.}

procedure eliminar(var archivo_maestro:maestro);
var
	codigo_novela:integer;
	n:novela;
begin
	leerM(archivo_maestro,n);
	writeln('Ingrese el codigo de la novela: ');
	readln(codigo_novela);
	while(n.codigo<>VALORALTO)do
	begin
		if(codigo_novela=n.codigo)then
		begin
			n.nombre:='@Eliminado';
			seek(archivo_maestro,FilePos(archivo_maestro)-1);
			write(archivo_maestro,n);
		end;
	end;
end;


{c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
proporcionado por el usuario.}

procedure listar (var archivo_maestro:maestro);
var
	n:novela;
	txt: Text;
begin
	assign(txt,'novelas.txt');
	rewrite (txt);
	seek (archivo_maestro,1); // me salteo el cabecera
	leerM(archivo_maestro,n);
	while (n.codigo <> VALORALTO) do begin
		with n do begin
			if (codigo > 0) then
				writeln (txt,'CODIGO: ',codigo,' NOMBRE: ',nombre,' GENERO: ',genero,' DIRECTOR: ',director,' DURACION: ',duracion,' PRECIO: ',precio:1:1)
			else
				writeln (txt,'ESPACIO LIBRE');
		end;
		leerM(archivo_maestro,n);
	end;
	close (archivo_maestro);
	close(txt);
end;

//MENU
procedure menu(var archivo_maestro:maestro);
var
	opcion:char;
begin
	reset(archivo_maestro);
	writeln('|--------------------------------------MENU-------------------------------------------|');
	writeln('A-Crear archivo de novelas');
	writeln('B-DAR DE ALTA NOVELA');
	writeln('C-MODIFICAR');
	writeln('D-ELIMINAR');
	writeln('E-LISTAR EN ARCHIVO DE TEXTO');
	writeln('F-MOSTRAR EN PANTALLA');
	writeln('G-FINALIZAR');
	readln(opcion);
	while opcion <> 'F' do
	begin
		case opcion of
			'A':crearMae(archivo_maestro);
			'B':darAlta(archivo_maestro);
			'C':modificar(archivo_maestro);
			'D':eliminar(archivo_maestro);
			'E':listar(archivo_maestro);
			'G':mostrarPantalla(archivo_maestro);
			
		end;
		writeln('|--------------------------------------MENU-------------------------------------------|');
		writeln('A-Crear archivo de novelas');
		writeln('B-ABRIR ARCHIVO');
		writeln('C-ELIMINAR');
		writeln('D-LISTAR EN ARCHIVO DE TEXTO');
		writeln('D-FINALIZAR');
		readln(opcion);
	end;
	close(archivo_maestro);
end;


var
	mae:maestro;
	nombre:string;
BEGIN
	writeln('Ingrese el nombre del maestro: ');
	readln(nombre);
	assign(mae,nombre);
	menu(mae);
	
END.

