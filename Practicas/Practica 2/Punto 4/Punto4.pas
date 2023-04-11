{
   4. 
   
   Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. 

Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.

Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.
   
   
}


program punto5;
const VALORALTO = 9999;
const DF = 2;
const RUTA_MAESTRO = './nav/log';

type detalle_usuario = record
	cod_usuario:integer;
	fecha:string;
	tiempo_sesion:real;
end;

type usuario_maestro = record
	cod_usuario:integer;
	fecha:string;
	tiempo_total_acumulado:real;
end;

type archivo_detalle = file of detalle_usuario;

detalles = record
	d : detalle_usuario;
	f : archivo_detalle;
end;

type archivo_maestro = file of usuario_maestro;

vector = array[0..DF] of detalles;

procedure leerDetalle (var detalle : archivo_detalle; var dato:detalle_usuario);
begin
	reset(detalle);
	if(not eof(detalle))then
		read(detalle,dato)
	else
		dato.cod_usuario:=VALORALTO;
end;

procedure inicializarArregloDetalles (var n_detalles:vector);
var
	i:integer;
	nombre:string;
begin
	for i:=0 to DF do
	begin
		write('Elija el nombre del archivo: ');
		readln(nombre);
		assign(n_detalles[i].f,nombre);
		rewrite(n_detalles[i].f);
		leerDetalle(n_detalles[i].f,n_detalles[i].d);
	end;
end;


procedure cerrarDetalles(var n_detalles:vector);
var
	i:integer;
begin
	for i:=0 to DF do
		begin
			close(n_detalles[i].f);
		end;
end;


procedure minimo(var n_detalles:vector; var min:detalle_usuario);
var
	i,pos:integer;
begin
	min.cod_usuario:=VALORALTO;
	pos:=-1;
	for i:=0 to DF do
	begin
		if(n_detalles[i].d.cod_usuario<min.cod_usuario)then
		begin	
			pos:=i;
			min:=n_detalles[i].d;
		end;
	end;
	if(pos=-1)then
		min.cod_usuario:=VALORALTO
	else
		leerDetalle(n_detalles[pos].f,n_detalles[pos].d);
end;

procedure crearMaestro();
var
	maestro:archivo_maestro;
	n_detalles:vector;
	min:detalle_usuario;
	total:usuario_maestro;
begin
	inicializarArregloDetalles(n_detalles);
	assign(maestro,RUTA_MAESTRO);
	rewrite(maestro);
	minimo(n_detalles,min);
	while(min.cod_usuario<>VALORALTO)do
	begin
		total.cod_usuario:=min.cod_usuario;
		while(min.cod_usuario<>VALORALTO) and (total.cod_usuario = min.cod_usuario)do
		begin
			total.fecha:= min.fecha;
			total.tiempo_total_acumulado := 0;
			while(min.cod_usuario<>VALORALTO)and (total.cod_usuario = min.cod_usuario) and(total.fecha=min.fecha)do
			begin
				total.tiempo_total_acumulado := total.tiempo_total_acumulado + min.tiempo_sesion;
				minimo(n_detalles,min);
			end;
			write(maestro,total);
		end;
	end;
	close(maestro);
	cerrarDetalles(n_detalles);
end;

BEGIN
	crearMaestro();
	
END.

