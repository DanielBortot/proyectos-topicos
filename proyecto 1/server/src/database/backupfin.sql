--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE root;
ALTER ROLE root WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:O8vFWw9bex/hNPiziQtgDg==$RMywB3kAv2X9rBa6jq/76tlGe8xdEfbbjlnkHyUhcWA=:v48oT7ONiEFQZ3uFyXh3uCg+xZdYZobUOfuZ7FJJJjk=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-1.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Debian 15.4-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-1.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Debian 15.4-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "proyecto1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-1.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Debian 15.4-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: proyecto1; Type: DATABASE; Schema: -; Owner: root
--

CREATE DATABASE proyecto1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE proyecto1 OWNER TO root;

\connect proyecto1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: datos; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public.datos AS (
	"primerNombre" character varying(50),
	"segundoNombre" character varying(50),
	"primerApellido" character varying(50),
	"segundoApellido" character varying(50),
	telefono character varying(11),
	cedula integer
);


ALTER TYPE public.datos OWNER TO root;

--
-- Name: datos_domain; Type: DOMAIN; Schema: public; Owner: root
--

CREATE DOMAIN public.datos_domain AS public.datos
	CONSTRAINT datos_domain_check CHECK ((((VALUE)."primerNombre" IS NOT NULL) AND ((VALUE)."primerApellido" IS NOT NULL) AND ((VALUE)."segundoApellido" IS NOT NULL) AND ((VALUE).telefono IS NOT NULL) AND ((VALUE).cedula IS NOT NULL)));


ALTER DOMAIN public.datos_domain OWNER TO root;

--
-- Name: fulljoin(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.fulljoin() RETURNS TABLE(nombre character varying, ingresos numeric, ventas numeric)
    LANGUAGE plpgsql
    AS $$	
	begin
		return query (
			select v."nombre", i."ingresos", v."ventas" from mayores_ingresos() i
				inner join mayores_ventas() v on i."nombre" = v."nombre"
		);
	end;
$$;


ALTER FUNCTION public.fulljoin() OWNER TO root;

--
-- Name: obt_ingresos(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.obt_ingresos() RETURNS TABLE(id integer, ingresos bigint)
    LANGUAGE plpgsql
    AS $$
	begin
		return query ( 
			select v."inventarioId", sum(v."precioVent"*v."cantVend") ingreso from "Hist_Venta" v
				group by v."inventarioId"
				order by v."inventarioId"
		);
	end;
$$;


ALTER FUNCTION public.obt_ingresos() OWNER TO root;

--
-- Name: obt_sucursales(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.obt_sucursales() RETURNS TABLE(idinv integer, idciu integer, nombre character varying)
    LANGUAGE plpgsql
    AS $$
	begin
		return query ( 
			SELECT i."id", c."id", c."nombre" FROM "Inventario" i
				INNER JOIN "Ciudad" c ON c."id" = i."ciudadId"
				ORDER BY i."id"
		);
	end;
$$;


ALTER FUNCTION public.obt_sucursales() OWNER TO root;

--
-- Name: obt_ventas(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.obt_ventas() RETURNS TABLE(id integer, ventas bigint)
    LANGUAGE plpgsql
    AS $$
	begin
		return query ( 
			select v."inventarioId", count(v."inventarioId") from "Hist_Venta" v
				group by v."inventarioId"
				order by v."inventarioId"
		);
	end;
$$;


ALTER FUNCTION public.obt_ventas() OWNER TO root;

--
-- Name: reporte1(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.reporte1() RETURNS TABLE(nombre character varying, descripcion text, cantvend bigint)
    LANGUAGE plpgsql
    AS $$
begin
	return query (
		select pro.nombre, coalesce(pro.descripcion,'No tiene descripcion') as descripcion, sum(ven."cantVend") as cantvend
		from "Producto" as pro inner join "Inventario" as inv on pro.id = inv."productoId" inner join "Hist_Venta" as ven on inv.id = ven."inventarioId"
		group by pro.nombre, pro.descripcion order by cantvend desc
	);
end;
$$;


ALTER FUNCTION public.reporte1() OWNER TO root;

--
-- Name: reporte2(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.reporte2() RETURNS TABLE(distribuidor character varying, producto character varying, fecha_inventario date)
    LANGUAGE plpgsql
    AS $$
Begin
		return query (
			SELECT
    		dist."nombre" AS distribuidor,
  			pro."nombre" AS producto,
    		hi."fecha" AS fecha_inventario
			FROM "Distribuidor" dist
			INNER JOIN "Hist_Inventario" hi ON dist."id" = hi."inventarioId"
			INNER JOIN "Inventario" i ON hi."inventarioId" = i."id"
			INNER JOIN "Producto" pro ON i."productoId" = pro."id"
			WHERE (hi."fecha", hi."distribuidorId") IN (
			SELECT MAX(fecha), h."distribuidorId" 
				FROM "Hist_Inventario" h
				GROUP BY h."distribuidorId"
			)
		);
end; 
$$;


ALTER FUNCTION public.reporte2() OWNER TO root;

--
-- Name: reporte3(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.reporte3() RETURNS TABLE(nombre character varying, ventas numeric)
    LANGUAGE plpgsql
    AS $$
	begin
		return query ( 		
			select s."nombre", sum(v.ventas) from OBT_VENTAS() v
				INNER JOIN OBT_SUCURSALES() s ON v."id" = s."idinv"
				group by s."nombre", s."idciu"
				order by s."idciu"
		);
	end;
$$;


ALTER FUNCTION public.reporte3() OWNER TO root;

--
-- Name: reporte4(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.reporte4() RETURNS TABLE(nombre character varying, ingresos numeric)
    LANGUAGE plpgsql
    AS $$
	begin
		return query ( 		
			select s."nombre", sum(i.ingresos) from OBT_INGRESOS() i
				INNER JOIN OBT_SUCURSALES() s ON i."id" = s."idinv"
				group by s."nombre", s."idciu"
				order by s."idciu"
		);
	end;
$$;


ALTER FUNCTION public.reporte4() OWNER TO root;

--
-- Name: reporte5(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.reporte5() RETURNS TABLE(nombre character varying, descripcion text, totalingreso bigint)
    LANGUAGE plpgsql
    AS $$

	begin
		return query (
			select producto.nombre,coalesce (producto.descripcion,'No tiene descripcion') descripcion, sum (historico."precioVent") TotalIngreso
			from "Producto" producto, "Inventario" inventario, "Hist_Venta" historico
			where  producto.id=inventario."productoId" and inventario.id=historico."inventarioId"
			group by producto.nombre,producto.descripcion
			order by TotalIngreso DESC

		);
	end;
$$;


ALTER FUNCTION public.reporte5() OWNER TO root;

--
-- Name: reporte6(character varying); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.reporte6(ciudadparam character varying) RETURNS TABLE(nombre_completo text, telefono character varying, cedula integer, totalasistencias bigint)
    LANGUAGE plpgsql
    AS $_$

	begin
		return query (
			select (datos_empleado)."primerNombre" || ' ' || coalesce ((datos_empleado)."segundoNombre",'') || ' ' || (datos_empleado)."primerApellido" || ' ' || (datos_empleado)."segundoApellido" nombre_completo,
			(datos_empleado).telefono, (datos_empleado)."cedula",count(histasis."empleadoId") TotalAsistencias
			from "Ciudad" ciudad, "Hist_Salarios" histsal , "Empleado" empleado, "Hist_Asistencia" histasis
			where lower (ciudad.nombre) like lower($1) and histsal."ciudadId"=ciudad.id 
	  		and histsal."empleadoId"=empleado.id and empleado.id=histasis."empleadoId" 
	  		and histsal."fechaFin" is null 
			group by empleado.datos_empleado
			order by TotalAsistencias desc
		);
	
	end;
$_$;


ALTER FUNCTION public.reporte6(ciudadparam character varying) OWNER TO root;

--
-- Name: reporte7(character varying); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.reporte7(ciu character varying) RETURNS TABLE(idempleado integer, ventas bigint, nombre_completo text, telefono character varying, cedula integer, ciudad character varying)
    LANGUAGE plpgsql
    AS $_$
	begin
		return query(		
			select 
				v."asistenciaEmpleadoId" idempleado,
				COUNT(v."asistenciaEmpleadoId") ventas,
				(datos_empleado)."primerNombre" || ' ' || coalesce ((datos_empleado)."segundoNombre",'') || ' ' || (datos_empleado)."primerApellido" || ' ' || (datos_empleado)."segundoApellido" nombre_completo,
				(datos_empleado).telefono,
				(datos_empleado)."cedula",
				ciu.nombre ciudad
				from "Venta" v
				inner join "Empleado" e on e."id" = v."asistenciaEmpleadoId"
				inner join (select distinct s."empleadoId", s."ciudadId" from "Hist_Salarios" s) sa ON e."id" = sa."empleadoId"
				inner join "Ciudad" ciu ON sa."ciudadId"=ciu."id"
				where lower (ciu."nombre") like lower($1)
				group by v."asistenciaEmpleadoId", (e.datos_empleado), ciu.nombre
				order by ventas desc
		);
	end;
$_$;


ALTER FUNCTION public.reporte7(ciu character varying) OWNER TO root;

--
-- Name: reporte8(integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.reporte8(infla integer) RETURNS TABLE(nombre character varying, descripcion text, precio_original real, precio_inflado double precision, diferencia_precio double precision, ciudad character varying)
    LANGUAGE plpgsql
    AS $$
begin
	return query (
		select pro.nombre, coalesce (pro.descripcion,'No tiene descripcion'), inv."costoVenta" as precio_original, 
		(inv."costoVenta" + (inv."costoVenta" * infla / 100)) as precio_inflado, 
		((inv."costoVenta" + (inv."costoVenta" * infla / 100)) - inv."costoVenta") as diferencia_precio,
		ciu.nombre
		from "Producto" as pro inner join "Inventario" as inv on pro.id = inv."productoId" inner join "Ciudad" as ciu on inv."ciudadId"=ciu.id
	);
end;
$$;


ALTER FUNCTION public.reporte8(infla integer) OWNER TO root;

--
-- Name: validar_cedula(integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.validar_cedula(cedula integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
begin
	if (cedula < 1000000 or cedula > 99999999) then
		raise notice 'La cedula % no es valida', cedula;
	else
		return cedula;
	end if;
end;
$$;


ALTER FUNCTION public.validar_cedula(cedula integer) OWNER TO root;

--
-- Name: validar_telefono(character varying); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.validar_telefono(telefono character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare
	telval varchar(11);
begin
	telval := substring(telefono, '[0-9]{1,11}');
	if (length(telval) < 11 or telval is null) then
		raise notice 'telefono % invalido, debe tener 11 numeros', telefono;
	else
		return telefono;
	end if;
end;
$$;


ALTER FUNCTION public.validar_telefono(telefono character varying) OWNER TO root;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Ciudad; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Ciudad" (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    "estadoId" integer NOT NULL
);


ALTER TABLE public."Ciudad" OWNER TO root;

--
-- Name: Ciudad_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Ciudad_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ciudad_id_seq" OWNER TO root;

--
-- Name: Ciudad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Ciudad_id_seq" OWNED BY public."Ciudad".id;


--
-- Name: Cliente; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Cliente" (
    id integer NOT NULL,
    datos_cliente public.datos_domain
);


ALTER TABLE public."Cliente" OWNER TO root;

--
-- Name: Cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Cliente_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Cliente_id_seq" OWNER TO root;

--
-- Name: Cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Cliente_id_seq" OWNED BY public."Cliente".id;


--
-- Name: Distribuidor; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Distribuidor" (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    telefono character varying(11) NOT NULL,
    rif integer NOT NULL,
    "ciudadId" integer NOT NULL,
    CONSTRAINT "CHK_caa9c5a6bddd973f297d49be1e" CHECK (((rif > 1000000) AND (rif < 100000000)))
);


ALTER TABLE public."Distribuidor" OWNER TO root;

--
-- Name: Distribuidor_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Distribuidor_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Distribuidor_id_seq" OWNER TO root;

--
-- Name: Distribuidor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Distribuidor_id_seq" OWNED BY public."Distribuidor".id;


--
-- Name: Empleado; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Empleado" (
    id integer NOT NULL,
    datos_empleado public.datos_domain
);


ALTER TABLE public."Empleado" OWNER TO root;

--
-- Name: Empleado_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Empleado_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Empleado_id_seq" OWNER TO root;

--
-- Name: Empleado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Empleado_id_seq" OWNED BY public."Empleado".id;


--
-- Name: Estado; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Estado" (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    "paisId" integer NOT NULL
);


ALTER TABLE public."Estado" OWNER TO root;

--
-- Name: Estado_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Estado_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Estado_id_seq" OWNER TO root;

--
-- Name: Estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Estado_id_seq" OWNED BY public."Estado".id;


--
-- Name: Hist_Asistencia; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Hist_Asistencia" (
    fecha date NOT NULL,
    "horaEntrada" time without time zone NOT NULL,
    "horaSalida" time without time zone,
    "empleadoId" integer NOT NULL
);


ALTER TABLE public."Hist_Asistencia" OWNER TO root;

--
-- Name: Hist_Inventario; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Hist_Inventario" (
    fecha date NOT NULL,
    "costoUnidad" real NOT NULL,
    "cantidadComp" integer NOT NULL,
    "distribuidorId" integer NOT NULL,
    "inventarioId" integer NOT NULL
);


ALTER TABLE public."Hist_Inventario" OWNER TO root;

--
-- Name: Hist_Salarios; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Hist_Salarios" (
    "numContrato" integer NOT NULL,
    "sueldoQuinc" integer NOT NULL,
    "fechaIni" date NOT NULL,
    "fechaFin" date,
    "empleadoId" integer NOT NULL,
    "ciudadId" integer NOT NULL,
    CONSTRAINT "CHK_41a2be8ae6dda4c74011bee1dc" CHECK (("sueldoQuinc" > 0)),
    CONSTRAINT "CHK_5a78be3899c0c4bb53fae90f23" CHECK (("numContrato" > 0))
);


ALTER TABLE public."Hist_Salarios" OWNER TO root;

--
-- Name: Hist_Venta; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Hist_Venta" (
    "precioVent" integer NOT NULL,
    "cantVend" integer NOT NULL,
    "ventaId" integer NOT NULL,
    "inventarioId" integer NOT NULL
);


ALTER TABLE public."Hist_Venta" OWNER TO root;

--
-- Name: Inventario; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Inventario" (
    id integer NOT NULL,
    cantidad integer NOT NULL,
    "costoVenta" real NOT NULL,
    "productoId" integer NOT NULL,
    "ciudadId" integer NOT NULL
);


ALTER TABLE public."Inventario" OWNER TO root;

--
-- Name: Inventario_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Inventario_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Inventario_id_seq" OWNER TO root;

--
-- Name: Inventario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Inventario_id_seq" OWNED BY public."Inventario".id;


--
-- Name: Pais; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Pais" (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public."Pais" OWNER TO root;

--
-- Name: Pais_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Pais_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Pais_id_seq" OWNER TO root;

--
-- Name: Pais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Pais_id_seq" OWNED BY public."Pais".id;


--
-- Name: Producto; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Producto" (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text
);


ALTER TABLE public."Producto" OWNER TO root;

--
-- Name: Producto_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Producto_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Producto_id_seq" OWNER TO root;

--
-- Name: Producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Producto_id_seq" OWNED BY public."Producto".id;


--
-- Name: Venta; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Venta" (
    id integer NOT NULL,
    hora time without time zone NOT NULL,
    monto real NOT NULL,
    "asistenciaFecha" date NOT NULL,
    "asistenciaEmpleadoId" integer NOT NULL,
    "clienteId" integer NOT NULL
);


ALTER TABLE public."Venta" OWNER TO root;

--
-- Name: Venta_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Venta_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Venta_id_seq" OWNER TO root;

--
-- Name: Venta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Venta_id_seq" OWNED BY public."Venta".id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.migrations OWNER TO root;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO root;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: Ciudad id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Ciudad" ALTER COLUMN id SET DEFAULT nextval('public."Ciudad_id_seq"'::regclass);


--
-- Name: Cliente id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Cliente" ALTER COLUMN id SET DEFAULT nextval('public."Cliente_id_seq"'::regclass);


--
-- Name: Distribuidor id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Distribuidor" ALTER COLUMN id SET DEFAULT nextval('public."Distribuidor_id_seq"'::regclass);


--
-- Name: Empleado id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Empleado" ALTER COLUMN id SET DEFAULT nextval('public."Empleado_id_seq"'::regclass);


--
-- Name: Estado id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Estado" ALTER COLUMN id SET DEFAULT nextval('public."Estado_id_seq"'::regclass);


--
-- Name: Inventario id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Inventario" ALTER COLUMN id SET DEFAULT nextval('public."Inventario_id_seq"'::regclass);


--
-- Name: Pais id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Pais" ALTER COLUMN id SET DEFAULT nextval('public."Pais_id_seq"'::regclass);


--
-- Name: Producto id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Producto" ALTER COLUMN id SET DEFAULT nextval('public."Producto_id_seq"'::regclass);


--
-- Name: Venta id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Venta" ALTER COLUMN id SET DEFAULT nextval('public."Venta_id_seq"'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Data for Name: Ciudad; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Ciudad" (id, nombre, "estadoId") FROM stdin;
1	Caracas	1
2	Hatillo	1
3	Lecheria	2
4	ElTigre	2
\.


--
-- Data for Name: Cliente; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Cliente" (id, datos_cliente) FROM stdin;
1	(Ana,Pérez,Rodríguez,María,04161234567,20123456)
2	(Juan,Gómez,García,Andrés,04122345678,19234567)
3	(María,López,Martínez,Antonio,04143456789,24345678)
4	(Carlos,Fernández,Sánchez,Luis,04164567890,25456789)
5	(Laura,Rodríguez,González,Valentina,04125678901,17567890)
6	(Andrés,Martínez,Pérez,Gabriel,04146789012,18678901)
7	(Isabel,Pérez,López,Sofía,04167890123,27789012)
8	(Javier,Sánchez,González,Eduardo,04128901234,28890123)
9	(Paula,González,Martínez,Carolina,04149012345,26901234)
10	(Pedro,López,Rodríguez,Alejandro,04160123456,29012345)
11	(Jorge,Martínez,García,Antonio,04121234567,30123456)
12	(Carmen,Sánchez,Pérez,Valeria,04142345678,30234567)
13	(Sergio,Pérez,González,Fernando,04163456789,27345678)
14	(Elena,López,Rodríguez,Gabriela,04124567890,30456789)
15	(Raúl,Rodríguez,Martínez,Mauricio,04145678901,24567890)
16	(Sofía,Martínez,Sánchez,Alejandra,04166789012,25678901)
17	(Alejandro,Sánchez,López,Eduardo,04127890123,26789012)
18	(Valentina,López,González,María,04148901234,27890123)
19	(Andrés,Pérez,Martínez,Alberto,04169012345,28901234)
20	(Marta,González,Sánchez,Carolina,04120123456,19012345)
21	(Eduardo,Rodríguez,García,Andrés,04141234567,24123456)
22	(Natalia,García,López,Valeria,04162345678,19234567)
23	(Roberto,Martínez,Pérez,Alejandro,04123456789,21345678)
24	(Andrea,Pérez,González,María,04144567890,22456789)
25	(Juan,López,Rodríguez,Antonio,04165678901,27567890)
26	(Sofía,González,Martínez,Valentina,04126789012,30678901)
27	(Alejandro,Rodríguez,Sánchez,Luis,04147890123,21789012)
28	(Valeria,Sánchez,López,Eduardo,04168901234,29890123)
29	(Andrés,Martínez,González,Antonio,4129012345,27901234)
30	(María,López,Pérez,Gabriela,04140123456,23012345)
\.


--
-- Data for Name: Distribuidor; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Distribuidor" (id, nombre, telefono, rif, "ciudadId") FROM stdin;
1	Rock & Food	02121328500	1000001	1
2	Polar	02121338505	1000002	1
3	Fresh Food	02121324505	1000003	1
4	El tenedor de oro	02121376505	1000004	1
5	Reyes de la comida	02124448505	1000005	1
6	Chayane & CO	02124567505	1000006	1
7	Odins Palace	02121326789	1000007	1
8	Come Rico	02121325566	1000008	2
9	Yummy Cafe	02121328505	1000009	2
10	Deli Munchies	02121117705	1000010	2
\.


--
-- Data for Name: Empleado; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Empleado" (id, datos_empleado) FROM stdin;
1	(Ana,Maria,López,Silva,04122403300,25446055)
2	(Carlos,Andrés,Rodríguez,Mendoza,04122404501,24685999)
3	(Laura,Isabella,González,Bravo,04122404201,28246205)
4	(Diego,,Martínez,Velázquez,04122407801,21231250)
5	(Marta,,Pérez,Paredes,04122408901,30246205)
6	(Javier,,Sánchez,Cordero,04122405601,9662942)
7	(Elena,,Fernández,Ramírez,04122408801,30246506)
8	(Andrés,Eduardo,Torres,Guzmán,04122405401,29666256)
9	(Sofía,,Ramírez,Rojas,04122402101,28795312)
10	(Alejandro,,Vargas,Rios,04122402001,11455896)
11	(Carmen,,Ruiz,Delgado,04122407801,24978210)
12	(Sergio,,García,Maldonado,04122447801,20555698)
13	(Camila,Sofia,Guzmán,Delgado,04122267801,30200265)
14	(Alfredo,Andres,Fung,Perez,04122457801,29555254)
15	(Joao,,"De Sousa",Barradas,04122787801,24455112)
16	(Carlos,Eduardo,Rodriguez,Sanchez,04122897801,28946513)
17	(Laura,Valentina,Mendoza,Velazquez,04122567801,27135468)
18	(Jacklyn,Vanessa,Farinez,"De la Santisima Trinidad",04122007801,26549513)
19	(Guztavo,,Vizcanio,Rogel,04122787801,20316413)
20	(Diego,Armando,Maradona,Gonzalez,04122657801,28159357)
\.


--
-- Data for Name: Estado; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Estado" (id, nombre, "paisId") FROM stdin;
1	DistritoCapital	1
2	Anzoategui	1
\.


--
-- Data for Name: Hist_Asistencia; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Hist_Asistencia" (fecha, "horaEntrada", "horaSalida", "empleadoId") FROM stdin;
2023-01-01	06:30:00	18:45:00	1
2023-02-02	07:15:00	19:30:00	2
2023-03-03	06:45:00	18:15:00	3
2023-04-04	06:15:00	18:30:00	4
2023-05-05	07:00:00	19:45:00	5
2023-06-06	07:30:00	19:15:00	6
2023-07-07	06:30:00	18:45:00	7
2023-08-08	06:45:00	18:15:00	8
2023-09-09	06:15:00	18:30:00	9
2023-01-10	07:15:00	19:30:00	10
2023-02-11	06:30:00	18:15:00	11
2023-03-12	06:45:00	18:30:00	12
2023-04-13	07:00:00	19:45:00	13
2023-05-14	07:30:00	19:15:00	14
2023-06-15	06:15:00	18:45:00	15
2023-07-16	06:30:00	18:15:00	16
2023-08-17	07:15:00	19:30:00	17
2023-09-18	06:45:00	18:30:00	18
2023-01-19	07:00:00	19:45:00	19
2023-02-20	06:30:00	18:15:00	20
2023-03-21	06:15:00	18:30:00	1
2023-04-22	07:15:00	19:30:00	2
2023-05-23	06:30:00	18:15:00	3
2023-06-24	06:45:00	18:30:00	4
2023-07-25	07:00:00	19:45:00	5
2023-08-26	07:30:00	19:15:00	6
2023-09-27	06:15:00	18:45:00	7
2023-01-28	06:30:00	18:15:00	8
2023-02-28	07:15:00	19:30:00	9
2023-03-30	06:45:00	18:30:00	10
2023-01-24	07:00:00	19:45:00	1
2023-02-22	07:15:00	19:30:00	1
2023-03-23	06:30:00	18:15:00	2
2023-04-24	06:45:00	18:30:00	2
2023-09-25	07:00:00	19:45:00	2
2023-10-26	07:30:00	19:15:00	2
2023-09-27	06:15:00	18:45:00	2
2023-08-28	06:30:00	18:15:00	10
2023-07-27	07:15:00	19:30:00	10
2023-06-30	06:45:00	18:30:00	10
2023-02-10	07:15:00	19:30:00	20
2023-02-11	06:30:00	18:15:00	4
2023-03-12	06:45:00	18:30:00	11
2023-04-18	07:00:00	19:45:00	13
2023-05-14	07:30:00	19:15:00	15
2023-06-06	06:15:00	18:45:00	15
2023-07-16	06:30:00	18:15:00	5
\.


--
-- Data for Name: Hist_Inventario; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Hist_Inventario" (fecha, "costoUnidad", "cantidadComp", "distribuidorId", "inventarioId") FROM stdin;
2023-01-12	1000	300	1	1
2023-01-12	900	400	2	2
2023-01-27	847	250	3	3
2023-01-28	673	650	4	4
2023-02-02	751	400	5	5
2023-02-05	919	500	2	6
2023-02-07	706	200	5	7
2023-02-15	610	300	6	8
2023-02-25	943	560	7	9
2023-02-06	615	590	8	10
2023-02-07	734	156	9	11
2023-02-12	569	293	10	12
2023-02-14	620	351	10	13
2023-02-16	878	222	6	14
2023-02-10	598	333	1	1
2023-02-16	708	124	2	2
2023-02-27	616	265	3	3
2023-02-26	778	346	4	4
2023-03-16	569	321	5	5
2023-03-22	878	213	1	6
2023-03-30	511	132	3	7
2023-04-15	672	123	6	8
2023-04-07	952	50	7	9
2023-04-06	365	60	8	10
2023-04-16	265	78	9	11
2023-05-20	244	98	10	12
2023-05-08	300	99	7	13
2023-05-11	333	96	8	14
2023-05-14	301	35	1	1
2023-05-21	200	45	2	2
2023-06-15	222	46	3	3
2023-06-16	132	42	4	4
2023-06-10	165	44	5	5
2023-06-12	120	11	4	6
2023-06-11	184	18	4	7
2023-07-30	198	19	6	8
2023-07-29	133	26	7	9
2023-07-07	162	27	8	10
2023-08-09	211	64	9	11
2023-08-21	125	18	10	12
2023-09-23	50	2	9	13
2023-10-05	487	200	9	14
\.


--
-- Data for Name: Hist_Salarios; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Hist_Salarios" ("numContrato", "sueldoQuinc", "fechaIni", "fechaFin", "empleadoId", "ciudadId") FROM stdin;
1	150	2023-02-18	2023-04-15	1	1
2	170	2023-01-15	2023-07-03	2	1
3	132	2023-02-23	2023-05-10	3	1
4	284	2023-01-20	\N	4	1
5	203	2023-02-09	2023-05-10	5	1
6	369	2023-03-03	\N	6	1
7	125	2023-03-10	\N	7	1
8	357	2023-01-21	\N	8	1
9	198	2023-02-14	2023-06-22	9	1
10	312	2023-03-05	2023-07-03	10	1
11	146	2023-04-19	\N	11	2
12	249	2023-05-31	\N	12	2
13	174	2023-05-26	2023-08-15	13	2
14	120	2023-05-19	2023-08-23	14	2
15	101	2023-01-02	\N	15	2
16	379	2023-02-11	2023-03-29	16	2
17	217	2023-03-28	2023-05-29	17	2
18	400	2023-04-14	2023-08-08	18	2
19	394	2023-05-07	\N	19	2
20	154	2023-04-13	\N	20	2
21	200	2023-05-08	\N	1	2
22	310	2023-06-22	\N	5	2
23	246	2023-07-03	\N	9	2
24	340	2023-08-15	\N	10	2
25	298	2023-05-29	\N	13	2
26	220	2023-07-03	\N	17	2
27	200	2023-05-10	\N	2	2
28	180	2023-08-23	\N	3	2
29	450	2023-08-08	\N	14	2
30	500	2023-08-08	\N	18	2
\.


--
-- Data for Name: Hist_Venta; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Hist_Venta" ("precioVent", "cantVend", "ventaId", "inventarioId") FROM stdin;
25	5	1	1
24	4	1	2
56	8	1	3
27	9	1	4
8	4	2	5
10	2	2	6
2	1	2	7
30	6	2	1
20	10	3	5
10	2	3	6
72	12	3	2
126	18	3	3
100	20	4	1
15	5	4	4
18	9	4	7
72	12	4	2
10	2	5	6
5	1	5	1
28	4	5	3
12	6	5	5
20	10	6	7
60	12	6	1
90	15	6	2
35	5	6	3
6	3	7	5
30	6	7	6
20	4	7	1
72	12	7	2
100	20	8	1
80	16	8	6
6	2	8	4
30	15	8	5
28	14	9	7
14	2	9	3
36	6	9	2
160	32	9	6
40	8	10	1
30	5	10	2
18	6	10	4
40	5	11	8
50	10	11	9
10	2	11	10
52	13	12	11
48	16	12	12
112	14	12	13
60	15	13	14
16	2	13	8
3	1	13	12
24	3	14	13
104	26	14	14
105	21	14	10
65	13	15	9
16	2	15	8
4	1	16	14
51	17	16	12
60	15	17	11
65	13	17	10
160	20	18	13
80	10	18	8
70	14	18	9
30	6	18	10
40	10	19	14
160	20	20	13
25	5	21	9
80	10	22	13
52	26	23	5
384	48	24	8
130	65	25	7
6	2	26	12
4	1	27	11
175	35	28	10
483	69	29	3
30	6	30	1
\.


--
-- Data for Name: Inventario; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Inventario" (id, cantidad, "costoVenta", "productoId", "ciudadId") FROM stdin;
1	100	5	1	1
2	138	6	2	1
3	245	7	3	1
4	55	3	4	1
5	97	2	5	1
6	92	5	6	1
7	165	2	7	1
8	254	8	1	2
9	59	5	2	2
10	260	5	3	2
11	135	4	4	2
12	120	3	5	2
13	150	8	6	2
14	160	4	7	2
\.


--
-- Data for Name: Pais; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Pais" (id, nombre) FROM stdin;
1	Venezuela
\.


--
-- Data for Name: Producto; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Producto" (id, nombre, descripcion) FROM stdin;
1	Shampoo	shapoo de los chinos
2	HarinaPan	Productos polar
3	Jabon Dove	Jabon de tocador
4	Azucar	\N
5	Sal	La extraida con la mejor mano de obra
6	Pasta	Pasta de los italianos
7	Arroz	\N
\.


--
-- Data for Name: Venta; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Venta" (id, hora, monto, "asistenciaFecha", "asistenciaEmpleadoId", "clienteId") FROM stdin;
1	06:10:00	132	2023-01-01	1	1
2	06:45:00	50	2023-02-02	2	2
3	18:30:00	228	2023-03-03	3	3
4	06:25:00	205	2023-04-04	4	4
5	06:55:00	55	2023-05-05	5	5
6	18:20:00	205	2023-06-06	6	6
7	06:15:00	128	2023-07-07	7	7
8	06:50:00	216	2023-08-08	8	8
9	18:35:00	238	2023-09-09	9	9
10	10:35:00	88	2023-01-10	10	10
11	12:55:00	100	2023-02-11	11	11
12	16:30:00	212	2023-03-12	12	12
13	07:55:00	79	2023-04-13	13	13
14	08:10:00	233	2023-05-14	14	14
15	09:25:00	81	2023-06-15	15	15
16	10:50:00	55	2023-07-16	16	16
17	11:05:00	125	2023-08-17	17	17
18	12:20:00	340	2023-09-18	18	18
19	13:35:00	40	2023-01-19	19	19
20	09:20:00	160	2023-02-20	20	20
21	15:00:00	25	2023-02-20	20	2
22	08:30:00	80	2023-02-20	20	5
23	13:30:00	52	2023-06-06	6	6
24	09:30:00	384	2023-05-14	14	8
25	10:30:00	130	2023-03-03	3	4
26	14:00:00	6	2023-09-18	18	6
27	18:30:00	4	2023-09-18	18	9
28	12:00:00	175	2023-09-18	18	1
29	16:30:00	483	2023-06-06	6	2
30	16:45:00	30	2023-06-06	6	20
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.migrations (id, "timestamp", name) FROM stdin;
\.


--
-- Name: Ciudad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Ciudad_id_seq"', 1, false);


--
-- Name: Cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Cliente_id_seq"', 1, false);


--
-- Name: Distribuidor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Distribuidor_id_seq"', 1, false);


--
-- Name: Empleado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Empleado_id_seq"', 1, false);


--
-- Name: Estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Estado_id_seq"', 1, false);


--
-- Name: Inventario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Inventario_id_seq"', 1, false);


--
-- Name: Pais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Pais_id_seq"', 1, false);


--
-- Name: Producto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Producto_id_seq"', 1, false);


--
-- Name: Venta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Venta_id_seq"', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.migrations_id_seq', 1, true);


--
-- Name: Hist_Venta PK_0aee21ff2b48773503ebe400e3d; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Hist_Venta"
    ADD CONSTRAINT "PK_0aee21ff2b48773503ebe400e3d" PRIMARY KEY ("ventaId", "inventarioId");


--
-- Name: Venta PK_2e7a31f0c6a99fe691dabfb2fa2; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Venta"
    ADD CONSTRAINT "PK_2e7a31f0c6a99fe691dabfb2fa2" PRIMARY KEY (id);


--
-- Name: Pais PK_39588447e7618c9343867dd9ffc; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Pais"
    ADD CONSTRAINT "PK_39588447e7618c9343867dd9ffc" PRIMARY KEY (id);


--
-- Name: Inventario PK_466f277b3f603fcbd34a908e54c; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Inventario"
    ADD CONSTRAINT "PK_466f277b3f603fcbd34a908e54c" PRIMARY KEY (id);


--
-- Name: Estado PK_4b73b059a55f610f3d8e3637352; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Estado"
    ADD CONSTRAINT "PK_4b73b059a55f610f3d8e3637352" PRIMARY KEY (id);


--
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- Name: Hist_Inventario PK_95912cda6f76ccbb3b190f41be1; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Hist_Inventario"
    ADD CONSTRAINT "PK_95912cda6f76ccbb3b190f41be1" PRIMARY KEY (fecha, "distribuidorId", "inventarioId");


--
-- Name: Hist_Asistencia PK_96169df3d96a9f9c01ad617d3e3; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Hist_Asistencia"
    ADD CONSTRAINT "PK_96169df3d96a9f9c01ad617d3e3" PRIMARY KEY (fecha, "empleadoId");


--
-- Name: Hist_Salarios PK_a9a18e3b7d2dc41b43b718d20ea; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Hist_Salarios"
    ADD CONSTRAINT "PK_a9a18e3b7d2dc41b43b718d20ea" PRIMARY KEY ("fechaIni", "empleadoId");


--
-- Name: Empleado PK_c373686f40463ef2523ed0656de; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Empleado"
    ADD CONSTRAINT "PK_c373686f40463ef2523ed0656de" PRIMARY KEY (id);


--
-- Name: Cliente PK_d6b00ec12b8a60095cc4389d35d; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Cliente"
    ADD CONSTRAINT "PK_d6b00ec12b8a60095cc4389d35d" PRIMARY KEY (id);


--
-- Name: Producto PK_e7929944b382b76708c4881fbde; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "PK_e7929944b382b76708c4881fbde" PRIMARY KEY (id);


--
-- Name: Distribuidor PK_f888272d7ffa45cb55ad0926472; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Distribuidor"
    ADD CONSTRAINT "PK_f888272d7ffa45cb55ad0926472" PRIMARY KEY (id);


--
-- Name: Ciudad PK_fea85b80b8e1989340f1ee72ae9; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Ciudad"
    ADD CONSTRAINT "PK_fea85b80b8e1989340f1ee72ae9" PRIMARY KEY (id);


--
-- Name: Estado UQ_144fc0d1d176b0cdbaef87ac1ee; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Estado"
    ADD CONSTRAINT "UQ_144fc0d1d176b0cdbaef87ac1ee" UNIQUE (nombre);


--
-- Name: Ciudad UQ_413cab0b153607af3a13c8c9db2; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Ciudad"
    ADD CONSTRAINT "UQ_413cab0b153607af3a13c8c9db2" UNIQUE (nombre);


--
-- Name: Producto UQ_6e86914f2eac7cf092dd634681c; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "UQ_6e86914f2eac7cf092dd634681c" UNIQUE (nombre);


--
-- Name: Distribuidor UQ_c0cde72799c4a14ea249144c651; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Distribuidor"
    ADD CONSTRAINT "UQ_c0cde72799c4a14ea249144c651" UNIQUE (nombre);


--
-- Name: Distribuidor UQ_c5cad2e2b05bf7621efb004b363; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Distribuidor"
    ADD CONSTRAINT "UQ_c5cad2e2b05bf7621efb004b363" UNIQUE (rif);


--
-- Name: Pais UQ_cc1641cb8eeb6c2143810168aed; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Pais"
    ADD CONSTRAINT "UQ_cc1641cb8eeb6c2143810168aed" UNIQUE (nombre);


--
-- Name: Venta FK_11cdd9c57d4b477ebc05600a938; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Venta"
    ADD CONSTRAINT "FK_11cdd9c57d4b477ebc05600a938" FOREIGN KEY ("clienteId") REFERENCES public."Cliente"(id);


--
-- Name: Estado FK_152ee037ef74338360ecc36e610; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Estado"
    ADD CONSTRAINT "FK_152ee037ef74338360ecc36e610" FOREIGN KEY ("paisId") REFERENCES public."Pais"(id);


--
-- Name: Hist_Inventario FK_170ca4c983b28c4d157722ad0fa; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Hist_Inventario"
    ADD CONSTRAINT "FK_170ca4c983b28c4d157722ad0fa" FOREIGN KEY ("distribuidorId") REFERENCES public."Distribuidor"(id);


--
-- Name: Inventario FK_1cad65396226ef93e837a07cde9; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Inventario"
    ADD CONSTRAINT "FK_1cad65396226ef93e837a07cde9" FOREIGN KEY ("productoId") REFERENCES public."Producto"(id);


--
-- Name: Ciudad FK_372e439864e090ab8c84c14aa7e; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Ciudad"
    ADD CONSTRAINT "FK_372e439864e090ab8c84c14aa7e" FOREIGN KEY ("estadoId") REFERENCES public."Estado"(id);


--
-- Name: Venta FK_37959360e4e8e8b896a50024bee; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Venta"
    ADD CONSTRAINT "FK_37959360e4e8e8b896a50024bee" FOREIGN KEY ("asistenciaFecha", "asistenciaEmpleadoId") REFERENCES public."Hist_Asistencia"(fecha, "empleadoId");


--
-- Name: Inventario FK_3d6bc8cba608bdc54581d4fe560; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Inventario"
    ADD CONSTRAINT "FK_3d6bc8cba608bdc54581d4fe560" FOREIGN KEY ("ciudadId") REFERENCES public."Ciudad"(id);


--
-- Name: Hist_Inventario FK_7384215dc057958a5ffb0e7adab; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Hist_Inventario"
    ADD CONSTRAINT "FK_7384215dc057958a5ffb0e7adab" FOREIGN KEY ("inventarioId") REFERENCES public."Inventario"(id);


--
-- Name: Hist_Asistencia FK_83eb2c02bc023c1fa5ed35f8f70; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Hist_Asistencia"
    ADD CONSTRAINT "FK_83eb2c02bc023c1fa5ed35f8f70" FOREIGN KEY ("empleadoId") REFERENCES public."Empleado"(id);


--
-- Name: Hist_Venta FK_a40775d381235b86396bbae9f31; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Hist_Venta"
    ADD CONSTRAINT "FK_a40775d381235b86396bbae9f31" FOREIGN KEY ("ventaId") REFERENCES public."Venta"(id);


--
-- Name: Distribuidor FK_bc7fdeeb6f2723cbe7a5403371c; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Distribuidor"
    ADD CONSTRAINT "FK_bc7fdeeb6f2723cbe7a5403371c" FOREIGN KEY ("ciudadId") REFERENCES public."Ciudad"(id);


--
-- Name: Hist_Salarios FK_bddb6727df27942db3d907946cd; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Hist_Salarios"
    ADD CONSTRAINT "FK_bddb6727df27942db3d907946cd" FOREIGN KEY ("empleadoId") REFERENCES public."Empleado"(id);


--
-- Name: Hist_Salarios FK_ciudad; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Hist_Salarios"
    ADD CONSTRAINT "FK_ciudad" FOREIGN KEY ("ciudadId") REFERENCES public."Ciudad"(id);


--
-- Name: Hist_Venta FK_d365c6d69482d502ed8d8ecfa36; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Hist_Venta"
    ADD CONSTRAINT "FK_d365c6d69482d502ed8d8ecfa36" FOREIGN KEY ("inventarioId") REFERENCES public."Inventario"(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

