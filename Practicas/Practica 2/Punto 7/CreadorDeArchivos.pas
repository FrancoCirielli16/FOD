program creadorArchivos;
uses crt;

CONST
n = 1;

type producto = record
	codigo:integer;
	nombre:string;
	precio:real;
	stock:integer;
	stock_min:integer;
end;

type detalle = record
	codigo:integer;
	cant_vendida:integer;
end;

type archivo_maestro = file of producto;
type archivo_detalle = file of detalle;

arDet = array [1..n] of archivo_detalle;


procedure leerMaestro (var m:producto);
begin
	with m do begin 
		write ('INGRESE CODIGO: '); readln (codigo);
		if (codigo <> -1) then begin
			write ('INGRESE NOMBRE DE PRODUCTOO: '); readln (nombre);
			write ('INGRESE PRECIO: '); readln (precio);
			write ('INGRESE STOCK: '); readln (stock);
			write ('INGRESE STOCK MINIMO: '); readln (stock_min);
		end;
		writeln ('');
	end;
end;

procedure imprimirMaestro (p:producto);
begin
	with p do begin
		writeln ('CODIGO: ',codigo,' |NOMBRE: ',nombre,' |PRECIO: ',precio,' |STOCK: ',stock,'|STOCK MINIMO: ',stock_min);
	end;
end;

procedure leerDet (var c:detalle);
begin
	with c do begin
		write ('INGRESE CODIGO: '); readln (codigo);
		if (codigo <> -1) then begin
			write ('INGRESE CANTIDAD VENDIDA: '); readln (cant_vendida);
		end;
		writeln ('');
	end;
end;

procedure imprimirDet (c:detalle);
begin
	with c do begin
		writeln (' |CODIGO: ',codigo);
		writeln ('CASOS ACTIVOS: ',cant_vendida);
		writeln ('');
	end;
end;

procedure crearMaestro (var arc_maestro:archivo_maestro);
var
p:producto;
begin
	rewrite (arc_maestro);
	leerMaestro (p);
	while (p.codigo <> -1) do begin
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
	while (d.codigo <> -1) do begin
		write (arc_detalle,d);
		leerDet(d);
	end;
	close (arc_detalle);
end;

procedure mostrarMaestro (var arc_maestro:archivo_maestro);
var
p:producto;
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
