{
A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
reuniendo dicha información.

Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
padre.

En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
lugar.

Realizar un programa que cree el archivo maestro a partir de toda la información de los
archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se
deberá, además, listar en un archivo de texto la información recolectada de cada persona.

Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.
Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
además puede no haber fallecido.
   
   
}


program untitled;

const DF=50;
const VALORALTO=9999;

type
	
direccion = record
	calle:string;
	nro:integer;
	piso:integer;
	depto:string;
	ciudad:string;
end;

data = record
	nombre:string;
	apellido:string;
	dni:integer;
end;

//nacimineto

nacimiento = record
	nro_partida:integer;
	nombre:string;
	apellido:string;
	dir:direccion;
	matricula_medico:integer;
	padre:data;
	madre:data;
end;

//fallecimiento

fallecimiento = record
	nro_nacimiento:integer;
	fallecido:data;
	matricula_medico:integer;
	fecha:string;
	hora:string;
	lugar:string;
end;

Fallecio = record
	matricula_medico:integer;
	fecha:string;
	hora:string;
	lugar:string;
end;

//maestro

maestro = record
	nro_partida:integer;
	nombre:string;
	apellido:string;
	dir:direccion;
	matricula_medico:integer;
	padre:data;
	madre:data;
	siFallecio:Fallecio;
end;

type archivoFallecimiento = file of fallecimiento;
type archivoNacimiento = file of nacimiento;

a_data = record
	d_n:nacimiento;
	f_n:archivoNacimiento;
	d_f:fallecimiento;
	f_f:archivoFallecimiento;
end;

detalles = array[1..DF] of a_data;




type archivo_maestro = file of maestro;


//leer detalle nacido
procedure leerNacido(var detalle:archivoNacimiento;var datoN:nacimiento);
begin
	if(not EOF(detalle))then
		read(detalle,datoN)
	else
		datoN.nro_partida:=VALORALTO;
end;	

//leer detalle fallecido
procedure leerFallecido(var detalle:archivoFallecimiento;var datoF:fallecimiento);
begin
	if(not EOF(detalle))then
		read(detalle,datoF)
	else
		datoF.nro_nacimiento:=VALORALTO;
end;

//inicializo vector de detalles de nacimientos
procedure inicializarDetalleN(var n_detalles:detalles);
var 
	i:integer;
	nombreN,nombreF:string;
begin
	for i:=1 to DF do
	begin
		write('Elija el nombre del archivo: ');
		readln(nombreN);
		assign(n_detalles[i].f_n, nombreN);
		reset(n_detalles[i].f_n);
		leerNacido(n_detalles[i].f_n,n_detalles[i].d_n);
		write('Elija el nombre del archivo: ');
		readln(nombreF);
		assign(n_detalles[i].f_f,nombreF);
		reset(n_detalles[i].f_f);
		leerFallecido(n_detalles[i].f_f,n_detalles[i].d_f);
	end;
end;


//cierro todos los archivos detalles de nacimientos
procedure cerrarDetallesN(var n_detalles:detalles);
var
	i:integer;
begin
	for i:=1 to DF do
	begin
		close(n_detalles[i].f_n);
		close(n_detalles[i].f_f);
	end;
end;


procedure minimoNacido(var n_detalles:detalles;var min:nacimiento);
var
	i,pos:integer;
begin
	min.nro_partida:=VALORALTO;
	pos:=-1;
	for i:=1 to DF do
	begin
		if(n_detalles[i].d_n.nro_partida<min.nro_partida)then
		begin
			pos:=i;
			min:=n_detalles[i].d_n;
		end;
	end;
	if(pos=-1)then
		min.nro_partida:=VALORALTO
	else
		leerNacido(n_detalles[pos].f_n,n_detalles[pos].d_n);
end;

procedure minimoFallecido(var n_detalles:detalles;var min:fallecimiento);
var
	i,pos:integer;
begin
	min.nro_nacimiento:=VALORALTO;
	pos:=-1;
	for i:=1 to DF do
	begin
		if(n_detalles[i].d_f.nro_nacimiento<min.nro_nacimiento)then
		begin
			pos:=i;
			min:=n_detalles[i].d_f;
		end;
	end;
	if(pos=-1)then
		min.nro_nacimiento:=VALORALTO
	else
		leerFallecido(n_detalles[i].f_f,n_detalles[i].d_f);
end;

procedure cargarNacimiento(var n: nacimiento; var m:maestro);
begin
    m.nro_partida := n.nro_partida;
    m.nombre := n.nombre;
    m.apellido := n.apellido;
    m.dir := n.dir;
    m.matricula_medico := n.matricula_medico; 
    m.padre := n.padre;
    m.madre := n.madre;
end;


procedure crearMaestro();
var
	mae:archivo_maestro;
	n_detalles:detalles;
	minN:nacimiento;
	minF:fallecimiento;
	m:maestro;
begin
	inicializarDetalleN(n_detalles);
	assign(mae,'maestro');
	rewrite(mae);
	minimoNacido(n_detalles,minN);
	minimoFallecido(n_detalles,minF);
	while(minN.nro_partida<>VALORALTO)do
	begin
		cargarNacimiento(minN,m);
		if(minN.nro_partida<>minF.nro_nacimiento)then
		begin
			m.siFallecio.matricula_medico:=0;
			m.siFallecio.fecha:='';
			m.siFallecio.hora:='';
			m.siFallecio.lugar:='';
		end
		else
			begin
				m.siFallecio.matricula_medico:=minF.matricula_medico;
				m.siFallecio.fecha:=minF.fecha;
				m.siFallecio.hora:=minF.hora;
				m.siFallecio.lugar:=minF.lugar;
				minimoFallecido(n_detalles,minF);
			end;
		write(mae,m);
		minimoNacido(n_detalles,minN); 
	end;
	close(mae);
	cerrarDetallesN(n_detalles);
end;

BEGIN
	crearMaestro();

	
END.

