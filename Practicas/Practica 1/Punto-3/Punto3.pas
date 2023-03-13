{
* 
3-Realizar un programa que presente un menú con opciones para:

a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.

b. Abrir el archivo anteriormente generado y

i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.

ii. Listar en pantalla los empleados de a uno por línea.

iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.

NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.
* 
}


program Punto3;

Type empleado = record
	nro_empleado:integer;
	nombre:string;
	apellido:string;
	edad:integer;
	dni:integer;
end;

Type archivo = file of empleado;
var empleados:archivo;

//CARGA DE DATOS DE EMPLEADO
procedure leerEmpleado (var E:empleado);
begin
	write('numero de empleado:');
	readln(E.nro_empleado);
	write('nombre:');
	readln(E.nombre);
	write('apellido:');
	readln(E.apellido);
	write('DNI:');
	readln(E.dni);
	write('edad:');
	readln(E.edad);
end;

//CARGA DE ARCHIVO DE EMPLEADOS
procedure cargar_archivo(var E:archivo);
var
	emp:empleado;
begin
	leerEmpleado(emp);
	reset(E);
	while emp.apellido <> 'fin' do
		begin	
			write(E,emp);
			leerEmpleado(emp);
		end;
	close(E);
end;

//PARA SIMPLIFICAR CODIGO Y NO REPETIR
procedure imprimirEmp(emp:empleado);
begin
	writeln('numero de empleado:');
	writeln(emp.nro_empleado);
	writeln('nombre:');
	writeln(emp.nombre);
	writeln('apellido:');
	writeln(emp.apellido);
	writeln('DNI:');
	writeln(emp.dni);
	writeln('edad:');
	writeln(emp.edad);
end;

//IMPRIME TODA LA DATA DEL ARCHIVO OPCION A
procedure imprimirALL (var E:archivo);
var
	emp:empleado;
begin
	reset(E);
	while not eof(E) do
		begin
			read(E,emp);
			imprimirEmp(emp);
		end;
	close(E);
end;

//IMPRIME LOS MAYORES DE 70 OPCION B
procedure imprimirMayores (var E:archivo);
var
	emp:empleado;
begin
	reset(E);
	while not eof(E) do
		begin
			read(E,emp);
			if(emp.edad > 70)then
				begin
					imprimirEmp(emp);
				end;
		end;
	close(E);
end;

//IMPRIME EMPLEADO CON NOMBRE O APELLIDO DESEADO OPCION C
procedure imprimirDeterminado(var E:archivo; nombre:string; apellido:string);
var
	emp:empleado;
begin
	reset(E);
	while not eof(E) do
		begin
			read(E,emp);
			if((emp.nombre = nombre) or (emp.apellido = apellido))then
				begin
					imprimirEmp(emp);
				end;
		end;
	close(E);
end;

//MENU
procedure menu(var E:archivo);
var
	apellido,nombre:string;
	opcion:char;
begin
	writeln('|--------------------------------------MENU-------------------------------------------|');
	writeln('A-Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
	writeln('B-Listar en pantalla los empleados de a uno por línea');
	writeln('C-Listar en pantalla empleados mayores de 70 anos, proximos a jubilarse');
	writeln('D-Finalizar');
	readln(opcion);
	while opcion <> 'D' do
	begin
		case opcion of
			'A': 
				begin
					write('elegir el nombre o el apellido de los que empleados que quieras ver:');
					readln(nombre);
					readln(apellido);
					imprimirDeterminado(E,nombre,apellido);
				end;
			'B':imprimirALL(E);
			'C':imprimirMayores(E);
		end;
		writeln('|--------------------------------------MENU-------------------------------------------|');
		writeln('A-Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
		writeln('B-Listar en pantalla los empleados de a uno por línea');
		writeln('C-Listar en pantalla empleados mayores de 70 anos, proximos a jubilarse');
		writeln('D-Finalizar');
		readln(opcion);
		{
		* opcion 2
		if(opcion = 'A')then
			begin
				writeln('elegir el nombre o el apellido de los que empleados que quieras ver:');
				read(nombre);
				read(apellido);
				imprimirDeterminado(E,nombre,apellido);
			end;
		if(opcion = 'B')then
			imprimirALL(E);
		if(opcion = 'C')then
			imprimirMayores(E);
		}
	end;
end;


var
	nombre:string;
BEGIN
	writeln('Elija el nombre del archivo');
	readln(nombre);
	Assign(empleados,nombre);
	rewrite(empleados);
	cargar_archivo(empleados);
	menu(empleados);
END.

