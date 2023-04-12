program crear;

type maestro = record
	cod_p:integer;
	cod_l:integer;
	numero_mesa:integer;
	cant_votos:integer;
end;


archivo_maestro = file of maestro;

procedure imprimirCl(c:maestro);
begin
	with c do begin
		writeln ('CODIGO PROVINCIA: ',cod_p);
		writeln ('CODIGO LOCALIDAD: ',cod_l);
		writeln ('NUMERO MESA: ',numero_mesa);
		writeln ('CANTIDAD VOTOS: ',cant_votos);
		writeln ('');
	end;
end;

procedure leerCl (var c:maestro);
begin
	with C do begin
		write ('INGRESE CODIGO PROVINCIA: '); readln (cod_p);
		if (cod_p <> -1) then begin
			write ('INGRESE CODIGO LOCALIDAD: '); readln (cod_l);
			write ('NUMERO DE MESA: '); readln (numero_mesa);
			write ('INGRESE CANTIDAD VOTOS: '); readln (cant_votos);
		end;
		writeln ('');
	end;
end;

procedure mostrarMaestro (var arc_maestro:archivo_maestro);
var
	c:maestro;
begin
	reset (arc_maestro);
	while not eof (arc_maestro) do begin
		read (arc_maestro,c);
		imprimirCl(c);
	end;
	close (arc_maestro);
end;

procedure crear (var arc_maestro:archivo_maestro);
var
c:maestro;
begin
	rewrite (arc_maestro);
	leerCl (c);
	while (c.cod_p <> -1) do begin
		write (arc_maestro,c);
		leerCl(c);
	end;
	close (arc_maestro);
end;

var
	arc_maestro:archivo_maestro;
begin
	Assign (arc_maestro,'maestro');
	//crear (arc_maestro);
	mostrarMaestro (arc_maestro);
end.
