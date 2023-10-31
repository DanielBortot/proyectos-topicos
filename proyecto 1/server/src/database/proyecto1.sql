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
	"primerApellido" character varying(50),
	"segundoNombre" character varying(50),
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
    "horaEntrada" time NOT NULL,
    "horaSalida" time,
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
    "precioVent" INTEGER NOT NULL,
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
    hora time NOT NULL,
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
\.


--
-- Data for Name: Cliente; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Cliente" (id, datos_cliente) FROM stdin;
1	(daniel,bortot,andres,luciani,04142543310,30875123)
\.


--
-- Data for Name: Distribuidor; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Distribuidor" (id, nombre, telefono, rif, "ciudadId") FROM stdin;
\.


--
-- Data for Name: Empleado; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Empleado" (id, datos_empleado) FROM stdin;
1	(daniel,bortot,andres,luciani,04142860327,29987471)
\.


--
-- Data for Name: Estado; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Estado" (id, nombre, "paisId") FROM stdin;
\.


--
-- Data for Name: Hist_Asistencia; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Hist_Asistencia" (fecha, "horaEntrada", "horaSalida", "empleadoId") FROM stdin;
\.


--
-- Data for Name: Hist_Inventario; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Hist_Inventario" (fecha, "costoUnidad", "cantidadComp", "distribuidorId", "inventarioId") FROM stdin;
\.


--
-- Data for Name: Hist_Salarios; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Hist_Salarios" ("numContrato", "sueldoQuinc", "fechaIni", "fechaFin", "empleadoId",  "ciudadId") FROM stdin;
\.


--
-- Data for Name: Hist_Venta; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Hist_Venta" ("precioVent", "cantVend", "ventaId", "inventarioId") FROM stdin;
\.


--
-- Data for Name: Inventario; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Inventario" (id, cantidad, "costoVenta", "productoId", "ciudadId") FROM stdin;
\.


--
-- Data for Name: Pais; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Pais" (id, nombre) FROM stdin;
\.


--
-- Data for Name: Producto; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Producto" (id, nombre, descripcion) FROM stdin;
\.


--
-- Data for Name: Venta; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Venta" (id,hora ,monto , "asistenciaFecha", "asistenciaEmpleadoId", "clienteId") FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.migrations (id, "timestamp", name) FROM stdin;
1	1697828901465	Base11697828901465
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

