program creadorArchivos;
uses crt;

CONST
n = 3;

type maestro = record
	cod_localidad:integer;
	nombre_localidad:string;
	cod_cepa:integer;
	nombre_cepa:string;
	cant_casos_activos:integer;
	cant_casos_nuevos:integer;
	cant_recuperados:integer;
	cant_fallecidos:integer;
end;

type detalle = record
	cod_localidad:integer;
	cod_cepa:integer;
	cant_casos_activos:integer;
	cant_casos_nuevos:integer;
	cant_recuperados:integer;
	cant_fallecidos:integer;
end;

archivo_maestro = file of maestro;
archivo_detalle = file of detalle;

arDet = array [1..n] of archivo_detalle;


procedure leerMaestro (var c:maestro);
begin
	with c do begin 
		write ('INGRESE CODIGO: '); readln (cod_localidad);
		if (cod_localidad <> -1) then begin
			write ('INGRESE NOMBRE MUNICIPIO: '); readln (nombre_localidad);
			write ('INGRESE CODIGO CEPA: '); readln (cod_cepa);
			write ('INGRESE NOMBRE CEPA: '); readln (nombre_cepa);
			write ('INGRESE CASOS ACTIVOS: '); readln (cant_casos_activos);
			write ('INGRESE CASOS NUEVOS: '); readln (cant_casos_nuevos);
			write ('INGRESE RECUPERADOS: '); readln (cant_recuperados);
			write ('INGRESE FALLECIDOS: '); readln (cant_fallecidos);
		end;
		writeln ('');
	end;
end;

procedure imprimirMaestro (c:maestro);
begin
	with c do begin
		writeln ('CODIGO MUNICIPIO: ',cod_localidad,' |NOMBRE MUNICIPIO: ',nombre_localidad,' |CODIGO CEPA: ',cod_cepa,' |NOMBRE CEPA: ',nombre_cepa);
		writeln ('CASOS ACTIVOS: ',cant_casos_activos,' |CASOS NUEVOS: ',cant_casos_nuevos,' |RECUPERADOS: ',cant_recuperados,' |FALLECIDOS: ',cant_fallecidos);
		writeln ('');
	end;
end;

procedure leerDet (var c:detalle);
begin
	with c do begin
		write ('INGRESE COD: '); readln (cod_localidad);
		if (cod_localidad <> -1) then begin
			
			write ('INGRESE CODIGO CEPA: '); readln (cod_cepa);
			write ('INGRESE CASOS ACTIVOS: '); readln (cant_casos_activos);
			write ('INGRESE CASOS NUEVOS: '); readln (cant_casos_nuevos);
			write ('INGRESE RECUPERADOS: '); readln (cant_recuperados);
			write ('INGRESE FALLECIDOS: '); readln (cant_fallecidos);

		end;
		writeln ('');
	end;
end;

procedure imprimirDet (c:detalle);
begin
	with c do begin
		writeln (' |CODIGO CEPA: ',cod_cepa);
		writeln ('CASOS ACTIVOS: ',cant_casos_activos,' |CASOS NUEVOS: ',cant_casos_nuevos,' |RECUPERADOS: ',cant_recuperados,' |FALLECIDOS: ',cant_fallecidos);
		writeln ('');
	end;
end;

procedure crearMaestro (var arc_maestro:archivo_maestro);
var
p:maestro;
begin
	rewrite (arc_maestro);
	leerMaestro (p);
	while (p.cod_localidad <> -1) do begin
		write (arc_maestro,p);
		leerMaestro(p);
	end;
	close (arc_maestro);
end;

procedure crearDetalle (var arc_detalle:archivo_detalle);
var
d:detalle;
begin
	rewrite (arc_detalle);
	leerDet (d);
	while (d.cod_localidad <> -1) do begin
		write (arc_detalle,d);
		leerDet(d);
	end;
	close (arc_detalle);
end;

procedure mostrarMaestro (var arc_maestro:archivo_maestro);
var
p:maestro;
begin
	reset (arc_maestro);
	while not eof (arc_maestro) do begin
		read (arc_maestro,p);
		imprimirMaestro(p);
	end;
	close (arc_maestro);
end;

procedure mostrarDetalle (var arc_detalle:archivo_detalle);
var
d:detalle;
begin
	reset (arc_detalle);
	while not eof (arc_detalle) do begin
		read (arc_detalle,d);
		imprimirDet(d);
	end;
	close (arc_detalle);
end;

var
arc_maestro: archivo_maestro;
aString: string;
i:integer;
deta:arDet;

begin
	Assign (arc_maestro,'maestro');
	writeln ('MAESTRO: ');
	//crearMaestro(arc_maestro);
	mostrarMaestro (arc_maestro);
	for i:= 1 to n do begin
		writeln ('DETALLE ',i,' : ');
		Str (i,aString);
		assign (deta[i],'detalle'+ aString);
		//crearDetalle (deta[i])
		mostrarDetalle (deta[i]);
	end;
end.
