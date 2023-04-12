{
Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:

Código de Provincia
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
NOTA: La información se encuentra ordenada por código de provincia y código de
localidad
   
   
}


program untitled;
const
VALORALTO=9999;

type maestro = record
	cod_p:integer;
	cod_l:integer;
	numero_mesa:integer;
	cant_votos:integer;
end;

type archivo_maestro = file of maestro;

procedure leerMaestro(var m:archivo_maestro;var dato:maestro);
begin
	if(not eof(m))then
		read(m,dato)
	else
		dato.cod_p:=VALORALTO;
end;

procedure procesarVotos(var m:archivo_maestro);
var
	actual,data:maestro;
	total_votos,total_provincia,total_localidad:integer;
begin
	reset(m);
	leerMaestro(m,data);
	total_votos:=0;
	while (data.cod_p <> VALORALTO) do
	begin
		total_provincia:=0;
		actual.cod_p:=data.cod_p;
		writeln ('|CODIGO PROVINCIA');
		writeln (' ',data.cod_p);
		writeln ('|CODIGO LOCALIDAD	|TOTAL DE VOTOS');
		while(data.cod_p = actual.cod_p)do
		begin
			total_localidad:=0;
			actual.cod_l:=data.cod_l;
			while(data.cod_p = actual.cod_p)and(data.cod_l = actual.cod_l)do
			begin
				total_localidad:=total_localidad+data.cant_votos;
				leerMaestro(m,data);
			end;
			writeln (' ',actual.cod_l,'			 ',total_localidad);
			total_provincia:=total_provincia+total_localidad;
		end;
		writeln ('|TOTAL DE VOTOS DE PROVINCIA:',total_provincia);
		writeln('');
		total_votos:=total_votos+total_provincia;
	end;
	writeln('Total General de Votos: ',total_votos);
end;

var
	m:archivo_maestro;
BEGIN
	assign(m,'maestro');
	procesarVotos(m);
	
END.

