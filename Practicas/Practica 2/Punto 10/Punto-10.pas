{
10. Se tiene información en un archivo de las horas extras realizadas por los empleados de
una empresa en un mes. Para cada empleado se tiene la siguiente información:

departamento, división, número de empleado, categoría y cantidad de horas extras
realizadas por el empleado. Se sabe que el archivo se encuentra ordenado por
departamento, luego por división, y por último, por número de empleados. Presentar en
pantalla un listado con el siguiente formato:

Departamento
División
Número de Empleado 
* Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____

Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
posición del valor coincidente con el número de categoría.

}


program Punto10;

const 
VALORALTO=9999;
DF=15;


type 
categ=1..DF;
empleado=record
	depa:integer;
	division:integer;
	num_empleado:integer;
	cate:categ;
	cant_horas_e:real;
end;

type maestro = file of empleado;

valores = array[1..DF]of real;

procedure leerMaestro(var m:maestro;var e:empleado);
begin
	if(not eof(m))then 
		read(m,e)
	else
		e.depa:=VALORALTO;
end;




procedure listar (var m:maestro;precios:valores);
var 
	e,actual:empleado;
	monto_total,horas_total,monto_total_e,horas_total_e,horas_division,monto_division:real;
begin
	reset(m);
	leerMaestro(m,e);
	while(e.depa<>VALORALTO)do
	begin
		writeln('DEPARTAMENTO:',e.depa);
		actual.depa:=e.depa;
		monto_total:=0;
		horas_total:=0;
		while (e.depa=actual.depa)do
		begin
			writeln('DIVISION',e.division);
			horas_division:=0;
			monto_division:=0;
			actual.division:=e.division;
			while (e.depa=actual.depa)and(e.division=actual.division)do
			begin
				horas_total_e:=0;
				monto_total_e:=0;
				actual.num_empleado:=e.num_empleado;
				while (e.depa=actual.depa)and(e.division=actual.division)and(e.num_empleado=actual.num_empleado)do
				begin
					actual.cate:=e.cate;
					horas_total_e:=horas_total_e+e.cant_horas_e;
					leerMaestro(m,e);
				end;
				writeln('Número de Empleado | Total de Hs. | Importe a cobrar');
				monto_total_e:=horas_total_e*precios[actual.cate];
				writeln(actual.num_empleado,'',horas_total,'',monto_total_e);
				writeln('-------------------------------------------------');
				horas_division:=horas_division+horas_total_e;
			end;
			writeln('TOTAL DE HORAS DE DIVISION: ',horas_division);
			monto_division:=monto_division+monto_total_e;
			writeln('MONTO TOTAL POR DIVISION: ',monto_division);
			horas_total:=horas_total+horas_division;
		end;
		writeln('TOTAL HORAS DEPAERTAMENTO: ',horas_total);
		monto_total:=monto_total+monto_division;
		writeln('MONTO TOTAL DEPARTAMENTO: ',monto_total);
	end;
	close(m);
end;

procedure cargarVector(var precios:valores);
var
	valor:real;
	i:integer;
	cate:integer;
	txt:Text;
begin
	assign(txt,'montos.txt');
	reset(txt);
	for i:=1 to DF do
	begin
		readln(txt,cate,valor);
		precios[cate]:=valor;
	end;
	close(txt);
	writeln('precios cargados');
end;

var
	precios:valores;
	m:maestro;
BEGIN
	cargarVector(precios);
	assign(m,'maestro');
	listar(m,precios);
END.

