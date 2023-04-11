{



Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.

Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. 

En consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez
   
   
 
}


program punto1;
const valoralto = -1;
type empleado=record 
	codigo:integer;
	nombre:string;
	monto:real;
end;

type archivo = file of empleado;

procedure crearArchivo(var arch_logico:archivo;arch_fisico:string);
var
	carga: text;
	emp: empleado;
begin
	writeln('Nombre del archivo fisico: ');
	assign(arch_logico,arch_fisico);
	assign(carga, 'empleados.txt');
	rewrite(arch_logico);
	reset(carga);
	while(not  eof(carga)) do 
    begin
		readln(carga, emp.codigo);
        readln(carga, emp.nombre);
        readln(carga, emp.monto);
		write(arch_logico, emp);
	end;
	writeln('Archivo cargado.');
	close(arch_logico); 
end;

//------------------------------------------------

procedure leer (var main:archivo; var dato:empleado);
begin
	if (not eof(main)) then 
		read (main, dato)
	else 
		dato.codigo := valoralto;
end;

procedure corteDeControl (var main:archivo);
var
	monto_tot:real;
	emp,emp_totalizado,emp_ant:empleado;
	arch_compactado:archivo;
begin
	assign(arch_compactado,'merge');
	reset(main);
	rewrite(arch_compactado);
	leer(main,emp);
	monto_tot := 0;
	
	while(emp.codigo<>valoralto)do
	begin
		monto_tot := 0;
		emp_ant:=emp;
		while(emp.codigo=emp_ant.codigo)do
		begin
			monto_tot:=monto_tot+emp.monto;
			leer(main,emp);
		end;
		emp_totalizado:=emp_ant;
		emp_totalizado.monto:=monto_tot;
		write(arch_compactado,emp_totalizado);
	end;
	close(main);
	close(arch_compactado);
end;



var 
	main:archivo;
BEGIN
	crearArchivo(main,'empleados');
	corteDeControl(main);
END.

