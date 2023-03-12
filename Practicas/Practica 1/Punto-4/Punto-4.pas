{
4. Agregar al menú del programa del ejercicio 3, opciones para:
	a. Añadir uno o más empleados al final del archivo con sus datos ingresados por 
	teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
	un número de empleado ya registrado (control de unicidad).
b. Modificar edad a uno o más empleados.
c. Exportar el contenido del archivo a un archivo de texto llamado
“todos_empleados.txt”.
d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado.
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

{OPCIONES DE MENU

 PUNTO 3
}
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

{PARTE 2
 
 Punto 4
}

function repetido(var E:archivo; empl:empleado):boolean;
var
	emp:empleado;
begin
	repetido := false;
	while not eof(E)do
		begin
			read(E,emp);
			if(empl.nro_empleado = emp.nro_empleado)then
				repetido := true;
		end;
end;

procedure cargarEmpleados(var E:archivo);
var
	emp:empleado;
begin
	leerEmpleado(emp);
	reset(E);
	while (emp.apellido <> 'fin') do
		begin
			if(not repetido(E,emp))then
				write(E,emp);
			leerEmpleado(emp);
		end;
	close(E);
end;

procedure modificarEdad(var E:archivo;nro_empleado:integer);
var 
	emp:empleado;
	edad:integer;
begin
	reset(E);
	while not eof(E)do
		begin
			read(E,emp);
			if(emp.nro_empleado = nro_empleado)then
				begin
					write('Elija la edad que se le va a modificar al empleado:');
					readln(edad);
					emp.edad:=edad;
					seek(E,filepos(E)-1);
					write(E,emp);
				end;
		end;
	close(E);	
end;

// Exportar a TXT
procedure exportarTxt(var E:archivo);
var
	txt: Text;
	emp:empleado;
begin
	assign(txt, 'todos_empleados.txt');
	rewrite(txt);
	reset(E);
	while not eof(E)do 
		begin
			read(E,emp);
			with emp do
				writeln(txt,' ',nro_empleado,' ',nombre,' ', apellido,' ',dni,' ',edad);
		end;
	writeln('________ Exportado Crack ________');
	close(E); 
	close(txt);
end;

procedure exportar_Emp_sin_dni(var E:archivo);
var
	txt: Text;
	emp:empleado;
begin
	assign(txt, 'faltaDNIEmpleado.txt');
	rewrite(txt);
	reset(E);
	while(not eof(E)) do 
		begin
			read(E,emp);
			if(emp.dni = 00)then
				begin
					with emp do
						writeln(txt,' ',nro_empleado,' ',nombre,' ', apellido,' ',dni,' ',edad);
				end;
		end;
	writeln('________ Exportado Crack ________');
	close(E); 
	close(txt);
end;

procedure menu(var E:archivo);
var
	apellido,nombre:string;
	opcion:char;
	nro_empleado:integer;
begin
	writeln('|--------------------------------------MENU-------------------------------------------|');
	writeln('A-Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
	writeln('B-Listar en pantalla los empleados de a uno por linea');
	writeln('C-Listar en pantalla empleados mayores de 70 anos, proximos a jubilarse');
	writeln('D-Anadir uno o mas empleados al final del archivo');
	writeln('E-Modificar edad a uno o mas empleados');
	writeln('F-Exportar el contenido del archivo a un archivo de texto llamado todos_empleados.txt');
	writeln('G-Exportar a un archivo de texto llamado: faltaDNIEmpleado.txt, los empleados que no tengan cargado el DNI (DNI en 00)');
	writeln('H-Finalizar');
	readln(opcion);
	while opcion <> 'H' do
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
			'D':cargarEmpleados(E);
			'E':
				begin
					write('Elija el numero del empleado para modificar su edad:');
					readln(nro_empleado);
					modificarEdad(E,nro_empleado);
				end;
			'F':exportarTxt(E);
			'G':exportar_Emp_sin_dni(E);
		end;
			writeln('|--------------------------------------MENU-------------------------------------------|');
			writeln('A-Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
			writeln('B-Listar en pantalla los empleados de a uno por linea');
			writeln('C-Listar en pantalla empleados mayores de 70 anos, proximos a jubilarse');
			writeln('D-Anadir uno o mas empleados al final del archivo');
			writeln('E-Modificar edad a uno o mas empleados');
			writeln('F-Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”.');
			writeln('G-Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados que no tengan cargado el DNI (DNI en 00)');
			writeln('H-Finalizar');
		readln(opcion);

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

