--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12 (Ubuntu 14.12-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.12 (Ubuntu 14.12-0ubuntu0.22.04.1)


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
-- Name: delete_columns(text, text[]); Type: FUNCTION; Schema: public; Owner: ezra
--

CREATE FUNCTION public.delete_columns(schema_to_process text, column_list text[]) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
    column_record RECORD;
BEGIN
    FOR column_record IN
        SELECT * FROM information_schema.columns AS cinfo
        WHERE cinfo.table_schema = $1 AND cinfo.column_name = ANY($2)
    LOOP
        EXECUTE 'ALTER TABLE ' || $1 || '.' || column_record.table_name || ' DROP COLUMN IF EXISTS '
            || column_record.column_name || ' CASCADE;';
    END LOOP;
END;
$_$;


ALTER FUNCTION public.delete_columns(schema_to_process text, column_list text[]) OWNER TO ezra;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: areas; Type: TABLE; Schema: public; Owner: ezra
--

CREATE TABLE public.areas (
    id integer NOT NULL,
    name character varying,
    on_island boolean,
    sector_id integer
);


ALTER TABLE public.areas OWNER TO ezra;

--
-- Name: areas_id_seq; Type: SEQUENCE; Schema: public; Owner: ezra
--

CREATE SEQUENCE public.areas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.areas_id_seq OWNER TO ezra;

--
-- Dependencies: 209
-- Name: areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezra
--

ALTER SEQUENCE public.areas_id_seq OWNED BY public.areas.id;


--
-- Name: checklists; Type: TABLE; Schema: public; Owner: ezra
--

CREATE TABLE public.checklists (
    id integer NOT NULL,
    survey_id integer,
    sector_id integer,
    area_id integer,
    max_parties integer,
    min_parties integer,
    feeder_watch boolean,
    on_island boolean,
    location character varying,
    start_time time without time zone,
    end_time time without time zone,
    break_hours double precision,
    hours_foot double precision,
    hours_car double precision,
    hours_boat double precision,
    hours_owling double precision,
    hours_total double precision,
    miles_foot double precision,
    miles_car double precision,
    miles_boat double precision,
    miles_owling double precision,
    miles_total double precision
);


ALTER TABLE public.checklists OWNER TO ezra;

--
-- Name: checklists_id_seq; Type: SEQUENCE; Schema: public; Owner: ezra
--

CREATE SEQUENCE public.checklists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.checklists_id_seq OWNER TO ezra;

--
-- Dependencies: 211
-- Name: checklists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezra
--

ALTER SEQUENCE public.checklists_id_seq OWNED BY public.checklists.id;


--
-- Name: checklists_observers; Type: TABLE; Schema: public; Owner: ezra
--

CREATE TABLE public.checklists_observers (
    checklist_id integer NOT NULL,
    observer_id integer NOT NULL
);


ALTER TABLE public.checklists_observers OWNER TO ezra;

--
-- Name: observations; Type: TABLE; Schema: public; Owner: ezra
--

CREATE TABLE public.observations (
    id integer NOT NULL,
    number integer,
    taxon_id integer,
    checklist_id integer,
    count_week boolean,
    notes character varying,
    survey_id integer,
    sector_id integer
);


ALTER TABLE public.observations OWNER TO ezra;

--
-- Name: observations_id_seq; Type: SEQUENCE; Schema: public; Owner: ezra
--

CREATE SEQUENCE public.observations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.observations_id_seq OWNER TO ezra;

--
-- Dependencies: 214
-- Name: observations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezra
--

ALTER SEQUENCE public.observations_id_seq OWNED BY public.observations.id;


--
-- Name: observers; Type: TABLE; Schema: public; Owner: ezra
--

CREATE TABLE public.observers (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying
);


ALTER TABLE public.observers OWNER TO ezra;

--
-- Name: observers_id_seq; Type: SEQUENCE; Schema: public; Owner: ezra
--

CREATE SEQUENCE public.observers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.observers_id_seq OWNER TO ezra;

--
-- Dependencies: 216
-- Name: observers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezra
--

ALTER SEQUENCE public.observers_id_seq OWNED BY public.observers.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: ezra
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO ezra;

--
-- Name: sectors; Type: TABLE; Schema: public; Owner: ezra
--

CREATE TABLE public.sectors (
    id integer NOT NULL,
    name character varying,
    code character varying,
    on_island boolean
);


ALTER TABLE public.sectors OWNER TO ezra;

--
-- Name: sectors_id_seq; Type: SEQUENCE; Schema: public; Owner: ezra
--

CREATE SEQUENCE public.sectors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sectors_id_seq OWNER TO ezra;

--
-- Dependencies: 218
-- Name: sectors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezra
--

ALTER SEQUENCE public.sectors_id_seq OWNED BY public.sectors.id;


--
-- Name: surveys; Type: TABLE; Schema: public; Owner: ezra
--

CREATE TABLE public.surveys (
    id integer NOT NULL,
    date date,
    year_id integer
);


ALTER TABLE public.surveys OWNER TO ezra;

--
-- Name: surveys_id_seq; Type: SEQUENCE; Schema: public; Owner: ezra
--

CREATE SEQUENCE public.surveys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.surveys_id_seq OWNER TO ezra;

--
-- Dependencies: 220
-- Name: surveys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezra
--

ALTER SEQUENCE public.surveys_id_seq OWNED BY public.surveys.id;


--
-- Name: taxons; Type: TABLE; Schema: public; Owner: ezra
--

CREATE TABLE public.taxons (
    id integer NOT NULL,
    common_name character varying,
    cbc_name character varying,
    scientific_name character varying,
    taxonomic_order integer,
    generic boolean,
    active boolean
);


ALTER TABLE public.taxons OWNER TO ezra;

--
-- Name: taxons_id_seq; Type: SEQUENCE; Schema: public; Owner: ezra
--

CREATE SEQUENCE public.taxons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taxons_id_seq OWNER TO ezra;

--
-- Dependencies: 222
-- Name: taxons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezra
--

ALTER SEQUENCE public.taxons_id_seq OWNED BY public.taxons.id;


--
-- Name: years; Type: TABLE; Schema: public; Owner: ezra
--

CREATE TABLE public.years (
    id integer NOT NULL,
    audubon_year integer,
    vashon_year integer
);


ALTER TABLE public.years OWNER TO ezra;

--
-- Name: years_id_seq; Type: SEQUENCE; Schema: public; Owner: ezra
--

CREATE SEQUENCE public.years_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.years_id_seq OWNER TO ezra;

--
-- Dependencies: 224
-- Name: years_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezra
--

ALTER SEQUENCE public.years_id_seq OWNED BY public.years.id;


--
-- Name: areas id; Type: DEFAULT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.areas ALTER COLUMN id SET DEFAULT nextval('public.areas_id_seq'::regclass);


--
-- Name: checklists id; Type: DEFAULT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.checklists ALTER COLUMN id SET DEFAULT nextval('public.checklists_id_seq'::regclass);


--
-- Name: observations id; Type: DEFAULT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.observations ALTER COLUMN id SET DEFAULT nextval('public.observations_id_seq'::regclass);


--
-- Name: observers id; Type: DEFAULT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.observers ALTER COLUMN id SET DEFAULT nextval('public.observers_id_seq'::regclass);


--
-- Name: sectors id; Type: DEFAULT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.sectors ALTER COLUMN id SET DEFAULT nextval('public.sectors_id_seq'::regclass);


--
-- Name: surveys id; Type: DEFAULT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.surveys ALTER COLUMN id SET DEFAULT nextval('public.surveys_id_seq'::regclass);


--
-- Name: taxons id; Type: DEFAULT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.taxons ALTER COLUMN id SET DEFAULT nextval('public.taxons_id_seq'::regclass);


--
-- Name: years id; Type: DEFAULT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.years ALTER COLUMN id SET DEFAULT nextval('public.years_id_seq'::regclass);


--
-- Dependencies: 210
-- Data for Name: areas; Type: TABLE DATA; Schema: public; Owner: ezra
--

COPY public.areas (id, name, on_island, sector_id) FROM stdin;
1	Central	t	1
2	East	t	1
3	South	t	1
4	West	t	1
5	CoHousing	t	1
6	KVI Beach	t	1
7	Three Tree Point	f	1
8	Vashon Town	t	1
9	VCC - Shinglemill	t	1
10	Owling	t	1
11	East	t	2
12	South	t	2
13	West	t	2
14	Christensen Pond	t	2
15	Paradise Cove - Camp Sealth	t	2
16	East	t	3
17	South	t	3
18	West	t	3
19	Dockton Town	t	3
20	Boat	t	4
21	North	f	5
22	South	f	5
23	Salmonberry Creek	f	5
24	East	f	6
25	West	f	6
26	Long Lake	f	6
27	Wayne Jackson	f	6
28	Owling	f	6
29	Combined	f	7
\.


--
-- Dependencies: 212
-- Data for Name: checklists; Type: TABLE DATA; Schema: public; Owner: ezra
--

COPY public.checklists (id, survey_id, sector_id, area_id, max_parties, min_parties, feeder_watch, on_island, location, start_time, end_time, break_hours, hours_foot, hours_car, hours_boat, hours_owling, hours_total, miles_foot, miles_car, miles_boat, miles_owling, miles_total) FROM stdin;
1	1	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2	2	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3	3	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	4	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	5	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	6	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7	7	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8	8	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9	9	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
10	10	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
11	11	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
12	12	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
13	13	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
14	14	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
15	15	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
16	16	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
17	17	5	21	1	1	f	\N	\N	00:30:00	06:45:00	\N	6	1	0.25	\N	7.25	1	5.75	0.25	\N	7
18	17	5	22	1	1	f	\N	\N	00:00:00	08:15:00	\N	6.5	1.75	0	0	8.25	5.75	12	0	0	17.75
19	17	6	24	2	2	f	\N	\N	\N	\N	\N	3.5	12.75	\N	1	17.25	3.5	79	\N	5	87.5
20	17	6	26	0	0	f	\N	\N	\N	\N	\N	0.5	1.75	\N	\N	2.25	0.5	4	\N	\N	4.5
21	17	6	27	1	1	f	\N	\N	00:00:00	07:00:00	\N	\N	7	\N	\N	7	\N	9	\N	\N	9
22	17	6	25	1	1	f	\N	\N	\N	\N	\N	1.5	3.5	\N	3.5	8.5	1.5	26	\N	9.5	37
23	17	3	\N	\N	\N	t	\N	Aukland	01:30:00	03:30:00	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
24	17	3	\N	\N	\N	t	\N	Blichfeldt	00:00:00	08:00:00	\N	3	\N	\N	\N	3	\N	\N	\N	\N	\N
25	17	3	\N	\N	\N	t	\N	Bloch	00:40:00	02:00:00	\N	1.25	\N	\N	\N	1.25	\N	\N	\N	\N	\N
26	17	3	16	1	1	f	\N	\N	23:35:00	06:20:00	\N	4	2.5	\N	\N	6.5	1	10.25	\N	\N	11.25
27	17	3	\N	\N	\N	t	\N	Nebeker	\N	\N	\N	0	\N	\N	\N	0	\N	\N	\N	\N	\N
28	17	3	17	1	1	f	\N	\N	00:45:00	09:15:00	\N	3	4.5	\N	\N	7.5	2	16.5	\N	\N	18.5
29	17	3	18	1	1	f	\N	\N	00:30:00	06:40:00	\N	3.75	2	\N	\N	5.75	1	20	\N	\N	21
30	17	7	29	5	5	f	\N	\N	\N	\N	\N	16	19.5	\N	\N	35.5	14	184	\N	\N	198
31	17	7	\N	\N	\N	t	\N	Coons	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
32	17	4	20	1	1	f	\N	\N	01:20:00	05:30:00	\N	\N	\N	4.25	\N	4.25	\N	\N	18	\N	18
33	17	1	1	1	1	f	\N	\N	01:00:00	06:00:00	\N	3.5	1.5	\N	\N	5	2	11	\N	\N	13
34	17	1	2	1	1	f	\N	\N	00:00:00	08:00:00	\N	6	2	\N	\N	8	2.5	9	\N	\N	11.5
35	17	1	\N	\N	\N	t	\N	Emmons	\N	\N	\N	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
36	17	1	\N	\N	\N	t	\N	Forrest	\N	\N	\N	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
37	17	1	\N	\N	\N	t	\N	Friars	\N	\N	\N	1.25	\N	\N	\N	1.25	\N	\N	\N	\N	\N
38	17	1	\N	\N	\N	t	\N	Holtz	\N	\N	\N	3	\N	\N	\N	3	\N	\N	\N	\N	\N
39	17	1	6	0	0	f	\N	\N	\N	\N	\N	0.5	\N	\N	\N	0.5	0.25	\N	\N	\N	0.25
40	17	1	\N	\N	\N	t	\N	Lewis	02:00:00	05:00:00	\N	3	\N	\N	\N	3	\N	\N	\N	\N	\N
41	17	1	10	0	0	f	\N	\N	19:30:00	23:00:00	\N	\N	\N	\N	3.5	3.5	\N	\N	\N	18.5	18.5
42	17	1	\N	\N	\N	t	\N	Ripley	23:00:00	08:30:00	\N	3.5	\N	\N	\N	3.5	\N	\N	\N	\N	\N
43	17	1	\N	\N	\N	t	\N	Rose	03:30:00	05:00:00	\N	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
44	17	1	\N	\N	\N	t	\N	Siegrist	\N	\N	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
45	17	1	3	1	1	f	\N	\N	00:00:00	08:40:00	\N	4	5.75	\N	\N	9.75	3	14	\N	\N	17
46	17	1	7	1	1	f	\N	\N	22:30:00	06:00:00	\N	5	1.5	\N	1	7.5	2	17	\N	2	21
47	17	1	\N	\N	\N	t	\N	Turner	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
48	17	1	9	1	1	f	\N	\N	01:00:00	07:00:00	\N	4	\N	\N	\N	4	1.75	\N	\N	\N	1.75
49	17	1	8	0	0	f	\N	\N	06:45:00	07:20:00	\N	0.75	\N	\N	\N	0.75	0.25	\N	\N	\N	0.25
50	17	1	4	1	1	f	\N	\N	01:00:00	07:20:00	\N	2.25	4	\N	\N	6.25	2	12	\N	\N	14
51	17	2	14	1	1	f	\N	\N	02:00:00	07:00:00	\N	3	\N	\N	\N	3	4	\N	\N	\N	4
52	17	2	\N	\N	\N	t	\N	DeNies	02:00:00	04:00:00	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
53	17	2	11	1	1	f	\N	\N	00:00:00	08:00:00	\N	3	5	\N	\N	8	3.5	18	\N	\N	21.5
54	17	2	\N	\N	\N	t	\N	Hatcher	01:00:00	05:15:00	\N	2.75	\N	\N	\N	2.75	\N	\N	\N	\N	\N
55	17	2	\N	\N	\N	t	\N	Korenek	\N	\N	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
56	17	2	15	1	1	f	\N	\N	01:00:00	04:00:00	\N	3	\N	\N	\N	3	3.5	\N	\N	\N	3.5
57	17	2	12	1	1	f	\N	\N	00:00:00	04:15:00	\N	3.25	1	\N	\N	4.25	2	5	\N	\N	7
58	17	2	\N	\N	\N	t	\N	Sweetman	02:00:00	08:30:00	\N	1.25	\N	\N	\N	1.25	\N	\N	\N	\N	\N
59	17	2	13	1	1	f	\N	\N	02:00:00	06:00:00	\N	3	1	\N	\N	4	2.5	10	\N	\N	12.5
60	18	5	21	1	1	f	\N	\N	00:30:00	06:45:00	\N	6	0.25	0.5	\N	6.75	0.25	5.75	3.25	\N	9.25
61	18	5	22	1	1	f	\N	\N	00:00:00	05:30:00	\N	\N	5.5	\N	\N	5.5	\N	44.25	\N	\N	44.25
62	18	6	24	1	1	f	\N	\N	00:00:00	07:30:00	\N	9	4	\N	\N	13	4.5	43	\N	\N	47.5
63	18	6	26	0	0	f	\N	\N	\N	\N	\N	2	0.5	\N	\N	2.5	0.5	9	\N	\N	9.5
64	18	6	28	0	0	f	\N	\N	\N	\N	\N	\N	\N	\N	3	3	\N	\N	\N	27	27
65	18	6	27	1	1	f	\N	\N	00:30:00	08:30:00	\N	\N	8	\N	\N	8	\N	79	\N	\N	79
66	18	6	25	1	1	f	\N	\N	\N	\N	\N	5.5	1	\N	\N	6.5	3	17	\N	\N	20
67	18	3	\N	\N	\N	t	\N	Aukland	04:15:00	08:15:00	\N	4	\N	\N	\N	4	\N	\N	\N	\N	\N
68	18	3	\N	\N	\N	t	\N	Bloch	00:00:00	02:00:00	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
69	18	3	19	1	1	f	\N	\N	00:15:00	08:00:00	\N	2	2.5	\N	\N	4.5	2	14	\N	\N	16
70	18	3	16	2	1	f	\N	\N	23:45:00	07:00:00	\N	5.75	1.5	\N	\N	7.25	3.25	7.25	\N	\N	10.5
71	18	3	\N	\N	\N	t	\N	Nebeker	\N	\N	\N	0	\N	\N	\N	0	\N	\N	\N	\N	\N
136	19	1	\N	\N	\N	t	\N	Rose	03:15:00	05:30:00	\N	2.25	\N	\N	\N	2.25	\N	\N	\N	\N	\N
72	18	3	17	1	1	f	\N	\N	00:15:00	08:15:00	\N	1	6	\N	\N	7	0.5	10.25	\N	\N	10.75
73	18	3	18	1	1	f	\N	\N	01:00:00	05:45:00	\N	2	2.75	\N	\N	4.75	0.5	20	\N	\N	20.5
74	18	7	29	5	5	f	\N	\N	23:45:00	07:40:00	\N	18	16	\N	\N	34	19	165.5	\N	\N	184.5
75	18	7	\N	\N	\N	t	\N	Coons	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
76	18	4	20	1	1	f	\N	\N	01:05:00	04:30:00	\N	\N	\N	3.5	\N	3.5	\N	\N	18	\N	18
77	18	1	\N	\N	\N	t	\N	Bronson	06:40:00	07:40:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
78	18	1	1	1	1	f	\N	\N	09:10:00	16:00:00	\N	5	1	\N	\N	6	1.5	10	\N	\N	11.5
79	18	1	2	1	1	f	\N	\N	23:50:00	08:15:00	\N	4	3	\N	\N	7	2.5	6.5	\N	\N	9
80	18	1	\N	\N	\N	t	\N	Emmons	02:15:00	03:00:00	\N	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
81	18	1	\N	\N	\N	t	\N	Friars	00:00:00	\N	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
82	18	1	\N	\N	\N	t	\N	Holtz	\N	\N	\N	2.5	\N	\N	\N	2.5	\N	\N	\N	\N	\N
83	18	1	6	0	0	f	\N	\N	00:15:00	01:00:00	\N	0.75	\N	\N	\N	0.75	0.25	\N	\N	\N	0.25
84	18	1	\N	\N	\N	t	\N	Lewis	04:00:00	09:00:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
85	18	1	10	0	0	f	\N	\N	19:30:00	23:00:00	\N	\N	\N	\N	3.5	3.5	\N	\N	\N	30.5	30.5
86	18	1	\N	\N	\N	t	\N	Rose	02:00:00	08:00:00	\N	4	\N	\N	\N	4	\N	\N	\N	\N	\N
87	18	1	\N	\N	\N	t	\N	Siegrist	00:00:00	08:00:00	\N	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
88	18	1	3	1	1	f	\N	\N	00:05:00	08:05:00	\N	2	6	\N	\N	8	2.5	23	\N	\N	25.5
89	18	1	7	1	1	f	\N	\N	00:15:00	06:30:00	\N	5	0.5	\N	\N	5.5	2.5	12	\N	\N	14.5
90	18	1	9	1	1	f	\N	\N	01:00:00	07:00:00	\N	4	\N	\N	\N	4	1.75	\N	\N	\N	1.75
91	18	1	8	0	0	f	\N	\N	07:45:00	08:30:00	\N	0.75	\N	\N	\N	0.75	0.5	\N	\N	\N	0.5
92	18	1	4	1	1	f	\N	\N	00:20:00	06:30:00	\N	4.5	0.5	\N	\N	5	1	6	\N	\N	7
93	18	2	14	1	1	f	\N	\N	02:00:00	04:00:00	\N	2	\N	\N	\N	2	2	\N	\N	\N	2
94	18	2	\N	\N	\N	t	\N	DeNies	00:30:00	03:30:00	\N	3	\N	\N	\N	3	\N	\N	\N	\N	\N
95	18	2	11	1	1	f	\N	\N	23:45:00	08:35:00	\N	3	6	\N	\N	9	3.5	17	\N	\N	20.5
96	18	2	\N	\N	\N	t	\N	Hatcher	01:00:00	06:45:00	\N	3	\N	\N	\N	3	\N	\N	\N	\N	\N
97	18	2	\N	\N	\N	t	\N	Macdonald	\N	\N	\N	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
98	18	2	15	1	1	f	\N	\N	00:15:00	04:05:00	\N	4	\N	\N	\N	4	2.25	\N	\N	\N	2.25
99	18	2	\N	\N	\N	t	\N	Parker	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
100	18	2	\N	\N	\N	t	\N	Ryan	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
101	18	2	\N	\N	\N	t	\N	Simons	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
102	18	2	12	1	1	f	\N	\N	01:15:00	05:15:00	\N	3	1	\N	\N	4	3	6	\N	\N	9
103	18	2	13	1	1	f	\N	\N	00:45:00	05:00:00	\N	3	1.25	\N	\N	4.25	2.5	5	\N	\N	7.5
104	19	5	21	1	1	f	\N	\N	00:25:00	05:25:00	\N	3.5	1.5	\N	\N	5	1.5	14.5	\N	\N	16
105	19	5	22	1	1	f	\N	\N	00:30:00	06:15:00	\N	1	4.75	\N	\N	5.75	1	40.5	\N	\N	41.5
106	19	6	24	1	1	f	\N	\N	00:00:00	06:45:00	\N	4.25	2.5	\N	\N	6.75	1	34.5	\N	\N	35.5
107	19	6	26	0	0	f	\N	\N	\N	\N	\N	2.25	0.25	\N	\N	2.5	0.75	3.75	\N	\N	4.5
108	19	6	28	0	0	f	\N	\N	\N	\N	\N	\N	\N	\N	3.25	3.25	\N	\N	\N	26.25	26.25
109	19	6	27	1	1	f	\N	\N	\N	\N	\N	\N	6	\N	\N	6	\N	75	\N	\N	75
110	19	6	25	1	1	f	\N	\N	\N	\N	\N	5	0.75	\N	\N	5.75	2.25	15	\N	\N	17.25
111	19	3	16	1	1	f	\N	\N	23:45:00	08:30:00	0.25	7.75	0.75	\N	\N	8.5	4	10.25	\N	\N	14.25
112	19	3	17	1	1	f	\N	\N	00:10:00	08:25:00	1.25	4	3	\N	\N	7	1	26	\N	\N	27
113	19	3	18	2	1	f	\N	\N	00:00:00	08:45:00	\N	1.5	10.5	\N	\N	12	1	35.5	\N	\N	36.5
114	19	3	\N	\N	\N	t	\N	Aukland	02:15:00	03:50:00	\N	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
115	19	3	\N	\N	\N	t	\N	Bloch	00:00:00	01:00:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
116	19	3	\N	\N	\N	t	\N	Durrett	00:00:00	05:30:00	4.5	1	\N	\N	\N	1	\N	\N	\N	\N	\N
117	19	3	\N	\N	\N	t	\N	Feinstein	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
118	19	3	\N	\N	\N	t	\N	Nebeker	\N	\N	\N	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
119	19	3	\N	\N	\N	t	\N	Woods	01:00:00	03:15:00	\N	2.25	\N	\N	\N	2.25	\N	\N	\N	\N	\N
120	19	7	29	5	5	f	\N	\N	\N	\N	\N	10	24	\N	\N	34	13	156	\N	\N	169
121	19	7	\N	\N	\N	t	\N	Coons	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
122	19	4	20	1	1	f	\N	\N	00:30:00	04:45:00	\N	\N	\N	4.25	\N	4.25	\N	\N	18	\N	18
123	19	1	1	1	1	f	\N	\N	01:00:00	08:00:00	\N	5	2	\N	\N	7	2	12	\N	\N	14
124	19	1	2	1	1	f	\N	\N	23:45:00	08:30:00	\N	4.5	4.25	\N	\N	8.75	3	36.25	\N	\N	39.25
125	19	1	6	0	0	f	\N	\N	00:15:00	01:00:00	\N	0.75	\N	\N	\N	0.75	1	\N	\N	\N	1
126	19	1	10	0	0	f	\N	\N	19:35:00	23:05:00	\N	\N	\N	\N	3.5	3.5	\N	\N	\N	29.75	29.75
127	19	1	3	1	1	f	\N	\N	00:00:00	08:30:00	1	4.5	3	\N	\N	7.5	4	8	\N	\N	12
128	19	1	7	2	1	f	\N	\N	00:00:00	06:15:00	\N	8.25	1	0	0.75	10	2.25	7	0	2	11.25
129	19	1	9	1	1	f	\N	\N	03:00:00	05:30:00	\N	3.5	\N	\N	\N	3.5	1.5	\N	\N	\N	1.5
130	19	1	8	0	0	f	\N	\N	05:30:00	08:30:00	\N	1	2	0.25	\N	3.25	0.75	3.25	2	\N	6
131	19	1	4	1	1	f	\N	\N	01:00:00	07:30:00	1.5	4.5	0.5	\N	0.25	5.25	1	6	\N	\N	7
132	19	1	\N	\N	\N	t	\N	Bronson	02:35:00	03:35:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
133	19	1	\N	\N	\N	t	\N	Davis	02:55:00	04:20:00	\N	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
134	19	1	\N	\N	\N	t	\N	Gorrell	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
135	19	1	\N	\N	\N	t	\N	Lewis	04:00:00	06:00:00	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
137	19	1	\N	\N	\N	t	\N	Siegrist	00:30:00	07:00:00	3.5	3	\N	\N	\N	3	\N	\N	\N	\N	\N
138	19	2	14	1	1	f	\N	\N	01:00:00	08:30:00	3	4.5	\N	\N	\N	4.5	3	\N	\N	\N	3
139	19	2	11	1	1	f	\N	\N	23:45:00	08:15:00	\N	3	5.5	\N	\N	8.5	3	17	\N	\N	20
140	19	2	15	1	1	f	\N	\N	00:30:00	03:30:00	\N	3	\N	\N	\N	3	1	\N	\N	\N	1
141	19	2	12	1	1	f	\N	\N	01:00:00	05:00:00	\N	3	1	\N	\N	4	3	10	\N	\N	13
142	19	2	13	1	1	f	\N	\N	23:45:00	06:00:00	\N	4.25	2	\N	\N	6.25	2.25	15.5	\N	\N	17.75
143	19	2	\N	\N	\N	t	\N	DeNies	02:00:00	07:00:00	1	4	\N	\N	\N	4	\N	\N	\N	\N	\N
144	19	2	\N	\N	\N	t	\N	Hatcher	01:45:00	06:30:00	2.75	2	\N	\N	\N	2	\N	\N	\N	\N	\N
145	19	2	\N	\N	\N	t	\N	Korenek	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
146	19	2	\N	\N	\N	t	\N	Macdonald	00:00:00	09:00:00	6	3	\N	\N	\N	3	\N	\N	\N	\N	\N
147	19	2	\N	\N	\N	t	\N	Madden	\N	\N	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
148	19	2	\N	\N	\N	t	\N	Simons	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
149	19	2	\N	\N	\N	t	\N	Touhey	01:45:00	02:45:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
150	20	5	21	1	1	f	\N	\N	01:30:00	06:15:00	\N	4	0.75	\N	\N	4.75	0.75	9	\N	\N	9.75
151	20	5	22	1	1	f	\N	\N	00:05:00	06:35:00	\N	0.5	6	\N	\N	6.5	0.5	38	\N	\N	38.5
152	20	6	24	1	1	f	\N	\N	23:45:00	07:15:00	0.25	5	2.25	\N	\N	7.25	2.5	32.25	\N	\N	34.75
153	20	6	26	0	0	f	\N	\N	\N	\N	\N	2.5	0.25	\N	\N	2.75	1.25	4.25	\N	\N	5.5
154	20	6	28	0	0	f	\N	\N	\N	\N	\N	\N	\N	\N	3.5	3.5	\N	\N	\N	22.5	22.5
155	20	6	27	1	1	f	\N	\N	00:00:00	08:00:00	2	\N	6	\N	\N	6	\N	74	\N	\N	74
156	20	6	25	1	1	f	\N	\N	\N	\N	\N	5	0.5	\N	\N	5.5	3	8.75	\N	\N	11.75
157	20	3	16	1	1	f	\N	\N	23:55:00	08:25:00	0.75	7.25	0.5	\N	\N	7.75	3.75	7.25	\N	\N	11
158	20	3	17	1	1	f	\N	\N	00:00:00	08:25:00	1	2	5.5	\N	\N	7.5	1	17	\N	\N	18
159	20	3	18	1	1	f	\N	\N	01:00:00	08:00:00	\N	2	5	\N	\N	7	1.25	17.75	\N	\N	19
160	20	3	\N	\N	\N	t	\N	Aukland	02:15:00	06:00:00	2.25	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
161	20	3	\N	\N	\N	t	\N	Bloch	01:50:00	08:10:00	5.25	1	\N	\N	\N	1	\N	\N	\N	\N	\N
162	20	3	\N	\N	\N	t	\N	Nebeker	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
163	20	3	\N	\N	\N	t	\N	Woods	00:30:00	02:30:00	\N	2	\N	\N	\N	2	1	\N	\N	\N	1
164	20	7	29	6	6	f	\N	\N	00:00:00	07:00:00	0.5	27.75	13.75	\N	\N	41.5	28.5	145.5	\N	\N	174
165	20	7	\N	\N	\N	t	\N	Coons	\N	\N	\N	3	\N	\N	\N	3	\N	\N	\N	\N	\N
166	20	4	20	1	1	f	\N	\N	00:00:00	03:30:00	\N	\N	\N	3.5	\N	3.5	\N	\N	18	\N	18
167	20	1	1	1	1	f	\N	\N	01:00:00	07:00:00	\N	5	1	\N	\N	6	3	9	\N	\N	12
168	20	1	2	1	1	f	\N	\N	00:00:00	09:00:00	\N	7.75	1.25	\N	\N	9	6	15.5	\N	\N	21.5
169	20	1	6	0	0	f	\N	\N	00:00:00	01:00:00	\N	1	\N	\N	\N	1	0.25	\N	\N	\N	0.25
170	20	1	10	0	0	f	\N	\N	19:35:00	23:00:00	\N	\N	\N	\N	3.5	3.5	\N	\N	\N	32.25	32.25
171	20	1	3	1	1	f	\N	\N	00:00:00	07:40:00	0.5	2.5	4.75	\N	\N	7.25	2	17	\N	\N	19
172	20	1	7	1	1	f	\N	\N	22:45:00	07:30:00	1.5	5	2	0	0.25	7.25	2	17.5	0	1.5	21
173	20	1	9	1	1	f	\N	\N	01:00:00	03:30:00	\N	2.5	\N	\N	\N	2.5	1	\N	\N	\N	1
174	20	1	8	0	0	f	\N	\N	04:30:00	08:30:00	\N	1.25	2.75	\N	\N	4	1	4.25	\N	\N	5.25
175	20	1	4	1	1	f	\N	\N	01:25:00	07:30:00	1	4.5	0.5	\N	\N	5	1	6.75	\N	\N	7.75
176	20	1	\N	\N	\N	t	\N	Anderson	01:05:00	03:05:00	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
177	20	1	\N	\N	\N	t	\N	Davis	04:00:00	05:00:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
178	20	1	\N	\N	\N	t	\N	Elenko	00:30:00	08:30:00	4	4	\N	\N	\N	4	\N	\N	\N	\N	\N
179	20	1	\N	\N	\N	t	\N	Emmons	00:15:00	01:15:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
180	20	1	\N	\N	\N	t	\N	Lewis	01:30:00	04:30:00	\N	3	\N	\N	\N	3	\N	\N	\N	\N	\N
181	20	1	\N	\N	\N	t	\N	Rose	06:00:00	08:00:00	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
182	20	1	\N	\N	\N	t	\N	Siegrist	00:30:00	08:00:00	6.5	1	\N	\N	\N	1	\N	\N	\N	\N	\N
183	20	2	14	1	1	f	\N	\N	01:00:00	08:30:00	2.5	5	\N	\N	\N	5	5	\N	\N	\N	5
184	20	2	11	1	1	f	\N	\N	23:50:00	08:30:00	0.25	6.5	2	\N	\N	8.5	3.5	18	\N	\N	21.5
185	20	2	15	1	1	f	\N	\N	01:30:00	05:25:00	0.75	3.25	\N	\N	\N	3.25	1	\N	\N	\N	1
186	20	2	12	1	1	f	\N	\N	00:30:00	04:15:00	\N	2.75	1	\N	\N	3.75	3	3	\N	\N	6
187	20	2	13	1	1	f	\N	\N	23:45:00	08:30:00	2	4.5	2.25	\N	\N	6.75	2.75	7.25	\N	\N	10
188	20	2	\N	\N	\N	t	\N	DeNies	01:00:00	05:00:00	1	3	\N	\N	\N	3	0.5	\N	\N	\N	0.5
189	20	2	\N	\N	\N	t	\N	Korenek	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
190	20	2	\N	\N	\N	t	\N	Macdonald	00:00:00	09:00:00	6	3	\N	\N	\N	3	\N	\N	\N	\N	\N
191	20	2	\N	\N	\N	t	\N	Sweetman	00:30:00	08:00:00	6.5	1	\N	\N	\N	1	0	\N	\N	\N	0
192	21	5	21	1	1	f	\N	\N	01:00:00	06:00:00	\N	4.25	0.75	\N	\N	5	1	14.25	\N	\N	15.25
193	21	5	23	0	0	f	\N	\N	14:05:00	15:45:00	\N	1.75	\N	\N	\N	1.75	2.5	\N	\N	\N	2.5
194	21	5	22	1	1	f	\N	\N	00:00:00	09:00:00	1.75	5	2.25	\N	\N	7.25	4	7	\N	\N	11
195	21	6	24	1	1	f	\N	\N	00:15:00	07:15:00	\N	2	5	\N	\N	7	2	12	\N	\N	14
196	21	6	26	0	0	f	\N	\N	04:00:00	07:00:00	\N	2.5	0.5	\N	\N	3	1	2.25	\N	\N	3.25
197	21	6	28	0	0	f	\N	\N	22:00:00	23:45:00	\N	\N	\N	\N	1.75	1.75	\N	\N	\N	5	5
198	21	6	27	1	1	f	\N	\N	02:30:00	08:00:00	\N	\N	5.5	\N	\N	5.5	\N	48	\N	\N	48
199	21	6	25	1	1	f	\N	\N	00:00:00	08:30:00	3	3.75	1.75	\N	\N	5.5	3.5	16	\N	\N	19.5
200	21	3	16	1	1	f	\N	\N	00:00:00	08:30:00	0.75	7	0.75	\N	\N	7.75	3.5	8	\N	\N	11.5
201	21	3	17	1	1	f	\N	\N	23:50:00	08:30:00	1.25	2	5.5	\N	\N	7.5	1	15	\N	\N	16
202	21	3	18	1	1	f	\N	\N	00:45:00	05:35:00	\N	3.25	1.5	\N	\N	4.75	3.5	19.5	\N	\N	23
203	21	3	\N	\N	\N	t	\N	Aukland	02:30:00	03:30:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
204	21	3	\N	\N	\N	t	\N	Nebeker	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
205	21	7	29	7	7	f	\N	\N	00:00:00	07:45:00	11.75	26	16.5	\N	\N	42.5	22	167	\N	\N	189
206	21	4	20	1	1	f	\N	\N	00:38:00	03:45:00	\N	\N	\N	3	\N	3	\N	\N	17	\N	17
207	21	1	1	1	1	f	\N	\N	01:15:00	08:00:00	0.75	4	2	\N	\N	6	2	11	\N	\N	13
208	21	1	5	1	1	f	\N	\N	00:15:00	02:45:00	\N	2.5	\N	\N	\N	2.5	2	\N	\N	\N	2
209	21	1	2	1	1	f	\N	\N	00:00:00	08:30:00	\N	5	3.5	\N	\N	8.5	4.5	23	\N	\N	27.5
210	21	1	6	0	0	f	\N	\N	00:00:00	00:45:00	\N	0.5	0.25	\N	\N	0.75	0.5	0.25	\N	\N	0.75
211	21	1	10	0	0	f	\N	\N	19:45:00	23:00:00	\N	\N	\N	\N	3.25	3.25	\N	\N	\N	27	27
212	21	1	3	1	1	f	\N	\N	00:00:00	08:00:00	1	4	3	\N	\N	7	4	15	\N	\N	19
213	21	1	7	1	1	f	\N	\N	23:15:00	08:30:00	1.5	4.75	2.25	0	0.75	7.75	3.25	21.75	0	5	30
214	21	1	9	1	1	f	\N	\N	04:30:00	07:30:00	\N	3	\N	\N	\N	3	2	\N	\N	\N	2
215	21	1	8	1	1	f	\N	\N	04:30:00	08:15:00	\N	1	2.75	\N	\N	3.75	1	14.5	\N	\N	15.5
216	21	1	4	1	1	f	\N	\N	01:00:00	07:30:00	1.5	4	1	\N	\N	5	1.25	7	\N	\N	8.25
217	21	1	\N	\N	\N	t	\N	Hunter 1	01:15:00	01:45:00	\N	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
218	21	1	\N	\N	\N	t	\N	Hunter 2	\N	\N	\N	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
219	21	1	\N	\N	\N	t	\N	Lewis	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
220	21	1	\N	\N	\N	t	\N	Morgan	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
221	21	1	\N	\N	\N	t	\N	Rose	\N	\N	\N	3	\N	\N	\N	3	\N	\N	\N	\N	\N
222	21	1	\N	\N	\N	t	\N	Shull	01:28:00	08:45:00	6.25	1	\N	\N	\N	1	\N	\N	\N	\N	\N
223	21	1	\N	\N	\N	t	\N	Siegrist	00:00:00	07:00:00	4.5	2.5	\N	\N	\N	2.5	\N	\N	\N	\N	\N
224	21	1	\N	\N	\N	t	\N	Soholt	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
225	21	1	\N	\N	\N	t	\N	Van Fleet	\N	\N	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
226	21	2	11	1	1	f	\N	\N	22:00:00	08:00:00	\N	6	2	\N	2	10	3.5	18	\N	18	39.5
227	21	2	15	1	1	f	\N	\N	01:50:00	04:45:00	0.5	2.5	\N	\N	\N	2.5	1.25	\N	\N	\N	1.25
228	21	2	12	1	1	f	\N	\N	00:30:00	03:30:00	\N	1	2	\N	\N	3	0.5	5	\N	\N	5.5
229	21	2	13	1	1	f	\N	\N	23:45:00	08:45:00	\N	6.25	2.75	\N	\N	9	4.25	32.5	\N	\N	36.75
230	21	2	\N	\N	\N	t	\N	Burman	01:00:00	07:15:00	5.5	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
231	21	2	\N	\N	\N	t	\N	Caldwell	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
232	21	2	\N	\N	\N	t	\N	DeNies	01:00:00	04:00:00	\N	3	\N	\N	\N	3	\N	\N	\N	\N	\N
233	21	2	\N	\N	\N	t	\N	Guddal	01:00:00	02:00:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
234	21	2	\N	\N	\N	t	\N	Korenek	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
235	21	2	\N	\N	\N	t	\N	Macdonald	\N	\N	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
236	21	2	\N	\N	\N	t	\N	Parker	\N	\N	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
237	22	5	21	1	1	f	\N	\N	01:45:00	05:45:00	\N	2.5	1.5	\N	\N	4	1	20	\N	\N	21
238	22	5	23	1	1	f	\N	\N	01:45:00	04:45:00	\N	2.75	0.25	\N	\N	3	1.25	2.75	\N	\N	4
239	22	5	22	1	1	f	\N	\N	05:00:00	08:15:00	\N	2.25	1	\N	\N	3.25	1.5	4	\N	\N	5.5
240	22	5	\N	\N	\N	t	\N	Sutton	00:30:00	07:45:00	5	2.25	\N	\N	\N	2.25	\N	\N	\N	\N	\N
241	22	6	24	3	3	f	\N	\N	00:00:00	05:45:00	2.25	7	8	\N	\N	15	6	93	\N	\N	99
242	22	6	26	0	0	f	\N	\N	04:00:00	06:00:00	\N	1.75	0.25	\N	\N	2	1.75	4	\N	\N	5.75
243	22	6	28	0	0	f	\N	\N	22:30:00	23:30:00	\N	\N	\N	\N	1	1	\N	\N	\N	7	7
244	22	6	25	1	1	f	\N	\N	00:00:00	09:00:00	2.5	5.5	1	\N	\N	6.5	3.75	16.5	\N	\N	20.25
245	22	6	\N	\N	\N	t	\N	Daniel	\N	\N	\N	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
246	22	3	16	1	1	f	\N	\N	00:15:00	07:00:00	0.75	5	1	\N	\N	6	5	7	\N	\N	12
247	22	3	17	1	1	f	\N	\N	00:00:00	08:00:00	1	2.5	4.5	\N	\N	7	1	16.5	\N	\N	17.5
248	22	3	18	1	1	f	\N	\N	01:30:00	08:45:00	\N	5.75	1.5	\N	\N	7.25	2.5	16.25	\N	\N	18.75
249	22	3	\N	\N	\N	t	\N	Aukland	02:15:00	08:00:00	4.75	1	\N	\N	\N	1	\N	\N	\N	\N	\N
250	22	3	\N	\N	\N	t	\N	Feinstein	03:00:00	05:00:00	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
251	22	3	\N	\N	\N	t	\N	Hunter	01:15:00	08:30:00	4.5	2.75	\N	\N	\N	2.75	\N	\N	\N	\N	\N
252	22	3	\N	\N	\N	t	\N	Keller	00:00:00	07:45:00	3.5	4.25	0	0	0	4.25	1	0	0	0	1
253	22	3	\N	\N	\N	t	\N	Nebeker	\N	\N	\N	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
254	22	3	\N	\N	\N	t	\N	Nelsen	01:00:00	08:00:00	3	4	\N	\N	\N	4	\N	\N	\N	\N	\N
255	22	3	\N	\N	\N	t	\N	O'Reilly	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
256	22	3	\N	\N	\N	t	\N	Van Os	04:30:00	06:30:00	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
257	22	3	\N	\N	\N	t	\N	Weise	02:45:00	08:15:00	3.5	2	\N	\N	\N	2	\N	\N	\N	\N	\N
258	22	7	29	7	7	f	\N	\N	22:45:00	07:15:00	20.5	29.5	8	\N	1.5	39	19	110.25	\N	5	134.25
259	22	7	\N	\N	\N	t	\N	Coons	\N	\N	\N	6	\N	\N	\N	6	\N	\N	\N	\N	\N
260	22	7	\N	\N	\N	t	\N	Dudley/Elfman	01:00:00	07:15:00	5.5	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
261	22	4	20	1	1	f	\N	\N	00:45:00	08:00:00	\N	5.25	2	\N	\N	7.25	1.25	25.5	\N	\N	26.75
262	22	1	1	1	1	f	\N	\N	\N	\N	\N	2.25	\N	\N	\N	2.25	1.25	\N	\N	\N	1.25
263	22	1	1	1	1	f	\N	\N	03:00:00	08:00:00	\N	3	2	\N	\N	5	2	15	\N	\N	17
264	22	1	5	1	1	f	\N	\N	00:15:00	02:15:00	\N	2	\N	\N	\N	2	2	\N	\N	\N	2
265	22	1	2	1	1	f	\N	\N	21:45:00	08:30:00	\N	6.5	2.25	\N	2	10.75	2.5	18.75	\N	6.25	27.5
266	22	1	2	1	1	f	\N	\N	06:30:00	07:00:00	\N	0.5	\N	\N	\N	0.5	0.5	\N	\N	\N	0.5
267	22	1	6	1	1	f	\N	\N	23:45:00	01:30:00	\N	1.75	0	\N	\N	1.75	0.25	0.5	\N	\N	0.75
268	22	1	2	1	1	f	\N	\N	\N	\N	\N	2.25	\N	\N	1	3.25	0.25	\N	\N	0.25	0.5
269	22	1	10	1	1	f	\N	\N	21:45:00	10:45:00	9.75	\N	\N	\N	3.25	3.25	\N	\N	\N	25	25
270	22	1	3	1	1	f	\N	\N	00:00:00	08:30:00	0.5	7.25	0.75	\N	\N	8	6	17	\N	\N	23
271	22	1	7	1	1	f	\N	\N	22:45:00	08:00:00	1.75	5.75	1.25	0	0.5	7.5	3.5	13	0	2	18.5
272	22	1	9	1	1	f	\N	\N	03:00:00	05:00:00	0.5	1.5	\N	\N	\N	1.5	2	\N	\N	\N	2
273	22	1	8	1	1	f	\N	\N	02:15:00	05:15:00	\N	2.75	0.25	\N	\N	3	3	2.25	\N	\N	5.25
274	22	1	4	1	1	f	\N	\N	01:00:00	07:00:00	1	4.5	0.5	\N	\N	5	1	7.5	\N	\N	8.5
275	22	1	\N	\N	\N	t	\N	Davis	01:30:00	03:00:00	0.5	1	\N	\N	\N	1	\N	\N	\N	\N	\N
276	22	1	\N	\N	\N	t	\N	Emmons	02:30:00	04:30:00	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
277	22	1	\N	\N	\N	t	\N	Holtz	03:15:00	04:45:00	\N	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
278	22	1	\N	\N	\N	t	\N	Hunter 1	07:30:00	08:00:00	\N	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
279	22	1	\N	\N	\N	t	\N	Hunter 2	07:00:00	07:15:00	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
280	22	1	\N	\N	\N	t	\N	Hunter 3	06:15:00	06:45:00	\N	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
281	22	1	\N	\N	\N	t	\N	Morgan	05:00:00	05:15:00	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
282	22	1	\N	\N	\N	t	\N	Newman	00:30:00	07:00:00	4.25	2.25	\N	\N	\N	2.25	\N	\N	\N	\N	\N
283	22	1	\N	\N	\N	t	\N	Roedell	00:00:00	01:00:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
284	22	1	\N	\N	\N	t	\N	Rose	02:00:00	08:15:00	3	3.25	\N	\N	\N	3.25	\N	\N	\N	\N	\N
285	22	1	\N	\N	\N	t	\N	Siegrist	00:00:00	08:00:00	6.5	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
286	22	1	\N	\N	\N	t	\N	Soholt	01:30:00	04:45:00	2	1.25	\N	\N	\N	1.25	\N	\N	\N	\N	\N
287	22	1	\N	\N	\N	t	\N	Spiers	04:30:00	07:30:00	\N	3	\N	\N	\N	3	0.5	\N	\N	\N	0.5
288	22	1	\N	\N	\N	t	\N	Turner	00:00:00	06:30:00	2.5	4	\N	\N	\N	4	\N	\N	\N	\N	\N
289	22	1	\N	\N	\N	t	\N	Van Fleet	23:45:00	08:15:00	6.75	1.75	\N	\N	\N	1.75	\N	\N	\N	\N	\N
290	22	2	12	1	1	f	\N	\N	03:15:00	04:15:00	\N	1	\N	\N	\N	1	1.5	\N	\N	\N	1.5
291	22	2	11	1	1	f	\N	\N	00:00:00	08:30:00	\N	6	2	\N	0.5	8.5	6	24	\N	0.5	30.5
292	22	2	15	1	1	f	\N	\N	01:00:00	06:30:00	3.5	2	\N	\N	\N	2	0.75	\N	\N	\N	0.75
293	22	2	11	1	1	f	\N	\N	00:30:00	07:30:00	4.5	2.5	\N	\N	\N	2.5	0.25	\N	\N	\N	0.25
294	22	2	12	1	1	f	\N	\N	00:00:00	05:00:00	\N	4	1	\N	\N	5	3	5	\N	\N	8
295	22	2	13	1	1	f	\N	\N	00:00:00	07:30:00	1.25	2.25	4	\N	\N	6.25	0.75	22	\N	\N	22.75
296	22	2	\N	\N	\N	t	\N	Andrews	03:00:00	04:00:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
297	22	2	\N	\N	\N	t	\N	DeNies	00:30:00	04:30:00	\N	4	\N	\N	\N	4	0.25	\N	\N	\N	0.25
298	22	2	\N	\N	\N	t	\N	Findlay	00:45:00	07:30:00	5	1.75	0	0	0	1.75	\N	\N	\N	\N	\N
299	22	2	\N	\N	\N	t	\N	Korenek	00:00:00	00:15:00	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
300	22	2	\N	\N	\N	t	\N	Macdonald	\N	\N	\N	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
301	22	2	\N	\N	\N	t	\N	McClellan	\N	\N	\N	5.5	\N	\N	\N	5.5	\N	\N	\N	\N	\N
302	22	2	\N	\N	\N	t	\N	Myers	00:30:00	07:30:00	5	2	\N	\N	\N	2	0.5	\N	\N	\N	0.5
303	22	2	\N	\N	\N	t	\N	Parker	06:20:00	07:20:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
304	22	2	\N	\N	\N	t	\N	Perla	03:00:00	06:30:00	2.5	1	\N	\N	\N	1	\N	\N	\N	\N	\N
305	22	2	\N	\N	\N	t	\N	Shinn	01:30:00	02:30:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
306	22	2	\N	\N	\N	t	\N	Sweetman	00:00:00	07:15:00	6	1.25	\N	\N	\N	1.25	\N	\N	\N	\N	\N
307	22	2	\N	\N	\N	t	\N	Thompson	03:45:00	08:30:00	2.5	2.25	\N	\N	\N	2.25	\N	\N	\N	\N	\N
308	22	2	\N	\N	\N	t	\N	White	00:15:00	04:15:00	3	1	\N	\N	\N	1	\N	\N	\N	\N	\N
309	23	5	21	1	1	f	\N	\N	00:28:00	06:42:00	\N	5.25	1	\N	\N	6.25	1.75	9.5	\N	\N	11.25
310	23	5	23	0	0	f	\N	\N	06:42:00	08:20:00	\N	1.25	0.5	\N	\N	1.75	0.5	1.25	\N	\N	1.75
311	23	5	22	0	0	f	\N	\N	\N	\N	\N	0	0	\N	\N	0	0	0	\N	\N	0
312	23	5	\N	\N	\N	t	\N	Sutton	01:45:00	07:50:00	5	1	\N	\N	\N	1	\N	\N	\N	\N	\N
313	23	6	24	1	1	f	\N	\N	00:30:00	07:45:00	\N	3	4.25	\N	\N	7.25	3.25	39	\N	\N	42.25
314	23	6	24	0	0	f	\N	\N	\N	\N	\N	0	0	\N	\N	0	0	0	\N	\N	0
315	23	6	26	0	0	f	\N	\N	03:31:00	05:58:00	\N	2.25	0.25	\N	\N	2.5	0.75	5	\N	\N	5.75
316	23	6	25	1	1	f	\N	\N	23:45:00	08:31:00	2.75	4.5	1.5	\N	\N	6	2.5	20.5	\N	\N	23
317	23	6	\N	\N	\N	t	\N	Daniel	\N	\N	\N	1.25	\N	\N	\N	1.25	\N	\N	\N	\N	\N
318	23	6	\N	\N	\N	t	\N	McMahon	02:00:00	05:00:00	\N	3	\N	\N	\N	3	\N	\N	\N	\N	\N
319	23	3	16	1	1	f	\N	\N	\N	\N	\N	3	\N	\N	\N	3	0.75	\N	\N	\N	0.75
320	23	3	16	1	1	f	\N	\N	00:12:00	08:25:00	\N	7.75	0.5	\N	\N	8.25	4.5	5	\N	\N	9.5
321	23	3	17	1	1	f	\N	\N	00:00:00	08:30:00	1	3.5	4	\N	\N	7.5	2.5	21.5	\N	\N	24
322	23	3	18	1	1	f	\N	\N	\N	\N	\N	2	\N	\N	\N	2	1.75	\N	\N	\N	1.75
323	23	3	18	1	1	f	\N	\N	21:30:00	09:50:00	1	7.25	1.5	\N	2.5	11.25	2.75	14	\N	22	38.75
324	23	3	\N	\N	\N	t	\N	Aukland	02:20:00	03:20:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
325	23	3	\N	\N	\N	t	\N	Durrett	01:10:00	08:20:00	5.75	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
326	23	3	\N	\N	\N	t	\N	Hunter	07:05:00	08:30:00	0.75	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
327	23	3	\N	\N	\N	t	\N	Nebeker	\N	\N	\N	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
328	23	3	\N	\N	\N	t	\N	Woods	03:45:00	04:45:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
329	23	7	29	1	1	f	\N	\N	00:30:00	06:00:00	\N	2	3.5	\N	\N	5.5	1	41.5	\N	\N	42.5
330	23	7	29	1	1	f	\N	\N	00:05:00	06:20:00	\N	5.75	0.5	\N	\N	6.25	4	13.5	\N	\N	17.5
331	23	7	29	1	1	f	\N	\N	01:15:00	03:00:00	\N	1.75	\N	\N	\N	1.75	1	\N	\N	\N	1
332	23	7	29	1	1	f	\N	\N	23:45:00	08:45:00	\N	6.25	2.75	\N	\N	9	7.5	35	\N	\N	42.5
333	23	7	29	1	1	f	\N	\N	00:00:00	06:00:00	\N	2	4	\N	\N	6	2.5	61	\N	\N	63.5
334	23	7	29	1	1	f	\N	\N	00:00:00	05:00:00	\N	3	2	\N	\N	5	3	14.5	\N	\N	17.5
335	23	7	29	1	1	f	\N	\N	00:30:00	06:15:00	\N	3.75	2	\N	\N	5.75	2.5	20	\N	\N	22.5
336	23	7	\N	\N	\N	t	\N	Dudley Elfman	01:15:00	07:15:00	5.25	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
337	23	4	20	1	1	f	\N	\N	00:40:00	03:10:00	\N	\N	\N	2.5	\N	2.5	\N	\N	15	\N	15
338	23	1	1	0	0	f	\N	\N	04:07:00	04:26:00	\N	0.25	\N	\N	\N	0.25	0.25	\N	\N	\N	0.25
339	23	1	1	0	0	f	\N	\N	04:45:00	05:00:00	\N	\N	\N	0.25	\N	0.25	\N	\N	2.25	\N	2.25
340	23	1	1	1	1	f	\N	\N	00:54:00	08:30:00	3.25	4	0.25	\N	\N	4.25	2	7	\N	\N	9
341	23	1	5	1	1	f	\N	\N	00:00:00	03:00:00	\N	3	\N	\N	\N	3	2.5	\N	\N	\N	2.5
342	23	1	2	1	1	f	\N	\N	00:05:00	08:35:00	\N	3.75	4.75	0	0	8.5	5	24	0	0	29
343	23	1	6	0	0	f	\N	\N	\N	\N	\N	0	\N	\N	\N	0	0	\N	\N	\N	0
344	23	1	10	0	0	f	\N	\N	\N	\N	\N	0	\N	\N	\N	0	0	\N	\N	\N	0
345	23	1	3	1	1	f	\N	\N	00:00:00	08:00:00	0.5	5	2.5	0	0	7.5	5	13	0	0	18
346	23	1	7	1	1	f	\N	\N	08:35:00	09:05:00	\N	\N	\N	\N	0.5	0.5	\N	\N	\N	0	0
347	23	1	7	1	1	f	\N	\N	07:15:00	16:35:00	1.25	5	2.5	0	0.5	8	3.75	15.5	0	3.5	22.75
348	23	1	8	1	1	f	\N	\N	04:30:00	07:30:00	0.25	2.5	0.25	\N	\N	2.75	2	2.25	\N	\N	4.25
349	23	1	4	1	1	f	\N	\N	01:10:00	06:10:00	1.25	2.75	1	\N	\N	3.75	1	5	\N	\N	6
350	23	1	\N	\N	\N	t	\N	Davis	04:20:00	05:23:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
351	23	1	\N	\N	\N	t	\N	Holtz	02:00:00	04:00:00	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
352	23	1	\N	\N	\N	t	\N	Hunter 1	00:20:00	08:20:00	7.25	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
353	23	1	\N	\N	\N	t	\N	Hunter 2	05:45:00	06:00:00	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
354	23	1	\N	\N	\N	t	\N	Roedell 1	01:55:00	07:35:00	5	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
355	23	1	\N	\N	\N	t	\N	Roedell 2	03:30:00	08:15:00	4.25	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
356	23	1	\N	\N	\N	t	\N	Siegrist	00:00:00	08:00:00	7.25	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
357	23	1	\N	\N	\N	t	\N	Smith	\N	\N	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
358	23	2	11	1	1	f	\N	\N	01:30:00	06:30:00	2	3	\N	\N	\N	3	0.5	\N	\N	\N	0.5
359	23	2	11	1	1	f	\N	\N	00:00:00	08:00:00	\N	4.5	3.5	\N	\N	8	3	27	\N	\N	30
360	23	2	12	1	1	f	\N	\N	05:00:00	06:40:00	\N	1.75	\N	\N	\N	1.75	0.75	\N	\N	\N	0.75
361	23	2	12	1	1	f	\N	\N	00:45:00	08:00:00	1	4.75	1.5	\N	\N	6.25	2.75	2.5	\N	\N	5.25
362	23	2	13	1	1	f	\N	\N	05:30:00	06:00:00	\N	0.5	\N	\N	\N	0.5	0.25	\N	\N	\N	0.25
363	23	2	13	1	1	f	\N	\N	00:10:00	08:30:00	1.5	3.25	3.5	\N	\N	6.75	2	9.5	\N	\N	11.5
364	23	2	\N	\N	\N	t	\N	Bell 1	\N	\N	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
365	23	2	\N	\N	\N	t	\N	Bell 2	\N	\N	\N	1.25	\N	\N	\N	1.25	\N	\N	\N	\N	\N
366	23	2	\N	\N	\N	t	\N	Burns	00:40:00	03:00:00	\N	2.25	\N	\N	\N	2.25	\N	\N	\N	\N	\N
367	23	2	\N	\N	\N	t	\N	DeNies	00:30:00	04:30:00	\N	4	\N	\N	\N	4	\N	\N	\N	\N	\N
368	23	2	\N	\N	\N	t	\N	Dizazzo	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
369	23	2	\N	\N	\N	t	\N	Findlay	01:00:00	08:30:00	5	2.5	\N	\N	\N	2.5	\N	\N	\N	\N	\N
370	23	2	\N	\N	\N	t	\N	Macdonald	01:05:00	08:30:00	5.5	2	\N	\N	\N	2	\N	\N	\N	\N	\N
371	23	2	\N	\N	\N	t	\N	McClellan	00:00:00	08:00:00	1.5	6.5	\N	\N	\N	6.5	\N	\N	\N	\N	\N
372	23	2	\N	\N	\N	t	\N	Myers	02:00:00	08:25:00	5.5	1	\N	\N	\N	1	\N	\N	\N	\N	\N
373	23	2	\N	\N	\N	t	\N	Parker	00:55:00	08:15:00	6.5	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
374	23	2	\N	\N	\N	t	\N	Perla	02:30:00	03:00:00	\N	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
375	23	2	\N	\N	\N	t	\N	Rippey	06:45:00	07:30:00	\N	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
376	23	2	\N	\N	\N	t	\N	Sweetman	05:40:00	06:30:00	\N	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
377	23	2	\N	\N	\N	t	\N	Thompson	05:42:00	06:27:00	\N	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
378	24	5	21	0	0	f	\N	\N	\N	\N	\N	0	\N	\N	\N	0	0	\N	\N	\N	0
379	24	5	21	1	1	f	\N	\N	00:30:00	08:30:00	\N	6.25	1.75	\N	\N	8	1.25	6	\N	\N	7.25
380	24	5	22	0	0	f	\N	\N	\N	\N	\N	0	\N	\N	\N	0	0	\N	\N	\N	0
381	24	5	\N	\N	\N	t	\N	Sutton	\N	\N	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
382	24	6	24	0	0	f	\N	\N	\N	\N	\N	0	\N	\N	\N	0	0	\N	\N	\N	0
383	24	6	24	1	1	f	\N	\N	06:00:00	07:00:00	\N	1	\N	\N	\N	1	0.75	\N	\N	\N	0.75
384	24	6	24	1	1	f	\N	\N	00:15:00	05:30:00	0.25	2.5	2.5	\N	\N	5	1.75	28	\N	\N	29.75
385	24	6	26	0	0	f	\N	\N	03:45:00	06:00:00	\N	2	0.25	\N	\N	2.25	0.75	3	\N	\N	3.75
386	24	6	25	1	1	f	\N	\N	21:30:00	08:45:00	2.75	5.5	1.25	\N	1.75	8.5	1.25	14.5	\N	9.75	25.5
387	24	6	\N	\N	\N	t	\N	Daniel	07:00:00	08:00:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
388	24	6	\N	\N	\N	t	\N	McMahon	04:30:00	05:30:00	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
389	24	3	16	1	1	f	\N	\N	00:15:00	08:00:00	\N	7	0.75	\N	\N	7.75	4.75	2.75	\N	\N	7.5
390	24	3	17	1	1	f	\N	\N	23:55:00	09:10:00	1	2	6.25	\N	\N	8.25	2	16.75	\N	\N	18.75
391	24	3	18	1	1	f	\N	\N	21:10:00	10:20:00	1.5	7.25	1.75	\N	2.75	11.75	2.75	13.75	\N	13.25	29.75
392	24	3	\N	\N	\N	t	\N	Aukland	05:20:00	07:00:00	\N	1.75	\N	\N	\N	1.75	\N	\N	\N	\N	\N
393	24	3	\N	\N	\N	t	\N	Hawkins	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
394	24	3	\N	\N	\N	t	\N	Nebeker	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
395	24	3	\N	\N	\N	t	\N	O'Reilly	\N	\N	\N	2	\N	\N	\N	2	\N	\N	\N	\N	\N
396	24	3	\N	\N	\N	t	\N	Pierce	04:00:00	05:15:00	\N	1.25	\N	\N	\N	1.25	\N	\N	\N	\N	\N
397	24	7	29	1	1	f	\N	\N	23:45:00	06:30:00	0.5	5.25	1	\N	\N	6.25	3	15	\N	\N	18
398	24	7	29	1	1	f	\N	\N	01:15:00	03:45:00	\N	2.5	\N	\N	\N	2.5	1.5	\N	\N	\N	1.5
399	24	7	29	1	1	f	\N	\N	00:00:00	08:15:00	\N	6.75	1.5	\N	\N	8.25	7.5	27	\N	\N	34.5
400	24	7	29	1	1	f	\N	\N	21:45:00	06:15:00	\N	2	4	\N	2.5	8.5	1	15.75	\N	19	35.75
401	24	7	29	1	1	f	\N	\N	00:15:00	07:45:00	1	5	1.5	\N	\N	6.5	4.25	20	\N	\N	24.25
402	24	7	29	1	1	f	\N	\N	00:10:00	05:30:00	\N	4.25	1	\N	\N	5.25	3.75	7	\N	\N	10.75
403	24	7	\N	\N	\N	t	\N	Coons	00:00:00	09:00:00	3	6	\N	\N	\N	6	\N	\N	\N	\N	\N
404	24	7	\N	\N	\N	t	\N	Dudley	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
405	24	4	20	1	1	f	\N	\N	01:00:00	03:45:00	\N	\N	\N	2.75	\N	2.75	\N	\N	14	\N	14
406	24	1	1	0	0	f	\N	\N	\N	\N	\N	\N	\N	0.25	\N	0.25	\N	\N	2.5	\N	2.5
407	24	1	1	1	1	f	\N	\N	01:00:00	07:30:00	0.5	4	2	\N	\N	6	2	12	\N	\N	14
408	24	1	5	0	0	f	\N	\N	07:20:00	07:55:00	\N	0.5	\N	\N	\N	0.5	0.5	\N	\N	\N	0.5
409	24	1	2	1	1	f	\N	\N	23:45:00	08:30:00	\N	7.75	1	\N	\N	8.75	7.25	21	\N	\N	28.25
410	24	1	3	1	1	f	\N	\N	00:00:00	08:00:00	\N	5	3	\N	\N	8	3	13	\N	\N	16
411	24	1	7	1	1	f	\N	\N	22:45:00	07:15:00	\N	4.25	3.75	\N	0.5	8.5	4	11	\N	1.5	16.5
412	24	1	8	0	0	f	\N	\N	07:00:00	08:20:00	0.5	0.25	0.5	\N	\N	0.75	0.5	1.75	\N	\N	2.25
413	24	1	4	1	1	f	\N	\N	00:10:00	05:15:00	0.5	3.5	1	\N	\N	4.5	1.5	5	\N	\N	6.5
414	24	1	\N	\N	\N	t	\N	Davis	\N	\N	\N	1	\N	\N	\N	1	\N	\N	\N	\N	\N
415	24	1	\N	\N	\N	t	\N	Holtz	\N	\N	\N	2.5	\N	\N	\N	2.5	\N	\N	\N	\N	\N
416	24	1	\N	\N	\N	t	\N	Koriath	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
417	24	2	\N	\N	\N	t	\N	McClellan	00:00:00	07:30:00	3.5	4	\N	\N	\N	4	\N	\N	\N	\N	\N
418	24	1	\N	\N	\N	t	\N	Richmond	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
419	24	1	\N	\N	\N	t	\N	Willsie	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
420	24	2	11	1	1	f	\N	\N	00:15:00	06:30:00	1.5	4.25	0.5	\N	\N	4.75	4.5	6.25	\N	\N	10.75
421	24	2	15	1	1	f	\N	\N	00:45:00	04:50:00	1	3	\N	\N	\N	3	2	\N	\N	\N	2
422	24	2	12	1	1	f	\N	\N	00:15:00	06:45:00	1	4.75	0.75	\N	\N	5.5	2.25	10.5	\N	\N	12.75
423	24	2	13	1	1	f	\N	\N	23:45:00	09:00:00	0.5	6.75	2	\N	\N	8.75	2.5	24	\N	\N	26.5
424	24	2	\N	\N	\N	t	\N	Burns	00:15:00	01:30:00	\N	1.25	\N	\N	\N	1.25	\N	\N	\N	\N	\N
425	24	2	\N	\N	\N	t	\N	DeNies	01:00:00	06:00:00	\N	5	\N	\N	\N	5	\N	\N	\N	\N	\N
426	24	2	\N	\N	\N	t	\N	Findlay	01:30:00	07:30:00	1	5	\N	\N	\N	5	\N	\N	\N	\N	\N
427	24	2	\N	\N	\N	t	\N	Parker	01:15:00	09:30:00	8	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
428	24	2	\N	\N	\N	t	\N	Paulsen	\N	\N	\N	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
429	24	2	\N	\N	\N	t	\N	Perla	23:30:00	00:00:00	\N	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
430	24	2	\N	\N	\N	t	\N	Rippey	00:00:00	08:15:00	7.5	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
431	24	2	\N	\N	\N	t	\N	Summers	13:15:00	13:30:00	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
432	24	2	\N	\N	\N	t	\N	Sweetman	02:05:00	08:10:00	4.5	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
433	25	5	21	0	0	f	\N	\N	\N	\N	\N	0	\N	\N	\N	0	0	\N	\N	\N	0
434	25	5	21	1	1	f	\N	\N	00:45:00	08:15:00	\N	5	2.5	\N	\N	7.5	1.75	9	\N	\N	10.75
435	25	5	22	1	1	f	\N	\N	00:30:00	04:45:00	\N	2.75	1.5	\N	\N	4.25	2.75	26	\N	\N	28.75
436	25	6	24	1	1	f	\N	\N	00:05:00	07:50:00	0.5	1.75	5.5	\N	\N	7.25	1.75	40.5	\N	\N	42.25
437	25	6	24	0	0	f	\N	\N	\N	\N	\N	0	\N	\N	\N	0	0	\N	\N	\N	0
438	25	6	26	0	0	f	\N	\N	03:45:00	06:00:00	\N	2	0.25	\N	\N	2.25	0.75	3.75	\N	\N	4.5
439	25	6	24	0	0	f	\N	\N	\N	\N	\N	0	\N	\N	\N	0	0	\N	\N	\N	0
440	25	6	25	1	1	f	\N	\N	21:15:00	08:45:00	2.25	6.25	1	\N	2	9.25	2.75	17.5	\N	14.25	34.5
441	25	6	\N	\N	\N	t	\N	Sutton	02:00:00	08:00:00	4.75	1.25	\N	\N	\N	1.25	\N	\N	\N	\N	\N
442	25	3	16	1	1	f	\N	\N	23:20:00	08:10:00	\N	8	0.5	\N	0.25	8.75	8.75	12.5	\N	0.25	21.5
443	25	3	17	1	1	f	\N	\N	00:05:00	08:20:00	1.25	3	4	\N	\N	7	2.5	10	\N	\N	12.5
444	25	3	18	1	1	f	\N	\N	21:30:00	09:45:00	1.25	7	1.5	\N	2.5	11	3.5	15	\N	10	28.5
445	25	3	\N	\N	\N	t	\N	Aukland	02:15:00	03:00:00	\N	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
446	25	3	\N	\N	\N	t	\N	Nebeker	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
447	25	3	\N	\N	\N	t	\N	O'Reilly	\N	\N	\N	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
448	25	7	29	1	1	f	\N	\N	23:50:00	08:00:00	\N	6.75	1.5	\N	\N	8.25	2.5	13.5	\N	\N	16
449	25	7	29	1	1	f	\N	\N	00:20:00	04:20:00	\N	4	\N	\N	\N	4	2	\N	\N	\N	2
450	25	7	29	1	1	f	\N	\N	00:00:00	08:00:00	\N	7	1	\N	\N	8	7.75	25	\N	\N	32.75
451	25	7	29	1	1	f	\N	\N	22:45:00	06:15:00	\N	2.75	3.25	\N	1.5	7.5	4.75	9.25	\N	14	28
452	25	7	29	1	1	f	\N	\N	00:45:00	07:30:00	1	4.25	1.5	\N	\N	5.75	5.5	25	\N	\N	30.5
453	25	7	29	1	1	f	\N	\N	00:00:00	05:00:00	\N	3.5	1.5	\N	\N	5	3	25	\N	\N	28
454	25	7	\N	\N	\N	t	\N	Dudley	\N	\N	\N	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
455	25	7	\N	\N	\N	t	\N	Guy	\N	\N	\N	0.5	\N	\N	\N	0.5	\N	\N	\N	\N	\N
456	25	4	20	1	1	f	\N	\N	01:00:00	04:00:00	\N	\N	\N	3	\N	3	\N	\N	15	\N	15
457	25	1	1	0	0	f	\N	\N	\N	\N	\N	0	\N	\N	\N	0	0	\N	\N	\N	0
458	25	1	1	1	1	f	\N	\N	01:30:00	08:15:00	1	5.25	0.5	\N	\N	5.75	4	9	\N	\N	13
459	25	1	5	0	0	f	\N	\N	\N	\N	\N	0	\N	\N	\N	0	0	\N	\N	\N	0
460	25	1	2	1	1	f	\N	\N	00:00:00	07:30:00	\N	6	1.5	\N	\N	7.5	4.75	12	\N	\N	16.75
461	25	1	3	1	1	f	\N	\N	00:00:00	08:15:00	1	6	1.25	\N	\N	7.25	6	26.25	\N	\N	32.25
462	25	1	7	1	1	f	\N	\N	22:45:00	08:00:00	0.75	6.5	1.25	0	0.75	8.5	4.5	13	0	1.25	18.75
463	25	1	8	0	0	f	\N	\N	\N	\N	\N	0	\N	\N	\N	0	0	\N	\N	\N	0
464	25	1	4	1	1	f	\N	\N	00:00:00	06:00:00	\N	4.75	1.25	\N	\N	6	3	7.25	\N	\N	10.25
465	25	2	11	1	1	f	\N	\N	23:30:00	06:30:00	1	6	\N	\N	\N	6	1	\N	\N	\N	1
466	25	2	11	1	1	f	\N	\N	00:30:00	08:30:00	\N	6	2	\N	\N	8	2	10	\N	\N	12
467	25	2	11	1	1	f	\N	\N	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	0.25	0.25
468	25	2	15	1	1	f	\N	\N	01:35:00	05:00:00	2	1.5	\N	\N	\N	1.5	1	\N	\N	\N	1
469	25	2	12	1	1	f	\N	\N	00:30:00	02:40:00	\N	2.25	\N	\N	\N	2.25	1.5	\N	\N	\N	1.5
470	25	2	12	1	1	f	\N	\N	01:00:00	04:30:00	\N	2.75	0.75	\N	\N	3.5	1	4	\N	\N	5
471	25	2	13	1	1	f	\N	\N	00:00:00	08:00:00	\N	4	4	\N	\N	8	2	22	\N	\N	24
472	25	2	\N	\N	\N	t	\N	Findlay	00:45:00	08:05:00	2.5	4.75	\N	\N	\N	4.75	\N	\N	\N	\N	\N
473	25	2	\N	\N	\N	t	\N	Lohr	\N	\N	\N	0.25	\N	\N	\N	0.25	\N	\N	\N	\N	\N
474	25	2	\N	\N	\N	t	\N	McClellan	\N	\N	\N	3.5	\N	\N	\N	3.5	\N	\N	\N	\N	\N
475	25	2	\N	\N	\N	t	\N	Parker	\N	\N	\N	0.75	\N	\N	\N	0.75	\N	\N	\N	\N	\N
476	25	2	\N	\N	\N	t	\N	Paulsen	00:00:00	08:30:00	7	1.5	\N	\N	\N	1.5	\N	\N	\N	\N	\N
477	25	2	\N	\N	\N	t	\N	Sweetman	00:30:00	08:30:00	6.75	1.25	\N	\N	\N	1.25	\N	\N	\N	\N	\N
\.


--
-- Dependencies: 213
-- Data for Name: checklists_observers; Type: TABLE DATA; Schema: public; Owner: ezra
--

COPY public.checklists_observers (checklist_id, observer_id) FROM stdin;
17	1
18	2
19	3
19	4
19	5
19	6
19	7
19	8
20	9
20	10
21	11
22	9
22	10
23	12
24	13
25	14
25	15
26	16
26	17
26	18
26	19
28	20
28	21
28	22
29	23
29	24
29	25
29	26
29	27
30	28
30	29
30	30
30	31
30	32
30	33
30	34
30	35
30	36
30	37
30	38
30	39
31	40
32	41
32	42
32	43
32	44
33	45
33	46
33	47
33	48
34	49
34	50
34	51
35	52
35	53
36	54
37	26
38	55
38	56
39	23
39	24
39	25
39	26
39	27
40	57
40	58
41	16
41	59
42	60
43	61
44	62
45	59
45	63
45	64
46	65
46	66
47	67
48	68
48	69
49	16
49	17
49	18
50	70
50	71
50	72
51	73
52	74
53	75
53	76
53	77
54	78
55	79
56	80
56	81
57	82
57	83
57	84
57	85
58	86
58	87
59	88
59	67
59	89
60	1
61	5
61	90
61	91
62	4
62	3
62	6
62	7
62	92
63	9
63	10
63	34
64	9
64	10
64	34
64	93
64	94
65	11
66	9
66	10
66	34
66	93
66	94
67	12
67	95
68	14
68	15
69	13
69	96
70	16
70	17
70	18
70	97
70	98
70	99
72	20
72	100
72	101
73	23
73	26
74	35
74	102
74	103
74	104
74	30
74	31
74	32
74	105
74	40
74	33
74	28
74	106
74	107
74	108
74	38
74	37
74	29
75	109
76	41
76	42
76	43
76	110
76	111
77	112
78	45
78	46
78	48
78	47
79	83
79	67
79	50
79	113
79	114
80	52
81	25
81	24
82	55
82	56
83	23
83	26
84	57
84	58
85	16
85	50
86	61
87	62
88	59
88	64
88	63
88	51
89	65
89	66
90	68
90	69
91	16
91	17
91	18
91	97
91	98
91	99
92	71
92	70
92	72
92	85
92	115
93	73
94	74
95	75
95	116
95	77
96	78
97	117
97	118
98	80
98	81
99	17
100	119
101	120
102	82
102	121
102	122
102	123
102	124
103	19
103	88
103	125
103	126
103	89
103	127
104	65
104	66
105	128
105	129
106	4
106	3
107	9
107	10
107	6
107	7
108	9
108	34
108	6
108	7
109	11
110	9
110	10
110	6
110	7
111	16
111	18
111	130
111	97
111	50
111	131
112	20
112	132
112	101
112	100
113	133
113	134
113	26
114	12
114	95
115	14
115	15
116	135
118	136
118	137
119	138
119	139
120	140
120	5
120	30
120	31
120	102
120	33
120	105
120	32
120	37
120	35
120	29
120	38
121	40
121	109
122	41
122	42
122	141
122	142
122	143
122	44
122	110
123	48
123	47
123	45
123	46
124	113
124	99
124	67
124	144
125	133
125	134
125	26
126	16
126	145
126	146
126	147
127	59
127	51
127	63
127	21
128	148
128	149
128	150
128	151
129	69
129	68
130	41
130	42
131	70
131	71
131	152
131	77
132	112
133	153
133	154
134	155
135	57
135	58
136	61
137	62
138	73
139	75
139	124
139	123
139	156
140	80
140	81
141	82
141	157
141	158
141	50
142	83
142	17
142	19
142	114
142	159
143	74
144	78
145	79
146	117
146	118
147	160
148	120
148	161
149	162
150	65
150	66
151	29
151	102
151	35
151	104
152	3
152	4
153	9
153	10
153	34
154	9
154	10
154	34
155	11
156	9
156	10
156	34
157	16
157	163
157	164
157	18
158	20
158	100
158	132
159	23
159	26
159	165
160	12
161	14
161	15
162	136
162	137
163	138
164	28
164	106
164	166
164	30
164	31
164	167
164	168
164	169
164	105
164	32
164	40
164	33
164	128
164	129
164	5
164	37
164	170
164	39
164	38
165	109
166	41
166	171
166	172
166	156
166	44
167	45
167	46
167	145
167	47
167	173
167	174
168	113
168	21
168	22
169	23
169	26
169	165
170	16
170	50
171	59
171	63
171	50
172	148
172	149
173	68
173	69
174	41
174	172
174	156
175	71
175	70
175	72
175	115
175	85
176	175
177	153
177	154
178	48
179	52
180	58
180	57
181	61
181	176
182	62
183	73
184	75
184	124
184	123
185	80
185	81
186	82
186	157
186	177
187	17
187	76
187	97
188	74
189	79
190	118
190	117
191	86
191	87
192	65
192	66
193	2
194	2
195	4
195	3
196	9
196	10
196	34
196	178
197	9
197	34
199	9
199	10
199	34
199	178
200	16
200	18
200	179
200	165
200	180
200	181
200	182
200	183
201	101
201	100
201	20
201	132
202	23
202	26
202	184
203	12
204	136
205	28
205	128
205	129
205	185
205	30
205	31
205	102
205	35
205	104
205	186
205	90
205	91
205	5
205	187
205	188
205	167
205	168
205	169
205	29
205	105
205	39
205	38
206	41
206	189
206	190
206	44
207	45
207	46
207	47
208	76
208	191
209	113
209	67
210	23
210	25
210	26
210	184
211	16
211	50
211	18
212	59
212	63
212	50
212	21
212	64
213	148
213	149
214	68
214	69
214	192
215	41
216	71
216	70
216	152
216	72
217	193
217	194
217	195
218	193
218	194
218	195
219	57
219	58
220	63
221	61
222	196
223	62
224	197
225	198
226	172
226	124
226	123
227	80
227	81
228	82
228	157
228	97
229	133
229	156
230	145
231	75
232	74
233	199
233	200
234	79
235	118
235	117
236	17
237	65
237	66
238	2
239	2
240	201
241	4
241	3
241	31
241	30
241	9
241	10
242	9
242	10
243	9
243	10
244	9
244	10
245	202
245	203
246	133
246	204
247	20
247	100
248	16
248	165
249	12
249	95
250	131
251	179
252	144
253	136
254	205
255	50
256	206
257	207
258	38
258	37
258	102
258	208
258	29
258	34
258	28
258	128
258	30
258	31
258	209
258	210
258	211
258	212
258	213
258	5
258	187
258	105
258	214
258	215
259	40
260	91
260	90
261	41
261	216
262	47
262	48
263	45
263	46
264	76
264	191
265	172
266	67
267	16
267	165
268	132
269	16
270	59
270	63
271	148
271	149
272	69
272	68
272	192
273	76
273	191
274	71
274	70
275	153
275	154
276	52
277	55
277	56
278	193
278	195
279	193
279	195
280	193
280	195
281	63
282	181
282	182
282	183
283	217
283	218
284	61
285	62
286	197
287	51
288	67
289	198
290	145
290	219
291	75
292	80
292	81
293	97
294	82
294	123
294	124
295	156
295	220
297	74
298	221
298	222
299	79
300	118
300	117
301	18
302	177
303	17
304	19
305	159
306	86
306	87
307	223
308	224
309	172
310	172
311	4
312	201
313	4
314	30
314	31
315	9
315	10
315	225
316	9
316	10
316	225
317	202
317	203
318	226
318	227
319	131
320	133
321	20
321	100
321	132
322	144
323	16
324	12
325	135
326	179
327	136
328	138
329	128
330	28
330	29
331	228
331	105
331	214
332	30
332	31
333	5
333	229
334	211
334	209
334	210
334	212
335	38
335	230
336	90
336	91
337	41
337	179
337	50
337	44
337	110
338	41
339	41
340	47
340	123
340	45
341	76
341	231
342	113
343	16
344	16
345	59
345	63
345	64
346	217
346	218
347	148
347	149
348	76
349	84
350	153
350	154
351	55
351	56
352	194
352	193
353	194
353	193
354	217
354	218
355	217
355	218
356	62
357	45
357	46
358	97
359	75
359	232
360	233
361	67
362	19
363	156
363	220
364	71
364	70
365	71
365	70
366	233
367	74
368	234
369	222
369	221
370	118
370	117
371	18
372	177
373	17
374	19
375	235
375	236
376	86
376	87
376	237
377	223
379	172
379	187
380	3
380	5
380	188
381	201
382	30
382	31
383	226
384	3
384	5
384	188
385	9
385	10
386	9
386	10
387	202
387	203
388	226
389	133
389	123
389	124
390	238
390	100
390	20
390	132
391	16
391	165
392	12
393	239
394	136
394	137
395	50
396	240
397	28
397	241
397	29
397	215
398	105
398	32
398	228
398	214
399	30
399	31
400	34
400	242
401	230
401	38
401	102
401	39
402	211
402	209
402	243
402	244
402	212
402	210
403	40
404	90
404	91
405	140
405	245
405	179
405	44
405	110
406	246
407	45
407	46
407	47
408	144
409	113
409	152
409	247
410	59
410	64
410	50
411	248
411	148
411	149
411	249
411	250
412	144
413	84
413	83
413	246
414	153
414	154
415	55
416	251
417	18
418	252
419	253
419	254
420	67
420	181
420	183
421	80
421	81
422	144
422	82
423	156
423	97
423	255
424	233
425	74
426	221
426	222
427	17
428	256
429	19
430	235
430	236
431	165
432	86
432	87
433	4
433	104
434	172
434	187
435	3
435	257
435	188
436	4
436	104
437	3
437	257
437	188
438	9
438	10
439	31
439	30
439	258
440	9
440	10
441	201
442	259
442	260
442	261
443	100
443	132
443	101
443	20
444	16
444	262
444	263
444	264
445	12
446	136
447	50
448	28
448	265
448	29
448	215
448	266
449	105
449	32
449	228
449	214
450	31
450	30
450	258
451	34
452	230
452	102
452	39
452	38
453	211
453	209
453	210
453	244
453	212
453	243
454	90
454	91
455	267
456	167
456	110
456	44
456	168
457	47
457	179
458	47
458	48
458	179
459	47
459	179
460	268
460	181
460	67
461	59
461	63
461	269
462	149
462	148
463	47
463	179
464	19
464	83
465	74
466	123
466	124
466	22
467	264
467	270
468	80
468	81
469	233
470	82
470	271
470	272
470	165
471	273
471	75
471	274
472	222
472	221
473	156
474	18
475	17
476	256
477	87
477	86
\.


--
-- Dependencies: 215
-- Data for Name: observations; Type: TABLE DATA; Schema: public; Owner: ezra
--

COPY public.observations (id, number, taxon_id, checklist_id, count_week, notes, survey_id, sector_id) FROM stdin;
1	480	7	1	\N	\N	1	\N
10	25	28	1	\N	\N	1	\N
100	103	196	1	\N	\N	1	\N
1000	223	83	9	\N	\N	9	\N
10000	4	191	325	\N	\N	23	3
10001	1	194	325	\N	\N	23	3
10002	3	196	325	\N	\N	23	3
10003	8	204	325	\N	3 male, 5 female	23	3
10004	150	207	325	\N	\N	23	3
10005	1	208	325	\N	\N	23	3
10006	1	131	326	\N	\N	23	3
10007	2	137	326	\N	\N	23	3
10008	1	153	326	\N	\N	23	3
10009	1	156	326	\N	\N	23	3
1001	90	86	9	\N	\N	9	\N
10010	4	158	326	\N	\N	23	3
10011	1	161	326	\N	\N	23	3
10012	1	171	326	\N	\N	23	3
10013	24	174	326	\N	\N	23	3
10014	1	175	326	\N	\N	23	3
10015	18	178	326	\N	\N	23	3
10016	12	189	326	\N	\N	23	3
10017	3	194	326	\N	\N	23	3
10018	2	196	326	\N	\N	23	3
10019	15	207	326	\N	\N	23	3
1002	5	87	9	\N	\N	9	\N
10020	21	131	327	\N	\N	23	3
10021	2	131	328	\N	\N	23	3
10022	6	156	328	\N	\N	23	3
10023	5	158	328	\N	\N	23	3
10024	3	161	328	\N	\N	23	3
10025	1	75	328	\N	\N	23	3
10026	1	173	328	\N	\N	23	3
10027	5	174	328	\N	\N	23	3
10028	3	175	328	\N	\N	23	3
10029	7	189	328	\N	\N	23	3
1003	1	88	9	\N	\N	9	\N
10030	2	194	328	\N	\N	23	3
10031	4	196	328	\N	\N	23	3
10032	4	207	328	\N	\N	23	3
10033	1	210	328	\N	\N	23	3
10034	22	18	329	\N	\N	23	7
10035	3	20	329	\N	\N	23	7
10036	1	39	329	\N	\N	23	7
10037	2	44	329	\N	\N	23	7
10038	2	137	329	\N	\N	23	7
10039	9	151	329	\N	\N	23	7
1004	34	89	9	\N	\N	9	\N
10040	11	153	329	\N	\N	23	7
10041	1	154	329	\N	\N	23	7
10042	1	164	329	\N	\N	23	7
10043	27	66	329	\N	\N	23	7
10044	1	76	329	\N	Heard only, arbitrarily assigned as adult	23	7
10045	1	79	329	\N	Seen by Diane Yorgason-Quinn and Faye McAdams Hands while driving through this area	23	7
10046	7	112	329	\N	\N	23	7
10047	1	171	329	\N	\N	23	7
10048	1	173	329	\N	\N	23	7
10049	25	174	329	\N	\N	23	7
1005	1	90	9	\N	\N	9	\N
10050	6	175	329	\N	\N	23	7
10051	67	176	329	\N	\N	23	7
10052	1	186	329	\N	\N	23	7
10053	1	188	329	\N	\N	23	7
10054	42	189	329	\N	\N	23	7
10055	11	194	329	\N	\N	23	7
10056	15	196	329	\N	\N	23	7
10057	3	199	329	\N	\N	23	7
10058	3	211	329	\N	\N	23	7
10059	59	7	330	\N	\N	23	7
1006	29	91	9	\N	\N	9	\N
10060	4	18	330	\N	\N	23	7
10061	81	20	330	\N	\N	23	7
10062	4	24	330	\N	\N	23	7
10063	3	28	330	\N	\N	23	7
10064	32	29	330	\N	\N	23	7
10065	4	33	330	\N	\N	23	7
10066	538	34	330	\N	\N	23	7
10067	1	35	330	\N	\N	23	7
10068	86	39	330	\N	\N	23	7
10069	55	40	330	\N	\N	23	7
1007	3	95	9	\N	\N	9	\N
10070	5	41	330	\N	\N	23	7
10071	1	43	330	\N	\N	23	7
10072	63	45	330	\N	\N	23	7
10073	13	59	330	\N	\N	23	7
10074	4	131	330	\N	\N	23	7
10075	5	86	330	\N	\N	23	7
10076	1	107	330	\N	\N	23	7
10077	13	112	330	\N	\N	23	7
10078	1	113	330	\N	\N	23	7
10079	40	114	330	\N	\N	23	7
1008	29	99	9	\N	\N	9	\N
10080	5	66	330	\N	\N	23	7
10081	1	69	330	\N	\N	23	7
10082	2	76	330	\N	Purdy Spit: 2 adult	23	7
10083	1	79	330	\N	\N	23	7
10084	2	132	330	\N	\N	23	7
10085	2	141	330	\N	\N	23	7
10086	4	137	330	\N	\N	23	7
10087	11	151	330	\N	\N	23	7
10088	42	153	330	\N	\N	23	7
10089	17	156	330	\N	\N	23	7
1009	15	100	9	\N	\N	9	\N
10090	5	158	330	\N	\N	23	7
10091	6	160	330	\N	\N	23	7
10092	1	171	330	\N	\N	23	7
10093	6	170	330	\N	\N	23	7
10094	1	167	330	\N	\N	23	7
10095	13	176	330	\N	\N	23	7
10096	1	175	330	\N	\N	23	7
10097	36	174	330	\N	\N	23	7
10098	214	207	330	\N	\N	23	7
10099	1	186	330	\N	\N	23	7
101	16	199	1	\N	\N	1	\N
1010	2	101	9	\N	\N	9	\N
10100	16	187	330	\N	\N	23	7
10101	7	194	330	\N	\N	23	7
10102	2	196	330	\N	\N	23	7
10103	4	199	330	\N	\N	23	7
10104	4	131	331	\N	14106 79th Avenue Ct NW, Gig Harbor: Yard	23	7
10105	1	134	331	\N	14106 79th Avenue Ct NW, Gig Harbor: In pine on trunk feeding at gate Springfield dr. 12’ overhead, clear view, white slash on side, red head, black/white spotty/streaky back, pecking to feed but no loud drumming.	23	7
10106	6	137	331	\N	14106 79th Avenue Ct NW, Gig Harbor: In two yards 3 + 3	23	7
10107	7	151	331	\N	14106 79th Avenue Ct NW, Gig Harbor: Heard on cushman line and seen in yards	23	7
10108	2	156	331	\N	\N	23	7
10109	3	158	331	\N	\N	23	7
1011	18	103	9	\N	\N	9	\N
10110	26	160	331	\N	14106 79th Avenue Ct NW, Gig Harbor: 12 In shallow residual snow feeding on rough hillside ground off 82nd and power line intersection, 14 in yard on and near suet feeders. Long observation and definite ID by homeowner-observers familiar with the species.	23	7
10111	2	161	331	\N	14106 79th Avenue Ct NW, Gig Harbor: Feeder 2 yards	23	7
10112	4	175	331	\N	14106 79th Avenue Ct NW, Gig Harbor: Backyard feeders males and females	23	7
10113	3	204	331	\N	14106 79th Avenue Ct NW, Gig Harbor: Feeder yard	23	7
10114	30	207	331	\N	14106 79th Avenue Ct NW, Gig Harbor: Two yards with feeders	23	7
10115	29	187	331	\N	14106 79th Avenue Ct NW, Gig Harbor: 10+19 in two yards	23	7
10116	2	191	331	\N	14106 79th Avenue Ct NW, Gig Harbor: Feeder under bushes	23	7
10117	7	194	331	\N	14106 79th Avenue Ct NW, Gig Harbor: 4 in Feeder yards + 3 on power line trail	23	7
10118	6	196	331	\N	14106 79th Avenue Ct NW, Gig Harbor: Pair behind feeders, foraging, 4 at feeder	23	7
10119	8	15	332	\N	\N	23	7
1012	467	106	9	\N	\N	9	\N
10120	2	18	332	\N	\N	23	7
10121	54	20	332	\N	\N	23	7
10122	13	28	332	\N	\N	23	7
10123	3	39	332	\N	\N	23	7
10124	4	43	332	\N	\N	23	7
10125	1	58	332	\N	\N	23	7
10126	2	131	332	\N	\N	23	7
10127	1	79	332	\N	\N	23	7
10128	1	134	332	\N	\N	23	7
10129	2	135	332	\N	\N	23	7
1013	4	108	9	\N	\N	9	\N
10130	1	137	332	\N	\N	23	7
10131	3	139	332	\N	\N	23	7
10132	23	151	332	\N	\N	23	7
10133	7	153	332	\N	\N	23	7
10134	1	154	332	\N	\N	23	7
10135	18	156	332	\N	\N	23	7
10136	8	158	332	\N	\N	23	7
10137	4	160	332	\N	\N	23	7
10138	1	170	332	\N	\N	23	7
10139	4	161	332	\N	\N	23	7
1014	4	109	9	\N	\N	9	\N
10140	15	175	332	\N	\N	23	7
10141	21	174	332	\N	\N	23	7
10142	2	186	332	\N	\N	23	7
10143	62	187	332	\N	\N	23	7
10144	27	194	332	\N	\N	23	7
10145	16	196	332	\N	\N	23	7
10146	6	7	333	\N	\N	23	7
10147	1	15	333	\N	\N	23	7
10148	1	18	333	\N	\N	23	7
10149	2	20	333	\N	\N	23	7
1015	4	111	9	\N	\N	9	\N
10150	1	22	333	\N	\N	23	7
10151	7	28	333	\N	\N	23	7
10152	4	39	333	\N	\N	23	7
10153	3	43	333	\N	\N	23	7
10154	1	131	333	\N	\N	23	7
10155	1	135	333	\N	\N	23	7
10156	2	137	333	\N	\N	23	7
10157	3	151	333	\N	\N	23	7
10158	19	153	333	\N	\N	23	7
10159	1	154	333	\N	\N	23	7
1016	989	112	9	\N	\N	9	\N
10160	21	156	333	\N	\N	23	7
10161	4	164	333	\N	\N	23	7
10162	1	167	333	\N	\N	23	7
10163	2	66	333	\N	\N	23	7
10164	4	113	333	\N	\N	23	7
10165	47	170	333	\N	\N	23	7
10166	24	174	333	\N	\N	23	7
10167	1	175	333	\N	\N	23	7
10168	3	176	333	\N	\N	23	7
10169	2	186	333	\N	\N	23	7
1017	93	113	9	\N	\N	9	\N
10170	29	189	333	\N	\N	23	7
10171	1	191	333	\N	\N	23	7
10172	7	194	333	\N	\N	23	7
10173	1	196	333	\N	\N	23	7
10174	3	207	333	\N	\N	23	7
10175	3	18	334	\N	\N	23	7
10176	102	20	334	\N	\N	23	7
10177	2	39	334	\N	\N	23	7
10178	5	43	334	\N	\N	23	7
10179	6	131	334	\N	\N	23	7
1018	367	116	9	\N	\N	9	\N
10180	2	137	334	\N	\N	23	7
10181	1	151	334	\N	\N	23	7
10182	24	153	334	\N	\N	23	7
10183	9	156	334	\N	\N	23	7
10184	8	158	334	\N	\N	23	7
10185	1	161	334	\N	\N	23	7
10186	1	69	334	\N	\N	23	7
10187	1	73	334	\N	\N	23	7
10188	5	112	334	\N	\N	23	7
10189	1	170	334	\N	\N	23	7
1019	246	117	9	\N	\N	9	\N
10190	68	174	334	\N	\N	23	7
10191	3	175	334	\N	\N	23	7
10192	15	176	334	\N	\N	23	7
10193	1	184	334	\N	\N	23	7
10194	4	186	334	\N	\N	23	7
10195	83	189	334	\N	\N	23	7
10196	3	191	334	\N	\N	23	7
10197	19	194	334	\N	\N	23	7
10198	7	196	334	\N	\N	23	7
10199	6	205	334	\N	\N	23	7
102	95	204	1	\N	\N	1	\N
1020	39	118	9	\N	\N	9	\N
10200	8	207	334	\N	\N	23	7
10201	1	2	335	\N	\N	23	7
10202	1	6	335	\N	\N	23	7
10203	40	7	335	\N	\N	23	7
10204	41	18	335	\N	\N	23	7
10205	47	20	335	\N	\N	23	7
10206	4	23	335	\N	\N	23	7
10207	3	39	335	\N	\N	23	7
10208	5	40	335	\N	\N	23	7
10209	1	43	335	\N	\N	23	7
1021	17	120	9	\N	\N	9	\N
10210	13	44	335	\N	\N	23	7
10211	42	45	335	\N	\N	23	7
10212	1	59	335	\N	\N	23	7
10213	2	117	335	\N	\N	23	7
10214	4	131	335	\N	\N	23	7
10215	14	106	335	\N	\N	23	7
10216	35	112	335	\N	\N	23	7
10217	9	66	335	\N	\N	23	7
10218	1	72	335	\N	\N	23	7
10219	1	76	335	\N	\N	23	7
1022	1	123	9	\N	\N	9	\N
10220	1	77	335	\N	\N	23	7
10221	1	79	335	\N	\N	23	7
10222	2	134	335	\N	\N	23	7
10223	2	136	335	\N	\N	23	7
10224	2	137	335	\N	\N	23	7
10225	9	139	335	\N	\N	23	7
10226	10	151	335	\N	\N	23	7
10227	45	153	335	\N	\N	23	7
10228	2	154	335	\N	\N	23	7
10229	20	156	335	\N	\N	23	7
1023	2	124	9	\N	\N	9	\N
10230	6	158	335	\N	\N	23	7
10231	1	171	335	\N	\N	23	7
10232	11	170	335	\N	\N	23	7
10233	2	161	335	\N	\N	23	7
10234	2	167	335	\N	\N	23	7
10235	14	176	335	\N	\N	23	7
10236	4	175	335	\N	\N	23	7
10237	1	173	335	\N	\N	23	7
10238	69	174	335	\N	\N	23	7
10239	1	204	335	\N	\N	23	7
1024	\N	126	9	t	\N	9	\N
10240	37	207	335	\N	\N	23	7
10241	1	186	335	\N	\N	23	7
10242	57	189	335	\N	\N	23	7
10243	7	191	335	\N	\N	23	7
10244	7	194	335	\N	\N	23	7
10245	8	196	335	\N	\N	23	7
10246	\N	131	336	t	\N	23	7
10247	\N	134	336	t	\N	23	7
10248	1	135	336	\N	\N	23	7
10249	2	137	336	\N	\N	23	7
1025	63	131	9	\N	\N	9	\N
10250	1	141	336	\N	\N	23	7
10251	2	151	336	\N	\N	23	7
10252	1	156	336	\N	\N	23	7
10253	1	158	336	\N	\N	23	7
10254	\N	160	336	t	\N	23	7
10255	\N	161	336	t	\N	23	7
10256	\N	175	336	t	\N	23	7
10257	\N	176	336	t	\N	23	7
10258	1	184	336	\N	\N	23	7
10259	5	189	336	\N	\N	23	7
1026	11	132	9	\N	\N	9	\N
10260	\N	191	336	t	\N	23	7
10261	1	197	336	\N	\N	23	7
10262	\N	204	336	t	\N	23	7
10263	2	207	336	\N	\N	23	7
10264	64	7	337	\N	\N	23	4
10265	3	18	337	\N	\N	23	4
10266	10	20	337	\N	\N	23	4
10267	6	29	337	\N	\N	23	4
10268	252	34	337	\N	\N	23	4
10269	144	35	337	\N	Quartermaster Harbor: Real count.	23	4
1027	1	134	9	\N	\N	9	\N
10270	116	39	337	\N	\N	23	4
10271	164	40	337	\N	\N	23	4
10272	74	41	337	\N	\N	23	4
10273	76	44	337	\N	\N	23	4
10274	71	45	337	\N	\N	23	4
10275	2	43	337	\N	Quartermaster Harbor: 2 from Anne Bell & Charlie Crow	23	4
10276	13	46	337	\N	Quartermaster Harbor: Real count.	23	4
10277	74	59	337	\N	\N	23	4
10278	1	60	337	\N	\N	23	4
10279	2	61	337	\N	\N	23	4
1028	23	135	9	\N	\N	9	\N
10280	1	103	337	\N	\N	23	4
10281	16	106	337	\N	\N	23	4
10282	34	112	337	\N	\N	23	4
10283	9	53	337	\N	\N	23	4
10284	3	55	337	\N	\N	23	4
10285	46	65	337	\N	\N	23	4
10286	2	67	337	\N	\N	23	4
10287	12	66	337	\N	\N	23	4
10288	2	76	337	\N	\N	23	4
10289	1	132	337	\N	\N	23	4
1029	8	136	9	\N	\N	9	\N
10290	6	153	337	\N	\N	23	4
10291	2	154	337	\N	\N	23	4
10292	0	33	338	\N	North Vashon Ferry Terminal: Originally 2, adjusted to 0 due to duplication w/ primary team	23	1
10293	3	34	338	\N	North Vashon Ferry Terminal: Originally 18, adjusted to 3 due to duplication w/ primary team	23	1
10294	8	39	338	\N	North Vashon Ferry Terminal: Originally 13, adjusted to 8 due to duplication w/ primary team	23	1
10295	0	40	338	\N	North Vashon Ferry Terminal: Originally 2, adjusted to 0 due to duplication w/ primary team	23	1
10296	0	45	338	\N	North Vashon Ferry Terminal: Originally 8, adjusted to 0 due to duplication w/ primary team	23	1
10297	0	59	338	\N	North Vashon Ferry Terminal: Originally 21, adjusted to 0 due to duplication w/ primary team	23	1
10298	8	60	338	\N	\N	23	1
10299	7	100	338	\N	\N	23	1
103	13	205	1	\N	\N	1	\N
1030	99	139	9	\N	\N	9	\N
10300	1	103	338	\N	\N	23	1
10301	2	106	338	\N	\N	23	1
10302	23	112	338	\N	\N	23	1
10303	1	55	338	\N	North Vashon Ferry Terminal: Originally 2, adjusted to 1 due to duplication w/ primary team	23	1
10304	10	65	338	\N	North Vashon Ferry Terminal: Originally 17, adjusted to 10 due to duplication w/ primary team	23	1
10305	4	67	338	\N	North Vashon Ferry Terminal: Originally 6, adjusted to 4 due to duplication w/ primary team	23	1
10306	2	66	338	\N	North Vashon Ferry Terminal: Originally 5, adjusted to 2 due to duplication w/ primary team	23	1
10307	1	69	338	\N	\N	23	1
10308	1	76	338	\N	\N	23	1
10309	14	62	339	\N	\N	23	1
1031	10	141	9	\N	\N	9	\N
10310	2	55	339	\N	\N	23	1
10311	2	33	340	\N	North Vashon Ferry Terminal: W of V dock	23	1
10312	15	34	340	\N	\N	23	1
10313	5	39	340	\N	\N	23	1
10314	5	40	340	\N	\N	23	1
10315	2	41	340	\N	\N	23	1
10316	9	45	340	\N	\N	23	1
10317	27	59	340	\N	\N	23	1
10318	1	117	340	\N	\N	23	1
10319	1	131	340	\N	\N	23	1
1032	1	143	9	\N	\N	9	\N
10320	0	100	340	\N	North Vashon Ferry Terminal: Sarah saw 6 one day ago 1.2.2022	23	1
10321	1	55	340	\N	\N	23	1
10322	7	65	340	\N	\N	23	1
10323	2	67	340	\N	\N	23	1
10324	3	66	340	\N	\N	23	1
10325	0	68	340	\N	North Vashon Ferry Terminal: Adjusted to 0 due to using higher cormorant species numbers from ferry dock visit by other team	23	1
10326	1	76	340	\N	\N	23	1
10327	3	137	340	\N	\N	23	1
10328	4	151	340	\N	\N	23	1
10329	6	153	340	\N	\N	23	1
1033	2	144	9	\N	\N	9	\N
10330	1	156	340	\N	\N	23	1
10331	26	158	340	\N	\N	23	1
10332	3	159	340	\N	Fisher Pond, Vashon Island: Audible only	23	1
10333	1	171	340	\N	\N	23	1
10334	3	161	340	\N	\N	23	1
10335	1	175	340	\N	\N	23	1
10336	1	174	340	\N	\N	23	1
10337	1	211	340	\N	\N	23	1
10338	2	205	340	\N	\N	23	1
10339	44	207	340	\N	\N	23	1
1034	2	145	9	\N	\N	9	\N
10340	2	186	340	\N	\N	23	1
10341	50	187	340	\N	\N	23	1
10342	10	191	340	\N	\N	23	1
10343	9	194	340	\N	Fisher Pond, Vashon Island: Video of each sparrow exploring the water's edge.	23	1
10344	4	196	340	\N	\N	23	1
10345	2	199	340	\N	Fisher Pond, Vashon Island: On cattails!	23	1
10346	1	126	340	\N	Margie Morgan: Heard by Margie Morgan at her house, which is located in the VN Central area	23	1
10347	15	7	341	\N	flyover	23	1
10348	1	20	341	\N	\N	23	1
10349	1	153	341	\N	\N	23	1
1035	5	149	9	\N	\N	9	\N
10350	2	154	341	\N	\N	23	1
10351	7	156	341	\N	\N	23	1
10352	3	158	341	\N	\N	23	1
10353	10	160	341	\N	\N	23	1
10354	1	161	341	\N	\N	23	1
10355	1	167	341	\N	\N	23	1
10356	1	73	341	\N	\N	23	1
10357	1	170	341	\N	\N	23	1
10358	20	174	341	\N	\N	23	1
10359	18	189	341	\N	\N	23	1
1036	102	151	9	\N	\N	9	\N
10360	1	191	341	\N	\N	23	1
10361	8	194	341	\N	\N	23	1
10362	4	196	341	\N	\N	23	1
10363	3	204	341	\N	\N	23	1
10364	102	207	341	\N	\N	23	1
10365	1	33	342	\N	\N	23	1
10366	8	34	342	\N	\N	23	1
10367	34	39	342	\N	\N	23	1
10368	13	40	342	\N	\N	23	1
10369	15	45	342	\N	\N	23	1
1037	1127	153	9	\N	\N	9	\N
10370	1	53	342	\N	\N	23	1
10371	4	55	342	\N	\N	23	1
10372	24	59	342	\N	\N	23	1
10373	21	60	342	\N	\N	23	1
10374	2	119	342	\N	\N	23	1
10375	2	131	342	\N	\N	23	1
10376	2	134	342	\N	\N	23	1
10377	2	135	342	\N	\N	23	1
10378	7	137	342	\N	\N	23	1
10379	1	144	342	\N	\N	23	1
1038	19	154	9	\N	\N	9	\N
10380	16	151	342	\N	\N	23	1
10381	6	153	342	\N	\N	23	1
10382	5	154	342	\N	\N	23	1
10383	5	156	342	\N	\N	23	1
10384	31	158	342	\N	\N	23	1
10385	2	161	342	\N	\N	23	1
10386	5	164	342	\N	\N	23	1
10387	1	65	342	\N	\N	23	1
10388	8	66	342	\N	\N	23	1
10389	1	67	342	\N	\N	23	1
1039	256	156	9	\N	\N	9	\N
10390	1	69	342	\N	\N	23	1
10391	5	76	342	\N	\N	23	1
10392	1	79	342	\N	\N	23	1
10393	9	86	342	\N	\N	23	1
10394	3	91	342	\N	\N	23	1
10395	2	100	342	\N	\N	23	1
10396	1	103	342	\N	\N	23	1
10397	43	106	342	\N	\N	23	1
10398	5	112	342	\N	\N	23	1
10399	19	113	342	\N	\N	23	1
104	82	206	1	\N	\N	1	\N
1040	223	158	9	\N	\N	9	\N
10400	29	114	342	\N	\N	23	1
10401	1	116	342	\N	\N	23	1
10402	7	170	342	\N	\N	23	1
10403	5	171	342	\N	\N	23	1
10404	409	174	342	\N	\N	23	1
10405	51	175	342	\N	\N	23	1
10406	35	176	342	\N	\N	23	1
10407	14	186	342	\N	\N	23	1
10408	113	189	342	\N	\N	23	1
10409	21	191	342	\N	\N	23	1
1041	51	160	9	\N	\N	9	\N
10410	27	194	342	\N	\N	23	1
10411	9	196	342	\N	\N	23	1
10412	17	204	342	\N	\N	23	1
10413	64	207	342	\N	\N	23	1
10414	2	140	342	\N	\N	23	1
10415	0	5	343	\N	\N	23	1
10416	36	18	343	\N	\N	23	1
10417	6	20	343	\N	\N	23	1
10418	0	29	343	\N	\N	23	1
10419	0	34	343	\N	\N	23	1
1042	49	161	9	\N	\N	9	\N
10420	0	35	343	\N	\N	23	1
10421	1	39	343	\N	\N	23	1
10422	0	40	343	\N	\N	23	1
10423	0	41	343	\N	\N	23	1
10424	0	45	343	\N	\N	23	1
10425	0	59	343	\N	\N	23	1
10426	0	60	343	\N	\N	23	1
10427	0	61	343	\N	\N	23	1
10428	5	117	343	\N	\N	23	1
10429	4	131	343	\N	\N	23	1
1043	11	163	9	\N	\N	9	\N
10430	0	82	343	\N	Ellisport, Vashon: 1 responded to playback - "poached" at Ellis Creek Natural Area in VS East area	23	1
10431	3	86	343	\N	\N	23	1
10432	0	100	343	\N	\N	23	1
10433	0	103	343	\N	\N	23	1
10434	0	106	343	\N	\N	23	1
10435	1	107	343	\N	\N	23	1
10436	0	112	343	\N	\N	23	1
10437	0	113	343	\N	\N	23	1
10438	1	114	343	\N	\N	23	1
10439	0	54	343	\N	\N	23	1
1044	60	165	9	\N	\N	9	\N
10440	0	55	343	\N	\N	23	1
10441	0	66	343	\N	\N	23	1
10442	0	69	343	\N	\N	23	1
10443	1	77	343	\N	Chautauqua Beach Neighborhood, Vashon: Immature	23	1
10444	0	132	343	\N	\N	23	1
10445	3	139	343	\N	\N	23	1
10446	1	151	343	\N	\N	23	1
10447	23	153	343	\N	\N	23	1
10448	2	156	343	\N	\N	23	1
10449	3	158	343	\N	\N	23	1
1045	1	166	9	\N	\N	9	\N
10450	1	171	343	\N	\N	23	1
10451	1	164	343	\N	\N	23	1
10452	2	167	343	\N	\N	23	1
10453	5	176	343	\N	\N	23	1
10454	51	174	343	\N	\N	23	1
10455	10	211	343	\N	\N	23	1
10456	2	204	343	\N	\N	23	1
10457	1	205	343	\N	\N	23	1
10458	213	207	343	\N	\N	23	1
10459	7	186	343	\N	\N	23	1
1046	34	167	9	\N	\N	9	\N
10460	9	189	343	\N	\N	23	1
10461	1	190	343	\N	\N	23	1
10462	2	191	343	\N	\N	23	1
10463	6	194	343	\N	\N	23	1
10464	4	196	343	\N	\N	23	1
10465	1	181	343	\N	\N	23	1
10466	2	183	343	\N	\N	23	1
10467	1	126	344	\N	Vashon--Island Center Forest: Heard immediately after NSWO response from further north	23	1
10468	1	129	344	\N	Vashon--Island Center Forest: Responded to playback	23	1
10469	4	7	345	\N	\N	23	1
1047	236	170	9	\N	\N	9	\N
10470	6	117	345	\N	\N	23	1
10471	1	131	345	\N	\N	23	1
10472	5	134	345	\N	\N	23	1
10473	3	137	345	\N	\N	23	1
10474	1	143	345	\N	\N	23	1
10475	9	153	345	\N	\N	23	1
10476	2	154	345	\N	\N	23	1
10477	12	156	345	\N	\N	23	1
10478	8	158	345	\N	\N	23	1
10479	1	161	345	\N	\N	23	1
1048	58	171	9	\N	\N	9	\N
10480	3	163	345	\N	\N	23	1
10481	8	164	345	\N	\N	23	1
10482	1	167	345	\N	\N	23	1
10483	1	76	345	\N	\N	23	1
10484	1	77	345	\N	\N	23	1
10485	1	79	345	\N	\N	23	1
10486	17	48	345	\N	Flying high overhead	23	1
10487	10	170	345	\N	\N	23	1
10488	1	171	345	\N	\N	23	1
10489	1	173	345	\N	\N	23	1
1049	5	173	9	\N	\N	9	\N
10490	103	174	345	\N	\N	23	1
10491	1	175	345	\N	\N	23	1
10492	7	176	345	\N	\N	23	1
10493	33	178	345	\N	\N	23	1
10494	8	186	345	\N	\N	23	1
10495	43	189	345	\N	\N	23	1
10496	24	191	345	\N	\N	23	1
10497	14	194	345	\N	\N	23	1
10498	11	196	345	\N	\N	23	1
10499	3	199	345	\N	\N	23	1
105	618	207	1	\N	\N	1	\N
1050	994	174	9	\N	\N	9	\N
10500	8	204	345	\N	\N	23	1
10501	3	205	345	\N	\N	23	1
10502	215	207	345	\N	\N	23	1
10503	7	211	345	\N	\N	23	1
10504	1	140	345	\N	\N	23	1
10505	1	123	346	\N	\N	23	1
10506	1	17	347	\N	\N	23	1
10507	180	18	347	\N	\N	23	1
10508	113	20	347	\N	\N	23	1
10509	10	33	347	\N	\N	23	1
1051	95	175	9	\N	\N	9	\N
10510	4	34	347	\N	\N	23	1
10511	2	35	347	\N	\N	23	1
10512	21	39	347	\N	\N	23	1
10513	63	40	347	\N	\N	23	1
10514	6	41	347	\N	\N	23	1
10515	5	44	347	\N	\N	23	1
10516	7	45	347	\N	\N	23	1
10517	2	55	347	\N	\N	23	1
10518	9	59	347	\N	\N	23	1
10519	9	60	347	\N	\N	23	1
1052	458	176	9	\N	\N	9	\N
10520	1	132	347	\N	\N	23	1
10521	3	137	347	\N	\N	23	1
10522	5	151	347	\N	\N	23	1
10523	33	153	347	\N	\N	23	1
10524	15	156	347	\N	\N	23	1
10525	7	158	347	\N	\N	23	1
10526	2	161	347	\N	\N	23	1
10527	1	167	347	\N	\N	23	1
10528	1	65	347	\N	\N	23	1
10529	4	66	347	\N	\N	23	1
1053	24	178	9	\N	\N	9	\N
10530	2	69	347	\N	\N	23	1
10531	1	76	347	\N	\N	23	1
10532	1	83	347	\N	\N	23	1
10533	11	86	347	\N	\N	23	1
10534	3	95	347	\N	\N	23	1
10535	1	100	347	\N	\N	23	1
10536	2	106	347	\N	\N	23	1
10537	2	109	347	\N	\N	23	1
10538	1	111	347	\N	\N	23	1
10539	15	112	347	\N	\N	23	1
1054	1	183	9	\N	\N	9	\N
10540	9	113	347	\N	\N	23	1
10541	44	116	347	\N	\N	23	1
10542	5	170	347	\N	\N	23	1
10543	1	171	347	\N	\N	23	1
10544	23	174	347	\N	\N	23	1
10545	1	175	347	\N	\N	23	1
10546	3	186	347	\N	\N	23	1
10547	11	189	347	\N	\N	23	1
10548	1	190	347	\N	\N	23	1
10549	9	191	347	\N	\N	23	1
1055	\N	184	9	t	\N	9	\N
10550	12	194	347	\N	\N	23	1
10551	3	196	347	\N	\N	23	1
10552	1	204	347	\N	\N	23	1
10553	12	207	347	\N	\N	23	1
10554	5	211	347	\N	\N	23	1
10555	2	14	347	\N	\N	23	1
10556	1	177	347	\N	\N	23	1
10557	1	142	347	\N	\N	23	1
10558	\N	172	347	t	Found on eBird checklist: https://ebird.org/checklist/S99781978	23	1
10559	2	119	348	\N	\N	23	1
1056	130	186	9	\N	\N	9	\N
10560	1	151	348	\N	\N	23	1
10561	5	153	348	\N	\N	23	1
10562	2	154	348	\N	\N	23	1
10563	1	156	348	\N	\N	23	1
10564	17	174	348	\N	\N	23	1
10565	1	175	348	\N	\N	23	1
10566	30	176	348	\N	\N	23	1
10567	17	189	348	\N	\N	23	1
10568	16	191	348	\N	\N	23	1
10569	2	194	348	\N	\N	23	1
1057	3	188	9	\N	\N	9	\N
10570	15	199	348	\N	\N	23	1
10571	6	207	348	\N	\N	23	1
10572	10	211	348	\N	\N	23	1
10573	1	9	349	\N	16305 Crescent Dr SW, Vashon: I’ll try to get a pic. All white, orang legs, with CAGO, same size	23	1
10574	24	7	349	\N	\N	23	1
10575	1	20	349	\N	16305 Crescent Dr SW, Vashon: Flying over	23	1
10576	4	34	349	\N	\N	23	1
10577	11	39	349	\N	\N	23	1
10578	39	40	349	\N	\N	23	1
10579	7	41	349	\N	\N	23	1
1058	796	189	9	\N	\N	9	\N
10580	4	46	349	\N	Vashon Island--Fern Cove and Shingle Mill Creek: COME/RBME - Too far and too many waves to distinguish	23	1
10581	26	48	349	\N	16305 Crescent Dr SW, Vashon: Flying over, first 20 med size, second 6 larger	23	1
10582	8	59	349	\N	\N	23	1
10583	1	104	349	\N	\N	23	1
10584	53	106	349	\N	\N	23	1
10585	7	113	349	\N	\N	23	1
10586	4	116	349	\N	16700–16898 137th Ave SW, Vashon: 2 w: Large, black wing tips\nVashon Island--Fern Cove and Shingle Mill Creek: Immature large gull with Oly gulls	23	1
10587	2	66	349	\N	\N	23	1
10588	1	69	349	\N	\N	23	1
10589	2	76	349	\N	\N	23	1
1059	12	190	9	\N	\N	9	\N
10590	1	77	349	\N	\N	23	1
10591	1	134	349	\N	\N	23	1
10592	1	135	349	\N	\N	23	1
10593	2	137	349	\N	16305 Crescent Dr SW, Vashon: Heard only	23	1
10594	16	153	349	\N	\N	23	1
10595	13	158	349	\N	\N	23	1
10596	1	170	349	\N	\N	23	1
10597	1	164	349	\N	\N	23	1
10598	8	176	349	\N	\N	23	1
10599	2	175	349	\N	\N	23	1
106	6	208	1	\N	\N	1	\N
1060	143	191	9	\N	\N	9	\N
10600	38	174	349	\N	\N	23	1
10601	1	210	349	\N	16305 Crescent Dr SW, Vashon: HOFI/PUFI	23	1
10602	1	186	349	\N	\N	23	1
10603	11	187	349	\N	\N	23	1
10604	6	191	349	\N	\N	23	1
10605	8	194	349	\N	\N	23	1
10606	2	196	349	\N	\N	23	1
10607	1	134	350	\N	\N	23	1
10608	1	154	350	\N	\N	23	1
10609	1	160	350	\N	\N	23	1
1061	4	193	9	\N	\N	9	\N
10610	15	189	350	\N	\N	23	1
10611	2	196	350	\N	\N	23	1
10612	1	131	351	\N	\N	23	1
10613	1	137	351	\N	\N	23	1
10614	2	156	351	\N	\N	23	1
10615	5	158	351	\N	\N	23	1
10616	2	161	351	\N	\N	23	1
10617	\N	170	351	t	\N	23	1
10618	2	175	351	\N	\N	23	1
10619	4	189	351	\N	\N	23	1
1062	250	194	9	\N	\N	9	\N
10620	2	194	351	\N	\N	23	1
10621	7	196	351	\N	\N	23	1
10622	2	204	351	\N	\N	23	1
10623	2	205	351	\N	\N	23	1
10624	4	207	351	\N	\N	23	1
10625	1	208	351	\N	\N	23	1
10626	1	174	352	\N	\N	23	1
10627	12	189	352	\N	\N	23	1
10628	2	194	352	\N	\N	23	1
10629	2	196	352	\N	\N	23	1
1063	299	196	9	\N	\N	9	\N
10630	1	156	353	\N	\N	23	1
10631	3	158	353	\N	\N	23	1
10632	2	161	353	\N	\N	23	1
10633	6	174	353	\N	\N	23	1
10634	5	189	353	\N	\N	23	1
10635	1	196	353	\N	\N	23	1
10636	5	207	353	\N	\N	23	1
10637	6	210	353	\N	\N	23	1
10638	\N	118	354	t	\N	23	1
10639	1	131	354	\N	Male	23	1
1064	183	199	9	\N	\N	9	\N
10640	\N	141	354	t	\N	23	1
10641	1	151	354	\N	\N	23	1
10642	1	153	354	\N	\N	23	1
10643	3	156	354	\N	\N	23	1
10644	4	158	354	\N	\N	23	1
10645	2	161	354	\N	\N	23	1
10646	\N	163	354	t	\N	23	1
10647	1	167	354	\N	\N	23	1
10648	1	76	354	\N	\N	23	1
10649	3	170	354	\N	\N	23	1
1065	41	201	9	\N	\N	9	\N
10650	2	174	354	\N	\N	23	1
10651	3	175	354	\N	Males	23	1
10652	3	189	354	\N	\N	23	1
10653	1	196	354	\N	\N	23	1
10654	2	204	354	\N	Males	23	1
10655	0	33	355	\N	3 reported, 2 male, 1 female, removed due to duplication with field team count	23	1
10656	0	39	355	\N	20 reported, 5 male, 15 female, removed due to duplication with field team count	23	1
10657	0	40	355	\N	3 reported, 1 male, 2 female, removed due to duplication with field team count	23	1
10658	0	59	355	\N	7 reported, removed due to duplication with field team count	23	1
10659	1	134	355	\N	\N	23	1
1066	267	204	9	\N	\N	9	\N
10660	2	153	355	\N	\N	23	1
10661	0	66	355	\N	1 reported, removed due to duplication with field team count	23	1
10662	0	116	355	\N	17 reported, removed due to duplication with field team count	23	1
10663	7	7	356	\N	\N	23	1
10664	\N	120	356	t	\N	23	1
10665	3	131	356	\N	\N	23	1
10666	2	137	356	\N	\N	23	1
10667	2	151	356	\N	\N	23	1
10668	\N	153	356	t	\N	23	1
10669	1	156	356	\N	\N	23	1
1067	110	205	9	\N	\N	9	\N
10670	3	158	356	\N	\N	23	1
10671	2	161	356	\N	\N	23	1
10672	1	164	356	\N	\N	23	1
10673	\N	76	356	t	\N	23	1
10674	\N	79	356	t	\N	23	1
10675	\N	170	356	t	\N	23	1
10676	\N	174	356	t	\N	23	1
10677	3	186	356	\N	\N	23	1
10678	40	189	356	\N	\N	23	1
10679	3	191	356	\N	\N	23	1
1068	41	206	9	\N	\N	9	\N
10680	4	194	356	\N	\N	23	1
10681	4	196	356	\N	\N	23	1
10682	2	204	356	\N	\N	23	1
10683	\N	207	356	t	\N	23	1
10684	14	34	357	\N	\N	23	1
10685	2	42	357	\N	\N	23	1
10686	1	77	357	\N	\N	23	1
10687	2	116	357	\N	\N	23	1
10688	6	189	357	\N	\N	23	1
10689	3	194	357	\N	\N	23	1
1069	1238	207	9	\N	\N	9	\N
10690	1	196	357	\N	\N	23	1
10691	1	2	358	\N	\N	23	2
10692	0	7	358	\N	Reported 25, removed due to conflict with primary field team	23	2
10693	3	131	358	\N	\N	23	2
10694	1	134	358	\N	\N	23	2
10695	4	153	358	\N	\N	23	2
10696	1	156	358	\N	\N	23	2
10697	2	158	358	\N	\N	23	2
10698	15	160	358	\N	\N	23	2
10699	2	161	358	\N	\N	23	2
107	24	211	1	\N	\N	1	\N
1070	74	208	9	\N	\N	9	\N
10700	2	76	358	\N	\N	23	2
10701	60	174	358	\N	\N	23	2
10702	9	176	358	\N	\N	23	2
10703	1	186	358	\N	\N	23	2
10704	4	189	358	\N	\N	23	2
10705	4	191	358	\N	\N	23	2
10706	1	194	358	\N	\N	23	2
10707	1	196	358	\N	\N	23	2
10708	1	204	358	\N	\N	23	2
10709	2	207	358	\N	\N	23	2
1071	111	211	9	\N	\N	9	\N
10710	2	208	358	\N	\N	23	2
10711	1	211	358	\N	\N	23	2
10712	44	7	359	\N	\N	23	2
10713	1	16	359	\N	1 from Ezra Parker at Portage Marsh	23	2
10714	7	20	359	\N	\N	23	2
10715	3	23	359	\N	\N	23	2
10716	2	24	359	\N	\N	23	2
10717	1	28	359	\N	\N	23	2
10718	\N	122	359	t	Reported by Laurie Tucker - heard from vicinity of nest box on her property	23	2
10719	8	131	359	\N	\N	23	2
1072	4	2	10	\N	\N	10	\N
10720	\N	132	359	t	\N	23	2
10721	1	134	359	\N	\N	23	2
10722	1	135	359	\N	\N	23	2
10723	13	137	359	\N	\N	23	2
10724	1	144	359	\N	\N	23	2
10725	1	149	359	\N	\N	23	2
10726	6	151	359	\N	\N	23	2
10727	24	153	359	\N	\N	23	2
10728	8	154	359	\N	\N	23	2
10729	33	156	359	\N	\N	23	2
1073	1	5	10	\N	\N	10	\N
10730	31	158	359	\N	\N	23	2
10731	\N	160	359	t	\N	23	2
10732	3	161	359	\N	\N	23	2
10733	5	163	359	\N	\N	23	2
10734	4	164	359	\N	\N	23	2
10735	3	167	359	\N	\N	23	2
10736	1	69	359	\N	\N	23	2
10737	3	76	359	\N	\N	23	2
10738	1	77	359	\N	\N	23	2
10739	3	79	359	\N	\N	23	2
1074	3	6	10	\N	\N	10	\N
10740	2	82	359	\N	1 from Ezra Parker at Ellis Creek Natural Area	23	2
10741	\N	86	359	t	\N	23	2
10742	1	112	359	\N	\N	23	2
10743	11	170	359	\N	\N	23	2
10744	1	171	359	\N	\N	23	2
10745	315	174	359	\N	\N	23	2
10746	9	175	359	\N	\N	23	2
10747	10	176	359	\N	\N	23	2
10748	5	186	359	\N	\N	23	2
10749	207	189	359	\N	\N	23	2
1075	120	7	10	\N	\N	10	\N
10750	13	191	359	\N	\N	23	2
10751	24	194	359	\N	\N	23	2
10752	\N	195	359	t	\N	23	2
10753	29	196	359	\N	\N	23	2
10754	2	199	359	\N	\N	23	2
10755	11	204	359	\N	\N	23	2
10756	174	207	359	\N	\N	23	2
10757	\N	211	359	t	\N	23	2
10758	2	134	360	\N	\N	23	2
10759	1	137	360	\N	\N	23	2
1076	\N	11	10	t	\N	10	\N
10760	1	141	360	\N	\N	23	2
10761	2	153	360	\N	\N	23	2
10762	1	158	360	\N	\N	23	2
10763	2	161	360	\N	\N	23	2
10764	1	163	360	\N	\N	23	2
10765	2	164	360	\N	\N	23	2
10766	1	167	360	\N	\N	23	2
10767	2	170	360	\N	\N	23	2
10768	50	174	360	\N	\N	23	2
10769	4	175	360	\N	\N	23	2
1077	30	15	10	\N	\N	10	\N
10770	4	194	360	\N	\N	23	2
10771	18	34	361	\N	\N	23	2
10772	3	35	361	\N	\N	23	2
10773	22	39	361	\N	\N	23	2
10774	23	40	361	\N	\N	23	2
10775	4	41	361	\N	\N	23	2
10776	4	45	361	\N	\N	23	2
10777	8	59	361	\N	\N	23	2
10778	2	117	361	\N	\N	23	2
10779	2	131	361	\N	\N	23	2
1078	6	16	10	\N	\N	10	\N
10780	1	100	361	\N	\N	23	2
10781	29	112	361	\N	\N	23	2
10782	1	55	361	\N	\N	23	2
10783	3	67	361	\N	\N	23	2
10784	16	66	361	\N	\N	23	2
10785	2	69	361	\N	\N	23	2
10786	4	76	361	\N	Talequah Ferry Terminal: 2 sets of mature pairs	23	2
10787	1	77	361	\N	Pohl Road: Immature	23	2
10788	2	132	361	\N	\N	23	2
10789	3	134	361	\N	\N	23	2
1079	9	17	10	\N	\N	10	\N
10790	3	141	361	\N	\N	23	2
10791	11	137	361	\N	\N	23	2
10792	1	145	361	\N	\N	23	2
10793	2	151	361	\N	\N	23	2
10794	16	153	361	\N	\N	23	2
10795	1	154	361	\N	\N	23	2
10796	4	156	361	\N	\N	23	2
10797	36	158	361	\N	\N	23	2
10798	13	171	361	\N	\N	23	2
10799	14	170	361	\N	\N	23	2
108	230	7	2	\N	\N	2	\N
1080	5029	18	10	\N	\N	10	\N
10800	5	161	361	\N	\N	23	2
10801	1	163	361	\N	\N	23	2
10802	4	164	361	\N	\N	23	2
10803	5	176	361	\N	\N	23	2
10804	32	175	361	\N	\N	23	2
10805	1134	174	361	\N	\N	23	2
10806	30	207	361	\N	\N	23	2
10807	114	187	361	\N	\N	23	2
10808	1	194	361	\N	\N	23	2
10809	2	196	361	\N	\N	23	2
1081	566	20	10	\N	\N	10	\N
10810	2	181	361	\N	\N	23	2
10811	34	7	362	\N	\N	23	2
10812	8	20	362	\N	4 male, 4 female	23	2
10813	5	39	362	\N	\N	23	2
10814	2	154	362	\N	\N	23	2
10815	1	164	362	\N	\N	23	2
10816	0	66	362	\N	2 reported, but duplicated by primary team	23	2
10817	7	68	362	\N	(too far south in water to see species with binocs)	23	2
10818	1	76	362	\N	\N	23	2
10819	0	114	362	\N	2 reported, but duplicated by primary team	23	2
1082	28	22	10	\N	\N	10	\N
10820	12	116	362	\N	\N	23	2
10821	6	189	362	\N	\N	23	2
10822	1	194	362	\N	\N	23	2
10823	1	196	362	\N	\N	23	2
10824	20	207	362	\N	\N	23	2
10825	1	7	363	\N	Vashon, 220th St. (Wax Orchard to Lisabeula): Heard.	23	2
10826	1	18	363	\N	\N	23	2
10827	2	23	363	\N	\N	23	2
10828	6	39	363	\N	\N	23	2
10829	5	44	363	\N	\N	23	2
1083	8	23	10	\N	\N	10	\N
10830	2	59	363	\N	\N	23	2
10831	1	60	363	\N	\N	23	2
10832	60	117	363	\N	Vashon, Wax Orchard Fields: Sitting on the wires	23	2
10833	1	86	363	\N	\N	23	2
10834	1	87	363	\N	\N	23	2
10835	2	103	363	\N	\N	23	2
10836	32	106	363	\N	\N	23	2
10837	19	113	363	\N	\N	23	2
10838	31	66	363	\N	\N	23	2
10839	2	69	363	\N	Vashon, Wax Orchard Fields: Hunting in a Wax Orchard field\nVashon, 220th St. (Wax Orchard to Lisabeula): Also hunting in a field.	23	2
1084	76	24	10	\N	\N	10	\N
10840	1	73	363	\N	\N	23	2
10841	2	76	363	\N	Vashon, Paradise Cove: Adult\nLisabuela Park: Adult	23	2
10842	2	79	363	\N	Vashon, Wax Orchard Fields: Flying over and circling	23	2
10843	2	132	363	\N	\N	23	2
10844	1	134	363	\N	\N	23	2
10845	4	137	363	\N	\N	23	2
10846	2	143	363	\N	Vashon, Wax Orchard Fields: Different than one at airport, which we could still see sitting in a tree.	23	2
10847	10	151	363	\N	\N	23	2
10848	10	153	363	\N	\N	23	2
10849	8	154	363	\N	\N	23	2
1085	1	27	10	\N	\N	10	\N
10850	3	156	363	\N	\N	23	2
10851	29	158	363	\N	\N	23	2
10852	7	160	363	\N	\N	23	2
10853	2	171	363	\N	\N	23	2
10854	28	170	363	\N	\N	23	2
10855	2	161	363	\N	\N	23	2
10856	4	163	363	\N	\N	23	2
10857	3	164	363	\N	\N	23	2
10858	3	167	363	\N	\N	23	2
10859	1	176	363	\N	\N	23	2
1086	130	28	10	\N	\N	10	\N
10860	16	175	363	\N	\N	23	2
10861	346	174	363	\N	Vashon Island--Wax Orchards/Airport on 232nd: Flocks of varying sizes appeared to be coming from a roost to the WNW.	23	2
10862	6	204	363	\N	\N	23	2
10863	388	207	363	\N	\N	23	2
10864	3	186	363	\N	\N	23	2
10865	99	187	363	\N	\N	23	2
10866	32	191	363	\N	\N	23	2
10867	24	194	363	\N	\N	23	2
10868	20	196	363	\N	\N	23	2
10869	3	131	364	\N	\N	23	2
1087	90	29	10	\N	\N	10	\N
10870	2	174	364	\N	\N	23	2
10871	6	189	364	\N	\N	23	2
10872	1	194	364	\N	\N	23	2
10873	1	131	365	\N	\N	23	2
10874	2	154	365	\N	\N	23	2
10875	10	158	365	\N	\N	23	2
10876	8	170	365	\N	\N	23	2
10877	2	174	365	\N	\N	23	2
10878	1	175	365	\N	\N	23	2
10879	2	189	365	\N	\N	23	2
1088	11	30	10	\N	\N	10	\N
10880	3	194	365	\N	\N	23	2
10881	8	207	365	\N	\N	23	2
10882	2	117	366	\N	\N	23	2
10883	3	131	366	\N	1 male; 2 female	23	2
10884	1	132	366	\N	heard chittering did not see it	23	2
10885	1	134	366	\N	\N	23	2
10886	2	137	366	\N	\N	23	2
10887	2	151	366	\N	\N	23	2
10888	4	153	366	\N	\N	23	2
10889	7	158	366	\N	some maybe black capped?	23	2
1089	1	31	10	\N	\N	10	\N
10890	4	161	366	\N	\N	23	2
10891	1	167	366	\N	\N	23	2
10892	0	76	366	\N	1 reported, duplicated by field team in area	23	2
10893	0	77	366	\N	1 reported, duplicated by field team in area	23	2
10894	400	174	366	\N	flying by; landing in big firs	23	2
10895	21	189	366	\N	\N	23	2
10896	3	194	366	\N	\N	23	2
10897	6	196	366	\N	\N	23	2
10898	2	204	366	\N	\N	23	2
10899	30	207	366	\N	flying over	23	2
109	31	15	2	\N	\N	2	\N
1090	40	33	10	\N	\N	10	\N
10900	2	135	367	\N	\N	23	2
10901	2	137	367	\N	\N	23	2
10902	2	151	367	\N	\N	23	2
10903	6	158	367	\N	\N	23	2
10904	2	161	367	\N	\N	23	2
10905	1	164	367	\N	\N	23	2
10906	2	171	367	\N	\N	23	2
10907	6	174	367	\N	\N	23	2
10908	1	186	367	\N	\N	23	2
10909	6	189	367	\N	\N	23	2
1091	1221	34	10	\N	\N	10	\N
10910	4	191	367	\N	\N	23	2
10911	1	194	367	\N	\N	23	2
10912	7	196	367	\N	\N	23	2
10913	2	207	367	\N	\N	23	2
10914	2	137	368	\N	\N	23	2
10915	3	153	368	\N	\N	23	2
10916	1	154	368	\N	\N	23	2
10917	2	156	368	\N	\N	23	2
10918	2	161	368	\N	\N	23	2
10919	2	167	368	\N	\N	23	2
1092	553	35	10	\N	\N	10	\N
10920	15	174	368	\N	\N	23	2
10921	3	175	368	\N	\N	23	2
10922	21	189	368	\N	\N	23	2
10923	7	196	368	\N	\N	23	2
10924	3	207	368	\N	\N	23	2
10925	2	211	368	\N	\N	23	2
10926	0	39	369	\N	Originally reported 2♂ at 10:30 a.m., removed due to higher count by boat team	23	2
10927	0	40	369	\N	Originally reported 1 ♂ at 10:30 a.m., removed due to higher count by boat team	23	2
10928	0	41	369	\N	Originally reported 3 at 3:15 p.m., removed due to higher count by boat team	23	2
10929	0	44	369	\N	Originally reported 63 at 10:30 a.m., removed due to higher count by boat team	23	2
1093	23	36	10	\N	\N	10	\N
10930	2	131	369	\N	2 ♂	23	2
10931	1	135	369	\N	1 ♂	23	2
10932	1	137	369	\N	1 ♂	23	2
10933	1	141	369	\N	1 ♂	23	2
10934	1	151	369	\N	\N	23	2
10935	3	158	369	\N	\N	23	2
10936	2	161	369	\N	\N	23	2
10937	1	174	369	\N	1 ♂	23	2
10938	3	175	369	\N	1♀; 2 ♂	23	2
10939	3	186	369	\N	\N	23	2
1094	1	38	10	\N	\N	10	\N
10940	11	189	369	\N	\N	23	2
10941	3	191	369	\N	\N	23	2
10942	3	196	369	\N	1 ♀; 2 ♂	23	2
10943	3	211	369	\N	2 ♀; 1 ♂	23	2
10944	2	131	370	\N	1 M 1 F	23	2
10945	2	135	370	\N	1 M 1 F	23	2
10946	2	137	370	\N	1 M 1 F	23	2
10947	1	141	370	\N	\N	23	2
10948	2	156	370	\N	\N	23	2
10949	10	158	370	\N	\N	23	2
1095	391	39	10	\N	\N	10	\N
10950	3	161	370	\N	\N	23	2
10951	1	79	370	\N	\N	23	2
10952	2	174	370	\N	\N	23	2
10953	6	189	370	\N	\N	23	2
10954	1	190	370	\N	\N	23	2
10955	3	191	370	\N	\N	23	2
10956	3	194	370	\N	\N	23	2
10957	2	196	370	\N	\N	23	2
10958	3	207	370	\N	\N	23	2
10959	2	131	371	\N	1 M, 1 F	23	2
1096	312	40	10	\N	\N	10	\N
10960	2	137	371	\N	\N	23	2
10961	2	151	371	\N	\N	23	2
10962	3	153	371	\N	\N	23	2
10963	1	154	371	\N	\N	23	2
10964	2	156	371	\N	\N	23	2
10965	5	158	371	\N	\N	23	2
10966	2	161	371	\N	\N	23	2
10967	1	163	371	\N	\N	23	2
10968	1	164	371	\N	\N	23	2
10969	1	76	371	\N	\N	23	2
1097	140	41	10	\N	\N	10	\N
10970	3	174	371	\N	\N	23	2
10971	1	175	371	\N	\N	23	2
10972	25	189	371	\N	\N	23	2
10973	4	194	371	\N	\N	23	2
10974	4	196	371	\N	\N	23	2
10975	3	207	371	\N	\N	23	2
10976	4	24	372	\N	\N	23	2
10977	3	131	372	\N	\N	23	2
10978	1	132	372	\N	\N	23	2
10979	1	134	372	\N	\N	23	2
1098	5	42	10	\N	\N	10	\N
10980	1	135	372	\N	\N	23	2
10981	1	137	372	\N	\N	23	2
10982	1	153	372	\N	\N	23	2
10983	4	156	372	\N	\N	23	2
10984	4	158	372	\N	\N	23	2
10985	1	163	372	\N	\N	23	2
10986	2	167	372	\N	\N	23	2
10987	1	168	372	\N	\N	23	2
10988	3	174	372	\N	\N	23	2
10989	3	189	372	\N	\N	23	2
1099	40	43	10	\N	\N	10	\N
10990	4	194	372	\N	\N	23	2
10991	3	196	372	\N	\N	23	2
10992	100	207	372	\N	\N	23	2
10993	1	135	373	\N	\N	23	2
10994	1	137	373	\N	\N	23	2
10995	1	151	373	\N	\N	23	2
10996	1	154	373	\N	\N	23	2
10997	1	170	373	\N	\N	23	2
10998	1	174	373	\N	\N	23	2
10999	1	186	373	\N	\N	23	2
11	100	29	1	\N	\N	1	\N
110	4	16	2	\N	\N	2	\N
1100	157	44	10	\N	\N	10	\N
11000	2	189	373	\N	\N	23	2
11001	1	194	373	\N	\N	23	2
11002	1	196	373	\N	\N	23	2
11003	2	207	373	\N	\N	23	2
11004	2	131	374	\N	male	23	2
11005	2	154	374	\N	\N	23	2
11006	1	164	374	\N	\N	23	2
11007	3	171	374	\N	\N	23	2
11008	1	194	374	\N	\N	23	2
11009	1	196	374	\N	\N	23	2
1101	178	45	10	\N	\N	10	\N
11010	2	131	375	\N	1 M, 1 F	23	2
11011	2	137	375	\N	1 M, 1 unknown	23	2
11012	2	158	375	\N	\N	23	2
11013	2	161	375	\N	\N	23	2
11014	18	174	375	\N	7 M, 2 F, 9 unknown	23	2
11015	1	186	375	\N	\N	23	2
11016	12	189	375	\N	\N	23	2
11017	2	191	375	\N	\N	23	2
11018	2	194	375	\N	\N	23	2
11019	5	205	375	\N	3 M, 2 F	23	2
1102	57	47	10	\N	\N	10	\N
11020	1	207	375	\N	\N	23	2
11021	1	208	375	\N	\N	23	2
11022	2	131	376	\N	\N	23	2
11023	1	135	376	\N	\N	23	2
11024	2	151	376	\N	\N	23	2
11025	1	153	376	\N	\N	23	2
11026	1	158	376	\N	\N	23	2
11027	6	160	376	\N	\N	23	2
11028	1	174	376	\N	\N	23	2
11029	1	176	376	\N	\N	23	2
1103	2	51	10	\N	\N	10	\N
11030	4	189	376	\N	\N	23	2
11031	2	190	376	\N	\N	23	2
11032	2	191	376	\N	\N	23	2
11033	4	196	376	\N	\N	23	2
11034	1	197	376	\N	\N	23	2
11035	5	207	376	\N	\N	23	2
11036	4	210	376	\N	\N	23	2
11037	1	134	377	\N	\N	23	2
11038	1	154	377	\N	\N	23	2
11039	1	168	377	\N	\N	23	2
1104	13	53	10	\N	\N	10	\N
11040	2	175	377	\N	\N	23	2
11041	3	194	377	\N	\N	23	2
11042	6	196	377	\N	\N	23	2
11043	1	159	377	\N	\N	23	2
11044	\N	122	378	t	VS - Laurie Tucker	24	5
11045	\N	148	378	t	KW - Ken Brown, Blackjack Valley	24	5
11046	\N	89	378	t	KE - Ken Brown, Yukon Village	24	5
11047	\N	109	378	t	KE - Ken Brown, Yukon Village	24	5
11048	\N	110	378	t	KE - Ken Brown, Yukon Village	24	5
11049	\N	195	378	t	KW - Ken Brown, Hovgaard Road	24	5
1105	43	54	10	\N	\N	10	\N
11050	\N	201	378	t	KW - Ken Brown, Blackjack Valley	24	5
11051	2	6	379	\N	\N	24	5
11052	49	7	379	\N	\N	24	5
11053	2	10	379	\N	2100 Yukon Harbor Road Southeast, Port Orchard: Hanging with the canada geese. Canada goose hybrid do not know with what.Bigger then Canada goose, Orange legs. One has mainly white face, black beak, white underwing patch. Other white moltted face, orange beak.	24	5
11054	2	11	379	\N	\N	24	5
11055	5	16	379	\N	Harper Park and estuary: 3m, 2f	24	5
11056	3	17	379	\N	\N	24	5
11057	2136	18	379	\N	8685 Southeast John Street, Port Orchard: Estimate by 10s\nYukon Harbor: Estimate by 10s	24	5
11058	1	19	379	\N	\N	24	5
11059	40	20	379	\N	Washington, US: 2 Decoys	24	5
1106	46	55	10	\N	\N	10	\N
11060	23	29	379	\N	\N	24	5
11061	12	30	379	\N	\N	24	5
11062	1	31	379	\N	\N	24	5
11063	6	33	379	\N	3379 Southeast Olympiad Drive, Port Orchard: 1f, 2m\nWashington, US: 1m,2f	24	5
11064	151	34	379	\N	Harper Pier: 6,1,,3,6,10,8,18\nWashington, US: 35,4,5	24	5
11065	4	35	379	\N	Harper Pier: Flying	24	5
11066	110	39	379	\N	Harper Pier: 1,4,4,12,10\nWashington, US: 37,11	24	5
11067	214	40	379	\N	Harper Pier: 3,6,6,1,12,15\nWashington, US: 30,71	24	5
11068	23	44	379	\N	\N	24	5
11069	61	45	379	\N	Harper Pier: 9,2,8\nWashington, US: 10,7	24	5
1107	10	57	10	\N	\N	10	\N
11070	8	46	379	\N	\N	24	5
11071	1	58	379	\N	\N	24	5
11072	136	59	379	\N	Harper Pier: 1,2,3,6,11\nWashington, US: 57,21	24	5
11073	19	60	379	\N	Harper Pier: 3,1,1,2,4	24	5
11074	18	62	379	\N	\N	24	5
11075	6	117	379	\N	\N	24	5
11076	10	119	379	\N	\N	24	5
11077	6	131	379	\N	\N	24	5
11078	16	86	379	\N	\N	24	5
11079	2	87	379	\N	\N	24	5
1108	10	58	10	\N	\N	10	\N
11080	40	100	379	\N	\N	24	5
11081	3	103	379	\N	\N	24	5
11082	39	106	379	\N	\N	24	5
11083	1	107	379	\N	\N	24	5
11084	1	111	379	\N	\N	24	5
11085	9	112	379	\N	\N	24	5
11086	21	113	379	\N	\N	24	5
11087	5	114	379	\N	\N	24	5
11088	6	116	379	\N	\N	24	5
11089	5	53	379	\N	\N	24	5
1109	317	59	10	\N	\N	10	\N
11090	1	54	379	\N	\N	24	5
11091	1	65	379	\N	\N	24	5
11092	22	67	379	\N	Harper Pier: 2,2,2,2	24	5
11093	22	66	379	\N	\N	24	5
11094	6	69	379	\N	\N	24	5
11095	5	76	379	\N	Southworth Ferry Terminal: Immature at 0904, 2 A at 0905\nHarper Park and estuary: Adult at 1148\nWashington, US: Immature at 1357	24	5
11096	1	79	379	\N	\N	24	5
11097	5	132	379	\N	\N	24	5
11098	2	135	379	\N	\N	24	5
11099	1	135	379	\N	\N	24	5
111	5	17	2	\N	\N	2	\N
1110	103	60	10	\N	\N	10	\N
11100	5	137	379	\N	\N	24	5
11101	1	149	379	\N	\N	24	5
11102	2	151	379	\N	\N	24	5
11103	5	152	379	\N	\N	24	5
11104	50	153	379	\N	\N	24	5
11105	6	154	379	\N	\N	24	5
11106	8	156	379	\N	\N	24	5
11107	8	158	379	\N	\N	24	5
11108	9	171	379	\N	\N	24	5
11109	5	170	379	\N	\N	24	5
1111	5	61	10	\N	\N	10	\N
11110	2	161	379	\N	\N	24	5
11111	3	163	379	\N	\N	24	5
11112	7	164	379	\N	\N	24	5
11113	56	176	379	\N	\N	24	5
11114	1	175	379	\N	\N	24	5
11115	91	174	379	\N	\N	24	5
11116	25	211	379	\N	\N	24	5
11117	12	204	379	\N	\N	24	5
11118	1	205	379	\N	\N	24	5
11119	4	208	379	\N	\N	24	5
1112	459	62	10	\N	\N	10	\N
11120	1	186	379	\N	\N	24	5
11121	3	186	379	\N	\N	24	5
11122	11	189	379	\N	\N	24	5
11123	20	190	379	\N	\N	24	5
11124	18	191	379	\N	\N	24	5
11125	27	194	379	\N	\N	24	5
11126	2	196	379	\N	\N	24	5
11127	7	196	379	\N	\N	24	5
11128	21	199	379	\N	\N	24	5
11129	1	181	379	\N	\N	24	5
1113	51	65	10	\N	\N	10	\N
11130	14	20	380	\N	\N	24	5
11131	2	113	380	\N	\N	24	5
11132	2	116	380	\N	\N	24	5
11133	9	66	380	\N	\N	24	5
11134	1	69	380	\N	\N	24	5
11135	1	79	380	\N	\N	24	5
11136	1	135	380	\N	\N	24	5
11137	1	136	380	\N	\N	24	5
11138	2	137	380	\N	\N	24	5
11139	2	151	380	\N	\N	24	5
1114	380	66	10	\N	\N	10	\N
11140	25	153	380	\N	\N	24	5
11141	1	154	380	\N	\N	24	5
11142	16	156	380	\N	\N	24	5
11143	13	158	380	\N	\N	24	5
11144	4	171	380	\N	\N	24	5
11145	1	170	380	\N	\N	24	5
11146	2	161	380	\N	\N	24	5
11147	1	163	380	\N	\N	24	5
11148	6	164	380	\N	\N	24	5
11149	1	167	380	\N	\N	24	5
1115	33	67	10	\N	\N	10	\N
11150	9	176	380	\N	\N	24	5
11151	29	174	380	\N	\N	24	5
11152	17	187	380	\N	\N	24	5
11153	15	194	380	\N	\N	24	5
11154	1	196	380	\N	\N	24	5
11155	\N	7	381	t	4 fly over	24	5
11156	1	20	381	\N	male - on pond	24	5
11157	\N	124	381	t	 2 - duet, recorded	24	5
11158	1	135	381	\N	\N	24	5
11159	1	139	381	\N	\N	24	5
1116	42	69	10	\N	\N	10	\N
11160	4	151	381	\N	\N	24	5
11161	2	153	381	\N	\N	24	5
11162	1	156	381	\N	\N	24	5
11163	3	158	381	\N	\N	24	5
11164	1	171	381	\N	\N	24	5
11165	2	161	381	\N	\N	24	5
11166	1	167	381	\N	\N	24	5
11167	1	131	381	\N	\N	24	5
11168	2	175	381	\N	\N	24	5
11169	2	205	381	\N	\N	24	5
1117	1	71	10	\N	\N	10	\N
11170	12	187	381	\N	\N	24	5
11171	1	194	381	\N	\N	24	5
11172	2	196	381	\N	\N	24	5
11173	56	15	382	\N	Mace Lake: Counted by ones.	24	6
11174	2	22	382	\N	\N	24	6
11175	27	20	382	\N	\N	24	6
11176	35	28	382	\N	\N	24	6
11177	35	39	382	\N	\N	24	6
11178	2	40	382	\N	\N	24	6
11179	1	43	382	\N	\N	24	6
1118	4	72	10	\N	\N	10	\N
11180	1	87	382	\N	\N	24	6
11181	8	114	382	\N	\N	24	6
11182	9	153	382	\N	\N	24	6
11183	1	194	382	\N	\N	24	6
11184	1	196	382	\N	\N	24	6
11185	25	199	382	\N	\N	24	6
11186	7	39	383	\N	Olalla Bay: Originally reported 30, reduced by count from earlier team(s)	24	6
11187	3	40	383	\N	Olalla Bay: Originally reported 11, reduced by count from earlier team(s)	24	6
11188	0	43	383	\N	Olalla Bay: Originally reported 1, reduced by count from earlier team(s)	24	6
11189	0	112	383	\N	Olalla Bay: Originally reported 11, reduced by count from earlier team(s)	24	6
1119	7	73	10	\N	\N	10	\N
11190	1	66	383	\N	\N	24	6
11191	2	69	383	\N	\N	24	6
11192	1	132	383	\N	\N	24	6
11193	2	29	384	\N	\N	24	6
11194	6	40	384	\N	13535–14099 Olalla Valley Rd SE, Olalla US-WA (47.4220,-122.5424): Originally reported 8, reduced by count from earlier team(s)	24	6
11195	2	45	384	\N	\N	24	6
11196	2	131	384	\N	\N	24	6
11197	1	82	384	\N	\N	24	6
11198	22	113	384	\N	13535–14099 Olalla Valley Rd SE, Olalla US-WA (47.4220,-122.5424): Originally reported 14, reduced by count from earlier team(s)	24	6
11199	1	55	384	\N	\N	24	6
112	3243	18	2	\N	\N	2	\N
1120	54	76	10	\N	\N	10	\N
11200	1	67	384	\N	\N	24	6
11201	1	73	384	\N	\N	24	6
11202	1	76	384	\N	\N	24	6
11203	1	135	384	\N	\N	24	6
11204	1	141	384	\N	\N	24	6
11205	5	151	384	\N	\N	24	6
11206	5	153	384	\N	\N	24	6
11207	1	154	384	\N	\N	24	6
11208	18	156	384	\N	\N	24	6
11209	21	158	384	\N	\N	24	6
1121	23	79	10	\N	\N	10	\N
11210	6	171	384	\N	\N	24	6
11211	15	170	384	\N	\N	24	6
11212	3	161	384	\N	\N	24	6
11213	6	164	384	\N	\N	24	6
11214	1	166	384	\N	\N	24	6
11215	2	167	384	\N	\N	24	6
11216	32	176	384	\N	\N	24	6
11217	5	175	384	\N	\N	24	6
11218	29	174	384	\N	\N	24	6
11219	14	187	384	\N	\N	24	6
1122	1	81	10	\N	\N	10	\N
11220	11	194	384	\N	\N	24	6
11221	3	196	384	\N	\N	24	6
11222	2	7	385	\N	\N	24	6
11223	5	15	385	\N	\N	24	6
11224	3	22	385	\N	\N	24	6
11225	35	18	385	\N	\N	24	6
11226	42	20	385	\N	\N	24	6
11227	1	24	385	\N	\N	24	6
11228	23	28	385	\N	\N	24	6
11229	1	29	385	\N	\N	24	6
1123	287	83	10	\N	\N	10	\N
11230	1	30	385	\N	\N	24	6
11231	33	39	385	\N	\N	24	6
11232	1	43	385	\N	\N	24	6
11233	32	44	385	\N	\N	24	6
11234	2	47	385	\N	\N	24	6
11235	42	58	385	\N	\N	24	6
11236	163	83	385	\N	\N	24	6
11237	0	86	385	\N	\N	24	6
11238	7	114	385	\N	\N	24	6
11239	33	66	385	\N	\N	24	6
1124	105	86	10	\N	\N	10	\N
11240	1	69	385	\N	\N	24	6
11241	0	71	385	\N	\N	24	6
11242	1	76	385	\N	\N	24	6
11243	1	79	385	\N	\N	24	6
11244	0	124	385	\N	\N	24	6
11245	0	126	385	\N	\N	24	6
11246	1	134	385	\N	\N	24	6
11247	2	137	385	\N	\N	24	6
11248	3	151	385	\N	\N	24	6
11249	6	153	385	\N	\N	24	6
1125	8	87	10	\N	\N	10	\N
11250	3	156	385	\N	\N	24	6
11251	0	158	385	\N	\N	24	6
11252	8	160	385	\N	\N	24	6
11253	1	171	385	\N	\N	24	6
11254	2	170	385	\N	\N	24	6
11255	3	161	385	\N	\N	24	6
11256	1	164	385	\N	\N	24	6
11257	0	166	385	\N	\N	24	6
11258	3	167	385	\N	\N	24	6
11259	1	176	385	\N	\N	24	6
1126	1	88	10	\N	\N	10	\N
11260	55	174	385	\N	\N	24	6
11261	1	205	385	\N	\N	24	6
11262	1	208	385	\N	\N	24	6
11263	0	186	385	\N	\N	24	6
11264	3	189	385	\N	\N	24	6
11265	0	190	385	\N	\N	24	6
11266	3	194	385	\N	\N	24	6
11267	1	196	385	\N	\N	24	6
11268	6	199	385	\N	\N	24	6
11269	0	184	385	\N	\N	24	6
1127	56	89	10	\N	\N	10	\N
11270	35	7	386	\N	\N	24	6
11271	4	22	386	\N	\N	24	6
11272	2	18	386	\N	\N	24	6
11273	68	20	386	\N	\N	24	6
11274	24	24	386	\N	\N	24	6
11275	1	28	386	\N	\N	24	6
11276	5	39	386	\N	\N	24	6
11277	5	43	386	\N	\N	24	6
11278	1	120	386	\N	\N	24	6
11279	5	131	386	\N	\N	24	6
1128	17	91	10	\N	\N	10	\N
11280	1	82	386	\N	\N	24	6
11281	8	86	386	\N	\N	24	6
11282	1	114	386	\N	\N	24	6
11283	1	69	386	\N	\N	24	6
11284	1	71	386	\N	\N	24	6
11285	1	73	386	\N	\N	24	6
11286	5	76	386	\N	\N	24	6
11287	2	79	386	\N	\N	24	6
11288	3	124	386	\N	\N	24	6
11289	1	126	386	\N	\N	24	6
1129	36	92	10	\N	\N	10	\N
11290	1	135	386	\N	\N	24	6
11291	7	137	386	\N	\N	24	6
11292	2	139	386	\N	\N	24	6
11293	1	144	386	\N	\N	24	6
11294	5	151	386	\N	\N	24	6
11295	4	152	386	\N	\N	24	6
11296	75	153	386	\N	\N	24	6
11297	6	154	386	\N	\N	24	6
11298	17	156	386	\N	\N	24	6
11299	3	158	386	\N	\N	24	6
113	544	20	2	\N	\N	2	\N
1130	8	95	10	\N	\N	10	\N
11300	25	160	386	\N	\N	24	6
11301	1	166	386	\N	\N	24	6
11302	1	167	386	\N	\N	24	6
11303	172	176	386	\N	\N	24	6
11304	1	175	386	\N	\N	24	6
11305	119	174	386	\N	\N	24	6
11306	9	211	386	\N	\N	24	6
11307	13	204	386	\N	\N	24	6
11308	1	205	386	\N	\N	24	6
11309	16	208	386	\N	\N	24	6
1131	15	99	10	\N	\N	10	\N
11310	2	186	386	\N	\N	24	6
11311	65	189	386	\N	\N	24	6
11312	1	190	386	\N	\N	24	6
11313	3	190	386	\N	\N	24	6
11314	32	191	386	\N	\N	24	6
11315	2	193	386	\N	\N	24	6
11316	6	197	386	\N	\N	24	6
11317	22	194	386	\N	\N	24	6
11318	9	196	386	\N	\N	24	6
11319	78	199	386	\N	\N	24	6
1132	24	100	10	\N	\N	10	\N
11320	1	184	386	\N	\N	24	6
11321	1	194	387	\N	\N	24	6
11322	2	196	387	\N	\N	24	6
11323	2	120	388	\N	\N	24	6
11324	1	131	388	\N	\N	24	6
11325	2	135	388	\N	\N	24	6
11326	1	136	388	\N	\N	24	6
11327	5	137	388	\N	\N	24	6
11328	0	143	388	\N	13495 Banner Rd SE, Olalla US-WA (47.4284,-122.5384): Reported but unconfirmed	24	6
11329	3	151	388	\N	\N	24	6
1133	20	103	10	\N	\N	10	\N
11330	2	153	388	\N	\N	24	6
11331	1	156	388	\N	\N	24	6
11332	1	158	388	\N	\N	24	6
11333	3	176	388	\N	\N	24	6
11334	1	174	388	\N	\N	24	6
11335	1	204	388	\N	\N	24	6
11336	3	210	388	\N	\N	24	6
11337	10	187	388	\N	\N	24	6
11338	1	190	388	\N	\N	24	6
11339	3	191	388	\N	\N	24	6
1134	150	105	10	\N	\N	10	\N
11340	5	194	388	\N	\N	24	6
11341	3	196	388	\N	\N	24	6
11342	3	197	388	\N	13495 Banner Rd SE, Olalla US-WA (47.4284,-122.5384): Lighter color than the Song Sparrow, but similar markings on the head and body	24	6
11343	24	199	388	\N	\N	24	6
11344	15	33	389	\N	\N	24	3
11345	23	34	389	\N	\N	24	3
11346	17	39	389	\N	\N	24	3
11347	41	40	389	\N	\N	24	3
11348	2	41	389	\N	\N	24	3
11349	22	45	389	\N	\N	24	3
1135	241	106	10	\N	\N	10	\N
11350	33	59	389	\N	\N	24	3
11351	3	60	389	\N	\N	24	3
11352	1	61	389	\N	\N	24	3
11353	1	118	389	\N	\N	24	3
11354	3	131	389	\N	\N	24	3
11355	1	99	389	\N	\N	24	3
11356	2	100	389	\N	\N	24	3
11357	2	103	389	\N	\N	24	3
11358	6	106	389	\N	\N	24	3
11359	35	113	389	\N	\N	24	3
1136	1	108	10	\N	\N	10	\N
11360	1	55	389	\N	\N	24	3
11361	2	67	389	\N	\N	24	3
11362	14	66	389	\N	\N	24	3
11363	1	69	389	\N	\N	24	3
11364	3	76	389	\N	\N	24	3
11365	5	79	389	\N	\N	24	3
11366	1	134	389	\N	\N	24	3
11367	5	135	389	\N	\N	24	3
11368	1	141	389	\N	\N	24	3
11369	7	137	389	\N	\N	24	3
1137	2	109	10	\N	\N	10	\N
11370	4	139	389	\N	\N	24	3
11371	1	145	389	\N	\N	24	3
11372	4	151	389	\N	\N	24	3
11373	22	153	389	\N	\N	24	3
11374	18	156	389	\N	\N	24	3
11375	5	158	389	\N	\N	24	3
11376	8	160	389	\N	\N	24	3
11377	8	171	389	\N	\N	24	3
11378	1	170	389	\N	\N	24	3
11379	5	161	389	\N	\N	24	3
1138	1	111	10	\N	\N	10	\N
11380	2	163	389	\N	\N	24	3
11381	15	164	389	\N	\N	24	3
11382	2	167	389	\N	\N	24	3
11383	6	176	389	\N	\N	24	3
11384	4	175	389	\N	\N	24	3
11385	2	173	389	\N	\N	24	3
11386	43	174	389	\N	\N	24	3
11387	14	204	389	\N	\N	24	3
11388	1	208	389	\N	\N	24	3
11389	8	186	389	\N	\N	24	3
1139	451	112	10	\N	\N	10	\N
11390	78	187	389	\N	\N	24	3
11391	10	191	389	\N	\N	24	3
11392	57	194	389	\N	\N	24	3
11393	14	196	389	\N	\N	24	3
11394	1	181	389	\N	\N	24	3
11395	11	183	389	\N	\N	24	3
11396	48	7	390	\N	\N	24	3
11397	3	18	390	\N	\N	24	3
11398	5	39	390	\N	\N	24	3
11399	2	41	390	\N	\N	24	3
114	6	23	2	\N	\N	2	\N
1140	112	113	10	\N	\N	10	\N
11400	2	43	390	\N	\N	24	3
11401	2	134	390	\N	\N	24	3
11402	1	135	390	\N	\N	24	3
11403	1	141	390	\N	\N	24	3
11404	9	137	390	\N	\N	24	3
11405	5	152	390	\N	\N	24	3
11406	46	153	390	\N	\N	24	3
11407	1	154	390	\N	\N	24	3
11408	12	156	390	\N	\N	24	3
11409	8	158	390	\N	\N	24	3
1141	1	115	10	\N	\N	10	\N
11410	6	171	390	\N	\N	24	3
11411	8	170	390	\N	\N	24	3
11412	3	161	390	\N	\N	24	3
11413	1	163	390	\N	\N	24	3
11414	3	164	390	\N	\N	24	3
11415	5	167	390	\N	\N	24	3
11416	12	131	390	\N	\N	24	3
11417	4	86	390	\N	\N	24	3
11418	1	87	390	\N	\N	24	3
11419	1	112	390	\N	\N	24	3
1142	308	116	10	\N	\N	10	\N
11420	3	69	390	\N	\N	24	3
11421	1	73	390	\N	\N	24	3
11422	2	76	390	\N	\N	24	3
11423	2	79	390	\N	\N	24	3
11424	12	10	390	\N	Flyover - possibly SNGO	24	3
11425	27	176	390	\N	\N	24	3
11426	10	175	390	\N	\N	24	3
11427	1	173	390	\N	\N	24	3
11428	21	174	390	\N	\N	24	3
11429	2	178	390	\N	\N	24	3
1143	282	117	10	\N	\N	10	\N
11430	14	211	390	\N	\N	24	3
11431	9	204	390	\N	\N	24	3
11432	3	205	390	\N	\N	24	3
11433	1	186	390	\N	\N	24	3
11434	1	188	390	\N	\N	24	3
11435	22	189	390	\N	\N	24	3
11436	2	190	390	\N	\N	24	3
11437	22	191	390	\N	\N	24	3
11438	22	194	390	\N	\N	24	3
11439	6	196	390	\N	\N	24	3
1144	58	118	10	\N	\N	10	\N
11440	12	183	390	\N	\N	24	3
11441	37	7	391	\N	\N	24	3
11442	5	11	391	\N	\N	24	3
11443	460	18	391	\N	\N	24	3
11444	34	20	391	\N	\N	24	3
11445	1	29	391	\N	\N	24	3
11446	69	34	391	\N	\N	24	3
11447	67	39	391	\N	\N	24	3
11448	61	40	391	\N	\N	24	3
11449	5	41	391	\N	\N	24	3
1145	15	120	10	\N	\N	10	\N
11450	3	43	391	\N	\N	24	3
11451	58	45	391	\N	\N	24	3
11452	2	58	391	\N	\N	24	3
11453	70	59	391	\N	\N	24	3
11454	20	60	391	\N	\N	24	3
11455	7	61	391	\N	Portage, Vashon: Known population at this location	24	3
11456	13	117	391	\N	\N	24	3
11457	2	119	391	\N	\N	24	3
11458	12	131	391	\N	\N	24	3
11459	0	82	391	\N	\N	24	3
1146	1	126	10	\N	\N	10	\N
11460	6	86	391	\N	\N	24	3
11461	1	87	391	\N	\N	24	3
11462	11	100	391	\N	\N	24	3
11463	16	106	391	\N	\N	24	3
11464	3	112	391	\N	\N	24	3
11465	15	113	391	\N	\N	24	3
11466	20	114	391	\N	\N	24	3
11467	3	53	391	\N	\N	24	3
11468	5	55	391	\N	\N	24	3
11469	2	65	391	\N	\N	24	3
1147	1	129	10	\N	\N	10	\N
11470	5	67	391	\N	\N	24	3
11471	14	66	391	\N	\N	24	3
11472	4	68	391	\N	\N	24	3
11473	4	69	391	\N	\N	24	3
11474	1	73	391	\N	\N	24	3
11475	6	76	391	\N	\N	24	3
11476	1	79	391	\N	\N	24	3
11477	1	124	391	\N	236th Street and 115th Avenue, Vashon: Heard to east of location, unprompted by playback	24	3
11478	2	126	391	\N	\N	24	3
11479	1	129	391	\N	\N	24	3
1148	78	131	10	\N	\N	10	\N
11480	2	132	391	\N	\N	24	3
11481	4	134	391	\N	\N	24	3
11482	1	135	391	\N	\N	24	3
11483	8	137	391	\N	\N	24	3
11484	6	151	391	\N	\N	24	3
11485	1	152	391	\N	\N	24	3
11486	96	153	391	\N	\N	24	3
11487	11	156	391	\N	\N	24	3
11488	14	158	391	\N	\N	24	3
11489	5	171	391	\N	\N	24	3
1149	33	132	10	\N	\N	10	\N
11490	2	170	391	\N	\N	24	3
11491	6	161	391	\N	\N	24	3
11492	1	163	391	\N	\N	24	3
11493	6	164	391	\N	\N	24	3
11494	3	167	391	\N	\N	24	3
11495	2	176	391	\N	\N	24	3
11496	3	173	391	\N	\N	24	3
11497	46	174	391	\N	\N	24	3
11498	40	204	391	\N	\N	24	3
11499	2	205	391	\N	\N	24	3
115	31	24	2	\N	\N	2	\N
1150	18	134	10	\N	\N	10	\N
11500	7	208	391	\N	\N	24	3
11501	6	186	391	\N	\N	24	3
11502	33	189	391	\N	\N	24	3
11503	10	190	391	\N	\N	24	3
11504	15	191	391	\N	\N	24	3
11505	1	193	391	\N	\N	24	3
11506	27	194	391	\N	\N	24	3
11507	10	196	391	\N	\N	24	3
11508	7	199	391	\N	\N	24	3
11509	2	181	391	\N	\N	24	3
1151	18	135	10	\N	\N	10	\N
11510	2	137	392	\N	\N	24	3
11511	1	156	392	\N	\N	24	3
11512	1	158	392	\N	\N	24	3
11513	11	160	392	\N	\N	24	3
11514	1	161	392	\N	\N	24	3
11515	2	131	392	\N	\N	24	3
11516	3	211	392	\N	\N	24	3
11517	9	187	392	\N	\N	24	3
11518	2	191	392	\N	\N	24	3
11519	1	196	392	\N	\N	24	3
1152	4	136	10	\N	\N	10	\N
11520	12	160	393	\N	\N	24	3
11521	18	131	394	\N	\N	24	3
11522	2	135	395	\N	\N	24	3
11523	2	137	395	\N	\N	24	3
11524	1	151	395	\N	\N	24	3
11525	7	158	395	\N	\N	24	3
11526	2	161	395	\N	\N	24	3
11527	5	131	395	\N	\N	24	3
11528	1	73	395	\N	\N	24	3
11529	4	176	395	\N	\N	24	3
1153	2	138	10	\N	\N	10	\N
11530	7	204	395	\N	\N	24	3
11531	6	187	395	\N	\N	24	3
11532	11	191	395	\N	\N	24	3
11533	1	194	395	\N	\N	24	3
11534	2	196	395	\N	\N	24	3
11535	\N	141	396	t	1	24	3
11536	1	137	396	\N	\N	24	3
11537	\N	151	396	t	1	24	3
11538	\N	152	396	t	2	24	3
11539	1	153	396	\N	\N	24	3
1154	75	139	10	\N	\N	10	\N
11540	1	156	396	\N	\N	24	3
11541	2	158	396	\N	\N	24	3
11542	1	131	396	\N	\N	24	3
11543	0	82	396	\N	Originally reported as 1 (heard), removed due to inappropriate habitat and lack of audio recording	24	3
11544	0	72	396	\N	\N	24	3
11545	1	75	396	\N	Originally reported as SSHA with the following note: Could be Cooper's. So hard to tell. Didn't notice a white band at the end of tail.	24	3
11546	1	76	396	\N	\N	24	3
11547	1	175	396	\N	\N	24	3
11548	2	174	396	\N	\N	24	3
11549	3	204	396	\N	1m 2f	24	3
1155	22	141	10	\N	\N	10	\N
11550	1	186	396	\N	\N	24	3
11551	2	187	396	\N	\N	24	3
11552	1	196	396	\N	\N	24	3
11553	68	7	397	\N	\N	24	7
11554	32	18	397	\N	\N	24	7
11555	45	20	397	\N	\N	24	7
11556	3	21	397	\N	\N	24	7
11557	2	23	397	\N	\N	24	7
11558	12	28	397	\N	\N	24	7
11559	63	29	397	\N	\N	24	7
1156	6	144	10	\N	\N	10	\N
11560	10	31	397	\N	\N	24	7
11561	2	33	397	\N	\N	24	7
11562	282	34	397	\N	\N	24	7
11563	82	39	397	\N	\N	24	7
11564	62	40	397	\N	\N	24	7
11565	45	41	397	\N	\N	24	7
11566	8	43	397	\N	\N	24	7
11567	2	44	397	\N	\N	24	7
11568	34	45	397	\N	\N	24	7
11569	66	59	397	\N	\N	24	7
1157	1	146	10	\N	\N	10	\N
11570	1	60	397	\N	\N	24	7
11571	1	120	397	\N	\N	24	7
11572	6	131	397	\N	\N	24	7
11573	1	103	397	\N	\N	24	7
11574	33	106	397	\N	\N	24	7
11575	55	112	397	\N	\N	24	7
11576	20	113	397	\N	\N	24	7
11577	1	65	397	\N	\N	24	7
11578	2	67	397	\N	\N	24	7
11579	81	66	397	\N	\N	24	7
1158	2	149	10	\N	\N	10	\N
11580	3	69	397	\N	\N	24	7
11581	1	73	397	\N	\N	24	7
11582	3	76	397	\N	\N	24	7
11583	4	79	397	\N	\N	24	7
11584	3	132	397	\N	\N	24	7
11585	1	135	397	\N	\N	24	7
11586	2	137	397	\N	\N	24	7
11587	9	151	397	\N	\N	24	7
11588	25	153	397	\N	\N	24	7
11589	20	156	397	\N	\N	24	7
1159	130	151	10	\N	\N	10	\N
11590	1	158	397	\N	\N	24	7
11591	5	160	397	\N	\N	24	7
11592	5	171	397	\N	\N	24	7
11593	1	170	397	\N	\N	24	7
11594	2	161	397	\N	\N	24	7
11595	1	166	397	\N	\N	24	7
11596	2	167	397	\N	\N	24	7
11597	15	176	397	\N	\N	24	7
11598	27	174	397	\N	\N	24	7
11599	2	211	397	\N	\N	24	7
116	3	25	2	\N	\N	2	\N
1160	1	152	10	\N	\N	10	\N
11600	11	204	397	\N	\N	24	7
11601	10	208	397	\N	\N	24	7
11602	4	186	397	\N	\N	24	7
11603	29	187	397	\N	\N	24	7
11604	5	190	397	\N	\N	24	7
11605	13	191	397	\N	\N	24	7
11606	11	194	397	\N	\N	24	7
11607	6	196	397	\N	\N	24	7
11608	11	199	397	\N	\N	24	7
11609	1	181	397	\N	\N	24	7
1161	975	153	10	\N	\N	10	\N
11610	5	131	398	\N	\N	24	7
11611	6	137	398	\N	\N	24	7
11612	6	151	398	\N	\N	24	7
11613	5	153	398	\N	\N	24	7
11614	25	156	398	\N	\N	24	7
11615	8	158	398	\N	\N	24	7
11616	12	160	398	\N	\N	24	7
11617	2	170	398	\N	\N	24	7
11618	2	161	398	\N	\N	24	7
11619	2	167	398	\N	\N	24	7
1162	11	154	10	\N	\N	10	\N
11620	1	176	398	\N	\N	24	7
11621	1	175	398	\N	\N	24	7
11622	1	174	398	\N	\N	24	7
11623	1	204	398	\N	\N	24	7
11624	3	208	398	\N	\N	24	7
11625	23	187	398	\N	\N	24	7
11626	1	191	398	\N	\N	24	7
11627	2	194	398	\N	\N	24	7
11628	3	196	398	\N	\N	24	7
11629	4	7	399	\N	\N	24	7
1163	167	156	10	\N	\N	10	\N
11630	3	15	399	\N	Mace Lake: Counted by ones.	24	7
11631	2	18	399	\N	\N	24	7
11632	34	20	399	\N	\N	24	7
11633	1	131	399	\N	\N	24	7
11634	5	86	399	\N	\N	24	7
11635	4	114	399	\N	\N	24	7
11636	8	66	399	\N	\N	24	7
11637	2	76	399	\N	\N	24	7
11638	3	135	399	\N	\N	24	7
11639	7	137	399	\N	\N	24	7
1164	254	158	10	\N	\N	10	\N
11640	8	151	399	\N	\N	24	7
11641	2	152	399	\N	\N	24	7
11642	9	153	399	\N	\N	24	7
11643	1	154	399	\N	\N	24	7
11644	23	156	399	\N	\N	24	7
11645	6	158	399	\N	\N	24	7
11646	3	171	399	\N	\N	24	7
11647	4	170	399	\N	\N	24	7
11648	4	161	399	\N	\N	24	7
11649	1	163	399	\N	\N	24	7
1165	81	160	10	\N	\N	10	\N
11650	1	164	399	\N	\N	24	7
11651	2	167	399	\N	\N	24	7
11652	21	176	399	\N	\N	24	7
11653	4	175	399	\N	\N	24	7
11654	1	173	399	\N	\N	24	7
11655	56	174	399	\N	\N	24	7
11656	1	204	399	\N	\N	24	7
11657	3	205	399	\N	\N	24	7
11658	6	186	399	\N	\N	24	7
11659	102	187	399	\N	\N	24	7
1166	76	161	10	\N	\N	10	\N
11660	17	194	399	\N	\N	24	7
11661	19	196	399	\N	\N	24	7
11662	9	7	400	\N	\N	24	7
11663	6	20	400	\N	\N	24	7
11664	15	28	400	\N	\N	24	7
11665	2	43	400	\N	\N	24	7
11666	1	131	400	\N	\N	24	7
11667	1	112	400	\N	\N	24	7
11668	1	66	400	\N	\N	24	7
11669	1	141	400	\N	14327 Crescent Valley Drive Northwest, Gig Harbor, Washington, US CBC Vashon pc wc: Reported by Diane and Faye, arbitrarily added to first checklist	24	7
1167	12	163	10	\N	\N	10	\N
11670	6	137	400	\N	\N	24	7
11671	3	151	400	\N	\N	24	7
11672	6	153	400	\N	\N	24	7
11673	2	154	400	\N	\N	24	7
11674	6	156	400	\N	\N	24	7
11675	2	171	400	\N	\N	24	7
11676	5	170	400	\N	\N	24	7
11677	6	161	400	\N	\N	24	7
11678	4	164	400	\N	\N	24	7
11679	1	167	400	\N	\N	24	7
1168	47	165	10	\N	\N	10	\N
11680	1	176	400	\N	\N	24	7
11681	2	175	400	\N	\N	24	7
11682	18	174	400	\N	\N	24	7
11683	7	211	400	\N	\N	24	7
11684	5	205	400	\N	\N	24	7
11685	33	187	400	\N	\N	24	7
11686	1	191	400	\N	\N	24	7
11687	3	194	400	\N	\N	24	7
11688	3	196	400	\N	\N	24	7
11689	7	181	400	\N	\N	24	7
1169	15	167	10	\N	\N	10	\N
11690	1	4	401	\N	The Lakes neighborhood: Small white goose with black wing tips , small dark bill   Juvenile	24	7
11691	38	7	401	\N	\N	24	7
11692	34	18	401	\N	\N	24	7
11693	25	20	401	\N	\N	24	7
11694	3	28	401	\N	\N	24	7
11695	13	39	401	\N	\N	24	7
11696	13	40	401	\N	\N	24	7
11697	2	43	401	\N	\N	24	7
11698	3	59	401	\N	\N	24	7
11699	1	120	401	\N	\N	24	7
117	45	28	2	\N	\N	2	\N
1170	1	168	10	\N	\N	10	\N
11700	10	131	401	\N	\N	24	7
11701	3	106	401	\N	\N	24	7
11702	10	112	401	\N	\N	24	7
11703	1	116	401	\N	\N	24	7
11704	1	67	401	\N	\N	24	7
11705	14	66	401	\N	\N	24	7
11706	1	79	401	\N	\N	24	7
11707	2	132	401	\N	\N	24	7
11708	2	134	401	\N	\N	24	7
11709	1	135	401	\N	\N	24	7
1171	148	170	10	\N	\N	10	\N
11710	1	135	401	\N	\N	24	7
11711	13	139	401	\N	\N	24	7
11712	8	151	401	\N	\N	24	7
11713	52	153	401	\N	\N	24	7
11714	3	154	401	\N	\N	24	7
11715	33	156	401	\N	\N	24	7
11716	18	158	401	\N	\N	24	7
11717	5	171	401	\N	\N	24	7
11718	22	170	401	\N	\N	24	7
11719	8	161	401	\N	\N	24	7
1172	45	171	10	\N	\N	10	\N
11720	1	163	401	\N	\N	24	7
11721	3	164	401	\N	\N	24	7
11722	6	167	401	\N	\N	24	7
11723	34	176	401	\N	\N	24	7
11724	1	175	401	\N	\N	24	7
11725	80	174	401	\N	\N	24	7
11726	22	204	401	\N	\N	24	7
11727	5	208	401	\N	\N	24	7
11728	3	186	401	\N	\N	24	7
11729	80	189	401	\N	\N	24	7
1173	1	172	10	\N	\N	10	\N
11730	8	191	401	\N	\N	24	7
11731	27	194	401	\N	\N	24	7
11732	14	196	401	\N	\N	24	7
11733	6	181	401	\N	\N	24	7
11734	1	182	401	\N	\N	24	7
11735	1	183	401	\N	\N	24	7
11736	1	184	401	\N	The Lakes neighborhood: Handsome male!	24	7
11737	6	7	402	\N	\N	24	7
11738	3	18	402	\N	\N	24	7
11739	83	20	402	\N	\N	24	7
1174	3	173	10	\N	\N	10	\N
11740	2	28	402	\N	\N	24	7
11741	1	39	402	\N	\N	24	7
11742	5	43	402	\N	\N	24	7
11743	1	58	402	\N	\N	24	7
11744	1	134	402	\N	\N	24	7
11745	3	135	402	\N	\N	24	7
11746	1	136	402	\N	\N	24	7
11747	2	139	402	\N	\N	24	7
11748	4	151	402	\N	\N	24	7
11749	12	153	402	\N	\N	24	7
1175	9813	174	10	\N	\N	10	\N
11750	20	156	402	\N	\N	24	7
11751	8	158	402	\N	\N	24	7
11752	8	171	402	\N	\N	24	7
11753	4	170	402	\N	\N	24	7
11754	7	161	402	\N	\N	24	7
11755	2	163	402	\N	\N	24	7
11756	2	164	402	\N	\N	24	7
11757	3	167	402	\N	\N	24	7
11758	12	131	402	\N	\N	24	7
11759	3	112	402	\N	\N	24	7
1176	56	175	10	\N	\N	10	\N
11760	\N	72	402	t	\N	24	7
11761	1	76	402	\N	Adult	24	7
11762	1	79	402	\N	\N	24	7
11763	15	176	402	\N	\N	24	7
11764	1	175	402	\N	\N	24	7
11765	11	174	402	\N	\N	24	7
11766	2	204	402	\N	\N	24	7
11767	1	208	402	\N	\N	24	7
11768	3	186	402	\N	\N	24	7
11769	77	189	402	\N	\N	24	7
1177	2072	176	10	\N	\N	10	\N
11770	23	194	402	\N	\N	24	7
11771	11	196	402	\N	\N	24	7
11772	1	199	402	\N	\N	24	7
11773	1	184	402	\N	\N	24	7
11774	3	135	403	\N	2 male, 1 female	24	7
11775	2	141	403	\N	1 male, 1 female	24	7
11776	3	137	403	\N	1 male, 2 females	24	7
11777	2	151	403	\N	\N	24	7
11778	2	154	403	\N	\N	24	7
11779	14	160	403	\N	\N	24	7
1178	317	178	10	\N	\N	10	\N
11780	1	161	403	\N	male	24	7
11781	7	175	403	\N	3 males, 4 females	24	7
11782	4	174	403	\N	\N	24	7
11783	6	187	403	\N	3 males, 3 females	24	7
11784	2	196	403	\N	1 male, 1 female	24	7
11785	1	184	403	\N	male	24	7
11786	\N	124	404	t	1	24	7
11787	\N	141	404	t	1	24	7
11788	1	137	404	\N	\N	24	7
11789	\N	151	404	t	1	24	7
1179	4	183	10	\N	\N	10	\N
11790	2	153	404	\N	\N	24	7
11791	1	156	404	\N	\N	24	7
11792	2	158	404	\N	\N	24	7
11793	15	160	404	\N	\N	24	7
11794	1	161	404	\N	\N	24	7
11795	2	131	404	\N	1 male and 1 female	24	7
11796	\N	73	404	t	1	24	7
11797	1	175	404	\N	\N	24	7
11798	2	186	404	\N	\N	24	7
11799	15	189	404	\N	\N	24	7
118	159	29	2	\N	\N	2	\N
1180	132	186	10	\N	\N	10	\N
11800	1	190	404	\N	\N	24	7
11801	2	191	404	\N	\N	24	7
11802	1	194	404	\N	\N	24	7
11803	2	196	404	\N	\N	24	7
11804	41	7	405	\N	\N	24	4
11805	34	18	405	\N	\N	24	4
11806	5	20	405	\N	\N	24	4
11807	28	29	405	\N	\N	24	4
11808	1036	34	405	\N	\N	24	4
11809	135	35	405	\N	Quartermaster Harbor: Verified by Bruce LaBar	24	4
1181	8	188	10	\N	\N	10	\N
11810	366	39	405	\N	\N	24	4
11811	431	40	405	\N	\N	24	4
11812	123	41	405	\N	\N	24	4
11813	1	43	405	\N	\N	24	4
11814	71	44	405	\N	\N	24	4
11815	181	45	405	\N	\N	24	4
11816	228	59	405	\N	\N	24	4
11817	1	60	405	\N	\N	24	4
11818	2	61	405	\N	\N	24	4
11819	4	100	405	\N	\N	24	4
1182	898	189	10	\N	\N	10	\N
11820	3	103	405	\N	\N	24	4
11821	28	106	405	\N	\N	24	4
11822	1	111	405	\N	\N	24	4
11823	149	113	405	\N	\N	24	4
11824	5	53	405	\N	\N	24	4
11825	2	55	405	\N	\N	24	4
11826	87	65	405	\N	\N	24	4
11827	14	67	405	\N	\N	24	4
11828	68	66	405	\N	\N	24	4
11829	5	69	405	\N	\N	24	4
1183	5	190	10	\N	\N	10	\N
11830	2	76	405	\N	\N	24	4
11831	4	132	405	\N	\N	24	4
11832	1	151	405	\N	\N	24	4
11833	30	153	405	\N	\N	24	4
11834	14	5	406	\N	\N	24	1
11835	9	20	407	\N	\N	24	1
11836	8	28	407	\N	\N	24	1
11837	7	33	407	\N	\N	24	1
11838	22	34	407	\N	\N	24	1
11839	9	39	407	\N	\N	24	1
1184	96	191	10	\N	\N	10	\N
11840	7	40	407	\N	\N	24	1
11841	2	43	407	\N	\N	24	1
11842	1	45	407	\N	\N	24	1
11843	5	59	407	\N	\N	24	1
11844	2	60	407	\N	\N	24	1
11845	1	134	407	\N	\N	24	1
11846	7	151	407	\N	\N	24	1
11847	12	153	407	\N	\N	24	1
11848	1	154	407	\N	\N	24	1
11849	1	156	407	\N	\N	24	1
1185	2	193	10	\N	\N	10	\N
11850	5	158	407	\N	\N	24	1
11851	2	161	407	\N	\N	24	1
11852	4	131	407	\N	\N	24	1
11853	7	100	407	\N	\N	24	1
11854	17	116	407	\N	\N	24	1
11855	10	65	407	\N	\N	24	1
11856	2	66	407	\N	\N	24	1
11857	2	69	407	\N	\N	24	1
11858	5	176	407	\N	\N	24	1
11859	1	175	407	\N	\N	24	1
1186	244	194	10	\N	\N	10	\N
11860	10	174	407	\N	\N	24	1
11861	10	208	407	\N	\N	24	1
11862	2	186	407	\N	\N	24	1
11863	22	187	407	\N	\N	24	1
11864	6	191	407	\N	\N	24	1
11865	4	194	407	\N	\N	24	1
11866	4	196	407	\N	\N	24	1
11867	1	135	408	\N	\N	24	1
11868	1	137	408	\N	\N	24	1
11869	7	139	408	\N	\N	24	1
1187	4	195	10	\N	\N	10	\N
11870	1	140	408	\N	\N	24	1
11871	3	156	408	\N	\N	24	1
11872	8	158	408	\N	\N	24	1
11873	2	170	408	\N	\N	24	1
11874	1	161	408	\N	\N	24	1
11875	5	131	408	\N	\N	24	1
11876	1	79	408	\N	\N	24	1
11877	7	176	408	\N	\N	24	1
11878	3	175	408	\N	and calling	24	1
11879	41	174	408	\N	\N	24	1
1188	196	196	10	\N	\N	10	\N
11880	2	204	408	\N	\N	24	1
11881	2	186	408	\N	\N	24	1
11882	12	187	408	\N	\N	24	1
11883	21	189	408	\N	\N	24	1
11884	6	191	408	\N	\N	24	1
11885	1	193	408	\N	Tan-striped form.  Pretty good look at it in shrubs near feeders at Roseballen.  White throat with obvious dusky-gray margin or boarder at upper breast.  Tan head streak instead of white.  I returned to look for it on the 6th (the next chance I had) but very few birds of any species were present.	24	1
11886	5	196	408	\N	\N	24	1
11887	1	183	408	\N	\N	24	1
11888	2	6	409	\N	\N	24	1
11889	19	7	409	\N	\N	24	1
1189	190	199	10	\N	\N	10	\N
11890	55	34	409	\N	\N	24	1
11891	27	39	409	\N	\N	24	1
11892	36	40	409	\N	\N	24	1
11893	3	44	409	\N	\N	24	1
11894	43	45	409	\N	\N	24	1
11895	49	59	409	\N	\N	24	1
11896	18	60	409	\N	\N	24	1
11897	1	62	409	\N	\N	24	1
11898	5	131	409	\N	\N	24	1
11899	2	87	409	\N	\N	24	1
119	14	30	2	\N	\N	2	\N
1190	65	201	10	\N	\N	10	\N
11900	4	100	409	\N	\N	24	1
11901	14	106	409	\N	\N	24	1
11902	3	112	409	\N	\N	24	1
11903	26	113	409	\N	\N	24	1
11904	29	114	409	\N	\N	24	1
11905	5	53	409	\N	\N	24	1
11906	3	54	409	\N	Muckleshoot Property - Vashon: Good Scope views at 150-200 m of Three birds swimming together.  Observed black 'chin' line on one bird; all three were larger - and with more robust bills - than Red-throated Loon; rounded heads; dark backs; bills not 'upturned'	24	1
11907	5	55	409	\N	\N	24	1
11908	1	65	409	\N	\N	24	1
11909	5	66	409	\N	\N	24	1
1191	1	203	10	\N	\N	10	\N
11910	2	69	409	\N	\N	24	1
11911	7	76	409	\N	Vashon Island - Glen Landing: Third year\nVashon Island - Point Beals: Adult and 3rd year	24	1
11912	1	79	409	\N	\N	24	1
11913	1	132	409	\N	\N	24	1
11914	2	134	409	\N	\N	24	1
11915	1	135	409	\N	\N	24	1
11916	7	137	409	\N	\N	24	1
11917	3	139	409	\N	\N	24	1
11918	2	144	409	\N	\N	24	1
11919	7	151	409	\N	\N	24	1
1192	336	204	10	\N	\N	10	\N
11920	35	153	409	\N	\N	24	1
11921	4	156	409	\N	\N	24	1
11922	37	158	409	\N	\N	24	1
11923	12	160	409	\N	\N	24	1
11924	4	171	409	\N	\N	24	1
11925	29	170	409	\N	\N	24	1
11926	13	161	409	\N	\N	24	1
11927	1	163	409	\N	\N	24	1
11928	18	164	409	\N	\N	24	1
11929	3	176	409	\N	\N	24	1
1193	38	205	10	\N	\N	10	\N
11930	13	175	409	\N	\N	24	1
11931	137	174	409	\N	\N	24	1
11932	2	178	409	\N	\N	24	1
11933	5	211	409	\N	\N	24	1
11934	1	205	409	\N	\N	24	1
11935	12	186	409	\N	\N	24	1
11936	98	189	409	\N	\N	24	1
11937	1	190	409	\N	\N	24	1
11938	20	191	409	\N	\N	24	1
11939	75	194	409	\N	\N	24	1
1194	9	206	10	\N	\N	10	\N
11940	35	196	409	\N	\N	24	1
11941	2	181	409	\N	\N	24	1
11942	5	183	409	\N	\N	24	1
11943	1	6	410	\N	\N	24	1
11944	21	7	410	\N	\N	24	1
11945	2	18	410	\N	\N	24	1
11946	10	20	410	\N	\N	24	1
11947	2	24	410	\N	\N	24	1
11948	8	28	410	\N	\N	24	1
11949	2	34	410	\N	\N	24	1
1195	1361	207	10	\N	\N	10	\N
11950	6	39	410	\N	\N	24	1
11951	7	40	410	\N	\N	24	1
11952	1	41	410	\N	\N	24	1
11953	11	44	410	\N	\N	24	1
11954	2	45	410	\N	\N	24	1
11955	1	59	410	\N	\N	24	1
11956	1	60	410	\N	\N	24	1
11957	8	117	410	\N	\N	24	1
11958	2	134	410	\N	\N	24	1
11959	8	137	410	\N	\N	24	1
1196	86	208	10	\N	\N	10	\N
11960	3	151	410	\N	\N	24	1
11961	7	153	410	\N	\N	24	1
11962	6	154	410	\N	\N	24	1
11963	20	156	410	\N	\N	24	1
11964	5	158	410	\N	\N	24	1
11965	1	171	410	\N	\N	24	1
11966	7	170	410	\N	\N	24	1
11967	2	161	410	\N	\N	24	1
11968	9	164	410	\N	\N	24	1
11969	3	131	410	\N	\N	24	1
1197	92	211	10	\N	\N	10	\N
11970	2	86	410	\N	\N	24	1
11971	1	112	410	\N	\N	24	1
11972	3	116	410	\N	\N	24	1
11973	1	67	410	\N	\N	24	1
11974	1	66	410	\N	\N	24	1
11975	1	79	410	\N	\N	24	1
11976	8	176	410	\N	\N	24	1
11977	4	175	410	\N	\N	24	1
11978	1	173	410	\N	\N	24	1
11979	72	174	410	\N	\N	24	1
1198	7	2	11	\N	\N	11	\N
11980	10	211	410	\N	\N	24	1
11981	25	204	410	\N	\N	24	1
11982	3	208	410	\N	\N	24	1
11983	5	186	410	\N	\N	24	1
11984	68	187	410	\N	\N	24	1
11985	5	190	410	\N	\N	24	1
11986	17	191	410	\N	\N	24	1
11987	1	193	410	\N	\N	24	1
11988	14	194	410	\N	\N	24	1
11989	6	196	410	\N	\N	24	1
1199	13	5	11	\N	\N	11	\N
11990	3	199	410	\N	\N	24	1
11991	140	18	411	\N	\N	24	1
11992	124	20	411	\N	\N	24	1
11993	1	23	411	\N	\N	24	1
11994	26	33	411	\N	\N	24	1
11995	3	34	411	\N	\N	24	1
11996	17	35	411	\N	\N	24	1
11997	55	39	411	\N	\N	24	1
11998	59	40	411	\N	\N	24	1
11999	3	41	411	\N	\N	24	1
12	6	30	1	\N	\N	1	\N
120	1	33	2	\N	\N	2	\N
1200	448	7	11	\N	\N	11	\N
12000	4	44	411	\N	\N	24	1
12001	5	45	411	\N	\N	24	1
12002	2	58	411	\N	\N	24	1
12003	20	59	411	\N	\N	24	1
12004	6	60	411	\N	\N	24	1
12005	1	132	411	\N	\N	24	1
12006	3	135	411	\N	\N	24	1
12007	1	141	411	\N	\N	24	1
12008	6	137	411	\N	\N	24	1
12009	3	151	411	\N	\N	24	1
1201	7	11	11	\N	\N	11	\N
12010	65	153	411	\N	\N	24	1
12011	12	156	411	\N	\N	24	1
12012	6	158	411	\N	\N	24	1
12013	22	160	411	\N	\N	24	1
12014	2	171	411	\N	\N	24	1
12015	7	170	411	\N	\N	24	1
12016	6	161	411	\N	\N	24	1
12017	5	164	411	\N	\N	24	1
12018	4	167	411	\N	\N	24	1
12019	1	131	411	\N	\N	24	1
1202	14	15	11	\N	\N	11	\N
12020	1	99	411	\N	\N	24	1
12021	5	100	411	\N	\N	24	1
12022	2	106	411	\N	\N	24	1
12023	1	112	411	\N	\N	24	1
12024	17	113	411	\N	\N	24	1
12025	125	116	411	\N	distant north edge circle	24	1
12026	3	53	411	\N	\N	24	1
12027	12	55	411	\N	\N	24	1
12028	2	67	411	\N	\N	24	1
12029	3	66	411	\N	\N	24	1
1203	12	16	11	\N	\N	11	\N
12030	1	69	411	\N	\N	24	1
12031	2	76	411	\N	\N	24	1
12032	1	176	411	\N	\N	24	1
12033	1	175	411	\N	\N	24	1
12034	104	174	411	\N	\N	24	1
12035	4	211	411	\N	\N	24	1
12036	12	204	411	\N	\N	24	1
12037	2	186	411	\N	\N	24	1
12038	15	189	411	\N	\N	24	1
12039	6	191	411	\N	\N	24	1
1204	12	17	11	\N	\N	11	\N
12040	31	194	411	\N	\N	24	1
12041	4	196	411	\N	\N	24	1
12042	1	199	411	\N	\N	24	1
12043	3	181	411	\N	\N	24	1
12044	1	184	411	\N	\N	24	1
12045	1	167	412	\N	\N	24	1
12046	2	131	412	\N	\N	24	1
12047	4	176	412	\N	\N	24	1
12048	1	173	412	\N	\N	24	1
12049	25	174	412	\N	\N	24	1
1205	4655	18	11	\N	\N	11	\N
12050	2	204	412	\N	\N	24	1
12051	9	189	412	\N	\N	24	1
12052	4	191	412	\N	\N	24	1
12053	2	194	412	\N	\N	24	1
12054	1	199	412	\N	\N	24	1
12055	2	183	412	\N	\N	24	1
12056	43	7	413	\N	\N	24	1
12057	1	17	413	\N	\N	24	1
12058	31	18	413	\N	\N	24	1
12059	13	20	413	\N	\N	24	1
1206	695	20	11	\N	\N	11	\N
12060	20	34	413	\N	\N	24	1
12061	25	39	413	\N	\N	24	1
12062	71	40	413	\N	\N	24	1
12063	4	41	413	\N	\N	24	1
12064	3	45	413	\N	\N	24	1
12065	22	59	413	\N	\N	24	1
12066	10	60	413	\N	\N	24	1
12067	2	131	413	\N	\N	24	1
12068	6	86	413	\N	\N	24	1
12069	2	87	413	\N	\N	24	1
1207	23	22	11	\N	\N	11	\N
12070	1	103	413	\N	\N	24	1
12071	91	106	413	\N	\N	24	1
12072	9	113	413	\N	\N	24	1
12073	4	116	413	\N	\N	24	1
12074	1	57	413	\N	\N	24	1
12075	15	66	413	\N	\N	24	1
12076	2	69	413	\N	\N	24	1
12077	1	76	413	\N	\N	24	1
12078	1	79	413	\N	\N	24	1
12079	4	132	413	\N	\N	24	1
1208	8	23	11	\N	\N	11	\N
12080	1	135	413	\N	\N	24	1
12081	2	137	413	\N	\N	24	1
12082	2	151	413	\N	\N	24	1
12083	14	153	413	\N	\N	24	1
12084	13	156	413	\N	\N	24	1
12085	11	158	413	\N	\N	24	1
12086	2	171	413	\N	\N	24	1
12087	14	170	413	\N	\N	24	1
12088	6	161	413	\N	\N	24	1
12089	5	164	413	\N	\N	24	1
1209	61	24	11	\N	\N	11	\N
12090	6	176	413	\N	\N	24	1
12091	3	175	413	\N	\N	24	1
12092	18	174	413	\N	\N	24	1
12093	2	211	413	\N	\N	24	1
12094	4	204	413	\N	\N	24	1
12095	32	210	413	\N	16305 Crescent Dr SW, Vashon: large flying flock, seemed like pine siskins, but the view was brief and they weren't seen again	24	1
12096	26	187	413	\N	\N	24	1
12097	11	191	413	\N	\N	24	1
12098	21	194	413	\N	\N	24	1
12099	9	196	413	\N	\N	24	1
121	836	34	2	\N	\N	2	\N
1210	17	25	11	\N	\N	11	\N
12100	1	184	413	\N	\N	24	1
12101	2	137	414	\N	\N	24	1
12102	2	154	414	\N	\N	24	1
12103	3	158	414	\N	\N	24	1
12104	1	170	414	\N	\N	24	1
12105	2	164	414	\N	\N	24	1
12106	2	131	414	\N	\N	24	1
12107	2	175	414	\N	\N	24	1
12108	2	174	414	\N	\N	24	1
12109	1	194	414	\N	\N	24	1
1211	150	28	11	\N	\N	11	\N
12110	1	137	415	\N	\N	24	1
12111	1	156	415	\N	\N	24	1
12112	5	158	415	\N	\N	24	1
12113	1	161	415	\N	\N	24	1
12114	1	164	415	\N	\N	24	1
12115	3	131	415	\N	\N	24	1
12116	1	175	415	\N	\N	24	1
12117	5	187	415	\N	\N	24	1
12118	1	194	415	\N	\N	24	1
12119	3	196	415	\N	\N	24	1
1212	117	29	11	\N	\N	11	\N
12120	1	134	416	\N	\N	24	1
12121	2	151	417	\N	\N	24	2
12122	3	153	417	\N	\N	24	2
12123	2	156	417	\N	\N	24	2
12124	7	158	417	\N	\N	24	2
12125	1	161	417	\N	\N	24	2
12126	2	131	417	\N	\N	24	2
12127	2	175	417	\N	\N	24	2
12128	7	174	417	\N	\N	24	2
12129	2	204	417	\N	\N	24	2
1213	12	30	11	\N	\N	11	\N
12130	1	206	417	\N	\N	24	2
12131	8	187	417	\N	\N	24	2
12132	1	191	417	\N	\N	24	2
12133	4	194	417	\N	\N	24	2
12134	2	196	417	\N	\N	24	2
12135	1	72	418	\N	\N	24	1
12136	1	55	419	\N	\N	24	1
12137	36	7	420	\N	\N	24	2
12138	0	14	420	\N	Monument: Reported 1 from this location, but there is a known domestic Muscovy population at a nearby farm	24	2
12139	4	18	420	\N	\N	24	2
1214	78	31	11	\N	\N	11	\N
12140	1	39	420	\N	\N	24	2
12141	4	117	420	\N	\N	24	2
12142	5	131	420	\N	\N	24	2
12143	5	86	420	\N	\N	24	2
12144	2	95	420	\N	\N	24	2
12145	3	106	420	\N	\N	24	2
12146	9	112	420	\N	\N	24	2
12147	1	69	420	\N	\N	24	2
12148	1	76	420	\N	\N	24	2
12149	1	132	420	\N	\N	24	2
1215	36	33	11	\N	\N	11	\N
12150	2	134	420	\N	\N	24	2
12151	1	135	420	\N	\N	24	2
12152	2	137	420	\N	\N	24	2
12153	1	144	420	\N	\N	24	2
12154	1	151	420	\N	\N	24	2
12155	21	153	420	\N	\N	24	2
12156	1	154	420	\N	\N	24	2
12157	18	156	420	\N	\N	24	2
12158	18	158	420	\N	\N	24	2
12159	3	171	420	\N	\N	24	2
1216	1233	34	11	\N	\N	11	\N
12160	25	170	420	\N	\N	24	2
12161	1	161	420	\N	\N	24	2
12162	2	163	420	\N	\N	24	2
12163	4	164	420	\N	\N	24	2
12164	26	176	420	\N	\N	24	2
12165	5	175	420	\N	\N	24	2
12166	27	174	420	\N	\N	24	2
12167	3	204	420	\N	\N	24	2
12168	2	208	420	\N	\N	24	2
12169	2	186	420	\N	\N	24	2
1217	328	35	11	\N	\N	11	\N
12170	59	187	420	\N	\N	24	2
12171	2	190	420	\N	\N	24	2
12172	9	194	420	\N	\N	24	2
12173	3	196	420	\N	\N	24	2
12174	5	199	420	\N	\N	24	2
12175	23	18	421	\N	\N	24	2
12176	1	34	421	\N	\N	24	2
12177	26	39	421	\N	\N	24	2
12178	28	40	421	\N	\N	24	2
12179	3	41	421	\N	\N	24	2
1218	26	36	11	\N	\N	11	\N
12180	25	44	421	\N	\N	24	2
12181	20	45	421	\N	\N	24	2
12182	21	59	421	\N	\N	24	2
12183	1	132	421	\N	\N	24	2
12184	4	153	421	\N	\N	24	2
12185	2	154	421	\N	\N	24	2
12186	5	86	421	\N	\N	24	2
12187	1	87	421	\N	\N	24	2
12188	53	106	421	\N	\N	24	2
12189	20	116	421	\N	\N	24	2
1219	676	39	11	\N	\N	11	\N
12190	1	67	421	\N	\N	24	2
12191	11	66	421	\N	\N	24	2
12192	1	76	421	\N	\N	24	2
12193	8	174	421	\N	\N	24	2
12194	1	194	421	\N	\N	24	2
12195	3	34	422	\N	near shore, SSE of Neill Point	24	2
12196	2	35	422	\N	Tahlequah	24	2
12197	5	39	422	\N	Tahlequah	24	2
12198	4	40	422	\N	Tahlequah	24	2
12199	3	41	422	\N	Tahlequah	24	2
122	448	35	2	\N	\N	2	\N
1220	447	40	11	\N	\N	11	\N
12200	24	44	422	\N	\N	24	2
12201	2	45	422	\N	Tahlequah	24	2
12202	5	59	422	\N	3 near shore, SSE of Neill Point; 2 Tahlequah -- originally reported as EAGR	24	2
12203	4	117	422	\N	Tahlequah	24	2
12204	1	132	422	\N	\N	24	2
12205	2	135	422	\N	\N	24	2
12206	1	137	422	\N	\N	24	2
12207	4	139	422	\N	\N	24	2
12208	5	153	422	\N	\N	24	2
12209	2	154	422	\N	\N	24	2
1221	142	41	11	\N	\N	11	\N
12210	2	156	422	\N	\N	24	2
12211	27	158	422	\N	\N	24	2
12212	4	171	422	\N	\N	24	2
12213	30	170	422	\N	\N	24	2
12214	9	161	422	\N	\N	24	2
12215	3	163	422	\N	\N	24	2
12216	17	164	422	\N	\N	24	2
12217	3	167	422	\N	\N	24	2
12218	3	112	422	\N	Tahlequah	24	2
12219	4	113	422	\N	Tahlequah -- originally reported as HERG	24	2
1222	28	42	11	\N	\N	11	\N
12220	13	53	422	\N	in group in Colvos Psg	24	2
12221	2	65	422	\N	Colvos Psg	24	2
12222	1	67	422	\N	\N	24	2
12223	8	66	422	\N	\N	24	2
12224	3	175	422	\N	\N	24	2
12225	16	174	422	\N	\N	24	2
12226	5	186	422	\N	\N	24	2
12227	42	187	422	\N	seen by car	24	2
12228	70	189	422	\N	\N	24	2
12229	50	194	422	\N	\N	24	2
1223	94	43	11	\N	\N	11	\N
12230	35	196	422	\N	\N	24	2
12231	19	7	423	\N	Vashon, 13700 220th Street: Resting and sleeping in front of a house.	24	2
12232	1	17	423	\N	Lisabuela Park: Originally reported 1, also recorded on other checklist for this location	24	2
12233	32	18	423	\N	Lisabuela Park: Originally reported 16, higher count on other checklist for this location	24	2
12234	1	28	423	\N	Vashon, Ernst Pond: Seen and heard calling when a bufflehead approached.	24	2
12235	5	35	423	\N	\N	24	2
12236	14	39	423	\N	Lisabuela Park: Originally reported 8, higher count on other checklist for this location	24	2
12237	3	40	423	\N	Lisabuela Park: Originally reported 2, higher count on other checklist for this location	24	2
12238	27	44	423	\N	\N	24	2
12239	9	59	423	\N	Lisabuela Park: Originally reported 3, higher count on other checklist for this location	24	2
1224	302	44	11	\N	\N	11	\N
12240	28	117	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: Originally reported 9, higher count on other checklist for this location	24	2
12241	1	131	423	\N	\N	24	2
12242	2	86	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: Calling and moving through the horse pastures.\nLisabuela Park: Originally reported 1, also recorded on other checklist for this location	24	2
12243	1	87	423	\N	Lisabuela Park: Doing lots of tail bobs!	24	2
12244	1	101	423	\N	\N	24	2
12245	5	113	423	\N	Lisabuela Park: Originally reported 2, higher count on other checklist for this location	24	2
12246	1	67	423	\N	\N	24	2
12247	3	66	423	\N	\N	24	2
12248	1	69	423	\N	\N	24	2
12249	1	76	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: In the top of a tree drying its wings like a cormorant.  Perhaps it had been swimming with food, since it hadn't been raining.	24	2
1225	254	45	11	\N	\N	11	\N
12250	4	79	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: Originally reported 1, higher count on other checklist for this location	24	2
12251	1	132	423	\N	Lisabuela Park: Originally reported 1, also recorded on other checklist for this location	24	2
12252	1	134	423	\N	\N	24	2
12253	1	133	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: On utility pole when VL arrived and flew off soon after.\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 1, also recorded on other checklist for this location -- Continuing. Sitting on phone pole	24	2
12254	1	141	423	\N	\N	24	2
12255	5	137	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: Originally reported 2, also recorded on other checklist for this location\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 2, also recorded on other checklist for this location\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 2, also recorded on other checklist for this location	24	2
12256	1	143	423	\N	\N	24	2
12257	1	149	423	\N	\N	24	2
12258	5	151	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: Originally reported 1, also recorded on other checklist for this location	24	2
12259	17	153	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: Originally reported 1, higher count on other checklist for this location\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 3, also recorded on other checklist for this location	24	2
1226	21	47	11	\N	\N	11	\N
12260	4	154	423	\N	\N	24	2
12261	5	156	423	\N	\N	24	2
12262	22	158	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: Originally reported 2, higher count on other checklist for this location	24	2
12263	4	171	423	\N	\N	24	2
12264	23	170	423	\N	\N	24	2
12265	10	161	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: Originally reported 1, also recorded on other checklist for this location	24	2
12266	4	163	423	\N	\N	24	2
12267	5	164	423	\N	\N	24	2
12268	3	167	423	\N	\N	24	2
12269	61	176	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: Originally reported 30, higher count on other checklist for this location\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 5, higher count on other checklist for this location\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 9, higher count on other checklist for this location\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 40, higher count on other checklist for this location	24	2
1227	15	50	11	\N	\N	11	\N
12270	4	175	423	\N	\N	24	2
12271	2	173	423	\N	\N	24	2
12272	155	174	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: Originally reported 6, higher count on other checklist for this location\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 2, higher count on other checklist for this location\nLisabuela Park: Originally reported 20, higher count on other checklist for this location\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 30, higher count on other checklist for this location\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 30, higher count on other checklist for this location\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 60, higher count on other checklist for this location	24	2
12273	2	211	423	\N	\N	24	2
12274	1	205	423	\N	\N	24	2
12275	2	208	423	\N	\N	24	2
12276	3	186	423	\N	\N	24	2
12277	33	187	423	\N	Vashon Island--Wax Orchards/Airport on 232nd: Originally reported 9, higher count on other checklist for this location\nVashon Island--Wax Orchards/Airport on 232nd: Originally reported 9, higher count on other checklist for this location	24	2
12278	1	190	423	\N	\N	24	2
12279	29	194	423	\N	Lisabuela Park: Originally reported 1, higher count on other checklist for this location	24	2
1228	5	51	11	\N	\N	11	\N
12280	21	196	423	\N	\N	24	2
12281	31	199	423	\N	\N	24	2
12282	1	137	424	\N	\N	24	2
12283	2	151	424	\N	\N	24	2
12284	2	153	424	\N	\N	24	2
12285	4	156	424	\N	\N	24	2
12286	3	161	424	\N	\N	24	2
12287	1	131	424	\N	male	24	2
12288	1	76	424	\N	fly by	24	2
12289	2	174	424	\N	\N	24	2
1229	61	53	11	\N	\N	11	\N
12290	3	204	424	\N	1 male + 2 female	24	2
12291	1	186	424	\N	\N	24	2
12292	14	187	424	\N	3 originally reported as Slate-colored	24	2
12293	1	189	424	\N	with leucism -- ID by Ezra Parker	24	2
12294	2	194	424	\N	\N	24	2
12295	5	196	424	\N	\N	24	2
12296	2	135	425	\N	\N	24	2
12297	1	141	425	\N	\N	24	2
12298	4	137	425	\N	\N	24	2
12299	2	151	425	\N	\N	24	2
123	16	36	2	\N	\N	2	\N
1230	198	54	11	\N	\N	11	\N
12300	3	153	425	\N	\N	24	2
12301	1	154	425	\N	\N	24	2
12302	2	156	425	\N	\N	24	2
12303	6	158	425	\N	\N	24	2
12304	1	171	425	\N	\N	24	2
12305	4	161	425	\N	\N	24	2
12306	1	164	425	\N	\N	24	2
12307	1	131	425	\N	\N	24	2
12308	1	79	425	\N	\N	24	2
12309	6	176	425	\N	\N	24	2
1231	50	55	11	\N	\N	11	\N
12310	2	175	425	\N	\N	24	2
12311	12	174	425	\N	\N	24	2
12312	1	207	425	\N	\N	24	2
12313	2	186	425	\N	\N	24	2
12314	8	187	425	\N	\N	24	2
12315	2	190	425	\N	\N	24	2
12316	2	191	425	\N	\N	24	2
12317	2	194	425	\N	\N	24	2
12318	5	196	425	\N	\N	24	2
12319	1	139	426	\N	1♀	24	2
1232	10	57	11	\N	\N	11	\N
12320	1	151	426	\N	\N	24	2
12321	2	153	426	\N	\N	24	2
12322	1	156	426	\N	\N	24	2
12323	2	158	426	\N	\N	24	2
12324	1	161	426	\N	\N	24	2
12325	1	164	426	\N	Entered as MAWR, changed to PAWR	24	2
12326	1	131	426	\N	1 ♂	24	2
12327	0	75	426	\N	Originally entered as 1 (Inferred from kill), removed due to lack of first-hand observation	24	2
12328	3	175	426	\N	2♂1♀	24	2
12329	1	174	426	\N	1♂	24	2
1233	27	58	11	\N	\N	11	\N
12330	1	211	426	\N	1♂	24	2
12331	1	186	426	\N	\N	24	2
12332	16	187	426	\N	\N	24	2
12333	1	190	426	\N	\N	24	2
12334	2	191	426	\N	\N	24	2
12335	0	193	426	\N	\N	24	2
12336	2	194	426	\N	\N	24	2
12337	3	196	426	\N	3♂	24	2
12338	1	197	426	\N	Originally reported as WTSP	24	2
12339	1	7	427	\N	\N	24	2
1234	410	59	11	\N	\N	11	\N
12340	1	141	427	\N	\N	24	2
12341	1	137	427	\N	\N	24	2
12342	1	151	427	\N	\N	24	2
12343	1	156	427	\N	\N	24	2
12344	1	161	427	\N	\N	24	2
12345	1	167	427	\N	\N	24	2
12346	1	174	427	\N	\N	24	2
12347	1	194	427	\N	\N	24	2
12348	2	126	428	\N	\N	24	2
12349	2	154	428	\N	\N	24	2
1235	84	60	11	\N	\N	11	\N
12350	2	158	428	\N	\N	24	2
12351	2	170	428	\N	\N	24	2
12352	2	161	428	\N	\N	24	2
12353	1	163	428	\N	\N	24	2
12354	3	131	428	\N	2 males, 1 female	24	2
12355	1	175	428	\N	\N	24	2
12356	13	187	428	\N	\N	24	2
12357	8	196	428	\N	\N	24	2
12358	7	197	428	\N	Originally reported as 7 FOSP w/ no SOSP	24	2
12359	\N	126	429	t	2 Jan. 1 night, hooting	24	2
1236	8	61	11	\N	\N	11	\N
12360	2	154	429	\N	\N	24	2
12361	1	171	429	\N	male	24	2
12362	3	170	429	\N	1 male, 2 female	24	2
12363	3	161	429	\N	\N	24	2
12364	2	131	429	\N	1 male, 1 female	24	2
12365	1	76	429	\N	adult, flyover	24	2
12366	2	187	429	\N	\N	24	2
12367	2	194	429	\N	\N	24	2
12368	2	196	429	\N	\N	24	2
12369	1	134	430	\N	\N	24	2
1237	742	62	11	\N	\N	11	\N
12370	1	137	430	\N	\N	24	2
12371	1	156	430	\N	\N	24	2
12372	1	131	430	\N	\N	24	2
12373	16	189	430	\N	\N	24	2
12374	1	194	430	\N	\N	24	2
12375	1	126	431	\N	\N	24	2
12376	16	7	432	\N	flying over	24	2
12377	1	139	432	\N	flying over	24	2
12378	3	156	432	\N	\N	24	2
12379	25	160	432	\N	\N	24	2
1238	39	65	11	\N	\N	11	\N
12380	1	161	432	\N	\N	24	2
12381	3	131	432	\N	\N	24	2
12382	2	175	432	\N	\N	24	2
12383	2	174	432	\N	\N	24	2
12384	6	211	432	\N	\N	24	2
12385	5	187	432	\N	\N	24	2
12386	3	190	432	\N	\N	24	2
12387	3	191	432	\N	\N	24	2
12388	2	194	432	\N	\N	24	2
12389	3	196	432	\N	\N	24	2
1239	289	66	11	\N	\N	11	\N
12390	4	197	432	\N	\N	24	2
12391	1	131	433	\N	\N	25	5
12392	1	137	433	\N	\N	25	5
12393	1	149	433	\N	\N	25	5
12394	2	151	433	\N	\N	25	5
12395	1	154	433	\N	\N	25	5
12396	5	156	433	\N	\N	25	5
12397	3	158	433	\N	\N	25	5
12398	3	171	433	\N	\N	25	5
12399	1	170	433	\N	\N	25	5
124	\N	38	2	t	\N	2	\N
1240	28	67	11	\N	\N	11	\N
12400	1	166	433	\N	\N	25	5
12401	9	174	433	\N	\N	25	5
12402	2	186	433	\N	\N	25	5
12403	1	187	433	\N	\N	25	5
12404	15	189	433	\N	\N	25	5
12405	20	191	433	\N	\N	25	5
12406	4	194	433	\N	\N	25	5
12407	2	196	433	\N	\N	25	5
12408	5	16	434	\N	\N	25	5
12409	2	17	434	\N	\N	25	5
1241	3	68	11	\N	\N	11	\N
12410	1434	18	434	\N	\N	25	5
12411	52	20	434	\N	\N	25	5
12412	1	24	434	\N	\N	25	5
12413	5	28	434	\N	\N	25	5
12414	84	29	434	\N	\N	25	5
12415	7	30	434	\N	\N	25	5
12416	10	31	434	\N	\N	25	5
12417	5	33	434	\N	\N	25	5
12418	129	34	434	\N	\N	25	5
12419	5	35	434	\N	\N	25	5
1242	49	69	11	\N	\N	11	\N
12420	178	39	434	\N	\N	25	5
12421	150	40	434	\N	\N	25	5
12422	3	41	434	\N	\N	25	5
12423	10	43	434	\N	\N	25	5
12424	2	44	434	\N	\N	25	5
12425	72	45	434	\N	\N	25	5
12426	105	59	434	\N	\N	25	5
12427	18	60	434	\N	\N	25	5
12428	112	62	434	\N	\N	25	5
12429	5	117	434	\N	\N	25	5
1243	2	71	11	\N	\N	11	\N
12430	8	131	434	\N	\N	25	5
12431	3	86	434	\N	\N	25	5
12432	8	89	434	\N	\N	25	5
12433	5	91	434	\N	\N	25	5
12434	8	103	434	\N	\N	25	5
12435	27	100	434	\N	\N	25	5
12436	10	99	434	\N	\N	25	5
12437	25	105	434	\N	\N	25	5
12438	252	106	434	\N	\N	25	5
12439	1	110	434	\N	\N	25	5
1244	6	72	11	\N	\N	11	\N
12440	11	109	434	\N	\N	25	5
12441	14	112	434	\N	\N	25	5
12442	16	113	434	\N	\N	25	5
12443	58	114	434	\N	\N	25	5
12444	7	111	434	\N	\N	25	5
12445	10	116	434	\N	\N	25	5
12446	5	53	434	\N	\N	25	5
12447	7	54	434	\N	\N	25	5
12448	9	65	434	\N	\N	25	5
12449	16	67	434	\N	\N	25	5
1245	6	73	11	\N	\N	11	\N
12450	32	66	434	\N	\N	25	5
12451	8	68	434	\N	\N	25	5
12452	2	69	434	\N	\N	25	5
12453	2	73	434	\N	\N	25	5
12454	8	76	434	\N	Southworth Ferry Terminal: Adults At 0858\n10621 Southeast Olympiad Drive, Port Orchard: 1 Adult 11:15, 1 immature 11:22\nHarper Park and estuary: Adults\nYukon Harbor: Adults	25	5
12455	3	132	434	\N	\N	25	5
12456	1	135	434	\N	\N	25	5
12457	2	136	434	\N	\N	25	5
12458	2	137	434	\N	\N	25	5
12459	2	139	434	\N	\N	25	5
1246	1	75	11	\N	\N	11	\N
12460	1	149	434	\N	\N	25	5
12461	3	151	434	\N	\N	25	5
12462	6	152	434	\N	\N	25	5
12463	168	153	434	\N	\N	25	5
12464	3	154	434	\N	\N	25	5
12465	18	156	434	\N	\N	25	5
12466	5	158	434	\N	\N	25	5
12467	36	160	434	\N	\N	25	5
12468	16	171	434	\N	\N	25	5
12469	16	170	434	\N	\N	25	5
1247	45	76	11	\N	\N	11	\N
12470	1	161	434	\N	\N	25	5
12471	3	163	434	\N	\N	25	5
12472	4	164	434	\N	\N	25	5
12473	5	167	434	\N	\N	25	5
12474	47	176	434	\N	\N	25	5
12475	1	175	434	\N	\N	25	5
12476	81	174	434	\N	\N	25	5
12477	2	211	434	\N	\N	25	5
12478	12	204	434	\N	\N	25	5
12479	60	207	434	\N	\N	25	5
1248	16	79	11	\N	\N	11	\N
12480	3	186	434	\N	\N	25	5
12481	29	187	434	\N	\N	25	5
12482	21	189	434	\N	\N	25	5
12483	15	191	434	\N	\N	25	5
12484	23	194	434	\N	\N	25	5
12485	8	196	434	\N	\N	25	5
12486	8	181	434	\N	\N	25	5
12487	2	182	434	\N	\N	25	5
12488	1	183	434	\N	\N	25	5
12489	4	184	434	\N	\N	25	5
1249	1	81	11	\N	\N	11	\N
12490	24	18	435	\N	\N	25	5
12491	25	20	435	\N	\N	25	5
12492	2	137	435	\N	\N	25	5
12493	2	151	435	\N	\N	25	5
12494	3	153	435	\N	\N	25	5
12495	1	154	435	\N	\N	25	5
12496	2	156	435	\N	\N	25	5
12497	15	158	435	\N	\N	25	5
12498	4	171	435	\N	\N	25	5
12499	42	170	435	\N	\N	25	5
125	298	39	2	\N	\N	2	\N
1250	1	82	11	\N	\N	11	\N
12500	5	161	435	\N	\N	25	5
12501	2	163	435	\N	\N	25	5
12502	8	164	435	\N	\N	25	5
12503	2	167	435	\N	\N	25	5
12504	4	176	435	\N	\N	25	5
12505	3	175	435	\N	\N	25	5
12506	22	174	435	\N	\N	25	5
12507	4	196	435	\N	\N	25	5
12508	16	18	436	\N	\N	25	6
12509	39	20	436	\N	\N	25	6
1251	88	83	11	\N	\N	11	\N
12510	5	39	436	\N	\N	25	6
12511	1	44	436	\N	\N	25	6
12512	1	58	436	\N	\N	25	6
12513	3	120	436	\N	\N	25	6
12514	2	113	436	\N	\N	25	6
12515	1	76	436	\N	\N	25	6
12516	1	132	436	\N	\N	25	6
12517	9	137	436	\N	\N	25	6
12518	1	143	436	\N	\N	25	6
12519	1	151	436	\N	\N	25	6
1252	104	86	11	\N	\N	11	\N
12520	12	153	436	\N	\N	25	6
12521	6	154	436	\N	\N	25	6
12522	2	156	436	\N	\N	25	6
12523	2	158	436	\N	\N	25	6
12524	3	160	436	\N	\N	25	6
12525	4	171	436	\N	\N	25	6
12526	2	161	436	\N	\N	25	6
12527	1	164	436	\N	\N	25	6
12528	1	167	436	\N	\N	25	6
12529	30	176	436	\N	\N	25	6
1253	2	87	11	\N	\N	11	\N
12530	2	175	436	\N	\N	25	6
12531	56	174	436	\N	\N	25	6
12532	2	186	436	\N	\N	25	6
12533	47	187	436	\N	\N	25	6
12534	10	189	436	\N	\N	25	6
12535	10	191	436	\N	\N	25	6
12536	15	194	436	\N	\N	25	6
12537	18	196	436	\N	\N	25	6
12538	3	199	436	\N	\N	25	6
12539	2	34	437	\N	\N	25	6
1254	2	88	11	\N	\N	11	\N
12540	3	39	437	\N	\N	25	6
12541	14	40	437	\N	\N	25	6
12542	2	41	437	\N	\N	25	6
12543	52	44	437	\N	\N	25	6
12544	2	59	437	\N	\N	25	6
12545	2	131	437	\N	\N	25	6
12546	14	112	437	\N	\N	25	6
12547	7	66	437	\N	\N	25	6
12548	1	132	437	\N	\N	25	6
12549	1	135	437	\N	\N	25	6
1255	26	89	11	\N	\N	11	\N
12550	2	141	437	\N	\N	25	6
12551	6	137	437	\N	\N	25	6
12552	2	151	437	\N	\N	25	6
12553	3	153	437	\N	\N	25	6
12554	4	156	437	\N	\N	25	6
12555	8	158	437	\N	\N	25	6
12556	6	170	437	\N	\N	25	6
12557	1	167	437	\N	\N	25	6
12558	8	174	437	\N	\N	25	6
12559	6	204	437	\N	\N	25	6
1256	1	90	11	\N	\N	11	\N
12560	40	187	437	\N	\N	25	6
12561	13	194	437	\N	\N	25	6
12562	2	196	437	\N	\N	25	6
12563	8	7	438	\N	\N	25	6
12564	2	15	438	\N	\N	25	6
12565	4	16	438	\N	\N	25	6
12566	14	18	438	\N	\N	25	6
12567	55	20	438	\N	\N	25	6
12568	26	28	438	\N	\N	25	6
12569	24	30	438	\N	\N	25	6
1257	12	91	11	\N	\N	11	\N
12570	124	39	438	\N	\N	25	6
12571	4	43	438	\N	\N	25	6
12572	14	44	438	\N	\N	25	6
12573	69	58	438	\N	\N	25	6
12574	3	83	438	\N	\N	25	6
12575	1	86	438	\N	\N	25	6
12576	1	95	438	\N	\N	25	6
12577	8	114	438	\N	\N	25	6
12578	19	66	438	\N	\N	25	6
12579	1	69	438	\N	\N	25	6
1258	45	92	11	\N	\N	11	\N
12580	1	79	438	\N	\N	25	6
12581	1	132	438	\N	\N	25	6
12582	1	135	438	\N	\N	25	6
12583	1	137	438	\N	\N	25	6
12584	2	151	438	\N	\N	25	6
12585	4	153	438	\N	\N	25	6
12586	2	154	438	\N	\N	25	6
12587	6	156	438	\N	\N	25	6
12588	4	160	438	\N	\N	25	6
12589	4	171	438	\N	\N	25	6
1259	4	95	11	\N	\N	11	\N
12590	17	174	438	\N	\N	25	6
12591	4	204	438	\N	\N	25	6
12592	8	207	438	\N	\N	25	6
12593	1	208	438	\N	\N	25	6
12594	6	189	438	\N	\N	25	6
12595	9	194	438	\N	\N	25	6
12596	2	196	438	\N	\N	25	6
12597	2	199	438	\N	\N	25	6
12598	1	7	439	\N	\N	25	6
12599	22	15	439	\N	\N	25	6
126	269	40	2	\N	\N	2	\N
1260	1	98	11	\N	\N	11	\N
12600	10	20	439	\N	\N	25	6
12601	8	28	439	\N	\N	25	6
12602	40	39	439	\N	\N	25	6
12603	10	40	439	\N	\N	25	6
12604	4	41	439	\N	\N	25	6
12605	4	43	439	\N	\N	25	6
12606	30	44	439	\N	\N	25	6
12607	6	45	439	\N	\N	25	6
12608	3	59	439	\N	\N	25	6
12609	1	120	439	\N	\N	25	6
1261	9	99	11	\N	\N	11	\N
12610	2	131	439	\N	\N	25	6
12611	1	87	439	\N	\N	25	6
12612	7	106	439	\N	\N	25	6
12613	3	114	439	\N	\N	25	6
12614	2	55	439	\N	\N	25	6
12615	1	65	439	\N	\N	25	6
12616	1	67	439	\N	\N	25	6
12617	9	69	439	\N	\N	25	6
12618	1	76	439	\N	\N	25	6
12619	1	79	439	\N	\N	25	6
1262	15	100	11	\N	\N	11	\N
12620	5	132	439	\N	\N	25	6
12621	1	137	439	\N	\N	25	6
12622	2	151	439	\N	\N	25	6
12623	7	153	439	\N	\N	25	6
12624	3	154	439	\N	\N	25	6
12625	3	158	439	\N	\N	25	6
12626	1	171	439	\N	\N	25	6
12627	3	164	439	\N	\N	25	6
12628	1	167	439	\N	\N	25	6
12629	1	174	439	\N	\N	25	6
1263	2	101	11	\N	\N	11	\N
12630	10	187	439	\N	\N	25	6
12631	3	191	439	\N	\N	25	6
12632	10	194	439	\N	\N	25	6
12633	1	196	439	\N	\N	25	6
12634	14	199	439	\N	\N	25	6
12635	97	7	440	\N	\N	25	6
12636	3	22	440	\N	\N	25	6
12637	3	16	440	\N	\N	25	6
12638	28	18	440	\N	\N	25	6
12639	88	20	440	\N	Vashon CBC, Kitsap West, Port Orchard: Mason b797ne	25	6
1264	28	103	11	\N	\N	11	\N
12640	8	24	440	\N	\N	25	6
12641	8	28	440	\N	\N	25	6
12642	6	39	440	\N	\N	25	6
12643	9	43	440	\N	\N	25	6
12644	2	119	440	\N	\N	25	6
12645	5	120	440	\N	\N	25	6
12646	3	131	440	\N	\N	25	6
12647	3	82	440	\N	Blackjack Creek Vashon CBC (47.4699,-122.6530): Two at Blackjack.	25	6
12648	5	95	440	\N	Blackjack Creek Vashon CBC (47.4699,-122.6530): Hovgaard Rd. Scaap calls. .	25	6
12649	2	114	440	\N	\N	25	6
1265	110	105	11	\N	\N	11	\N
12650	3	76	440	\N	\N	25	6
12651	6	79	440	\N	\N	25	6
12652	4	124	440	\N	Blackjack Creek Vashon CBC (47.4699,-122.6530): Duet pair at Blackjack and one near Price Dairy and one at Hovgaard.	25	6
12653	1	126	440	\N	\N	25	6
12654	2	135	440	\N	\N	25	6
12655	8	137	440	\N	\N	25	6
12656	1	139	440	\N	\N	25	6
12657	1	143	440	\N	\N	25	6
12658	1	151	440	\N	\N	25	6
12659	3	152	440	\N	\N	25	6
1266	209	106	11	\N	\N	11	\N
12660	18	153	440	\N	\N	25	6
12661	2	154	440	\N	\N	25	6
12662	16	156	440	\N	\N	25	6
12663	21	158	440	\N	\N	25	6
12664	2	171	440	\N	\N	25	6
12665	6	170	440	\N	\N	25	6
12666	2	161	440	\N	\N	25	6
12667	5	164	440	\N	\N	25	6
12668	1	166	440	\N	\N	25	6
12669	1	169	440	\N	\N	25	6
1267	1	107	11	\N	\N	11	\N
12670	66	176	440	\N	\N	25	6
12671	166	174	440	\N	\N	25	6
12672	5	211	440	\N	\N	25	6
12673	13	204	440	\N	\N	25	6
12674	31	207	440	\N	\N	25	6
12675	3	208	440	\N	\N	25	6
12676	4	210	440	\N	\N	25	6
12677	6	186	440	\N	\N	25	6
12678	100	189	440	\N	\N	25	6
12679	9	190	440	\N	\N	25	6
1268	1	108	11	\N	\N	11	\N
12680	38	191	440	\N	\N	25	6
12681	15	194	440	\N	\N	25	6
12682	8	196	440	\N	\N	25	6
12683	166	199	440	\N	\N	25	6
12684	1	202	440	\N	Vashon CBC, Kitsap West, Port Orchard: Male, observed by pond on Lider rd.  Brown head, black body, large conical dark bill.  Looked for more bur not successful.	25	6
12685	41	201	440	\N	\N	25	6
12686	1	135	441	\N	\N	25	6
12687	1	136	441	\N	\N	25	6
12688	1	139	441	\N	\N	25	6
12689	1	151	441	\N	\N	25	6
1269	1	109	11	\N	\N	11	\N
12690	2	153	441	\N	\N	25	6
12691	1	154	441	\N	\N	25	6
12692	1	156	441	\N	\N	25	6
12693	5	158	441	\N	\N	25	6
12694	7	160	441	\N	\N	25	6
12695	1	161	441	\N	\N	25	6
12696	1	167	441	\N	\N	25	6
12697	1	174	441	\N	\N	25	6
12698	5	187	441	\N	\N	25	6
12699	2	194	441	\N	\N	25	6
127	90	41	2	\N	\N	2	\N
1270	6	111	11	\N	\N	11	\N
12700	3	196	441	\N	\N	25	6
12701	2	33	442	\N	\N	25	3
12702	5	34	442	\N	\N	25	3
12703	6	35	442	\N	\N	25	3
12704	29	39	442	\N	\N	25	3
12705	13	40	442	\N	\N	25	3
12706	10	45	442	\N	\N	25	3
12707	36	59	442	\N	\N	25	3
12708	3	60	442	\N	\N	25	3
12709	7	119	442	\N	Vashon Marine Park East Trail: Seen partial flock (some had flown out of view) driving out onto 59th. CBC folks for Robinson West may have also seen greater nuber/entire flock.	25	3
1271	703	112	11	\N	\N	11	\N
12710	1	131	442	\N	\N	25	3
12711	9	103	442	\N	\N	25	3
12712	2	101	442	\N	Point Robinson: Flying mid-channel southbound as pair (typical for species as I understand). Ruling out Ancient in that underwing was dark. Ruling out Common Murre as birds lacked bulk/length; had thinner black necklace; and had more black on cap and eye/face (in all fairness, difficult to make out Marbled pirate's eye patch vs Murre's eyeline at distance). A second pair seen five minutes later northbound; possibly/likely same pair; not recounting.	25	3
12713	3	100	442	\N	\N	25	3
12714	6	106	442	\N	\N	25	3
12715	32	113	442	\N	\N	25	3
12716	1	54	442	\N	\N	25	3
12717	1	55	442	\N	\N	25	3
12718	14	65	442	\N	\N	25	3
12719	3	67	442	\N	\N	25	3
1272	25	113	11	\N	\N	11	\N
12720	16	66	442	\N	\N	25	3
12721	2	69	442	\N	\N	25	3
12722	7	76	442	\N	\N	25	3
12723	2	79	442	\N	\N	25	3
12724	\N	127	442	t	\N	25	3
12725	3	135	442	\N	\N	25	3
12726	1	141	442	\N	\N	25	3
12727	10	137	442	\N	\N	25	3
12728	2	144	442	\N	\N	25	3
12729	2	149	442	\N	Point Robinson: One by intersection into park; one down by old gift shop; both with shorts bit of song (to help cinch ID).	25	3
1273	28	116	11	\N	\N	11	\N
12730	3	151	442	\N	\N	25	3
12731	1	152	442	\N	\N	25	3
12732	43	153	442	\N	\N	25	3
12733	2	154	442	\N	\N	25	3
12734	6	156	442	\N	\N	25	3
12735	26	158	442	\N	\N	25	3
12736	15	171	442	\N	\N	25	3
12737	12	170	442	\N	\N	25	3
12738	1	163	442	\N	\N	25	3
12739	1	164	442	\N	\N	25	3
1274	305	117	11	\N	\N	11	\N
12740	3	167	442	\N	\N	25	3
12741	10	175	442	\N	\N	25	3
12742	51	174	442	\N	\N	25	3
12743	21	204	442	\N	\N	25	3
12744	88	207	442	\N	\N	25	3
12745	2	208	442	\N	\N	25	3
12746	6	186	442	\N	\N	25	3
12747	36	187	442	\N	\N	25	3
12748	16	191	442	\N	\N	25	3
12749	12	194	442	\N	\N	25	3
1275	47	118	11	\N	\N	11	\N
12750	13	196	442	\N	\N	25	3
12751	1	181	442	\N	\N	25	3
12752	79	7	443	\N	\N	25	3
12753	3	20	443	\N	\N	25	3
12754	1	134	443	\N	\N	25	3
12755	1	135	443	\N	\N	25	3
12756	14	137	443	\N	\N	25	3
12757	1	151	443	\N	\N	25	3
12758	64	153	443	\N	\N	25	3
12759	5	156	443	\N	\N	25	3
1276	30	120	11	\N	\N	11	\N
12760	46	158	443	\N	\N	25	3
12761	9	160	443	\N	\N	25	3
12762	8	171	443	\N	\N	25	3
12763	14	170	443	\N	\N	25	3
12764	2	161	443	\N	\N	25	3
12765	1	163	443	\N	\N	25	3
12766	4	164	443	\N	\N	25	3
12767	1	167	443	\N	\N	25	3
12768	6	131	443	\N	\N	25	3
12769	37	116	443	\N	\N	25	3
1277	1	122	11	\N	\N	11	\N
12770	1	69	443	\N	\N	25	3
12771	2	75	443	\N	\N	25	3
12772	2	76	443	\N	\N	25	3
12773	2	79	443	\N	\N	25	3
12774	32	176	443	\N	\N	25	3
12775	1	173	443	\N	\N	25	3
12776	105	174	443	\N	\N	25	3
12777	3	178	443	\N	\N	25	3
12778	23	211	443	\N	\N	25	3
12779	3	204	443	\N	\N	25	3
1278	2	124	11	\N	\N	11	\N
12780	23	207	443	\N	\N	25	3
12781	3	208	443	\N	\N	25	3
12782	4	186	443	\N	\N	25	3
12783	99	187	443	\N	\N	25	3
12784	9	191	443	\N	\N	25	3
12785	16	194	443	\N	\N	25	3
12786	34	196	443	\N	\N	25	3
12787	25	183	443	\N	\N	25	3
12788	25	7	444	\N	\N	25	3
12789	0	17	444	\N	\N	25	3
1279	4	126	11	\N	\N	11	\N
12790	300	18	444	\N	\N	25	3
12791	24	20	444	\N	\N	25	3
12792	18	29	444	\N	\N	25	3
12793	62	34	444	\N	\N	25	3
12794	1	35	444	\N	\N	25	3
12795	89	39	444	\N	\N	25	3
12796	58	40	444	\N	\N	25	3
12797	4	41	444	\N	\N	25	3
12798	1	43	444	\N	\N	25	3
12799	2	44	444	\N	\N	25	3
128	67	42	2	\N	\N	2	\N
1280	1	128	11	\N	\N	11	\N
12800	51	45	444	\N	\N	25	3
12801	1	58	444	\N	\N	25	3
12802	85	59	444	\N	\N	25	3
12803	27	60	444	\N	\N	25	3
12804	11	61	444	\N	\N	25	3
12805	9	119	444	\N	59th Avenue, Vashon: Subtracted 7 from probable duplication w/ MT East team	25	3
12806	11	131	444	\N	Rabbs Lagoon: Display dive	25	3
12807	1	82	444	\N	\N	25	3
12808	1	86	444	\N	\N	25	3
12809	1	87	444	\N	\N	25	3
1281	3	129	11	\N	\N	11	\N
12810	4	103	444	\N	\N	25	3
12811	8	100	444	\N	\N	25	3
12812	1	99	444	\N	\N	25	3
12813	14	106	444	\N	\N	25	3
12814	2	113	444	\N	\N	25	3
12815	18	114	444	\N	\N	25	3
12816	3	53	444	\N	\N	25	3
12817	3	54	444	\N	\N	25	3
12818	6	55	444	\N	\N	25	3
12819	3	65	444	\N	\N	25	3
1282	75	131	11	\N	\N	11	\N
12820	5	66	444	\N	\N	25	3
12821	3	68	444	\N	\N	25	3
12822	5	69	444	\N	\N	25	3
12823	1	72	444	\N	\N	25	3
12824	1	75	444	\N	\N	25	3
12825	10	76	444	\N	\N	25	3
12826	3	79	444	\N	\N	25	3
12827	2	124	444	\N	\N	25	3
12828	2	126	444	\N	\N	25	3
12829	3	129	444	\N	\N	25	3
1283	34	132	11	\N	\N	11	\N
12830	3	132	444	\N	\N	25	3
12831	1	134	444	\N	\N	25	3
12832	1	135	444	\N	\N	25	3
12833	9	137	444	\N	Lower Gold Beach, Vashon: Added 2 from count by Anna, Caroline and Laurie	25	3
12834	2	139	444	\N	\N	25	3
12835	1	140	444	\N	\N	25	3
12836	1	149	444	\N	\N	25	3
12837	3	151	444	\N	\N	25	3
12838	1	152	444	\N	\N	25	3
12839	33	153	444	\N	\N	25	3
1284	15	134	11	\N	\N	11	\N
12840	10	156	444	\N	\N	25	3
12841	12	158	444	\N	\N	25	3
12842	15	160	444	\N	\N	25	3
12843	7	171	444	\N	\N	25	3
12844	11	170	444	\N	\N	25	3
12845	6	161	444	\N	\N	25	3
12846	2	163	444	\N	\N	25	3
12847	8	164	444	\N	\N	25	3
12848	4	167	444	\N	\N	25	3
12849	4	175	444	\N	\N	25	3
1285	23	135	11	\N	\N	11	\N
12850	3	173	444	\N	\N	25	3
12851	25	174	444	\N	Lower Gold Beach, Vashon: Added 5 from count by Anna, Caroline and Laurie	25	3
12852	5	211	444	\N	\N	25	3
12853	22	204	444	\N	\N	25	3
12854	2	205	444	\N	\N	25	3
12855	247	207	444	\N	Lower Gold Beach, Vashon: Added 6 from count by Anna, Caroline and Laurie	25	3
12856	2	208	444	\N	\N	25	3
12857	1	186	444	\N	\N	25	3
12858	35	189	444	\N	\N	25	3
12859	4	190	444	\N	\N	25	3
1286	6	136	11	\N	\N	11	\N
12860	33	191	444	\N	\N	25	3
12861	31	194	444	\N	\N	25	3
12862	21	196	444	\N	\N	25	3
12863	6	199	444	\N	\N	25	3
12864	23	181	444	\N	\N	25	3
12865	3	182	444	\N	\N	25	3
12866	4	183	444	\N	\N	25	3
12867	1	184	444	\N	\N	25	3
12868	2	137	445	\N	\N	25	3
12869	1	151	445	\N	\N	25	3
1287	127	139	11	\N	\N	11	\N
12870	1	153	445	\N	\N	25	3
12871	2	156	445	\N	\N	25	3
12872	2	158	445	\N	\N	25	3
12873	2	161	445	\N	\N	25	3
12874	2	131	445	\N	\N	25	3
12875	1	174	445	\N	\N	25	3
12876	2	211	445	\N	\N	25	3
12877	4	204	445	\N	\N	25	3
12878	9	187	445	\N	\N	25	3
12879	1	191	445	\N	\N	25	3
1288	21	141	11	\N	\N	11	\N
12880	2	194	445	\N	\N	25	3
12881	2	196	445	\N	\N	25	3
12882	17	131	446	\N	\N	25	3
12883	1	139	447	\N	\N	25	3
12884	2	131	447	\N	\N	25	3
12885	7	174	447	\N	\N	25	3
12886	6	204	447	\N	\N	25	3
12887	12	187	447	\N	\N	25	3
12888	1	194	447	\N	\N	25	3
12889	1	196	447	\N	\N	25	3
1289	\N	143	11	t	\N	11	\N
12890	1	6	448	\N	\N	25	7
12891	67	7	448	\N	\N	25	7
12892	7	18	448	\N	\N	25	7
12893	33	20	448	\N	\N	25	7
12894	13	23	448	\N	\N	25	7
12895	23	28	448	\N	\N	25	7
12896	35	29	448	\N	\N	25	7
12897	7	33	448	\N	\N	25	7
12898	562	34	448	\N	\N	25	7
12899	55	39	448	\N	\N	25	7
129	40	43	2	\N	\N	2	\N
1290	2	144	11	\N	\N	11	\N
12900	77	40	448	\N	6814 152nd Street Ct NW, Gig Harbor US-WA (47.3968,-122.6300): Males doing calls.	25	7
12901	30	41	448	\N	\N	25	7
12902	13	43	448	\N	\N	25	7
12903	45	44	448	\N	\N	25	7
12904	74	45	448	\N	\N	25	7
12905	187	59	448	\N	\N	25	7
12906	2	62	448	\N	\N	25	7
12907	12	120	448	\N	\N	25	7
12908	5	131	448	\N	\N	25	7
12909	20	103	448	\N	\N	25	7
1291	\N	145	11	t	\N	11	\N
12910	23	106	448	\N	\N	25	7
12911	2	112	448	\N	\N	25	7
12912	49	113	448	\N	\N	25	7
12913	2	54	448	\N	\N	25	7
12914	55	66	448	\N	\N	25	7
12915	3	69	448	\N	\N	25	7
12916	7	76	448	\N	\N	25	7
12917	4	132	448	\N	\N	25	7
12918	4	135	448	\N	14800 Bethel Burley Road Southeast, Port Orchard: Male seen and heard\n15423 Horseshoe Ave SW, Port Orchard: Male	25	7
12919	1	136	448	\N	14800 Bethel Burley Road Southeast, Port Orchard: Male seen	25	7
1292	3	149	11	\N	\N	11	\N
12920	2	141	448	\N	15423 Horseshoe Ave SW, Port Orchard: Pair	25	7
12921	10	137	448	\N	\N	25	7
12922	5	139	448	\N	\N	25	7
12923	9	151	448	\N	\N	25	7
12924	52	153	448	\N	\N	25	7
12925	1	154	448	\N	\N	25	7
12926	11	156	448	\N	\N	25	7
12927	18	158	448	\N	\N	25	7
12928	6	171	448	\N	\N	25	7
12929	1	170	448	\N	\N	25	7
1293	191	151	11	\N	\N	11	\N
12930	2	161	448	\N	\N	25	7
12931	1	163	448	\N	\N	25	7
12932	3	167	448	\N	\N	25	7
12933	38	176	448	\N	\N	25	7
12934	1	175	448	\N	\N	25	7
12935	52	174	448	\N	\N	25	7
12936	2	211	448	\N	\N	25	7
12937	7	204	448	\N	\N	25	7
12938	12	210	448	\N	\N	25	7
12939	1	186	448	\N	15423 Horseshoe Ave SW, Port Orchard: Heard.	25	7
1294	1	152	11	\N	\N	11	\N
12940	63	189	448	\N	\N	25	7
12941	2	191	448	\N	\N	25	7
12942	9	194	448	\N	\N	25	7
12943	4	196	448	\N	\N	25	7
12944	20	199	448	\N	\N	25	7
12945	3	181	448	\N	\N	25	7
12946	1	184	448	\N	\N	25	7
12947	3	131	449	\N	\N	25	7
12948	8	137	449	\N	\N	25	7
12949	8	151	449	\N	\N	25	7
1295	962	153	11	\N	\N	11	\N
12950	1	154	449	\N	\N	25	7
12951	18	156	449	\N	\N	25	7
12952	26	158	449	\N	\N	25	7
12953	2	161	449	\N	\N	25	7
12954	1	211	449	\N	\N	25	7
12955	1	204	449	\N	\N	25	7
12956	1	207	449	\N	\N	25	7
12957	3	186	449	\N	\N	25	7
12958	28	187	449	\N	\N	25	7
12959	5	191	449	\N	\N	25	7
1296	11	154	11	\N	\N	11	\N
12960	14	194	449	\N	\N	25	7
12961	6	196	449	\N	\N	25	7
12962	4	15	450	\N	\N	25	7
12963	32	20	450	\N	\N	25	7
12964	5	21	450	\N	\N	25	7
12965	4	131	450	\N	\N	25	7
12966	2	73	450	\N	\N	25	7
12967	1	134	450	\N	\N	25	7
12968	2	135	450	\N	\N	25	7
12969	2	136	450	\N	\N	25	7
1297	364	156	11	\N	\N	11	\N
12970	2	141	450	\N	\N	25	7
12971	5	137	450	\N	\N	25	7
12972	1	139	450	\N	\N	25	7
12973	2	142	450	\N	\N	25	7
12974	7	151	450	\N	\N	25	7
12975	6	153	450	\N	\N	25	7
12976	5	154	450	\N	\N	25	7
12977	63	156	450	\N	\N	25	7
12978	32	158	450	\N	\N	25	7
12979	16	171	450	\N	\N	25	7
1298	287	158	11	\N	\N	11	\N
12980	39	170	450	\N	\N	25	7
12981	9	161	450	\N	\N	25	7
12982	8	163	450	\N	\N	25	7
12983	2	164	450	\N	\N	25	7
12984	3	167	450	\N	\N	25	7
12985	8	176	450	\N	\N	25	7
12986	10	175	450	\N	\N	25	7
12987	31	174	450	\N	\N	25	7
12988	140	207	450	\N	\N	25	7
12989	2	186	450	\N	\N	25	7
1299	112	160	11	\N	\N	11	\N
12990	67	187	450	\N	\N	25	7
12991	10	191	450	\N	\N	25	7
12992	20	194	450	\N	\N	25	7
12993	13	196	450	\N	\N	25	7
12994	3	20	451	\N	\N	25	7
12995	16	28	451	\N	\N	25	7
12996	1	39	451	\N	\N	25	7
12997	12	40	451	\N	\N	25	7
12998	8	41	451	\N	\N	25	7
12999	5	44	451	\N	\N	25	7
13	8	33	1	\N	\N	1	\N
130	34	44	2	\N	\N	2	\N
1300	139	161	11	\N	\N	11	\N
13000	9	45	451	\N	\N	25	7
13001	1	120	451	\N	\N	25	7
13002	5	131	451	\N	\N	25	7
13003	3	112	451	\N	\N	25	7
13004	3	66	451	\N	\N	25	7
13005	1	72	451	\N	\N	25	7
13006	2	76	451	\N	1415 Sea Cliff Drive Northwest, Gig Harbor: Adult	25	7
13007	1	79	451	\N	\N	25	7
13008	3	137	451	\N	\N	25	7
13009	2	139	451	\N	\N	25	7
1301	27	163	11	\N	\N	11	\N
13010	1	151	451	\N	\N	25	7
13011	9	153	451	\N	\N	25	7
13012	2	154	451	\N	\N	25	7
13013	8	156	451	\N	\N	25	7
13014	1	158	451	\N	\N	25	7
13015	3	171	451	\N	\N	25	7
13016	3	170	451	\N	\N	25	7
13017	1	163	451	\N	\N	25	7
13018	5	164	451	\N	\N	25	7
13019	1	167	451	\N	\N	25	7
1302	118	165	11	\N	\N	11	\N
13020	5	176	451	\N	\N	25	7
13021	5	175	451	\N	\N	25	7
13022	9	174	451	\N	\N	25	7
13023	2	211	451	\N	\N	25	7
13024	1	205	451	\N	\N	25	7
13025	2	186	451	\N	\N	25	7
13026	26	187	451	\N	\N	25	7
13027	1	191	451	\N	\N	25	7
13028	12	194	451	\N	\N	25	7
13029	6	196	451	\N	\N	25	7
1303	1	166	11	\N	\N	11	\N
13030	3	199	451	\N	\N	25	7
13031	3	181	451	\N	\N	25	7
13032	19	7	452	\N	\N	25	7
13033	12	20	452	\N	\N	25	7
13034	3	39	452	\N	\N	25	7
13035	8	40	452	\N	\N	25	7
13036	8	41	452	\N	\N	25	7
13037	12	43	452	\N	\N	25	7
13038	36	44	452	\N	\N	25	7
13039	2	45	452	\N	\N	25	7
1304	48	167	11	\N	\N	11	\N
13040	10	59	452	\N	\N	25	7
13041	10	131	452	\N	\N	25	7
13042	14	103	452	\N	\N	25	7
13043	1	100	452	\N	\N	25	7
13044	2	105	452	\N	\N	25	7
13045	75	106	452	\N	\N	25	7
13046	7	112	452	\N	8913 Randall Dr NW, Gig Harbor: 2 Immature	25	7
13047	25	116	452	\N	\N	25	7
13048	1	53	452	\N	\N	25	7
13049	2	67	452	\N	\N	25	7
1305	343	170	11	\N	\N	11	\N
13050	67	66	452	\N	\N	25	7
13051	1	72	452	\N	\N	25	7
13052	1	79	452	\N	\N	25	7
13053	1	132	452	\N	\N	25	7
13054	2	136	452	\N	\N	25	7
13055	1	137	452	\N	\N	25	7
13056	5	139	452	\N	\N	25	7
13057	1	149	452	\N	\N	25	7
13058	11	151	452	\N	\N	25	7
13059	19	153	452	\N	\N	25	7
1306	90	171	11	\N	\N	11	\N
13060	1	154	452	\N	\N	25	7
13061	17	156	452	\N	\N	25	7
13062	30	158	452	\N	\N	25	7
13063	36	160	452	\N	\N	25	7
13064	9	171	452	\N	\N	25	7
13065	29	170	452	\N	\N	25	7
13066	2	161	452	\N	\N	25	7
13067	4	163	452	\N	\N	25	7
13068	6	164	452	\N	\N	25	7
13069	2	167	452	\N	\N	25	7
1307	2	173	11	\N	\N	11	\N
13070	2	176	452	\N	\N	25	7
13071	4	175	452	\N	\N	25	7
13072	45	174	452	\N	\N	25	7
13073	12	204	452	\N	\N	25	7
13074	2	207	452	\N	\N	25	7
13075	6	186	452	\N	\N	25	7
13076	96	189	452	\N	\N	25	7
13077	12	191	452	\N	\N	25	7
13078	25	194	452	\N	\N	25	7
13079	14	196	452	\N	\N	25	7
1308	1227	174	11	\N	\N	11	\N
13080	8	181	452	\N	\N	25	7
13081	56	7	453	\N	\N	25	7
13082	80	20	453	\N	\N	25	7
13083	8	28	453	\N	\N	25	7
13084	1	30	453	\N	\N	25	7
13085	1	34	453	\N	\N	25	7
13086	7	39	453	\N	\N	25	7
13087	10	40	453	\N	\N	25	7
13088	6	41	453	\N	\N	25	7
13089	6	43	453	\N	\N	25	7
1309	122	175	11	\N	\N	11	\N
13090	25	44	453	\N	\N	25	7
13091	8	45	453	\N	\N	25	7
13092	1	58	453	\N	\N	25	7
13093	6	59	453	\N	\N	25	7
13094	2	132	453	\N	\N	25	7
13095	2	135	453	\N	\N	25	7
13096	2	137	453	\N	\N	25	7
13097	1	149	453	\N	\N	25	7
13098	2	151	453	\N	\N	25	7
13099	22	153	453	\N	\N	25	7
131	140	45	2	\N	\N	2	\N
1310	655	176	11	\N	\N	11	\N
13100	2	154	453	\N	\N	25	7
13101	11	156	453	\N	\N	25	7
13102	7	158	453	\N	\N	25	7
13103	13	160	453	\N	\N	25	7
13104	6	171	453	\N	\N	25	7
13105	6	170	453	\N	\N	25	7
13106	2	161	453	\N	\N	25	7
13107	3	163	453	\N	\N	25	7
13108	2	164	453	\N	\N	25	7
13109	4	131	453	\N	\N	25	7
1311	21	178	11	\N	\N	11	\N
13110	4	106	453	\N	\N	25	7
13111	3	109	453	\N	\N	25	7
13112	8	112	453	\N	\N	25	7
13113	1	111	453	\N	\N	25	7
13114	5	66	453	\N	\N	25	7
13115	1	69	453	\N	\N	25	7
13116	4	76	453	\N	\N	25	7
13117	1	79	453	\N	\N	25	7
13118	5	176	453	\N	\N	25	7
13119	4	175	453	\N	\N	25	7
1312	12	183	11	\N	\N	11	\N
13120	1	173	453	\N	\N	25	7
13121	23	174	453	\N	\N	25	7
13122	5	204	453	\N	\N	25	7
13123	86	207	453	\N	\N	25	7
13124	1	208	453	\N	\N	25	7
13125	3	186	453	\N	\N	25	7
13126	69	187	453	\N	\N	25	7
13127	11	191	453	\N	\N	25	7
13128	16	194	453	\N	\N	25	7
13129	9	196	453	\N	\N	25	7
1313	7	184	11	\N	\N	11	\N
13130	1	199	453	\N	\N	25	7
13131	2	181	453	\N	\N	25	7
13132	2	184	453	\N	\N	25	7
13133	1	135	454	\N	\N	25	7
13134	1	136	454	\N	\N	25	7
13135	1	141	454	\N	\N	25	7
13136	1	137	454	\N	\N	25	7
13137	3	151	454	\N	\N	25	7
13138	6	156	454	\N	\N	25	7
13139	8	158	454	\N	\N	25	7
1314	77	186	11	\N	\N	11	\N
13140	15	160	454	\N	\N	25	7
13141	1	161	454	\N	\N	25	7
13142	3	131	454	\N	\N	25	7
13143	1	175	454	\N	\N	25	7
13144	1	204	454	\N	\N	25	7
13145	1	207	454	\N	\N	25	7
13146	3	208	454	\N	\N	25	7
13147	30	187	454	\N	\N	25	7
13148	1	191	454	\N	\N	25	7
13149	2	194	454	\N	\N	25	7
1315	1	188	11	\N	\N	11	\N
13150	3	196	454	\N	\N	25	7
13151	4	158	455	\N	\N	25	7
13152	1	161	455	\N	\N	25	7
13153	2	204	455	\N	\N	25	7
13154	19	189	455	\N	\N	25	7
13155	2	196	455	\N	\N	25	7
13156	63	7	456	\N	\N	25	4
13157	51	18	456	\N	\N	25	4
13158	6	20	456	\N	\N	25	4
13159	5	29	456	\N	\N	25	4
1316	1574	189	11	\N	\N	11	\N
13160	575	34	456	\N	\N	25	4
13161	157	35	456	\N	\N	25	4
13162	397	39	456	\N	\N	25	4
13163	523	40	456	\N	\N	25	4
13164	127	41	456	\N	\N	25	4
13165	2	43	456	\N	\N	25	4
13166	3	44	456	\N	\N	25	4
13167	68	45	456	\N	\N	25	4
13168	176	59	456	\N	\N	25	4
13169	1	87	456	\N	\N	25	4
1317	14	190	11	\N	\N	11	\N
13170	6	100	456	\N	\N	25	4
13171	25	106	456	\N	\N	25	4
13172	66	113	456	\N	\N	25	4
13173	6	53	456	\N	\N	25	4
13174	2	54	456	\N	\N	25	4
13175	1	55	456	\N	\N	25	4
13176	9	65	456	\N	\N	25	4
13177	11	67	456	\N	\N	25	4
13178	59	66	456	\N	\N	25	4
13179	2	69	456	\N	\N	25	4
1318	144	191	11	\N	\N	11	\N
13180	4	76	456	\N	\N	25	4
13181	1	72	456	\N	\N	25	4
13182	2	132	456	\N	\N	25	4
13183	1	151	456	\N	\N	25	4
13184	9	153	456	\N	\N	25	4
13185	1	199	456	\N	\N	25	4
13186	2	18	457	\N	\N	25	1
13187	6	20	457	\N	\N	25	1
13188	10	28	457	\N	\N	25	1
13189	10	39	457	\N	\N	25	1
1319	1	193	11	\N	\N	11	\N
13190	2	43	457	\N	\N	25	1
13191	1	58	457	\N	\N	25	1
13192	2	137	457	\N	\N	25	1
13193	3	154	457	\N	\N	25	1
13194	5	158	457	\N	\N	25	1
13195	1	164	457	\N	\N	25	1
13196	2	174	457	\N	\N	25	1
13197	2	194	457	\N	\N	25	1
13198	1	196	457	\N	\N	25	1
13199	10	119	458	\N	\N	25	1
132	95	47	2	\N	\N	2	\N
1320	333	194	11	\N	\N	11	\N
13200	1	134	458	\N	\N	25	1
13201	2	137	458	\N	\N	25	1
13202	1	144	458	\N	\N	25	1
13203	5	151	458	\N	\N	25	1
13204	8	153	458	\N	\N	25	1
13205	1	156	458	\N	\N	25	1
13206	10	158	458	\N	\N	25	1
13207	4	171	458	\N	\N	25	1
13208	1	170	458	\N	\N	25	1
13209	3	161	458	\N	\N	25	1
1321	2	195	11	\N	\N	11	\N
13210	1	164	458	\N	\N	25	1
13211	1	167	458	\N	\N	25	1
13212	1	131	458	\N	\N	25	1
13213	1	68	458	\N	\N	25	1
13214	1	75	458	\N	\N	25	1
13215	1	76	458	\N	\N	25	1
13216	36	176	458	\N	\N	25	1
13217	14	174	458	\N	\N	25	1
13218	11	204	458	\N	\N	25	1
13219	65	207	458	\N	\N	25	1
1322	317	196	11	\N	\N	11	\N
13220	39	187	458	\N	\N	25	1
13221	4	191	458	\N	\N	25	1
13222	1	193	458	\N	\N	25	1
13223	7	194	458	\N	\N	25	1
13224	8	196	458	\N	\N	25	1
13225	1	174	459	\N	\N	25	1
13226	1	187	459	\N	\N	25	1
13227	2	194	459	\N	\N	25	1
13228	2	196	459	\N	\N	25	1
13229	2	7	460	\N	\N	25	1
1323	1	198	11	\N	\N	11	\N
13230	2	20	460	\N	\N	25	1
13231	31	34	460	\N	\N	25	1
13232	1	35	460	\N	\N	25	1
13233	17	39	460	\N	\N	25	1
13234	12	40	460	\N	\N	25	1
13235	16	45	460	\N	\N	25	1
13236	61	59	460	\N	\N	25	1
13237	4	60	460	\N	\N	25	1
13238	18	131	460	\N	\N	25	1
13239	1	103	460	\N	\N	25	1
1324	107	199	11	\N	\N	11	\N
13240	7	100	460	\N	\N	25	1
13241	5	99	460	\N	\N	25	1
13242	11	106	460	\N	\N	25	1
13243	1	109	460	\N	\N	25	1
13244	37	112	460	\N	\N	25	1
13245	4	55	460	\N	\N	25	1
13246	8	65	460	\N	\N	25	1
13247	2	67	460	\N	\N	25	1
13248	20	66	460	\N	\N	25	1
13249	2	76	460	\N	\N	25	1
1325	30	201	11	\N	\N	11	\N
13250	1	134	460	\N	\N	25	1
13251	2	135	460	\N	\N	25	1
13252	11	137	460	\N	\N	25	1
13253	3	149	460	\N	\N	25	1
13254	3	151	460	\N	\N	25	1
13255	37	153	460	\N	\N	25	1
13256	3	154	460	\N	\N	25	1
13257	18	156	460	\N	\N	25	1
13258	49	158	460	\N	\N	25	1
13259	1	160	460	\N	\N	25	1
1326	1	202	11	\N	\N	11	\N
13260	15	171	460	\N	\N	25	1
13261	15	170	460	\N	\N	25	1
13262	9	161	460	\N	\N	25	1
13263	4	163	460	\N	\N	25	1
13264	11	164	460	\N	\N	25	1
13265	6	176	460	\N	\N	25	1
13266	8	175	460	\N	\N	25	1
13267	46	174	460	\N	\N	25	1
13268	29	204	460	\N	\N	25	1
13269	6	207	460	\N	\N	25	1
1327	208	204	11	\N	\N	11	\N
13270	121	187	460	\N	\N	25	1
13271	5	190	460	\N	\N	25	1
13272	20	191	460	\N	\N	25	1
13273	29	194	460	\N	\N	25	1
13274	24	196	460	\N	\N	25	1
13275	4	181	460	\N	\N	25	1
13276	1	132	461	\N	\N	25	1
13277	2	137	461	\N	\N	25	1
13278	5	151	461	\N	\N	25	1
13279	8	153	461	\N	\N	25	1
1328	39	205	11	\N	\N	11	\N
13280	2	154	461	\N	\N	25	1
13281	9	156	461	\N	\N	25	1
13282	20	158	461	\N	\N	25	1
13283	15	171	461	\N	\N	25	1
13284	16	170	461	\N	\N	25	1
13285	2	161	461	\N	\N	25	1
13286	2	163	461	\N	\N	25	1
13287	16	164	461	\N	\N	25	1
13288	1	167	461	\N	\N	25	1
13289	59	176	461	\N	\N	25	1
1329	56	206	11	\N	\N	11	\N
13290	1	175	461	\N	\N	25	1
13291	52	174	461	\N	\N	25	1
13292	6	211	461	\N	\N	25	1
13293	12	204	461	\N	\N	25	1
13294	42	207	461	\N	\N	25	1
13295	3	186	461	\N	\N	25	1
13296	19	187	461	\N	\N	25	1
13297	12	191	461	\N	\N	25	1
13298	19	194	461	\N	\N	25	1
13299	9	196	461	\N	\N	25	1
133	10	50	2	\N	\N	2	\N
1330	642	207	11	\N	\N	11	\N
13300	5	199	461	\N	\N	25	1
13301	5	6	461	\N	\N	25	1
13302	11	7	461	\N	\N	25	1
13303	22	20	461	\N	\N	25	1
13304	9	39	461	\N	\N	25	1
13305	5	40	461	\N	\N	25	1
13306	5	59	461	\N	\N	25	1
13307	5	117	461	\N	\N	25	1
13308	2	131	461	\N	\N	25	1
13309	6	116	461	\N	\N	25	1
1331	28	208	11	\N	\N	11	\N
13310	1	66	461	\N	\N	25	1
13311	2	69	461	\N	\N	25	1
13312	1	75	461	\N	\N	25	1
13313	1	76	461	\N	\N	25	1
13314	1	79	461	\N	\N	25	1
13315	5	7	462	\N	\N	25	1
13316	150	18	462	\N	\N	25	1
13317	114	20	462	\N	\N	25	1
13318	1	23	462	\N	\N	25	1
13319	7	33	462	\N	\N	25	1
1332	4	209	11	\N	\N	11	\N
13320	40	34	462	\N	\N	25	1
13321	97	35	462	\N	\N	25	1
13322	26	39	462	\N	\N	25	1
13323	18	40	462	\N	\N	25	1
13324	5	41	462	\N	\N	25	1
13325	7	45	462	\N	\N	25	1
13326	1	58	462	\N	\N	25	1
13327	29	59	462	\N	\N	25	1
13328	14	60	462	\N	\N	25	1
13329	1	132	462	\N	\N	25	1
1333	2	210	11	\N	\N	11	\N
13330	2	141	462	\N	\N	25	1
13331	4	137	462	\N	\N	25	1
13332	1	151	462	\N	\N	25	1
13333	32	153	462	\N	\N	25	1
13334	6	156	462	\N	\N	25	1
13335	2	158	462	\N	\N	25	1
13336	1	161	462	\N	\N	25	1
13337	1	163	462	\N	\N	25	1
13338	4	164	462	\N	\N	25	1
13339	2	167	462	\N	\N	25	1
1334	104	211	11	\N	\N	11	\N
13340	1	131	462	\N	\N	25	1
13341	1	83	462	\N	\N	25	1
13342	1	103	462	\N	\N	25	1
13343	6	100	462	\N	\N	25	1
13344	2	106	462	\N	\N	25	1
13345	21	109	462	\N	\N	25	1
13346	11	112	462	\N	\N	25	1
13347	17	113	462	\N	\N	25	1
13348	100	116	462	\N	\N	25	1
13349	2	54	462	\N	\N	25	1
1335	1	2	12	\N	\N	12	\N
13350	9	55	462	\N	\N	25	1
13351	3	67	462	\N	\N	25	1
13352	2	66	462	\N	\N	25	1
13353	2	69	462	\N	\N	25	1
13354	1	76	462	\N	\N	25	1
13355	1	176	462	\N	\N	25	1
13356	4	174	462	\N	\N	25	1
13357	4	211	462	\N	\N	25	1
13358	4	204	462	\N	\N	25	1
13359	3	189	462	\N	\N	25	1
1336	8	5	12	\N	\N	12	\N
13360	3	190	462	\N	\N	25	1
13361	7	191	462	\N	\N	25	1
13362	6	194	462	\N	\N	25	1
13363	1	196	462	\N	\N	25	1
13364	3	199	462	\N	\N	25	1
13365	3	156	463	\N	\N	25	1
13366	5	158	463	\N	\N	25	1
13367	1	131	463	\N	\N	25	1
13368	3	211	463	\N	\N	25	1
13369	1	204	463	\N	\N	25	1
1337	4	6	12	\N	\N	12	\N
13370	1	186	463	\N	\N	25	1
13371	30	187	463	\N	\N	25	1
13372	2	190	463	\N	\N	25	1
13373	1	191	463	\N	\N	25	1
13374	3	194	463	\N	\N	25	1
13375	3	196	463	\N	\N	25	1
13376	1	199	463	\N	\N	25	1
13377	23	7	464	\N	\N	25	1
13378	2	17	464	\N	\N	25	1
13379	63	18	464	\N	Vashon Island--Fern Cove and Shingle Mill Creek: Subtracted count from previous visit	25	1
1338	410	7	12	\N	\N	12	\N
13380	9	20	464	\N	\N	25	1
13381	5	33	464	\N	\N	25	1
13382	30	34	464	\N	Vashon Island--Fern Cove and Shingle Mill Creek: Subtracted count from previous visit	25	1
13383	40	39	464	\N	Vashon Island--Fern Cove and Shingle Mill Creek: Subtracted count from previous visit	25	1
13384	62	40	464	\N	Vashon Island--Fern Cove and Shingle Mill Creek: Subtracted count from previous visit	25	1
13385	6	41	464	\N	\N	25	1
13386	7	42	464	\N	\N	25	1
13387	3	44	464	\N	\N	25	1
13388	18	45	464	\N	\N	25	1
13389	48	59	464	\N	\N	25	1
1339	27	15	12	\N	\N	12	\N
13390	6	60	464	\N	\N	25	1
13391	8	62	464	\N	\N	25	1
13392	30	117	464	\N	\N	25	1
13393	2	131	464	\N	\N	25	1
13394	1	89	464	\N	\N	25	1
13395	23	100	464	\N	\N	25	1
13396	1	105	464	\N	\N	25	1
13397	173	106	464	\N	\N	25	1
13398	2	112	464	\N	\N	25	1
13399	13	116	464	\N	\N	25	1
134	21	51	2	\N	\N	2	\N
1340	6	16	12	\N	\N	12	\N
13400	1	55	464	\N	\N	25	1
13401	3	65	464	\N	\N	25	1
13402	18	67	464	\N	\N	25	1
13403	21	66	464	\N	Vashon Island--Fern Cove and Shingle Mill Creek: Subtracted count from previous visit	25	1
13404	1	76	464	\N	\N	25	1
13405	2	132	464	\N	Vashon Island--Fern Cove and Shingle Mill Creek: Subtracted count from previous visit	25	1
13406	2	135	464	\N	\N	25	1
13407	2	137	464	\N	\N	25	1
13408	1	151	464	\N	\N	25	1
13409	154	153	464	\N	Vashon Island--Fern Cove and Shingle Mill Creek: Subtracted count from previous visit	25	1
1341	13	17	12	\N	\N	12	\N
13410	31	156	464	\N	\N	25	1
13411	25	158	464	\N	\N	25	1
13412	1	160	464	\N	\N	25	1
13413	3	171	464	\N	\N	25	1
13414	3	170	464	\N	\N	25	1
13415	11	161	464	\N	\N	25	1
13416	1	163	464	\N	\N	25	1
13417	7	164	464	\N	\N	25	1
13418	21	174	464	\N	\N	25	1
13419	80	207	464	\N	\N	25	1
1342	3903	18	12	\N	\N	12	\N
13420	8	187	464	\N	\N	25	1
13421	6	194	464	\N	\N	25	1
13422	9	196	464	\N	\N	25	1
13423	10	199	464	\N	\N	25	1
13424	3	184	464	\N	\N	25	1
13425	2	135	465	\N	\N	25	2
13426	1	141	465	\N	\N	25	2
13427	2	139	465	\N	\N	25	2
13428	2	151	465	\N	\N	25	2
13429	1	154	465	\N	\N	25	2
1343	1066	20	12	\N	\N	12	\N
13430	2	156	465	\N	\N	25	2
13431	8	158	465	\N	\N	25	2
13432	2	170	465	\N	\N	25	2
13433	2	161	465	\N	\N	25	2
13434	1	164	465	\N	\N	25	2
13435	2	131	465	\N	\N	25	2
13436	1	76	465	\N	\N	25	2
13437	1	175	465	\N	\N	25	2
13438	10	174	465	\N	\N	25	2
13439	1	186	465	\N	\N	25	2
1344	18	22	12	\N	\N	12	\N
13440	12	189	465	\N	\N	25	2
13441	2	191	465	\N	\N	25	2
13442	1	194	465	\N	\N	25	2
13443	5	196	465	\N	\N	25	2
13444	20	7	466	\N	\N	25	2
13445	6	20	466	\N	\N	25	2
13446	1	24	466	\N	\N	25	2
13447	2	28	466	\N	\N	25	2
13448	2	39	466	\N	at Judd Creek mouth	25	2
13449	3	43	466	\N	at Judd Creek mouth	25	2
1345	17	23	12	\N	\N	12	\N
13450	3	44	466	\N	at Judd Creek mouth - originally reported as RBME	25	2
13451	37	117	466	\N	\N	25	2
13452	2	132	466	\N	\N	25	2
13453	1	134	466	\N	\N	25	2
13454	10	137	466	\N	\N	25	2
13455	6	153	466	\N	\N	25	2
13456	11	154	466	\N	\N	25	2
13457	2	156	466	\N	\N	25	2
13458	1	158	466	\N	\N	25	2
13459	3	171	466	\N	\N	25	2
1346	56	24	12	\N	\N	12	\N
13460	6	170	466	\N	\N	25	2
13461	2	161	466	\N	\N	25	2
13462	1	163	466	\N	\N	25	2
13463	3	164	466	\N	\N	25	2
13464	1	167	466	\N	\N	25	2
13465	4	131	466	\N	\N	25	2
13466	9	112	466	\N	\N	25	2
13467	2	69	466	\N	\N	25	2
13468	1	73	466	\N	\N	25	2
13469	2	76	466	\N	\N	25	2
1347	43	28	12	\N	\N	12	\N
13470	3	79	466	\N	\N	25	2
13471	12	176	466	\N	\N	25	2
13472	14	175	466	\N	\N	25	2
13473	20	174	466	\N	\N	25	2
13474	4	211	466	\N	\N	25	2
13475	1	186	466	\N	\N	25	2
13476	18	187	466	\N	\N	25	2
13477	1	191	466	\N	\N	25	2
13478	12	194	466	\N	\N	25	2
13479	10	196	466	\N	\N	25	2
1348	188	29	12	\N	\N	12	\N
13480	1	181	466	\N	\N	25	2
13481	1	184	466	\N	\N	25	2
13482	1	122	467	\N	\N	25	2
13483	25	18	468	\N	\N	25	2
13484	4	34	468	\N	\N	25	2
13485	11	39	468	\N	\N	25	2
13486	34	40	468	\N	\N	25	2
13487	3	44	468	\N	\N	25	2
13488	20	59	468	\N	Originally reported as 6 HOGR and 14 EAGR, changed to all HOGR after follow up	25	2
13489	1	132	468	\N	\N	25	2
1349	17	30	12	\N	\N	12	\N
13490	6	137	468	\N	\N	25	2
13491	4	153	468	\N	\N	25	2
13492	2	154	468	\N	\N	25	2
13493	2	156	468	\N	\N	25	2
13494	1	87	468	\N	\N	25	2
13495	71	106	468	\N	\N	25	2
13496	14	114	468	\N	Originally reported 6 HERG, changed to WEGU/GWGU after follow up	25	2
13497	4	67	468	\N	\N	25	2
13498	23	66	468	\N	\N	25	2
13499	1	69	468	\N	\N	25	2
135	33	53	2	\N	\N	2	\N
1350	2	31	12	\N	\N	12	\N
13500	2	76	468	\N	\N	25	2
13501	13	174	468	\N	\N	25	2
13502	5	187	468	\N	\N	25	2
13503	6	194	468	\N	\N	25	2
13504	2	134	469	\N	\N	25	2
13505	1	135	469	\N	\N	25	2
13506	1	141	469	\N	\N	25	2
13507	4	137	469	\N	\N	25	2
13508	2	151	469	\N	\N	25	2
13509	2	153	469	\N	\N	25	2
1351	35	33	12	\N	\N	12	\N
13510	5	156	469	\N	\N	25	2
13511	9	158	469	\N	\N	25	2
13512	1	170	469	\N	\N	25	2
13513	5	161	469	\N	\N	25	2
13514	2	163	469	\N	\N	25	2
13515	1	164	469	\N	\N	25	2
13516	1	167	469	\N	\N	25	2
13517	2	131	469	\N	\N	25	2
13518	3	76	469	\N	\N	25	2
13519	1	79	469	\N	\N	25	2
1352	1230	34	12	\N	\N	12	\N
13520	1	175	469	\N	\N	25	2
13521	4	174	469	\N	\N	25	2
13522	3	204	469	\N	\N	25	2
13523	1	186	469	\N	\N	25	2
13524	15	187	469	\N	\N	25	2
13525	2	191	469	\N	\N	25	2
13526	6	194	469	\N	\N	25	2
13527	11	196	469	\N	\N	25	2
13528	20	34	470	\N	\N	25	2
13529	11	39	470	\N	\N	25	2
1353	487	35	12	\N	\N	12	\N
13530	33	40	470	\N	\N	25	2
13531	8	44	470	\N	\N	25	2
13532	65	45	470	\N	\N	25	2
13533	3	59	470	\N	\N	25	2
13534	1	60	470	\N	\N	25	2
13535	2	139	470	\N	\N	25	2
13536	3	153	470	\N	\N	25	2
13537	4	156	470	\N	\N	25	2
13538	10	158	470	\N	\N	25	2
13539	15	160	470	\N	\N	25	2
1354	18	36	12	\N	\N	12	\N
13540	2	171	470	\N	\N	25	2
13541	13	170	470	\N	\N	25	2
13542	3	163	470	\N	\N	25	2
13543	1	164	470	\N	\N	25	2
13544	3	131	470	\N	\N	25	2
13545	2	113	470	\N	\N	25	2
13546	241	116	470	\N	\N	25	2
13547	4	67	470	\N	\N	25	2
13548	18	66	470	\N	\N	25	2
13549	34	68	470	\N	\N	25	2
1355	583	39	12	\N	\N	12	\N
13550	1	69	470	\N	\N	25	2
13551	1	73	470	\N	\N	25	2
13552	4	175	470	\N	\N	25	2
13553	10	174	470	\N	\N	25	2
13554	1	186	470	\N	\N	25	2
13555	16	189	470	\N	\N	25	2
13556	21	194	470	\N	\N	25	2
13557	12	196	470	\N	\N	25	2
13558	2	7	471	\N	\N	25	2
13559	2	18	471	\N	\N	25	2
1356	377	40	12	\N	\N	12	\N
13560	4	20	471	\N	\N	25	2
13561	1	28	471	\N	\N	25	2
13562	26	39	471	\N	\N	25	2
13563	4	40	471	\N	\N	25	2
13564	2	41	471	\N	\N	25	2
13565	18	45	471	\N	\N	25	2
13566	6	59	471	\N	\N	25	2
13567	\N	124	471	t	From Tramp Harbor Rd in VS East area	25	2
13568	3	132	471	\N	\N	25	2
13569	1	135	471	\N	\N	25	2
1357	144	41	12	\N	\N	12	\N
13570	1	141	471	\N	\N	25	2
13571	14	137	471	\N	\N	25	2
13572	1	149	471	\N	\N	25	2
13573	5	153	471	\N	\N	25	2
13574	7	154	471	\N	\N	25	2
13575	26	156	471	\N	\N	25	2
13576	18	158	471	\N	\N	25	2
13577	5	160	471	\N	\N	25	2
13578	12	171	471	\N	\N	25	2
13579	27	170	471	\N	\N	25	2
1358	2	42	12	\N	\N	12	\N
13580	8	161	471	\N	\N	25	2
13581	3	163	471	\N	\N	25	2
13582	11	164	471	\N	\N	25	2
13583	6	167	471	\N	\N	25	2
13584	7	131	471	\N	\N	25	2
13585	2	82	471	\N	\N	25	2
13586	2	103	471	\N	\N	25	2
13587	10	105	471	\N	\N	25	2
13588	27	106	471	\N	\N	25	2
13589	18	113	471	\N	\N	25	2
1359	56	43	12	\N	\N	12	\N
13590	2	53	471	\N	\N	25	2
13591	2	67	471	\N	\N	25	2
13592	41	66	471	\N	\N	25	2
13593	1	79	471	\N	\N	25	2
13594	51	176	471	\N	\N	25	2
13595	5	175	471	\N	\N	25	2
13596	53	174	471	\N	\N	25	2
13597	8	204	471	\N	\N	25	2
13598	7	186	471	\N	\N	25	2
13599	25	187	471	\N	\N	25	2
136	10	54	2	\N	\N	2	\N
1360	274	44	12	\N	\N	12	\N
13600	1	191	471	\N	\N	25	2
13601	30	194	471	\N	\N	25	2
13602	24	196	471	\N	\N	25	2
13603	1	181	471	\N	\N	25	2
13604	1	156	472	\N	\N	25	2
13605	3	158	472	\N	\N	25	2
13606	1	161	472	\N	\N	25	2
13607	1	131	472	\N	\N	25	2
13608	10	189	472	\N	\N	25	2
13609	2	191	472	\N	\N	25	2
1361	210	45	12	\N	\N	12	\N
13610	1	193	472	\N	\N	25	2
13611	2	194	472	\N	\N	25	2
13612	1	196	472	\N	\N	25	2
13613	1	196	473	\N	\N	25	2
13614	5	153	473	\N	\N	25	2
13615	4	194	473	\N	\N	25	2
13616	2	156	473	\N	\N	25	2
13617	2	174	473	\N	\N	25	2
13618	1	161	473	\N	\N	25	2
13619	1	175	473	\N	\N	25	2
1362	21	47	12	\N	\N	12	\N
13620	2	154	473	\N	\N	25	2
13621	3	158	473	\N	\N	25	2
13622	2	187	473	\N	\N	25	2
13623	1	135	473	\N	\N	25	2
13624	1	164	473	\N	\N	25	2
13625	1	204	473	\N	\N	25	2
13626	1	170	473	\N	\N	25	2
13627	1	171	473	\N	\N	25	2
13628	8	156	474	\N	\N	25	2
13629	9	158	474	\N	\N	25	2
1363	1	49	12	\N	\N	12	\N
13630	1	161	474	\N	\N	25	2
13631	2	131	474	\N	\N	25	2
13632	2	175	474	\N	\N	25	2
13633	3	174	474	\N	\N	25	2
13634	2	204	474	\N	\N	25	2
13635	13	189	474	\N	\N	25	2
13636	4	194	474	\N	\N	25	2
13637	3	196	474	\N	\N	25	2
13638	1	124	475	\N	\N	25	2
13639	1	137	475	\N	\N	25	2
1364	3	51	12	\N	\N	12	\N
13640	1	154	475	\N	\N	25	2
13641	2	158	475	\N	\N	25	2
13642	2	171	475	\N	\N	25	2
13643	1	170	475	\N	\N	25	2
13644	1	163	475	\N	\N	25	2
13645	3	164	475	\N	\N	25	2
13646	1	167	475	\N	\N	25	2
13647	1	131	475	\N	\N	25	2
13648	1	175	475	\N	\N	25	2
13649	1	174	475	\N	\N	25	2
1365	40	53	12	\N	\N	12	\N
13650	2	207	475	\N	Originally reported as a heard-only flock w/ no number, going w/ minimum count for hearing more than one bird	25	2
13651	1	194	475	\N	\N	25	2
13652	1	196	475	\N	\N	25	2
13653	1	136	476	\N	\N	25	2
13654	1	139	476	\N	\N	25	2
13655	2	154	476	\N	\N	25	2
13656	5	158	476	\N	\N	25	2
13657	2	131	476	\N	\N	25	2
13658	1	121	476	\N	Originally reported as MODO	25	2
13659	1	175	476	\N	\N	25	2
1366	110	54	12	\N	\N	12	\N
13660	1	186	476	\N	\N	25	2
13661	17	187	476	\N	\N	25	2
13662	5	194	476	\N	\N	25	2
13663	13	196	476	\N	\N	25	2
13664	1	142	476	\N	Originally reported as second HAWO	25	2
13665	2	156	477	\N	\N	25	2
13666	3	158	477	\N	\N	25	2
13667	5	160	477	\N	\N	25	2
13668	4	131	477	\N	\N	25	2
13669	1	69	477	\N	\N	25	2
1367	28	55	12	\N	\N	12	\N
13670	1	76	477	\N	\N	25	2
13671	2	187	477	\N	Originally reported as SCJU	25	2
13672	2	189	477	\N	\N	25	2
13673	1	190	477	\N	\N	25	2
13674	1	191	477	\N	\N	25	2
13675	4	196	477	\N	\N	25	2
13676	7	197	477	\N	\N	25	2
13677	1	181	477	\N	\N	25	2
1368	1	57	12	\N	\N	12	\N
1369	16	58	12	\N	\N	12	\N
137	28	55	2	\N	\N	2	\N
1370	437	59	12	\N	\N	12	\N
1371	86	60	12	\N	\N	12	\N
1372	27	61	12	\N	\N	12	\N
1373	562	62	12	\N	\N	12	\N
1374	33	65	12	\N	\N	12	\N
1375	219	66	12	\N	\N	12	\N
1376	19	67	12	\N	\N	12	\N
1377	1	68	12	\N	\N	12	\N
1378	23	69	12	\N	\N	12	\N
1379	1	71	12	\N	\N	12	\N
138	24	58	2	\N	\N	2	\N
1380	10	72	12	\N	\N	12	\N
1381	3	73	12	\N	\N	12	\N
1382	1	75	12	\N	\N	12	\N
1383	72	76	12	\N	\N	12	\N
1384	26	79	12	\N	\N	12	\N
1385	1	81	12	\N	\N	12	\N
1386	3	82	12	\N	\N	12	\N
1387	17	83	12	\N	\N	12	\N
1388	115	86	12	\N	\N	12	\N
1389	5	87	12	\N	\N	12	\N
139	241	59	2	\N	\N	2	\N
1390	3	88	12	\N	\N	12	\N
1391	9	89	12	\N	\N	12	\N
1392	4	91	12	\N	\N	12	\N
1393	90	92	12	\N	\N	12	\N
1394	9	95	12	\N	\N	12	\N
1395	3	99	12	\N	\N	12	\N
1396	24	100	12	\N	\N	12	\N
1397	2	101	12	\N	\N	12	\N
1398	14	103	12	\N	\N	12	\N
1399	2	105	12	\N	\N	12	\N
14	1016	34	1	\N	\N	1	\N
140	76	60	2	\N	\N	2	\N
1400	171	106	12	\N	\N	12	\N
1401	13	107	12	\N	\N	12	\N
1402	3	109	12	\N	\N	12	\N
1403	2	110	12	\N	\N	12	\N
1404	2	111	12	\N	\N	12	\N
1405	319	112	12	\N	\N	12	\N
1406	60	113	12	\N	\N	12	\N
1407	87	116	12	\N	\N	12	\N
1408	299	117	12	\N	\N	12	\N
1409	4	118	12	\N	\N	12	\N
141	4	61	2	\N	\N	2	\N
1410	10	120	12	\N	\N	12	\N
1411	1	122	12	\N	\N	12	\N
1412	1	123	12	\N	\N	12	\N
1413	2	124	12	\N	\N	12	\N
1414	1	125	12	\N	\N	12	\N
1415	7	126	12	\N	\N	12	\N
1416	2	129	12	\N	\N	12	\N
1417	82	131	12	\N	\N	12	\N
1418	22	132	12	\N	\N	12	\N
1419	10	134	12	\N	\N	12	\N
142	1747	62	2	\N	\N	2	\N
1420	27	135	12	\N	\N	12	\N
1421	7	136	12	\N	\N	12	\N
1422	119	139	12	\N	\N	12	\N
1423	21	141	12	\N	\N	12	\N
1424	3	144	12	\N	\N	12	\N
1425	1	145	12	\N	\N	12	\N
1426	164	151	12	\N	\N	12	\N
1427	3	152	12	\N	\N	12	\N
1428	741	153	12	\N	\N	12	\N
1429	20	154	12	\N	\N	12	\N
143	9	65	2	\N	\N	2	\N
1430	234	156	12	\N	\N	12	\N
1431	358	158	12	\N	\N	12	\N
1432	37	160	12	\N	\N	12	\N
1433	80	161	12	\N	\N	12	\N
1434	20	163	12	\N	\N	12	\N
1435	162	164	12	\N	\N	12	\N
1436	1	166	12	\N	\N	12	\N
1437	32	167	12	\N	\N	12	\N
1438	295	170	12	\N	\N	12	\N
1439	68	171	12	\N	\N	12	\N
144	389	66	2	\N	\N	2	\N
1440	38	173	12	\N	\N	12	\N
1441	918	174	12	\N	\N	12	\N
1442	111	175	12	\N	\N	12	\N
1443	880	176	12	\N	\N	12	\N
1444	1	178	12	\N	\N	12	\N
1445	5	183	12	\N	\N	12	\N
1446	11	184	12	\N	\N	12	\N
1447	123	186	12	\N	\N	12	\N
1448	2	188	12	\N	\N	12	\N
1449	1118	189	12	\N	\N	12	\N
145	9	67	2	\N	\N	2	\N
1450	12	190	12	\N	\N	12	\N
1451	156	191	12	\N	\N	12	\N
1452	2	193	12	\N	\N	12	\N
1453	514	194	12	\N	\N	12	\N
1454	333	196	12	\N	\N	12	\N
1455	194	199	12	\N	\N	12	\N
1456	49	201	12	\N	\N	12	\N
1457	264	204	12	\N	\N	12	\N
1458	31	205	12	\N	\N	12	\N
1459	5	206	12	\N	\N	12	\N
146	2	68	2	\N	\N	2	\N
1460	250	207	12	\N	\N	12	\N
1461	21	208	12	\N	\N	12	\N
1462	10	209	12	\N	\N	12	\N
1463	110	211	12	\N	\N	12	\N
1464	10	2	13	\N	\N	13	\N
1465	\N	5	13	t	\N	13	\N
1466	2	6	13	\N	\N	13	\N
1467	315	7	13	\N	\N	13	\N
1468	20	15	13	\N	\N	13	\N
1469	10	16	13	\N	\N	13	\N
147	37	69	2	\N	\N	2	\N
1470	7	17	13	\N	\N	13	\N
1471	3556	18	13	\N	\N	13	\N
1472	469	20	13	\N	\N	13	\N
1473	15	22	13	\N	\N	13	\N
1474	1	23	13	\N	\N	13	\N
1475	23	24	13	\N	\N	13	\N
1476	255	28	13	\N	\N	13	\N
1477	120	29	13	\N	\N	13	\N
1478	59	30	13	\N	\N	13	\N
1479	126	31	13	\N	\N	13	\N
148	5	72	2	\N	\N	2	\N
1480	16	33	13	\N	\N	13	\N
1481	1131	34	13	\N	\N	13	\N
1482	461	35	13	\N	\N	13	\N
1483	22	36	13	\N	\N	13	\N
1484	674	39	13	\N	\N	13	\N
1485	391	40	13	\N	\N	13	\N
1486	183	41	13	\N	\N	13	\N
1487	1	42	13	\N	\N	13	\N
1488	38	43	13	\N	\N	13	\N
1489	460	44	13	\N	\N	13	\N
149	4	73	2	\N	\N	2	\N
1490	259	45	13	\N	\N	13	\N
1491	59	47	13	\N	\N	13	\N
1492	3	51	13	\N	\N	13	\N
1493	75	53	13	\N	\N	13	\N
1494	38	54	13	\N	\N	13	\N
1495	56	55	13	\N	\N	13	\N
1496	38	58	13	\N	\N	13	\N
1497	730	59	13	\N	\N	13	\N
1498	154	60	13	\N	\N	13	\N
1499	24	61	13	\N	\N	13	\N
15	904	35	1	\N	\N	1	\N
150	28	76	2	\N	\N	2	\N
1500	761	62	13	\N	\N	13	\N
1501	1	63	13	\N	\N	13	\N
1502	55	65	13	\N	\N	13	\N
1503	418	66	13	\N	\N	13	\N
1504	24	67	13	\N	\N	13	\N
1505	47	69	13	\N	\N	13	\N
1506	4	72	13	\N	\N	13	\N
1507	3	73	13	\N	\N	13	\N
1508	2	75	13	\N	\N	13	\N
1509	41	76	13	\N	\N	13	\N
151	14	79	2	\N	\N	2	\N
1510	17	79	13	\N	\N	13	\N
1511	3	82	13	\N	\N	13	\N
1512	131	83	13	\N	\N	13	\N
1513	82	86	13	\N	\N	13	\N
1514	3	87	13	\N	\N	13	\N
1515	6	88	13	\N	\N	13	\N
1516	14	89	13	\N	\N	13	\N
1517	137	91	13	\N	\N	13	\N
1518	6	92	13	\N	\N	13	\N
1519	10	95	13	\N	\N	13	\N
152	401	83	2	\N	\N	2	\N
1520	12	98	13	\N	\N	13	\N
1521	95	99	13	\N	\N	13	\N
1522	32	100	13	\N	\N	13	\N
1523	638	103	13	\N	\N	13	\N
1524	193	105	13	\N	\N	13	\N
1525	475	106	13	\N	\N	13	\N
1526	7	107	13	\N	\N	13	\N
1527	2	108	13	\N	\N	13	\N
1528	5	109	13	\N	\N	13	\N
1529	1	110	13	\N	\N	13	\N
153	63	86	2	\N	\N	2	\N
1530	5	111	13	\N	\N	13	\N
1531	820	112	13	\N	\N	13	\N
1532	110	113	13	\N	\N	13	\N
1533	233	116	13	\N	\N	13	\N
1534	132	117	13	\N	\N	13	\N
1535	\N	118	13	t	\N	13	\N
1536	67	120	13	\N	\N	13	\N
1537	2	123	13	\N	\N	13	\N
1538	2	124	13	\N	\N	13	\N
1539	3	126	13	\N	\N	13	\N
154	2	87	2	\N	\N	2	\N
1540	73	131	13	\N	\N	13	\N
1541	25	132	13	\N	\N	13	\N
1542	8	134	13	\N	\N	13	\N
1543	25	135	13	\N	\N	13	\N
1544	7	136	13	\N	\N	13	\N
1545	128	139	13	\N	\N	13	\N
1546	29	141	13	\N	\N	13	\N
1547	1	143	13	\N	\N	13	\N
1548	5	144	13	\N	\N	13	\N
1549	1	145	13	\N	\N	13	\N
155	16	89	2	\N	\N	2	\N
1550	139	151	13	\N	\N	13	\N
1551	1024	153	13	\N	\N	13	\N
1552	21	154	13	\N	\N	13	\N
1553	245	156	13	\N	\N	13	\N
1554	371	158	13	\N	\N	13	\N
1555	16	160	13	\N	\N	13	\N
1556	79	161	13	\N	\N	13	\N
1557	16	163	13	\N	\N	13	\N
1558	92	164	13	\N	\N	13	\N
1559	13	166	13	\N	\N	13	\N
156	3	90	2	\N	\N	2	\N
1560	34	167	13	\N	\N	13	\N
1561	248	170	13	\N	\N	13	\N
1562	96	171	13	\N	\N	13	\N
1563	\N	173	13	t	\N	13	\N
1564	2086	174	13	\N	\N	13	\N
1565	92	175	13	\N	\N	13	\N
1566	1103	176	13	\N	\N	13	\N
1567	17	178	13	\N	\N	13	\N
1568	1	183	13	\N	\N	13	\N
1569	14	184	13	\N	\N	13	\N
157	77	91	2	\N	\N	2	\N
1570	121	186	13	\N	\N	13	\N
1571	1	188	13	\N	\N	13	\N
1572	948	189	13	\N	\N	13	\N
1573	25	190	13	\N	\N	13	\N
1574	138	191	13	\N	\N	13	\N
1575	\N	193	13	t	\N	13	\N
1576	286	194	13	\N	\N	13	\N
1577	245	196	13	\N	\N	13	\N
1578	623	199	13	\N	\N	13	\N
1579	135	201	13	\N	\N	13	\N
158	5	92	2	\N	\N	2	\N
1580	210	204	13	\N	\N	13	\N
1581	52	205	13	\N	\N	13	\N
1582	45	206	13	\N	\N	13	\N
1583	1089	207	13	\N	\N	13	\N
1584	35	208	13	\N	\N	13	\N
1585	6	209	13	\N	\N	13	\N
1586	101	211	13	\N	\N	13	\N
1587	\N	4	14	t	\N	14	\N
1588	32	5	14	\N	\N	14	\N
1589	372	7	14	\N	\N	14	\N
159	6	96	2	\N	\N	2	\N
1590	\N	11	14	t	\N	14	\N
1591	33	15	14	\N	\N	14	\N
1592	3	16	14	\N	\N	14	\N
1593	12	17	14	\N	\N	14	\N
1594	4162	18	14	\N	\N	14	\N
1595	434	20	14	\N	\N	14	\N
1596	13	22	14	\N	\N	14	\N
1597	1	23	14	\N	\N	14	\N
1598	47	24	14	\N	\N	14	\N
1599	141	28	14	\N	\N	14	\N
16	18	36	1	\N	\N	1	\N
160	3	99	2	\N	\N	2	\N
1600	219	29	14	\N	\N	14	\N
1601	51	30	14	\N	\N	14	\N
1602	12	31	14	\N	\N	14	\N
1603	41	33	14	\N	\N	14	\N
1604	2055	34	14	\N	\N	14	\N
1605	343	35	14	\N	\N	14	\N
1606	47	36	14	\N	\N	14	\N
1607	4	37	14	\N	\N	14	\N
1608	886	39	14	\N	\N	14	\N
1609	619	40	14	\N	\N	14	\N
161	10	100	2	\N	\N	2	\N
1610	237	41	14	\N	\N	14	\N
1611	2	42	14	\N	\N	14	\N
1612	57	43	14	\N	\N	14	\N
1613	789	44	14	\N	\N	14	\N
1614	255	45	14	\N	\N	14	\N
1615	101	47	14	\N	\N	14	\N
1616	3	51	14	\N	\N	14	\N
1617	117	53	14	\N	\N	14	\N
1618	90	54	14	\N	\N	14	\N
1619	71	55	14	\N	\N	14	\N
162	10	103	2	\N	\N	2	\N
1620	\N	56	14	t	\N	14	\N
1621	4	57	14	\N	\N	14	\N
1622	61	58	14	\N	\N	14	\N
1623	739	59	14	\N	\N	14	\N
1624	141	60	14	\N	\N	14	\N
1625	25	61	14	\N	\N	14	\N
1626	453	62	14	\N	\N	14	\N
1627	38	65	14	\N	\N	14	\N
1628	471	66	14	\N	\N	14	\N
1629	37	67	14	\N	\N	14	\N
163	30	105	2	\N	\N	2	\N
1630	17	68	14	\N	\N	14	\N
1631	46	69	14	\N	\N	14	\N
1632	2	71	14	\N	\N	14	\N
1633	4	72	14	\N	\N	14	\N
1634	5	73	14	\N	\N	14	\N
1635	2	75	14	\N	\N	14	\N
1636	55	76	14	\N	\N	14	\N
1637	23	79	14	\N	\N	14	\N
1638	1	80	14	\N	\N	14	\N
1639	2	82	14	\N	\N	14	\N
164	188	106	2	\N	\N	2	\N
1640	1264	83	14	\N	\N	14	\N
1641	24	86	14	\N	\N	14	\N
1642	3	87	14	\N	\N	14	\N
1643	33	89	14	\N	\N	14	\N
1644	27	91	14	\N	\N	14	\N
1645	12	98	14	\N	\N	14	\N
1646	33	99	14	\N	\N	14	\N
1647	33	100	14	\N	\N	14	\N
1648	1	101	14	\N	\N	14	\N
1649	53	103	14	\N	\N	14	\N
165	2	108	2	\N	\N	2	\N
1650	10	105	14	\N	\N	14	\N
1651	293	106	14	\N	\N	14	\N
1652	8	107	14	\N	\N	14	\N
1653	2	108	14	\N	\N	14	\N
1654	17	109	14	\N	\N	14	\N
1655	2	110	14	\N	\N	14	\N
1656	4	111	14	\N	\N	14	\N
1657	607	112	14	\N	\N	14	\N
1658	91	113	14	\N	\N	14	\N
1659	99	116	14	\N	\N	14	\N
166	16	109	2	\N	\N	2	\N
1660	163	117	14	\N	\N	14	\N
1661	23	118	14	\N	\N	14	\N
1662	6	119	14	\N	\N	14	\N
1663	22	120	14	\N	\N	14	\N
1664	3	122	14	\N	\N	14	\N
1665	1	123	14	\N	\N	14	\N
1666	3	124	14	\N	\N	14	\N
1667	4	126	14	\N	\N	14	\N
1668	1	128	14	\N	\N	14	\N
1669	88	131	14	\N	\N	14	\N
167	1	110	2	\N	\N	2	\N
1670	28	132	14	\N	\N	14	\N
1671	13	134	14	\N	\N	14	\N
1672	26	135	14	\N	\N	14	\N
1673	5	136	14	\N	\N	14	\N
1674	137	139	14	\N	\N	14	\N
1675	32	141	14	\N	\N	14	\N
1676	1	143	14	\N	\N	14	\N
1677	8	144	14	\N	\N	14	\N
1678	2	145	14	\N	\N	14	\N
1679	5	149	14	\N	\N	14	\N
168	1	111	2	\N	\N	2	\N
1680	144	151	14	\N	\N	14	\N
1681	2	152	14	\N	\N	14	\N
1682	1465	153	14	\N	\N	14	\N
1683	11	154	14	\N	\N	14	\N
1684	376	156	14	\N	\N	14	\N
1685	493	158	14	\N	\N	14	\N
1686	20	160	14	\N	\N	14	\N
1687	106	161	14	\N	\N	14	\N
1688	11	163	14	\N	\N	14	\N
1689	96	164	14	\N	\N	14	\N
169	394	112	2	\N	\N	2	\N
1690	4	166	14	\N	\N	14	\N
1691	26	167	14	\N	\N	14	\N
1692	1	169	14	\N	\N	14	\N
1693	710	170	14	\N	\N	14	\N
1694	197	171	14	\N	\N	14	\N
1695	3	173	14	\N	\N	14	\N
1696	1199	174	14	\N	\N	14	\N
1697	146	175	14	\N	\N	14	\N
1698	1331	176	14	\N	\N	14	\N
1699	5	178	14	\N	\N	14	\N
17	1	37	1	\N	\N	1	\N
170	16	113	2	\N	\N	2	\N
1700	13	183	14	\N	\N	14	\N
1701	5	184	14	\N	\N	14	\N
1702	84	186	14	\N	\N	14	\N
1703	1236	189	14	\N	\N	14	\N
1704	6	190	14	\N	\N	14	\N
1705	186	191	14	\N	\N	14	\N
1706	402	194	14	\N	\N	14	\N
1707	2	195	14	\N	\N	14	\N
1708	256	196	14	\N	\N	14	\N
1709	285	199	14	\N	\N	14	\N
171	167	116	2	\N	\N	2	\N
1710	25	201	14	\N	\N	14	\N
1711	227	204	14	\N	\N	14	\N
1712	13	205	14	\N	\N	14	\N
1713	185	206	14	\N	\N	14	\N
1714	7024	207	14	\N	\N	14	\N
1715	34	208	14	\N	\N	14	\N
1716	136	211	14	\N	\N	14	\N
1717	5	5	15	\N	\N	15	\N
1718	326	7	15	\N	\N	15	\N
1719	30	15	15	\N	\N	15	\N
172	364	117	2	\N	\N	2	\N
1720	8	16	15	\N	\N	15	\N
1721	9	17	15	\N	\N	15	\N
1722	3357	18	15	\N	\N	15	\N
1723	603	20	15	\N	\N	15	\N
1724	9	22	15	\N	\N	15	\N
1725	31	23	15	\N	\N	15	\N
1726	67	24	15	\N	\N	15	\N
1727	4	27	15	\N	\N	15	\N
1728	100	28	15	\N	\N	15	\N
1729	264	29	15	\N	\N	15	\N
173	8	118	2	\N	\N	2	\N
1730	33	30	15	\N	\N	15	\N
1731	7	31	15	\N	\N	15	\N
1732	27	33	15	\N	\N	15	\N
1733	1476	34	15	\N	\N	15	\N
1734	202	35	15	\N	\N	15	\N
1735	25	36	15	\N	\N	15	\N
1736	954	39	15	\N	\N	15	\N
1737	462	40	15	\N	\N	15	\N
1738	143	41	15	\N	\N	15	\N
1739	113	43	15	\N	\N	15	\N
174	4	120	2	\N	\N	2	\N
1740	348	44	15	\N	\N	15	\N
1741	295	45	15	\N	\N	15	\N
1742	65	47	15	\N	\N	15	\N
1743	4	51	15	\N	\N	15	\N
1744	55	53	15	\N	\N	15	\N
1745	19	54	15	\N	\N	15	\N
1746	29	55	15	\N	\N	15	\N
1747	1	56	15	\N	\N	15	\N
1748	87	58	15	\N	\N	15	\N
1749	447	59	15	\N	\N	15	\N
175	4	124	2	\N	\N	2	\N
1750	48	60	15	\N	\N	15	\N
1751	8	61	15	\N	\N	15	\N
1752	46	62	15	\N	\N	15	\N
1753	24	65	15	\N	\N	15	\N
1754	200	66	15	\N	\N	15	\N
1755	42	67	15	\N	\N	15	\N
1756	2	68	15	\N	\N	15	\N
1757	24	69	15	\N	\N	15	\N
1758	1	70	15	\N	\N	15	\N
1759	2	71	15	\N	\N	15	\N
176	1	126	2	\N	\N	2	\N
1760	2	72	15	\N	\N	15	\N
1761	6	73	15	\N	\N	15	\N
1762	3	75	15	\N	\N	15	\N
1763	23	79	15	\N	\N	15	\N
1764	5	82	15	\N	\N	15	\N
1765	116	83	15	\N	\N	15	\N
1766	97	86	15	\N	\N	15	\N
1767	8	87	15	\N	\N	15	\N
1768	5	88	15	\N	\N	15	\N
1769	15	91	15	\N	\N	15	\N
177	14	131	2	\N	\N	2	\N
1770	54	92	15	\N	\N	15	\N
1771	\N	95	15	t	\N	15	\N
1772	3	99	15	\N	\N	15	\N
1773	20	100	15	\N	\N	15	\N
1774	1	101	15	\N	\N	15	\N
1775	17	103	15	\N	\N	15	\N
1776	4	105	15	\N	\N	15	\N
1777	395	106	15	\N	\N	15	\N
1778	5	107	15	\N	\N	15	\N
1779	1	108	15	\N	\N	15	\N
178	25	132	2	\N	\N	2	\N
1780	1	111	15	\N	\N	15	\N
1781	542	112	15	\N	\N	15	\N
1782	139	113	15	\N	\N	15	\N
1783	9	116	15	\N	\N	15	\N
1784	198	117	15	\N	\N	15	\N
1785	31	118	15	\N	\N	15	\N
1786	3	119	15	\N	\N	15	\N
1787	8	120	15	\N	\N	15	\N
1788	1	123	15	\N	\N	15	\N
1789	6	126	15	\N	\N	15	\N
179	7	135	2	\N	\N	2	\N
1790	1	129	15	\N	\N	15	\N
1791	81	131	15	\N	\N	15	\N
1792	37	132	15	\N	\N	15	\N
1793	16	134	15	\N	\N	15	\N
1794	23	135	15	\N	\N	15	\N
1795	6	136	15	\N	\N	15	\N
1796	105	139	15	\N	\N	15	\N
1797	18	141	15	\N	\N	15	\N
1798	1	143	15	\N	\N	15	\N
1799	4	144	15	\N	\N	15	\N
18	367	39	1	\N	\N	1	\N
180	3	136	2	\N	\N	2	\N
1800	2	145	15	\N	\N	15	\N
1801	3	149	15	\N	\N	15	\N
1802	125	151	15	\N	\N	15	\N
1803	1	152	15	\N	\N	15	\N
1804	886	153	15	\N	\N	15	\N
1805	38	154	15	\N	\N	15	\N
1806	321	156	15	\N	\N	15	\N
1807	351	158	15	\N	\N	15	\N
1808	51	160	15	\N	\N	15	\N
1809	95	161	15	\N	\N	15	\N
181	57	139	2	\N	\N	2	\N
1810	25	163	15	\N	\N	15	\N
1811	74	164	15	\N	\N	15	\N
1812	4	166	15	\N	\N	15	\N
1813	32	167	15	\N	\N	15	\N
1814	\N	169	15	t	\N	15	\N
1815	215	170	15	\N	\N	15	\N
1816	51	171	15	\N	\N	15	\N
1817	11	173	15	\N	\N	15	\N
1818	853	174	15	\N	\N	15	\N
1819	87	175	15	\N	\N	15	\N
182	6	141	2	\N	\N	2	\N
1820	1454	176	15	\N	\N	15	\N
1821	3	179	15	\N	\N	15	\N
1822	9	183	15	\N	\N	15	\N
1823	5	184	15	\N	\N	15	\N
1824	89	186	15	\N	\N	15	\N
1825	1	188	15	\N	\N	15	\N
1826	1230	189	15	\N	\N	15	\N
1827	17	190	15	\N	\N	15	\N
1828	191	191	15	\N	\N	15	\N
1829	3	193	15	\N	\N	15	\N
183	2	144	2	\N	\N	2	\N
1830	343	194	15	\N	\N	15	\N
1831	\N	195	15	t	\N	15	\N
1832	265	196	15	\N	\N	15	\N
1833	203	199	15	\N	\N	15	\N
1834	1	201	15	\N	\N	15	\N
1835	105	204	15	\N	\N	15	\N
1836	33	205	15	\N	\N	15	\N
1837	12	206	15	\N	\N	15	\N
1838	1	207	15	\N	\N	15	\N
1839	10	208	15	\N	\N	15	\N
184	1	148	2	\N	\N	2	\N
1840	98	211	15	\N	\N	15	\N
1841	5	5	16	\N	\N	16	\N
1842	4	6	16	\N	\N	16	\N
1843	348	7	16	\N	\N	16	\N
1844	8	15	16	\N	\N	16	\N
1845	1	16	16	\N	\N	16	\N
1846	6	17	16	\N	\N	16	\N
1847	2366	18	16	\N	\N	16	\N
1848	502	20	16	\N	\N	16	\N
1849	13	22	16	\N	\N	16	\N
185	5	149	2	\N	\N	2	\N
1850	19	23	16	\N	\N	16	\N
1851	58	24	16	\N	\N	16	\N
1852	20	25	16	\N	\N	16	\N
1853	110	28	16	\N	\N	16	\N
1854	173	29	16	\N	\N	16	\N
1855	16	30	16	\N	\N	16	\N
1856	30	33	16	\N	\N	16	\N
1857	1096	34	16	\N	\N	16	\N
1858	348	35	16	\N	\N	16	\N
1859	25	36	16	\N	\N	16	\N
186	78	151	2	\N	\N	2	\N
1860	10	37	16	\N	\N	16	\N
1861	1	38	16	\N	\N	16	\N
1862	844	39	16	\N	\N	16	\N
1863	504	40	16	\N	\N	16	\N
1864	172	41	16	\N	\N	16	\N
1865	51	43	16	\N	\N	16	\N
1866	261	44	16	\N	\N	16	\N
1867	276	45	16	\N	\N	16	\N
1868	20	47	16	\N	\N	16	\N
1869	1	51	16	\N	\N	16	\N
187	1009	153	2	\N	\N	2	\N
1870	54	53	16	\N	\N	16	\N
1871	84	54	16	\N	\N	16	\N
1872	50	55	16	\N	\N	16	\N
1873	\N	56	16	t	\N	16	\N
1874	68	58	16	\N	\N	16	\N
1875	542	59	16	\N	\N	16	\N
1876	81	60	16	\N	\N	16	\N
1877	11	61	16	\N	\N	16	\N
1878	43	62	16	\N	\N	16	\N
1879	142	65	16	\N	\N	16	\N
188	9	154	2	\N	\N	2	\N
1880	286	66	16	\N	\N	16	\N
1881	54	67	16	\N	\N	16	\N
1882	187	68	16	\N	\N	16	\N
1883	22	69	16	\N	\N	16	\N
1884	3	71	16	\N	\N	16	\N
1885	3	72	16	\N	\N	16	\N
1886	3	73	16	\N	\N	16	\N
1887	34	76	16	\N	\N	16	\N
1888	8	79	16	\N	\N	16	\N
1889	4	82	16	\N	\N	16	\N
189	132	156	2	\N	\N	2	\N
1890	2	83	16	\N	\N	16	\N
1891	72	86	16	\N	\N	16	\N
1892	1	87	16	\N	\N	16	\N
1893	2	88	16	\N	\N	16	\N
1894	30	91	16	\N	\N	16	\N
1895	60	92	16	\N	\N	16	\N
1896	10	95	16	\N	\N	16	\N
1897	19	99	16	\N	\N	16	\N
1898	24	100	16	\N	\N	16	\N
1899	6	103	16	\N	\N	16	\N
19	474	40	1	\N	\N	1	\N
190	153	158	2	\N	\N	2	\N
1900	412	106	16	\N	\N	16	\N
1901	2	107	16	\N	\N	16	\N
1902	7	109	16	\N	\N	16	\N
1903	1	111	16	\N	\N	16	\N
1904	421	112	16	\N	\N	16	\N
1905	99	113	16	\N	\N	16	\N
1906	74	116	16	\N	\N	16	\N
1907	233	117	16	\N	\N	16	\N
1908	6	118	16	\N	\N	16	\N
1909	2	119	16	\N	\N	16	\N
191	20	160	2	\N	\N	2	\N
1910	36	120	16	\N	\N	16	\N
1911	2	124	16	\N	\N	16	\N
1912	2	126	16	\N	\N	16	\N
1913	2	129	16	\N	\N	16	\N
1914	124	131	16	\N	\N	16	\N
1915	26	132	16	\N	\N	16	\N
1916	6	134	16	\N	\N	16	\N
1917	21	135	16	\N	\N	16	\N
1918	2	136	16	\N	\N	16	\N
1919	120	139	16	\N	\N	16	\N
192	30	161	2	\N	\N	2	\N
1920	15	141	16	\N	\N	16	\N
1921	3	144	16	\N	\N	16	\N
1922	2	145	16	\N	\N	16	\N
1923	1	146	16	\N	\N	16	\N
1924	2	149	16	\N	\N	16	\N
1925	152	151	16	\N	\N	16	\N
1926	\N	152	16	t	\N	16	\N
1927	726	153	16	\N	\N	16	\N
1928	17	154	16	\N	\N	16	\N
1929	324	156	16	\N	\N	16	\N
193	8	163	2	\N	\N	2	\N
1930	252	158	16	\N	\N	16	\N
1931	15	160	16	\N	\N	16	\N
1932	79	161	16	\N	\N	16	\N
1933	1	162	16	\N	\N	16	\N
1934	22	163	16	\N	\N	16	\N
1935	41	164	16	\N	\N	16	\N
1936	2	166	16	\N	\N	16	\N
1937	27	167	16	\N	\N	16	\N
1938	1	169	16	\N	\N	16	\N
1939	166	170	16	\N	\N	16	\N
194	54	165	2	\N	\N	2	\N
1940	103	171	16	\N	\N	16	\N
1941	4	173	16	\N	\N	16	\N
1942	1431	174	16	\N	\N	16	\N
1943	70	175	16	\N	\N	16	\N
1944	738	176	16	\N	\N	16	\N
1945	\N	178	16	t	\N	16	\N
1946	2	179	16	\N	\N	16	\N
1947	23	183	16	\N	\N	16	\N
1948	2	184	16	\N	\N	16	\N
1949	42	186	16	\N	\N	16	\N
195	1	166	2	\N	\N	2	\N
1950	1219	189	16	\N	\N	16	\N
1951	38	190	16	\N	\N	16	\N
1952	226	191	16	\N	\N	16	\N
1953	3	193	16	\N	\N	16	\N
1954	242	194	16	\N	\N	16	\N
1955	232	196	16	\N	\N	16	\N
1956	248	199	16	\N	\N	16	\N
1957	111	201	16	\N	\N	16	\N
1958	156	204	16	\N	\N	16	\N
1959	56	205	16	\N	\N	16	\N
196	19	167	2	\N	\N	2	\N
1960	61	206	16	\N	\N	16	\N
1961	666	207	16	\N	\N	16	\N
1962	86	208	16	\N	\N	16	\N
1963	19	209	16	\N	\N	16	\N
1964	20	210	16	\N	\N	16	\N
1965	112	211	16	\N	\N	16	\N
1966	2	5	17	\N	\N	17	5
1967	7	17	17	\N	\N	17	5
1968	2111	18	17	\N	AMWI - main mass counted from photos, eyeball estimate was high	17	5
1969	99	20	17	\N	\N	17	5
197	1	169	2	\N	\N	2	\N
1970	7	24	17	\N	\N	17	5
1971	31	29	17	\N	\N	17	5
1972	5	30	17	\N	\N	17	5
1973	7	33	17	\N	\N	17	5
1974	68	34	17	\N	\N	17	5
1975	130	39	17	\N	\N	17	5
1976	115	40	17	\N	\N	17	5
1977	2	41	17	\N	\N	17	5
1978	3	43	17	\N	\N	17	5
1979	43	44	17	\N	\N	17	5
198	121	170	2	\N	\N	2	\N
1980	37	45	17	\N	\N	17	5
1981	46	53	17	\N	RTLO - almost all associated with porpoise & sealion and cormorants	17	5
1982	2	54	17	\N	\N	17	5
1983	7	55	17	\N	\N	17	5
1984	59	59	17	\N	\N	17	5
1985	11	60	17	\N	\N	17	5
1986	2	61	17	\N	\N	17	5
1987	5	117	17	\N	\N	17	5
1988	8	119	17	\N	\N	17	5
1989	2	131	17	\N	\N	17	5
199	86	171	2	\N	\N	2	\N
1990	4	132	17	\N	\N	17	5
1991	1	137	17	\N	\N	17	5
1992	4	151	17	\N	\N	17	5
1993	31	153	17	\N	\N	17	5
1994	3	156	17	\N	\N	17	5
1995	32	65	17	\N	\N	17	5
1996	51	66	17	\N	\N	17	5
1997	6	67	17	\N	\N	17	5
1998	120	68	17	\N	cormorant sp. - flock, around harbor porpoises and sealions, too far to determine in BRCO or DCCO, although those that flew were BRCO	17	5
1999	6	69	17	\N	GBHE - in one clump trees	17	5
2	24	15	1	\N	\N	1	\N
20	95	41	1	\N	\N	1	\N
200	2	173	2	\N	\N	2	\N
2000	23	86	17	\N	\N	17	5
2001	25	91	17	\N	\N	17	5
2002	4	99	17	\N	\N	17	5
2003	17	100	17	\N	\N	17	5
2004	142	106	17	\N	\N	17	5
2005	32	112	17	\N	\N	17	5
2006	13	113	17	\N	\N	17	5
2007	38	116	17	\N	gull sp. - large gulls to far to judge pure or hybrid, or western	17	5
2008	24	174	17	\N	AMRO - none at school, usually 20+, in fact no birds at the school	17	5
2009	29	176	17	\N	\N	17	5
201	691	174	2	\N	\N	2	\N
2010	21	189	17	\N	DEJU - added in Ver2, birds not checked for Oregon vs slate-colored, assumed most were Oregon but they moved too fast	17	5
2011	5	194	17	\N	\N	17	5
2012	3	196	17	\N	\N	17	5
2013	11	199	17	\N	\N	17	5
2014	12	204	17	\N	\N	17	5
2015	14	18	18	\N	\N	17	5
2016	3	20	18	\N	\N	17	5
2017	4	39	18	\N	\N	17	5
2018	2	40	18	\N	\N	17	5
2019	6	41	18	\N	\N	17	5
202	25	175	2	\N	\N	2	\N
2020	1	54	18	\N	\N	17	5
2021	11	59	18	\N	\N	17	5
2022	3	119	18	\N	\N	17	5
2023	20	120	18	\N	\N	17	5
2024	1	126	18	\N	\N	17	5
2025	3	131	18	\N	\N	17	5
2026	1	132	18	\N	\N	17	5
2027	6	134	18	\N	\N	17	5
2028	2	135	18	\N	\N	17	5
2029	20	137	18	\N	\N	17	5
203	1024	176	2	\N	\N	2	\N
2030	1	141	18	\N	\N	17	5
2031	6	149	18	\N	\N	17	5
2032	28	151	18	\N	\N	17	5
2033	6	153	18	\N	\N	17	5
2034	2	154	18	\N	\N	17	5
2035	32	156	18	\N	\N	17	5
2036	29	158	18	\N	\N	17	5
2037	19	160	18	\N	\N	17	5
2038	4	161	18	\N	\N	17	5
2039	2	163	18	\N	\N	17	5
204	1	184	2	\N	\N	2	\N
2040	33	164	18	\N	\N	17	5
2041	6	167	18	\N	\N	17	5
2042	2	67	18	\N	\N	17	5
2043	1	72	18	\N	\N	17	5
2044	2	76	18	\N	\N	17	5
2045	2	86	18	\N	\N	17	5
2046	13	106	18	\N	\N	17	5
2047	6	113	18	\N	\N	17	5
2048	156	170	18	\N	\N	17	5
2049	9	171	18	\N	\N	17	5
205	30	186	2	\N	\N	2	\N
2050	66	174	18	\N	\N	17	5
2051	12	175	18	\N	\N	17	5
2052	49	176	18	\N	\N	17	5
2053	47	186	18	\N	\N	17	5
2054	72	189	18	\N	\N	17	5
2055	12	191	18	\N	\N	17	5
2056	74	194	18	\N	\N	17	5
2057	39	196	18	\N	\N	17	5
2058	7	204	18	\N	\N	17	5
2059	14	206	18	\N	\N	17	5
206	1	188	2	\N	\N	2	\N
2060	29	211	18	\N	\N	17	5
2061	19	6	19	\N	\N	17	6
2062	19	7	19	\N	\N	17	6
2063	61	18	19	\N	\N	17	6
2064	21	20	19	\N	\N	17	6
2065	8	34	19	\N	\N	17	6
2066	12	39	19	\N	\N	17	6
2067	9	41	19	\N	\N	17	6
2068	5	43	19	\N	\N	17	6
2069	4	44	19	\N	\N	17	6
207	564	189	2	\N	\N	2	\N
2070	8	59	19	\N	\N	17	6
2071	54	117	19	\N	\N	17	6
2072	12	118	19	\N	\N	17	6
2073	2	120	19	\N	\N	17	6
2074	1	123	19	\N	\N	17	6
2075	7	131	19	\N	\N	17	6
2076	1	132	19	\N	\N	17	6
2077	1	134	19	\N	\N	17	6
2078	1	135	19	\N	\N	17	6
2079	1	136	19	\N	\N	17	6
208	24	191	2	\N	\N	2	\N
2080	25	137	19	\N	\N	17	6
2081	4	141	19	\N	\N	17	6
2082	1	149	19	\N	\N	17	6
2083	20	151	19	\N	\N	17	6
2084	23	153	19	\N	\N	17	6
2085	6	154	19	\N	\N	17	6
2086	28	156	19	\N	\N	17	6
2087	11	158	19	\N	\N	17	6
2088	1	161	19	\N	\N	17	6
2089	3	163	19	\N	\N	17	6
209	183	194	2	\N	\N	2	\N
2090	28	164	19	\N	\N	17	6
2091	3	167	19	\N	\N	17	6
2092	11	66	19	\N	\N	17	6
2093	1	67	19	\N	\N	17	6
2094	1	75	19	\N	\N	17	6
2095	3	76	19	\N	\N	17	6
2096	1	77	19	\N	\N	17	6
2097	14	86	19	\N	\N	17	6
2098	2	87	19	\N	\N	17	6
2099	8	106	19	\N	\N	17	6
21	24	43	1	\N	\N	1	\N
210	102	196	2	\N	\N	2	\N
2100	13	112	19	\N	\N	17	6
2101	1	113	19	\N	\N	17	6
2102	10	116	19	\N	\N	17	6
2103	1	25	19	\N	\N	17	6
2104	42	170	19	\N	\N	17	6
2105	3	171	19	\N	\N	17	6
2106	106	174	19	\N	\N	17	6
2107	17	175	19	\N	\N	17	6
2108	62	176	19	\N	\N	17	6
2109	9	186	19	\N	\N	17	6
211	84	199	2	\N	\N	2	\N
2110	142	189	19	\N	\N	17	6
2111	8	191	19	\N	\N	17	6
2112	52	194	19	\N	\N	17	6
2113	26	196	19	\N	\N	17	6
2114	12	199	19	\N	\N	17	6
2115	3	204	19	\N	\N	17	6
2116	6	205	19	\N	\N	17	6
2117	32	207	19	\N	\N	17	6
2118	3	211	19	\N	\N	17	6
2119	5	7	20	\N	\N	17	6
212	6	201	2	\N	\N	2	\N
2120	5	15	20	\N	\N	17	6
2121	6	16	20	\N	\N	17	6
2122	1	17	20	\N	\N	17	6
2123	82	18	20	\N	\N	17	6
2124	150	20	20	\N	\N	17	6
2125	2	23	20	\N	\N	17	6
2126	9	24	20	\N	\N	17	6
2127	170	28	20	\N	\N	17	6
2128	5	29	20	\N	\N	17	6
2129	45	30	20	\N	\N	17	6
213	116	204	2	\N	\N	2	\N
2130	55	39	20	\N	\N	17	6
2131	1	40	20	\N	\N	17	6
2132	5	43	20	\N	\N	17	6
2133	6	44	20	\N	\N	17	6
2134	2	47	20	\N	\N	17	6
2135	50	58	20	\N	\N	17	6
2136	7	119	20	\N	\N	17	6
2137	1	132	20	\N	\N	17	6
2138	5	137	20	\N	\N	17	6
2139	1	141	20	\N	\N	17	6
214	47	205	2	\N	\N	2	\N
2140	1	151	20	\N	\N	17	6
2141	76	153	20	\N	\N	17	6
2142	2	154	20	\N	\N	17	6
2143	2	156	20	\N	\N	17	6
2144	10	158	20	\N	\N	17	6
2145	1	161	20	\N	\N	17	6
2146	1	164	20	\N	\N	17	6
2147	2	167	20	\N	\N	17	6
2148	6	66	20	\N	\N	17	6
2149	3	76	20	\N	\N	17	6
215	6	206	2	\N	\N	2	\N
2150	1	79	20	\N	\N	17	6
2151	97	83	20	\N	\N	17	6
2152	4	86	20	\N	\N	17	6
2153	5	112	20	\N	\N	17	6
2154	5	170	20	\N	\N	17	6
2155	5	171	20	\N	\N	17	6
2156	11	174	20	\N	\N	17	6
2157	2	175	20	\N	\N	17	6
2158	9	176	20	\N	\N	17	6
2159	8	186	20	\N	\N	17	6
216	1849	207	2	\N	\N	2	\N
2160	22	189	20	\N	\N	17	6
2161	6	194	20	\N	\N	17	6
2162	7	196	20	\N	\N	17	6
2163	2	199	20	\N	\N	17	6
2164	66	201	20	\N	\N	17	6
2165	1	204	20	\N	\N	17	6
2166	4	205	20	\N	\N	17	6
2167	4	211	20	\N	\N	17	6
2168	1	155	20	\N	\N	17	6
2169	8	118	21	\N	\N	17	6
217	55	208	2	\N	\N	2	\N
2170	8	120	21	\N	\N	17	6
2171	2	135	21	\N	\N	17	6
2172	2	136	21	\N	\N	17	6
2173	4	137	21	\N	\N	17	6
2174	5	141	21	\N	\N	17	6
2175	12	151	21	\N	\N	17	6
2176	5	153	21	\N	\N	17	6
2177	5	156	21	\N	\N	17	6
2178	11	158	21	\N	\N	17	6
2179	1	71	21	\N	\N	17	6
218	\N	209	2	t	\N	2	\N
2180	35	174	21	\N	\N	17	6
2181	2	175	21	\N	\N	17	6
2182	40	176	21	\N	\N	17	6
2183	2	186	21	\N	\N	17	6
2184	12	189	21	\N	\N	17	6
2185	10	194	21	\N	\N	17	6
2186	19	196	21	\N	\N	17	6
2187	4	205	21	\N	\N	17	6
2188	7	211	21	\N	\N	17	6
2189	12	18	22	\N	\N	17	6
219	34	211	2	\N	\N	2	\N
2190	8	20	22	\N	\N	17	6
2191	4	28	22	\N	\N	17	6
2192	4	39	22	\N	\N	17	6
2193	2	43	22	\N	\N	17	6
2194	6	120	22	\N	\N	17	6
2195	3	124	22	\N	\N	17	6
2196	1	126	22	\N	\N	17	6
2197	1	129	22	\N	\N	17	6
2198	8	137	22	\N	\N	17	6
2199	1	144	22	\N	\N	17	6
22	29	44	1	\N	\N	1	\N
220	281	7	3	\N	\N	3	\N
2200	1	148	22	\N	\N	17	6
2201	2	151	22	\N	\N	17	6
2202	194	153	22	\N	\N	17	6
2203	6	154	22	\N	\N	17	6
2204	24	156	22	\N	\N	17	6
2205	8	158	22	\N	\N	17	6
2206	5	161	22	\N	\N	17	6
2207	2	164	22	\N	\N	17	6
2208	1	69	22	\N	\N	17	6
2209	1	72	22	\N	\N	17	6
221	33	15	3	\N	\N	3	\N
2210	6	76	22	\N	\N	17	6
2211	5	79	22	\N	\N	17	6
2212	1	82	22	\N	\N	17	6
2213	12	86	22	\N	\N	17	6
2214	1	95	22	\N	\N	17	6
2215	1	112	22	\N	\N	17	6
2216	15	170	22	\N	\N	17	6
2217	1	171	22	\N	\N	17	6
2218	64	174	22	\N	\N	17	6
2219	27	176	22	\N	\N	17	6
222	8	17	3	\N	\N	3	\N
2220	7	186	22	\N	\N	17	6
2221	125	189	22	\N	\N	17	6
2222	2	190	22	\N	\N	17	6
2223	10	191	22	\N	\N	17	6
2224	15	194	22	\N	\N	17	6
2225	15	196	22	\N	\N	17	6
2226	30	199	22	\N	\N	17	6
2227	4	204	22	\N	\N	17	6
2228	1	205	22	\N	\N	17	6
2229	50	207	22	\N	\N	17	6
223	3219	18	3	\N	\N	3	\N
2230	8	208	22	\N	\N	17	6
2231	14	211	22	\N	\N	17	6
2232	3	131	23	\N	\N	17	3
2233	2	135	23	\N	\N	17	3
2234	1	141	23	\N	\N	17	3
2235	1	151	23	\N	\N	17	3
2236	2	153	23	\N	\N	17	3
2237	2	156	23	\N	\N	17	3
2238	3	158	23	\N	\N	17	3
2239	1	161	23	\N	\N	17	3
224	666	20	3	\N	\N	3	\N
2240	1	73	23	\N	\N	17	3
2241	11	189	23	\N	\N	17	3
2242	2	191	23	\N	\N	17	3
2243	2	196	23	\N	\N	17	3
2244	6	204	23	\N	\N	17	3
2245	7	207	23	\N	\N	17	3
2246	1	208	23	\N	\N	17	3
2247	4	131	24	\N	\N	17	3
2248	1	135	24	\N	\N	17	3
2249	2	137	24	\N	\N	17	3
225	5	23	3	\N	\N	3	\N
2250	1	141	24	\N	\N	17	3
2251	2	151	24	\N	\N	17	3
2252	16	153	24	\N	\N	17	3
2253	3	156	24	\N	\N	17	3
2254	6	158	24	\N	\N	17	3
2255	1	73	24	\N	\N	17	3
2256	1	174	24	\N	\N	17	3
2257	6	176	24	\N	\N	17	3
2258	5	191	24	\N	\N	17	3
2259	3	196	24	\N	\N	17	3
226	42	24	3	\N	\N	3	\N
2260	4	204	24	\N	\N	17	3
2261	10	207	24	\N	\N	17	3
2262	4	208	24	\N	\N	17	3
2263	5	211	24	\N	\N	17	3
2264	3	131	25	\N	\N	17	3
2265	1	151	25	\N	\N	17	3
2266	2	153	25	\N	\N	17	3
2267	1	154	25	\N	\N	17	3
2268	2	156	25	\N	\N	17	3
2269	5	158	25	\N	\N	17	3
227	87	28	3	\N	\N	3	\N
2270	2	161	25	\N	\N	17	3
2271	1	163	25	\N	\N	17	3
2272	1	164	25	\N	\N	17	3
2273	1	167	25	\N	\N	17	3
2274	1	72	25	\N	\N	17	3
2275	1	170	25	\N	\N	17	3
2276	1	174	25	\N	\N	17	3
2277	1	175	25	\N	\N	17	3
2278	1	186	25	\N	\N	17	3
2279	9	189	25	\N	\N	17	3
228	97	29	3	\N	\N	3	\N
2280	1	194	25	\N	\N	17	3
2281	3	196	25	\N	\N	17	3
2282	2	204	25	\N	\N	17	3
2283	3	205	25	\N	\N	17	3
2284	1	207	25	\N	\N	17	3
2285	1	208	25	\N	\N	17	3
2286	19	5	26	\N	\N	17	3
2287	17	7	26	\N	\N	17	3
2288	6	33	26	\N	\N	17	3
2289	7	34	26	\N	\N	17	3
229	8	33	3	\N	\N	3	\N
2290	16	39	26	\N	\N	17	3
2291	22	40	26	\N	\N	17	3
2292	3	44	26	\N	\N	17	3
2293	10	45	26	\N	\N	17	3
2294	2	55	26	\N	\N	17	3
2295	26	59	26	\N	\N	17	3
2296	6	60	26	\N	\N	17	3
2297	4	131	26	\N	\N	17	3
2298	1	132	26	\N	\N	17	3
2299	2	135	26	\N	\N	17	3
23	194	45	1	\N	\N	1	\N
230	438	34	3	\N	\N	3	\N
2300	7	137	26	\N	\N	17	3
2301	1	141	26	\N	\N	17	3
2302	5	151	26	\N	\N	17	3
2303	34	153	26	\N	\N	17	3
2304	6	156	26	\N	\N	17	3
2305	11	158	26	\N	\N	17	3
2306	1	163	26	\N	\N	17	3
2307	4	164	26	\N	\N	17	3
2308	2	167	26	\N	\N	17	3
2309	5	65	26	\N	\N	17	3
231	783	35	3	\N	\N	3	\N
2310	5	66	26	\N	\N	17	3
2311	2	67	26	\N	\N	17	3
2312	1	72	26	\N	\N	17	3
2313	1	76	26	\N	\N	17	3
2314	1	77	26	\N	\N	17	3
2315	2	79	26	\N	\N	17	3
2316	1	99	26	\N	\N	17	3
2317	1	100	26	\N	\N	17	3
2318	7	106	26	\N	\N	17	3
2319	19	112	26	\N	\N	17	3
232	7	36	3	\N	\N	3	\N
2320	1	113	26	\N	\N	17	3
2321	30	170	26	\N	\N	17	3
2322	13	171	26	\N	\N	17	3
2323	100	174	26	\N	\N	17	3
2324	1	175	26	\N	\N	17	3
2325	6	176	26	\N	\N	17	3
2326	11	178	26	\N	\N	17	3
2327	5	186	26	\N	\N	17	3
2328	67	189	26	\N	\N	17	3
2329	14	191	26	\N	\N	17	3
233	76	37	3	\N	\N	3	\N
2330	14	194	26	\N	\N	17	3
2331	7	196	26	\N	\N	17	3
2332	1	205	26	\N	\N	17	3
2333	80	207	26	\N	\N	17	3
2334	30	131	27	\N	\N	17	3
2335	1	6	28	\N	\N	17	3
2336	93	7	28	\N	\N	17	3
2337	18	18	28	\N	\N	17	3
2338	2	20	28	\N	\N	17	3
2339	2	29	28	\N	\N	17	3
234	479	39	3	\N	\N	3	\N
2340	31	34	28	\N	\N	17	3
2341	8	35	28	\N	\N	17	3
2342	11	39	28	\N	\N	17	3
2343	21	40	28	\N	\N	17	3
2344	5	43	28	\N	\N	17	3
2345	1	53	28	\N	\N	17	3
2346	7	59	28	\N	\N	17	3
2347	50	117	28	\N	\N	17	3
2348	2	131	28	\N	\N	17	3
2349	2	132	28	\N	\N	17	3
235	457	40	3	\N	\N	3	\N
2350	1	135	28	\N	\N	17	3
2351	17	137	28	\N	\N	17	3
2352	1	141	28	\N	\N	17	3
2353	1	151	28	\N	\N	17	3
2354	40	153	28	\N	\N	17	3
2355	1	154	28	\N	\N	17	3
2356	8	156	28	\N	\N	17	3
2357	20	158	28	\N	\N	17	3
2358	2	161	28	\N	\N	17	3
2359	2	167	28	\N	\N	17	3
236	102	41	3	\N	\N	3	\N
2360	3	66	28	\N	\N	17	3
2361	2	67	28	\N	\N	17	3
2362	1	72	28	\N	\N	17	3
2363	2	76	28	\N	\N	17	3
2364	1	79	28	\N	\N	17	3
2365	4	86	28	\N	\N	17	3
2366	33	112	28	\N	\N	17	3
2367	1	170	28	\N	\N	17	3
2368	2	171	28	\N	\N	17	3
2369	2	173	28	\N	\N	17	3
237	41	43	3	\N	\N	3	\N
2370	10	174	28	\N	\N	17	3
2371	10	175	28	\N	\N	17	3
2372	54	176	28	\N	\N	17	3
2373	1	181	28	\N	\N	17	3
2374	3	186	28	\N	\N	17	3
2375	1	188	28	\N	\N	17	3
2376	68	189	28	\N	\N	17	3
2377	5	190	28	\N	\N	17	3
2378	3	191	28	\N	\N	17	3
2379	17	194	28	\N	\N	17	3
238	21	44	3	\N	\N	3	\N
2380	11	196	28	\N	\N	17	3
2381	20	204	28	\N	\N	17	3
2382	13	207	28	\N	\N	17	3
2383	6	211	28	\N	\N	17	3
2384	15	7	29	\N	\N	17	3
2385	1	17	29	\N	EUWI - Jeff, Fran & Ann	17	3
2386	295	18	29	\N	\N	17	3
2387	33	20	29	\N	\N	17	3
2388	2	29	29	\N	\N	17	3
2389	3	33	29	\N	\N	17	3
239	199	45	3	\N	\N	3	\N
2390	40	34	29	\N	\N	17	3
2391	3	35	29	\N	\N	17	3
2392	26	39	29	\N	\N	17	3
2393	18	40	29	\N	\N	17	3
2394	6	41	29	\N	\N	17	3
2395	1	43	29	\N	\N	17	3
2396	2	44	29	\N	\N	17	3
2397	27	45	29	\N	\N	17	3
2398	1	54	29	\N	\N	17	3
2399	3	55	29	\N	\N	17	3
24	88	47	1	\N	\N	1	\N
240	6	47	3	\N	\N	3	\N
2400	14	59	29	\N	\N	17	3
2401	7	60	29	\N	\N	17	3
2402	3	61	29	\N	\N	17	3
2403	52	117	29	\N	\N	17	3
2404	3	131	29	\N	\N	17	3
2405	1	132	29	\N	\N	17	3
2406	1	134	29	\N	\N	17	3
2407	3	137	29	\N	\N	17	3
2408	6	151	29	\N	\N	17	3
2409	37	153	29	\N	\N	17	3
241	15	50	3	\N	\N	3	\N
2410	5	154	29	\N	\N	17	3
2411	3	156	29	\N	\N	17	3
2412	6	158	29	\N	\N	17	3
2413	\N	163	29	t	\N	17	3
2414	10	66	29	\N	\N	17	3
2415	2	76	29	\N	\N	17	3
2416	1	82	29	\N	\N	17	3
2417	3	86	29	\N	\N	17	3
2418	1	87	29	\N	\N	17	3
2419	1	88	29	\N	\N	17	3
242	21	51	3	\N	\N	3	\N
2420	1	105	29	\N	\N	17	3
2421	4	106	29	\N	\N	17	3
2422	3	107	29	\N	\N	17	3
2423	8	109	29	\N	\N	17	3
2424	5	112	29	\N	\N	17	3
2425	1	170	29	\N	\N	17	3
2426	1	171	29	\N	\N	17	3
2427	94	174	29	\N	\N	17	3
2428	1	175	29	\N	\N	17	3
2429	4	186	29	\N	\N	17	3
243	58	53	3	\N	\N	3	\N
2430	11	189	29	\N	\N	17	3
2431	7	194	29	\N	\N	17	3
2432	10	196	29	\N	\N	17	3
2433	3	204	29	\N	\N	17	3
2434	55	207	29	\N	\N	17	3
2435	1	208	29	\N	\N	17	3
2436	4	211	29	\N	\N	17	3
2437	50	6	30	\N	\N	17	7
2438	41	7	30	\N	\N	17	7
2439	3	15	30	\N	\N	17	7
244	71	54	3	\N	\N	3	\N
2440	295	18	30	\N	\N	17	7
2441	267	22	30	\N	\N	17	7
2442	2	23	30	\N	\N	17	7
2443	4	24	30	\N	\N	17	7
2444	19	28	30	\N	\N	17	7
2445	10	30	30	\N	\N	17	7
2446	100	31	30	\N	\N	17	7
2447	10	33	30	\N	\N	17	7
2448	220	34	30	\N	\N	17	7
2449	90	39	30	\N	\N	17	7
245	41	55	3	\N	\N	3	\N
2450	57	40	30	\N	\N	17	7
2451	40	41	30	\N	\N	17	7
2452	26	43	30	\N	\N	17	7
2453	2	44	30	\N	\N	17	7
2454	56	45	30	\N	\N	17	7
2455	1	54	30	\N	\N	17	7
2456	1	55	30	\N	\N	17	7
2457	3	58	30	\N	\N	17	7
2458	18	60	30	\N	\N	17	7
2459	1	61	30	\N	\N	17	7
246	12	58	3	\N	\N	3	\N
2460	6	117	30	\N	\N	17	7
2461	10	120	30	\N	\N	17	7
2462	9	131	30	\N	\N	17	7
2463	8	132	30	\N	\N	17	7
2464	2	134	30	\N	\N	17	7
2465	4	135	30	\N	\N	17	7
2466	3	136	30	\N	\N	17	7
2467	31	137	30	\N	\N	17	7
2468	3	141	30	\N	\N	17	7
2469	32	151	30	\N	\N	17	7
247	433	59	3	\N	\N	3	\N
2470	227	153	30	\N	\N	17	7
2471	8	154	30	\N	\N	17	7
2472	61	156	30	\N	\N	17	7
2473	46	158	30	\N	\N	17	7
2474	9	161	30	\N	\N	17	7
2475	4	163	30	\N	\N	17	7
2476	26	164	30	\N	\N	17	7
2477	9	167	30	\N	\N	17	7
2478	5	62	30	\N	\N	17	7
2479	37	66	30	\N	\N	17	7
248	58	60	3	\N	\N	3	\N
2480	6	69	30	\N	\N	17	7
2481	1	73	30	\N	\N	17	7
2482	6	76	30	\N	\N	17	7
2483	5	79	30	\N	\N	17	7
2484	17	86	30	\N	\N	17	7
2485	1	87	30	\N	\N	17	7
2486	1	88	30	\N	\N	17	7
2487	50	92	30	\N	\N	17	7
2488	49	106	30	\N	\N	17	7
2489	68	112	30	\N	\N	17	7
249	3	61	3	\N	\N	3	\N
2490	15	113	30	\N	\N	17	7
2491	72	170	30	\N	\N	17	7
2492	17	171	30	\N	\N	17	7
2493	4	173	30	\N	\N	17	7
2494	204	174	30	\N	\N	17	7
2495	31	175	30	\N	\N	17	7
2496	69	176	30	\N	\N	17	7
2497	35	186	30	\N	\N	17	7
2498	348	189	30	\N	\N	17	7
2499	7	191	30	\N	\N	17	7
25	\N	49	1	t	\N	1	\N
250	4781	62	3	\N	\N	3	\N
2500	80	194	30	\N	\N	17	7
2501	71	196	30	\N	\N	17	7
2502	41	199	30	\N	\N	17	7
2503	5	204	30	\N	\N	17	7
2504	1	205	30	\N	\N	17	7
2505	31	207	30	\N	\N	17	7
2506	4	208	30	\N	\N	17	7
2507	20	211	30	\N	\N	17	7
2508	1	136	31	\N	\N	17	7
2509	1	151	31	\N	\N	17	7
251	1	63	3	\N	\N	3	\N
2510	4	156	31	\N	\N	17	7
2511	5	158	31	\N	\N	17	7
2512	12	160	31	\N	\N	17	7
2513	4	161	31	\N	\N	17	7
2514	1	163	31	\N	\N	17	7
2515	1	171	31	\N	\N	17	7
2516	3	174	31	\N	\N	17	7
2517	4	175	31	\N	\N	17	7
2518	2	186	31	\N	\N	17	7
2519	4	194	31	\N	\N	17	7
252	5	65	3	\N	\N	3	\N
2520	79	7	32	\N	\N	17	4
2521	1	17	32	\N	\N	17	4
2522	535	18	32	\N	\N	17	4
2523	98	20	32	\N	\N	17	4
2524	68	29	32	\N	\N	17	4
2525	442	34	32	\N	\N	17	4
2526	354	35	32	\N	\N	17	4
2527	302	39	32	\N	\N	17	4
2528	232	40	32	\N	\N	17	4
2529	79	41	32	\N	\N	17	4
253	496	66	3	\N	\N	3	\N
2530	7	43	32	\N	\N	17	4
2531	25	44	32	\N	\N	17	4
2532	104	45	32	\N	\N	17	4
2533	47	53	32	\N	\N	17	4
2534	15	54	32	\N	\N	17	4
2535	4	55	32	\N	\N	17	4
2536	177	59	32	\N	\N	17	4
2537	11	60	32	\N	\N	17	4
2538	6	61	32	\N	\N	17	4
2539	3	117	32	\N	\N	17	4
254	3	67	3	\N	\N	3	\N
2540	6	132	32	\N	\N	17	4
2541	61	65	32	\N	BRAC - adjusted up by 15 as per email discussion w/ Ed & Jean	17	4
2542	54	66	32	\N	\N	17	4
2543	8	67	32	\N	\N	17	4
2544	4	76	32	\N	\N	17	4
2545	1	77	32	\N	\N	17	4
2546	19	86	32	\N	\N	17	4
2547	5	99	32	\N	\N	17	4
2548	1	100	32	\N	\N	17	4
2549	50	106	32	\N	\N	17	4
255	2	68	3	\N	\N	3	\N
2550	76	112	32	\N	\N	17	4
2551	1	116	32	\N	\N	17	4
2552	1	20	33	\N	\N	17	1
2553	2	29	33	\N	\N	17	1
2554	2	33	33	\N	\N	17	1
2555	1	34	33	\N	\N	17	1
2556	12	37	33	\N	\N	17	1
2557	5	39	33	\N	\N	17	1
2558	\N	43	33	t	\N	17	1
2559	1	45	33	\N	\N	17	1
256	33	69	3	\N	\N	3	\N
2560	2	59	33	\N	\N	17	1
2561	3	60	33	\N	\N	17	1
2562	\N	119	33	t	\N	17	1
2563	2	131	33	\N	\N	17	1
2564	\N	134	33	t	\N	17	1
2565	1	135	33	\N	\N	17	1
2566	8	137	33	\N	\N	17	1
2567	1	151	33	\N	\N	17	1
2568	\N	152	33	t	\N	17	1
2569	14	153	33	\N	\N	17	1
257	4	72	3	\N	\N	3	\N
2570	30	158	33	\N	\N	17	1
2571	1	161	33	\N	\N	17	1
2572	4	164	33	\N	\N	17	1
2573	1	66	33	\N	\N	17	1
2574	\N	69	33	t	\N	17	1
2575	1	113	33	\N	\N	17	1
2576	3	171	33	\N	\N	17	1
2577	14	174	33	\N	\N	17	1
2578	3	175	33	\N	\N	17	1
2579	100	176	33	\N	\N	17	1
258	6	73	3	\N	\N	3	\N
2580	\N	179	33	t	\N	17	1
2581	1	184	33	\N	\N	17	1
2582	2	186	33	\N	\N	17	1
2583	26	189	33	\N	\N	17	1
2584	8	191	33	\N	\N	17	1
2585	2	194	33	\N	\N	17	1
2586	5	196	33	\N	\N	17	1
2587	6	204	33	\N	\N	17	1
2588	3	207	33	\N	\N	17	1
2589	1	209	33	\N	\N	17	1
259	15	76	3	\N	\N	3	\N
2590	2	211	33	\N	\N	17	1
2591	1	16	34	\N	\N	17	1
2592	1	20	34	\N	\N	17	1
2593	3	34	34	\N	\N	17	1
2594	22	39	34	\N	\N	17	1
2595	6	41	34	\N	\N	17	1
2596	2	43	34	\N	\N	17	1
2597	3	45	34	\N	\N	17	1
2598	1	55	34	\N	\N	17	1
2599	12	59	34	\N	\N	17	1
26	2	50	1	\N	\N	1	\N
260	13	79	3	\N	\N	3	\N
2600	8	60	34	\N	\N	17	1
2601	5	131	34	\N	\N	17	1
2602	1	134	34	\N	\N	17	1
2603	7	137	34	\N	\N	17	1
2604	9	151	34	\N	\N	17	1
2605	25	153	34	\N	\N	17	1
2606	1	154	34	\N	\N	17	1
2607	6	158	34	\N	\N	17	1
2608	6	160	34	\N	\N	17	1
2609	4	161	34	\N	\N	17	1
261	1	82	3	\N	\N	3	\N
2610	4	164	34	\N	\N	17	1
2611	1	66	34	\N	\N	17	1
2612	1	68	34	\N	\N	17	1
2613	5	76	34	\N	\N	17	1
2614	1	86	34	\N	\N	17	1
2615	11	106	34	\N	\N	17	1
2616	13	112	34	\N	\N	17	1
2617	4	116	34	\N	\N	17	1
2618	11	170	34	\N	\N	17	1
2619	3	171	34	\N	\N	17	1
262	401	83	3	\N	\N	3	\N
2620	8	174	34	\N	\N	17	1
2621	4	175	34	\N	\N	17	1
2622	32	189	34	\N	\N	17	1
2623	9	191	34	\N	\N	17	1
2624	7	194	34	\N	\N	17	1
2625	4	196	34	\N	\N	17	1
2626	45	207	34	\N	\N	17	1
2627	2	211	34	\N	\N	17	1
2628	4	131	35	\N	\N	17	1
2629	1	137	36	\N	\N	17	1
263	43	86	3	\N	\N	3	\N
2630	2	151	36	\N	\N	17	1
2631	15	189	36	\N	\N	17	1
2632	3	196	36	\N	\N	17	1
2633	\N	20	37	t	\N	17	1
2634	20	117	37	\N	\N	17	1
2635	\N	119	37	t	\N	17	1
2636	6	131	37	\N	\N	17	1
2637	3	137	37	\N	\N	17	1
2638	3	151	37	\N	\N	17	1
2639	3	153	37	\N	\N	17	1
264	2	87	3	\N	\N	3	\N
2640	2	156	37	\N	\N	17	1
2641	2	158	37	\N	\N	17	1
2642	3	161	37	\N	\N	17	1
2643	\N	73	37	t	\N	17	1
2644	4	174	37	\N	\N	17	1
2645	10	176	37	\N	\N	17	1
2646	4	186	37	\N	\N	17	1
2647	8	189	37	\N	\N	17	1
2648	6	190	37	\N	\N	17	1
2649	5	191	37	\N	\N	17	1
265	2	88	3	\N	\N	3	\N
2650	2	194	37	\N	\N	17	1
2651	4	196	37	\N	\N	17	1
2652	20	199	37	\N	\N	17	1
2653	3	204	37	\N	\N	17	1
2654	10	208	37	\N	\N	17	1
2655	\N	211	37	t	\N	17	1
2656	2	131	38	\N	\N	17	1
2657	1	154	38	\N	\N	17	1
2658	2	156	38	\N	\N	17	1
2659	9	158	38	\N	\N	17	1
266	28	89	3	\N	\N	3	\N
2660	4	161	38	\N	\N	17	1
2661	1	164	38	\N	\N	17	1
2662	3	186	38	\N	\N	17	1
2663	8	189	38	\N	\N	17	1
2664	5	194	38	\N	\N	17	1
2665	6	196	38	\N	\N	17	1
2666	2	205	38	\N	\N	17	1
2667	3	207	38	\N	\N	17	1
2668	44	18	39	\N	\N	17	1
2669	12	20	39	\N	\N	17	1
267	78	91	3	\N	\N	3	\N
2670	28	24	39	\N	\N	17	1
2671	1	132	39	\N	\N	17	1
2672	1	76	39	\N	\N	17	1
2673	3	86	39	\N	\N	17	1
2674	3	131	40	\N	\N	17	1
2675	1	154	40	\N	\N	17	1
2676	1	156	40	\N	\N	17	1
2677	14	158	40	\N	\N	17	1
2678	2	161	40	\N	\N	17	1
2679	2	186	40	\N	\N	17	1
268	15	92	3	\N	\N	3	\N
2680	12	189	40	\N	\N	17	1
2681	8	194	40	\N	\N	17	1
2682	5	196	40	\N	\N	17	1
2683	1	207	40	\N	\N	17	1
2684	1	129	41	\N	\N	17	1
2685	3	131	42	\N	\N	17	1
2686	2	135	42	\N	\N	17	1
2687	2	151	42	\N	\N	17	1
2688	1	153	42	\N	\N	17	1
2689	6	156	42	\N	\N	17	1
269	52	99	3	\N	\N	3	\N
2690	11	158	42	\N	\N	17	1
2691	3	161	42	\N	\N	17	1
2692	1	73	42	\N	\N	17	1
2693	1	174	42	\N	\N	17	1
2694	1	186	42	\N	\N	17	1
2695	14	189	42	\N	\N	17	1
2696	8	191	42	\N	\N	17	1
2697	3	194	42	\N	\N	17	1
2698	7	196	42	\N	\N	17	1
2699	1	204	42	\N	\N	17	1
27	4	51	1	\N	\N	1	\N
270	17	100	3	\N	\N	3	\N
2700	35	207	42	\N	\N	17	1
2701	4	208	42	\N	\N	17	1
2702	1	151	43	\N	\N	17	1
2703	1	156	43	\N	\N	17	1
2704	6	158	43	\N	\N	17	1
2705	1	174	43	\N	\N	17	1
2706	1	175	43	\N	\N	17	1
2707	3	186	43	\N	\N	17	1
2708	9	189	43	\N	\N	17	1
2709	7	191	43	\N	\N	17	1
271	3	101	3	\N	\N	3	\N
2710	3	194	43	\N	\N	17	1
2711	4	196	43	\N	\N	17	1
2712	4	204	43	\N	\N	17	1
2713	4	207	43	\N	\N	17	1
2714	5	131	44	\N	\N	17	1
2715	1	137	44	\N	\N	17	1
2716	2	156	44	\N	\N	17	1
2717	5	158	44	\N	\N	17	1
2718	4	161	44	\N	\N	17	1
2719	1	72	44	\N	\N	17	1
272	6	103	3	\N	\N	3	\N
2720	4	174	44	\N	\N	17	1
2721	2	175	44	\N	\N	17	1
2722	2	186	44	\N	\N	17	1
2723	22	189	44	\N	\N	17	1
2724	1	191	44	\N	\N	17	1
2725	4	194	44	\N	\N	17	1
2726	6	196	44	\N	\N	17	1
2727	3	204	44	\N	\N	17	1
2728	8	18	45	\N	\N	17	1
2729	20	20	45	\N	MALL - 16 from Ed	17	1
273	2	105	3	\N	\N	3	\N
2730	1	22	45	\N	\N	17	1
2731	2	39	45	\N	\N	17	1
2732	4	41	45	\N	\N	17	1
2733	2	45	45	\N	\N	17	1
2734	1	59	45	\N	\N	17	1
2735	7	117	45	\N	\N	17	1
2736	\N	122	45	t	BNOW - count week from Loren @ LS Cedar	17	1
2737	\N	126	45	t	\N	17	1
2738	5	131	45	\N	\N	17	1
2739	2	134	45	\N	\N	17	1
274	224	106	3	\N	\N	3	\N
2740	2	135	45	\N	\N	17	1
2741	4	137	45	\N	\N	17	1
2742	1	141	45	\N	PIWO - Ed	17	1
2743	1	143	45	\N	\N	17	1
2744	4	151	45	\N	\N	17	1
2745	17	153	45	\N	\N	17	1
2746	13	154	45	\N	\N	17	1
2747	20	156	45	\N	\N	17	1
2748	10	158	45	\N	\N	17	1
2749	1	161	45	\N	\N	17	1
275	1	107	3	\N	\N	3	\N
2750	3	163	45	\N	\N	17	1
2751	8	164	45	\N	\N	17	1
2752	2	167	45	\N	\N	17	1
2753	1	66	45	\N	\N	17	1
2754	1	69	45	\N	\N	17	1
2755	1	76	45	\N	\N	17	1
2756	1	79	45	\N	RTHA - Ed	17	1
2757	1	86	45	\N	\N	17	1
2758	\N	95	45	t	\N	17	1
2759	2	113	45	\N	\N	17	1
276	8	109	3	\N	\N	3	\N
2760	1	78	45	\N	RSHA - Ed/Jean	17	1
2761	\N	147	45	t	ATFL - Ezra/Erik Steffens	17	1
2762	\N	200	45	t	WEME - Ezra/Karen Fevold	17	1
2763	17	170	45	\N	\N	17	1
2764	3	171	45	\N	\N	17	1
2765	81	174	45	\N	\N	17	1
2766	13	175	45	\N	VATH - 2 from Ed @ Plum Forest	17	1
2767	10	176	45	\N	\N	17	1
2768	\N	184	45	t	\N	17	1
2769	6	186	45	\N	\N	17	1
277	1	110	3	\N	\N	3	\N
2770	79	189	45	\N	\N	17	1
2771	1	190	45	\N	\N	17	1
2772	10	191	45	\N	\N	17	1
2773	12	194	45	\N	\N	17	1
2774	14	196	45	\N	\N	17	1
2775	14	199	45	\N	\N	17	1
2776	14	204	45	\N	\N	17	1
2777	1	208	45	\N	\N	17	1
2778	8	211	45	\N	\N	17	1
2779	65	7	46	\N	\N	17	1
278	2	111	3	\N	\N	3	\N
2780	181	18	46	\N	\N	17	1
2781	49	20	46	\N	\N	17	1
2782	1	23	46	\N	\N	17	1
2783	8	28	46	\N	\N	17	1
2784	1	29	46	\N	\N	17	1
2785	9	33	46	\N	\N	17	1
2786	29	34	46	\N	\N	17	1
2787	10	35	46	\N	\N	17	1
2788	22	39	46	\N	\N	17	1
2789	30	40	46	\N	\N	17	1
279	564	112	3	\N	\N	3	\N
2790	25	41	46	\N	\N	17	1
2791	4	44	46	\N	\N	17	1
2792	5	45	46	\N	\N	17	1
2793	12	47	46	\N	\N	17	1
2794	7	55	46	\N	\N	17	1
2795	6	58	46	\N	\N	17	1
2796	15	59	46	\N	\N	17	1
2797	11	60	46	\N	\N	17	1
2798	4	117	46	\N	\N	17	1
2799	1	123	46	\N	\N	17	1
28	94	53	1	\N	\N	1	\N
280	26	113	3	\N	\N	3	\N
2800	3	131	46	\N	\N	17	1
2801	1	135	46	\N	\N	17	1
2802	2	136	46	\N	\N	17	1
2803	6	137	46	\N	\N	17	1
2804	2	151	46	\N	\N	17	1
2805	147	153	46	\N	\N	17	1
2806	36	156	46	\N	\N	17	1
2807	7	158	46	\N	\N	17	1
2808	4	160	46	\N	\N	17	1
2809	2	161	46	\N	\N	17	1
281	45	116	3	\N	\N	3	\N
2810	2	163	46	\N	\N	17	1
2811	9	164	46	\N	\N	17	1
2812	8	167	46	\N	\N	17	1
2813	7	66	46	\N	\N	17	1
2814	1	69	46	\N	\N	17	1
2815	2	72	46	\N	\N	17	1
2816	1	73	46	\N	\N	17	1
2817	2	76	46	\N	\N	17	1
2818	2	82	46	\N	\N	17	1
2819	17	83	46	\N	\N	17	1
282	298	117	3	\N	\N	3	\N
2820	1	100	46	\N	\N	17	1
2821	4	107	46	\N	\N	17	1
2822	5	111	46	\N	\N	17	1
2823	3	112	46	\N	\N	17	1
2824	74	113	46	\N	\N	17	1
2825	7	116	46	\N	\N	17	1
2826	11	170	46	\N	\N	17	1
2827	10	171	46	\N	\N	17	1
2828	45	174	46	\N	\N	17	1
2829	4	176	46	\N	\N	17	1
283	15	118	3	\N	\N	3	\N
2830	1	181	46	\N	\N	17	1
2831	1	186	46	\N	\N	17	1
2832	13	189	46	\N	\N	17	1
2833	18	194	46	\N	\N	17	1
2834	6	196	46	\N	\N	17	1
2835	12	199	46	\N	\N	17	1
2836	2	204	46	\N	\N	17	1
2837	19	207	46	\N	\N	17	1
2838	2	208	46	\N	\N	17	1
2839	4	211	46	\N	\N	17	1
284	8	120	3	\N	\N	3	\N
2840	2	126	47	\N	\N	17	1
2841	14	158	47	\N	\N	17	1
2842	6	161	47	\N	\N	17	1
2843	2	175	47	\N	\N	17	1
2844	20	189	47	\N	\N	17	1
2845	2	207	47	\N	\N	17	1
2846	\N	17	48	t	\N	17	1
2847	\N	18	48	t	\N	17	1
2848	4	20	48	\N	\N	17	1
2849	\N	39	48	t	\N	17	1
285	2	124	3	\N	\N	3	\N
2850	\N	51	48	t	\N	17	1
2851	2	118	48	\N	\N	17	1
2852	\N	126	48	t	\N	17	1
2853	2	131	48	\N	\N	17	1
2854	\N	137	48	t	\N	17	1
2855	1	141	48	\N	\N	17	1
2856	2	151	48	\N	\N	17	1
2857	2	153	48	\N	\N	17	1
2858	1	154	48	\N	\N	17	1
2859	4	158	48	\N	\N	17	1
286	\N	126	3	t	\N	3	\N
2860	4	161	48	\N	\N	17	1
2861	1	72	48	\N	\N	17	1
2862	\N	76	48	t	\N	17	1
2863	2	79	48	\N	\N	17	1
2864	2	86	48	\N	\N	17	1
2865	8	174	48	\N	\N	17	1
2866	1	175	48	\N	\N	17	1
2867	1	184	48	\N	\N	17	1
2868	26	189	48	\N	\N	17	1
2869	2	191	48	\N	\N	17	1
287	18	131	3	\N	\N	3	\N
2870	2	196	48	\N	\N	17	1
2871	5	205	48	\N	\N	17	1
2872	\N	206	48	t	\N	17	1
2873	5	207	48	\N	\N	17	1
2874	5	211	48	\N	\N	17	1
2875	6	131	49	\N	ANHU - 2 from Ed	17	1
2876	1	137	49	\N	\N	17	1
2877	4	153	49	\N	\N	17	1
2878	4	156	49	\N	\N	17	1
2879	3	158	49	\N	\N	17	1
288	25	132	3	\N	\N	3	\N
2880	1	167	49	\N	\N	17	1
2881	1	79	49	\N	\N	17	1
2882	3	171	49	\N	\N	17	1
2883	1	174	49	\N	\N	17	1
2884	30	176	49	\N	\N	17	1
2885	2	181	49	\N	\N	17	1
2886	2	186	49	\N	FOSP - 1 from Ed	17	1
2887	42	189	49	\N	DEJU - 12 from Ed	17	1
2888	9	191	49	\N	\N	17	1
2889	1	193	49	\N	\N	17	1
289	3	134	3	\N	\N	3	\N
2890	3	194	49	\N	SOSP - 1 from Ed	17	1
2891	7	196	49	\N	\N	17	1
2892	8	199	49	\N	RWBB - adjusted down from 28 due to count of 20 from Friars feeder	17	1
2893	1	204	49	\N	\N	17	1
2894	2	18	50	\N	\N	17	1
2895	12	20	50	\N	\N	17	1
2896	4	33	50	\N	\N	17	1
2897	6	34	50	\N	\N	17	1
2898	15	39	50	\N	\N	17	1
2899	5	40	50	\N	\N	17	1
29	149	54	1	\N	\N	1	\N
290	15	135	3	\N	\N	3	\N
2900	4	41	50	\N	\N	17	1
2901	5	43	50	\N	\N	17	1
2902	20	44	50	\N	\N	17	1
2903	14	45	50	\N	\N	17	1
2904	1	53	50	\N	\N	17	1
2905	1	55	50	\N	\N	17	1
2906	15	59	50	\N	\N	17	1
2907	5	117	50	\N	\N	17	1
2908	4	137	50	\N	\N	17	1
2909	2	141	50	\N	\N	17	1
291	3	136	3	\N	\N	3	\N
2910	1	143	50	\N	\N	17	1
2911	9	153	50	\N	\N	17	1
2912	6	158	50	\N	\N	17	1
2913	2	164	50	\N	\N	17	1
2914	1	65	50	\N	\N	17	1
2915	13	66	50	\N	\N	17	1
2916	10	67	50	\N	\N	17	1
2917	2	76	50	\N	\N	17	1
2918	3	86	50	\N	\N	17	1
2919	2	87	50	\N	\N	17	1
292	45	139	3	\N	\N	3	\N
2920	1	89	50	\N	\N	17	1
2921	22	106	50	\N	\N	17	1
2922	13	112	50	\N	\N	17	1
2923	7	170	50	\N	\N	17	1
2924	2	173	50	\N	\N	17	1
2925	40	174	50	\N	\N	17	1
2926	3	175	50	\N	\N	17	1
2927	5	176	50	\N	\N	17	1
2928	23	189	50	\N	\N	17	1
2929	1	191	50	\N	\N	17	1
293	16	141	3	\N	\N	3	\N
2930	11	194	50	\N	\N	17	1
2931	3	196	50	\N	\N	17	1
2932	3	131	51	\N	\N	17	2
2933	3	135	51	\N	\N	17	2
2934	1	137	51	\N	\N	17	2
2935	3	141	51	\N	\N	17	2
2936	2	153	51	\N	\N	17	2
2937	2	154	51	\N	\N	17	2
2938	8	156	51	\N	\N	17	2
2939	12	158	51	\N	\N	17	2
294	1	144	3	\N	\N	3	\N
2940	4	161	51	\N	\N	17	2
2941	1	163	51	\N	\N	17	2
2942	3	164	51	\N	\N	17	2
2943	3	167	51	\N	\N	17	2
2944	1	69	51	\N	\N	17	2
2945	1	72	51	\N	\N	17	2
2946	1	171	51	\N	\N	17	2
2947	2	174	51	\N	\N	17	2
2948	1	175	51	\N	\N	17	2
2949	10	189	51	\N	\N	17	2
295	2	149	3	\N	\N	3	\N
2950	1	190	51	\N	\N	17	2
2951	5	194	51	\N	\N	17	2
2952	8	196	51	\N	\N	17	2
2953	3	204	51	\N	\N	17	2
2954	10	207	51	\N	\N	17	2
2955	1	131	52	\N	\N	17	2
2956	1	135	52	\N	\N	17	2
2957	1	137	52	\N	\N	17	2
2958	2	151	52	\N	\N	17	2
2959	1	154	52	\N	\N	17	2
296	180	151	3	\N	\N	3	\N
2960	1	156	52	\N	\N	17	2
2961	2	158	52	\N	\N	17	2
2962	1	79	52	\N	\N	17	2
2963	3	171	52	\N	\N	17	2
2964	4	174	52	\N	\N	17	2
2965	3	186	52	\N	\N	17	2
2966	10	189	52	\N	\N	17	2
2967	1	191	52	\N	\N	17	2
2968	1	194	52	\N	\N	17	2
2969	4	196	52	\N	\N	17	2
297	958	153	3	\N	\N	3	\N
2970	50	7	53	\N	\N	17	2
2971	42	20	53	\N	\N	17	2
2972	2	34	53	\N	\N	17	2
2973	3	39	53	\N	\N	17	2
2974	5	41	53	\N	\N	17	2
2975	8	43	53	\N	\N	17	2
2976	5	44	53	\N	\N	17	2
2977	1	51	53	\N	\N	17	2
2978	6	131	53	\N	\N	17	2
2979	3	132	53	\N	\N	17	2
298	9	154	3	\N	\N	3	\N
2980	2	134	53	\N	\N	17	2
2981	5	135	53	\N	\N	17	2
2982	9	137	53	\N	\N	17	2
2983	4	141	53	\N	\N	17	2
2984	10	151	53	\N	\N	17	2
2985	18	153	53	\N	\N	17	2
2986	5	154	53	\N	\N	17	2
2987	13	156	53	\N	\N	17	2
2988	36	158	53	\N	\N	17	2
2989	\N	160	53	t	\N	17	2
299	193	156	3	\N	\N	3	\N
2990	2	161	53	\N	\N	17	2
2991	\N	163	53	t	\N	17	2
2992	20	164	53	\N	\N	17	2
2993	3	167	53	\N	\N	17	2
2994	1	69	53	\N	\N	17	2
2995	1	72	53	\N	\N	17	2
2996	1	73	53	\N	\N	17	2
2997	3	76	53	\N	\N	17	2
2998	1	77	53	\N	\N	17	2
2999	2	79	53	\N	\N	17	2
3	2	16	1	\N	\N	1	\N
30	33	55	1	\N	\N	1	\N
300	199	158	3	\N	\N	3	\N
3000	1	82	53	\N	\N	17	2
3001	8	86	53	\N	\N	17	2
3002	1	95	53	\N	\N	17	2
3003	52	170	53	\N	GCKI - 4 from Ed	17	2
3004	2	171	53	\N	\N	17	2
3005	66	174	53	\N	\N	17	2
3006	8	175	53	\N	\N	17	2
3007	2	176	53	\N	\N	17	2
3008	3	186	53	\N	\N	17	2
3009	2	188	53	\N	\N	17	2
301	130	160	3	\N	\N	3	\N
3010	69	189	53	\N	\N	17	2
3011	1	190	53	\N	\N	17	2
3012	26	191	53	\N	\N	17	2
3013	22	194	53	\N	\N	17	2
3014	1	195	53	\N	\N	17	2
3015	20	196	53	\N	\N	17	2
3016	25	199	53	\N	\N	17	2
3017	2	204	53	\N	\N	17	2
3018	1	205	53	\N	\N	17	2
3019	\N	206	53	t	\N	17	2
302	67	161	3	\N	\N	3	\N
3020	48	207	53	\N	\N	17	2
3021	2	208	53	\N	\N	17	2
3022	1	135	54	\N	\N	17	2
3023	1	137	54	\N	\N	17	2
3024	1	141	54	\N	\N	17	2
3025	2	151	54	\N	\N	17	2
3026	2	153	54	\N	\N	17	2
3027	4	156	54	\N	\N	17	2
3028	2	158	54	\N	\N	17	2
3029	2	161	54	\N	\N	17	2
303	11	163	3	\N	\N	3	\N
3030	2	167	54	\N	\N	17	2
3031	1	175	54	\N	\N	17	2
3032	3	178	54	\N	\N	17	2
3033	3	189	54	\N	\N	17	2
3034	3	194	54	\N	\N	17	2
3035	5	196	54	\N	\N	17	2
3036	8	207	54	\N	\N	17	2
3037	4	208	54	\N	\N	17	2
3038	2	211	54	\N	\N	17	2
3039	2	131	55	\N	\N	17	2
304	127	165	3	\N	\N	3	\N
3040	7	156	55	\N	\N	17	2
3041	2	161	55	\N	\N	17	2
3042	6	170	55	\N	GCKI - 6 from Ed	17	2
3043	4	175	55	\N	\N	17	2
3044	20	189	55	\N	\N	17	2
3045	2	194	55	\N	\N	17	2
3046	3	196	55	\N	\N	17	2
3047	54	18	56	\N	\N	17	2
3048	16	20	56	\N	\N	17	2
3049	1	34	56	\N	\N	17	2
305	5	166	3	\N	\N	3	\N
3050	19	39	56	\N	\N	17	2
3051	15	40	56	\N	\N	17	2
3052	1	41	56	\N	\N	17	2
3053	5	45	56	\N	\N	17	2
3054	25	59	56	\N	\N	17	2
3055	2	132	56	\N	\N	17	2
3056	30	153	56	\N	\N	17	2
3057	1	154	56	\N	\N	17	2
3058	2	156	56	\N	\N	17	2
3059	1	164	56	\N	\N	17	2
306	58	167	3	\N	\N	3	\N
3060	5	66	56	\N	\N	17	2
3061	1	69	56	\N	\N	17	2
3062	1	76	56	\N	\N	17	2
3063	1	79	56	\N	\N	17	2
3064	10	86	56	\N	\N	17	2
3065	12	106	56	\N	\N	17	2
3066	9	112	56	\N	\N	17	2
3067	18	116	56	\N	\N	17	2
3068	2	170	56	\N	\N	17	2
3069	1	171	56	\N	\N	17	2
307	1	169	3	\N	\N	3	\N
3070	8	174	56	\N	\N	17	2
3071	2	175	56	\N	\N	17	2
3072	20	189	56	\N	\N	17	2
3073	2	194	56	\N	\N	17	2
3074	5	207	56	\N	\N	17	2
3075	11	34	57	\N	\N	17	2
3076	19	39	57	\N	\N	17	2
3077	7	41	57	\N	\N	17	2
3078	6	42	57	\N	\N	17	2
3079	3	44	57	\N	\N	17	2
308	376	170	3	\N	\N	3	\N
3080	23	45	57	\N	\N	17	2
3081	2	59	57	\N	\N	17	2
3082	1	60	57	\N	\N	17	2
3083	3	117	57	\N	\N	17	2
3084	13	131	57	\N	\N	17	2
3085	4	137	57	\N	\N	17	2
3086	13	153	57	\N	\N	17	2
3087	31	158	57	\N	\N	17	2
3088	3	161	57	\N	\N	17	2
3089	8	164	57	\N	\N	17	2
309	97	171	3	\N	\N	3	\N
3090	1	65	57	\N	\N	17	2
3091	17	66	57	\N	\N	17	2
3092	6	67	57	\N	\N	17	2
3093	3	76	57	\N	\N	17	2
3094	4	86	57	\N	\N	17	2
3095	6	112	57	\N	\N	17	2
3096	11	170	57	\N	\N	17	2
3097	7	171	57	\N	\N	17	2
3098	9	174	57	\N	\N	17	2
3099	8	175	57	\N	\N	17	2
31	12	58	1	\N	\N	1	\N
310	1	173	3	\N	\N	3	\N
3100	15	189	57	\N	\N	17	2
3101	9	194	57	\N	\N	17	2
3102	14	196	57	\N	\N	17	2
3103	45	207	57	\N	\N	17	2
3104	3	131	58	\N	\N	17	2
3105	1	137	58	\N	\N	17	2
3106	1	151	58	\N	\N	17	2
3107	3	153	58	\N	\N	17	2
3108	3	156	58	\N	\N	17	2
3109	3	158	58	\N	\N	17	2
311	717	174	3	\N	\N	3	\N
3110	2	161	58	\N	\N	17	2
3111	2	186	58	\N	\N	17	2
3112	4	189	58	\N	\N	17	2
3113	1	191	58	\N	\N	17	2
3114	13	194	58	\N	\N	17	2
3115	2	196	58	\N	\N	17	2
3116	2	199	58	\N	\N	17	2
3117	9	204	58	\N	\N	17	2
3118	11	207	58	\N	\N	17	2
3119	32	18	59	\N	\N	17	2
312	52	175	3	\N	\N	3	\N
3120	4	20	59	\N	\N	17	2
3121	2	34	59	\N	\N	17	2
3122	4	39	59	\N	\N	17	2
3123	2	40	59	\N	\N	17	2
3124	2	41	59	\N	\N	17	2
3125	2	43	59	\N	\N	17	2
3126	4	44	59	\N	\N	17	2
3127	4	45	59	\N	\N	17	2
3128	8	59	59	\N	\N	17	2
3129	7	117	59	\N	\N	17	2
313	1042	176	3	\N	\N	3	\N
3130	6	118	59	\N	\N	17	2
3131	6	131	59	\N	\N	17	2
3132	2	134	59	\N	\N	17	2
3133	10	137	59	\N	\N	17	2
3134	3	143	59	\N	\N	17	2
3135	1	144	59	\N	\N	17	2
3136	2	151	59	\N	\N	17	2
3137	24	153	59	\N	\N	17	2
3138	2	156	59	\N	\N	17	2
3139	8	158	59	\N	\N	17	2
314	2	179	3	\N	\N	3	\N
3140	8	161	59	\N	\N	17	2
3141	1	164	59	\N	\N	17	2
3142	6	66	59	\N	\N	17	2
3143	1	69	59	\N	\N	17	2
3144	\N	71	59	t	\N	17	2
3145	2	76	59	\N	\N	17	2
3146	1	77	59	\N	\N	17	2
3147	2	79	59	\N	\N	17	2
3148	8	86	59	\N	\N	17	2
3149	1	98	59	\N	\N	17	2
315	1	183	3	\N	\N	3	\N
3150	4	112	59	\N	\N	17	2
3151	14	170	59	\N	\N	17	2
3152	2	171	59	\N	\N	17	2
3153	1	173	59	\N	HETH - 1 from Harsi	17	2
3154	18	174	59	\N	\N	17	2
3155	8	175	59	\N	\N	17	2
3156	100	176	59	\N	\N	17	2
3157	20	189	59	\N	\N	17	2
3158	8	191	59	\N	\N	17	2
3159	12	194	59	\N	\N	17	2
316	7	184	3	\N	\N	3	\N
3160	14	196	59	\N	\N	17	2
3161	2	204	59	\N	\N	17	2
3162	4	205	59	\N	\N	17	2
3163	12	207	59	\N	\N	17	2
3164	7	7	60	\N	\N	18	5
3165	3	17	60	\N	EUWI only 1, scoped flock several times – Chazz Hesselein reported 3 EUWI at Yukon Harbor when stopping at the end of the day on his way home	18	5
3166	1944	18	60	\N	AMWI none at Yukon Harbor, BAEA flew over bridge soaring when there, several groups east of Harper boat lauch concentrated in Harper Boat Lauch Bay, counted from images here + 50 more at SE Olympiad Drive Pond	18	5
3167	47	20	60	\N	\N	18	5
3168	2	24	60	\N	\N	18	5
3169	38	29	60	\N	\N	18	5
317	48	186	3	\N	\N	3	\N
3170	6	31	60	\N	\N	18	5
3171	1	33	60	\N	\N	18	5
3172	169	34	60	\N	\N	18	5
3173	1	35	60	\N	\N	18	5
3174	202	39	60	\N	\N	18	5
3175	105	40	60	\N	\N	18	5
3176	1	41	60	\N	\N	18	5
3177	9	43	60	\N	PBGRs at Harper Pier in salt water, ponds frozen, same for HOMEs	18	5
3178	2	44	60	\N	\N	18	5
3179	28	45	60	\N	\N	18	5
318	2	188	3	\N	\N	3	\N
3180	7	53	60	\N	\N	18	5
3181	2	55	60	\N	\N	18	5
3182	2	58	60	\N	PBGRs at Harper Pier in salt water, ponds frozen, same for HOMEs	18	5
3183	43	59	60	\N	\N	18	5
3184	11	60	60	\N	\N	18	5
3185	4	119	60	\N	\N	18	5
3186	1	131	60	\N	\N	18	5
3187	5	132	60	\N	\N	18	5
3188	2	137	60	\N	\N	18	5
3189	47	153	60	\N	\N	18	5
319	798	189	3	\N	\N	3	\N
3190	10	62	60	\N	WEGR 4 S. Colby turnout, 6 off Southworth, plus 1 dead 1/2 eaten	18	5
3191	38	66	60	\N	\N	18	5
3192	5	67	60	\N	\N	18	5
3193	2	69	60	\N	\N	18	5
3194	3	76	60	\N	\N	18	5
3195	1	79	60	\N	\N	18	5
3196	4	86	60	\N	\N	18	5
3197	24	89	60	\N	BLTU on "Mew Gull" dock to east of Curley Creek bridge	18	5
3198	5	100	60	\N	\N	18	5
3199	137	106	60	\N	MEGU ~100 feeding along rip, 1/2 way to Blake	18	5
32	344	59	1	\N	\N	1	\N
320	7	190	3	\N	\N	3	\N
3200	1	109	60	\N	CAGU, HERG, & THGU at Harper Pier to Wonder Bread	18	5
3201	1	110	60	\N	CAGU, HERG, & THGU at Harper Pier to Wonder Bread	18	5
3202	3	111	60	\N	CAGU, HERG, & THGU at Harper Pier to Wonder Bread	18	5
3203	33	112	60	\N	\N	18	5
3204	2	113	60	\N	\N	18	5
3205	67	116	60	\N	large gulls gw or hybrids, at distance	18	5
3206	2	174	60	\N	\N	18	5
3207	1	186	60	\N	\N	18	5
3208	1	189	60	\N	\N	18	5
3209	3	194	60	\N	\N	18	5
321	22	191	3	\N	\N	3	\N
3210	2	211	60	\N	\N	18	5
3211	9	18	61	\N	\N	18	5
3212	11	39	61	\N	\N	18	5
3213	3	41	61	\N	\N	18	5
3214	1	43	61	\N	\N	18	5
3215	1	59	61	\N	\N	18	5
3216	1	118	61	\N	\N	18	5
3217	4	119	61	\N	\N	18	5
3218	2	131	61	\N	\N	18	5
3219	1	132	61	\N	\N	18	5
322	\N	192	3	t	\N	3	\N
3220	1	136	61	\N	\N	18	5
3221	2	137	61	\N	\N	18	5
3222	2	141	61	\N	\N	18	5
3223	1	149	61	\N	\N	18	5
3224	11	151	61	\N	\N	18	5
3225	2	153	61	\N	\N	18	5
3226	3	154	61	\N	\N	18	5
3227	13	156	61	\N	\N	18	5
3228	4	158	61	\N	\N	18	5
3229	6	161	61	\N	\N	18	5
323	298	194	3	\N	\N	3	\N
3230	1	163	61	\N	\N	18	5
3231	9	164	61	\N	\N	18	5
3232	2	76	61	\N	\N	18	5
3233	7	112	61	\N	\N	18	5
3234	46	170	61	\N	\N	18	5
3235	1	171	61	\N	\N	18	5
3236	58	174	61	\N	\N	18	5
3237	20	175	61	\N	\N	18	5
3238	10	176	61	\N	\N	18	5
3239	4	186	61	\N	\N	18	5
324	1	195	3	\N	\N	3	\N
3240	30	189	61	\N	\N	18	5
3241	2	191	61	\N	\N	18	5
3242	7	194	61	\N	\N	18	5
3243	3	196	61	\N	\N	18	5
3244	1	204	61	\N	\N	18	5
3245	1	205	61	\N	\N	18	5
3246	1	206	61	\N	\N	18	5
3247	12	207	61	\N	\N	18	5
3248	3	208	61	\N	\N	18	5
3249	12	211	61	\N	\N	18	5
325	190	196	3	\N	\N	3	\N
3250	37	7	62	\N	\N	18	6
3251	10	15	62	\N	\N	18	6
3252	5	18	62	\N	\N	18	6
3253	20	20	62	\N	\N	18	6
3254	10	28	62	\N	\N	18	6
3255	4	34	62	\N	\N	18	6
3256	26	39	62	\N	\N	18	6
3257	5	40	62	\N	\N	18	6
3258	16	41	62	\N	\N	18	6
3259	11	43	62	\N	\N	18	6
326	104	199	3	\N	\N	3	\N
3260	3	45	62	\N	\N	18	6
3261	19	59	62	\N	\N	18	6
3262	\N	60	62	t	\N	18	6
3263	2	119	62	\N	\N	18	6
3264	3	131	62	\N	\N	18	6
3265	4	132	62	\N	\N	18	6
3266	2	134	62	\N	\N	18	6
3267	2	135	62	\N	\N	18	6
3268	6	137	62	\N	\N	18	6
3269	1	141	62	\N	\N	18	6
327	2	201	3	\N	\N	3	\N
3270	6	149	62	\N	\N	18	6
3271	17	151	62	\N	\N	18	6
3272	46	153	62	\N	\N	18	6
3273	4	154	62	\N	\N	18	6
3274	24	156	62	\N	\N	18	6
3275	15	158	62	\N	\N	18	6
3276	4	161	62	\N	\N	18	6
3277	3	163	62	\N	\N	18	6
3278	6	164	62	\N	\N	18	6
3279	5	167	62	\N	\N	18	6
328	178	204	3	\N	\N	3	\N
3280	11	62	62	\N	\N	18	6
3281	23	66	62	\N	\N	18	6
3282	2	67	62	\N	\N	18	6
3283	2	69	62	\N	\N	18	6
3284	3	76	62	\N	\N	18	6
3285	2	77	62	\N	\N	18	6
3286	4	79	62	\N	\N	18	6
3287	1	86	62	\N	\N	18	6
3288	3	100	62	\N	\N	18	6
3289	1	106	62	\N	\N	18	6
329	16	205	3	\N	\N	3	\N
3290	1	107	62	\N	\N	18	6
3291	7	112	62	\N	\N	18	6
3292	5	113	62	\N	\N	18	6
3293	15	116	62	\N	\N	18	6
3294	17	170	62	\N	\N	18	6
3295	7	171	62	\N	\N	18	6
3296	115	174	62	\N	\N	18	6
3297	3	175	62	\N	\N	18	6
3298	21	176	62	\N	\N	18	6
3299	1	179	62	\N	\N	18	6
33	49	60	1	\N	\N	1	\N
330	21	206	3	\N	\N	3	\N
3300	2	186	62	\N	\N	18	6
3301	122	189	62	\N	\N	18	6
3302	16	191	62	\N	\N	18	6
3303	20	194	62	\N	\N	18	6
3304	23	196	62	\N	\N	18	6
3305	2	204	62	\N	\N	18	6
3306	4	205	62	\N	\N	18	6
3307	50	207	62	\N	\N	18	6
3308	9	7	63	\N	\N	18	6
3309	5	15	63	\N	\N	18	6
331	1196	207	3	\N	\N	3	\N
3310	66	18	63	\N	\N	18	6
3311	142	20	63	\N	\N	18	6
3312	11	24	63	\N	\N	18	6
3313	53	28	63	\N	\N	18	6
3314	2	29	63	\N	\N	18	6
3315	39	30	63	\N	\N	18	6
3316	27	39	63	\N	\N	18	6
3317	13	43	63	\N	\N	18	6
3318	34	47	63	\N	\N	18	6
3319	29	58	63	\N	\N	18	6
332	6	208	3	\N	\N	3	\N
3320	60	153	63	\N	\N	18	6
3321	4	156	63	\N	\N	18	6
3322	1	164	63	\N	\N	18	6
3323	9	66	63	\N	\N	18	6
3324	1	76	63	\N	\N	18	6
3325	1	79	63	\N	\N	18	6
3326	90	83	63	\N	\N	18	6
3327	7	86	63	\N	\N	18	6
3328	2	112	63	\N	\N	18	6
3329	1	171	63	\N	\N	18	6
333	101	211	3	\N	\N	3	\N
3330	50	174	63	\N	\N	18	6
3331	60	176	63	\N	\N	18	6
3332	5	189	63	\N	\N	18	6
3333	3	194	63	\N	\N	18	6
3334	4	196	63	\N	\N	18	6
3335	70	199	63	\N	\N	18	6
3336	30	201	63	\N	\N	18	6
3337	1	21	63	\N	\N	18	6
3338	1	122	64	\N	\N	18	6
3339	\N	124	64	t	\N	18	6
334	\N	5	4	t	\N	4	\N
3340	4	126	64	\N	\N	18	6
3341	1	129	64	\N	\N	18	6
3342	1	86	64	\N	\N	18	6
3343	2	16	65	\N	\N	18	6
3344	10	20	65	\N	\N	18	6
3345	1	135	65	\N	\N	18	6
3346	1	136	65	\N	\N	18	6
3347	5	137	65	\N	\N	18	6
3348	2	141	65	\N	\N	18	6
3349	3	151	65	\N	\N	18	6
335	327	7	4	\N	\N	4	\N
3350	1	154	65	\N	\N	18	6
3351	2	156	65	\N	\N	18	6
3352	3	158	65	\N	\N	18	6
3353	2	161	65	\N	\N	18	6
3354	1	167	65	\N	\N	18	6
3355	1	76	65	\N	\N	18	6
3356	43	25	65	\N	Entered as 45 GADW	18	6
3357	32	174	65	\N	\N	18	6
3358	10	189	65	\N	\N	18	6
3359	4	196	65	\N	\N	18	6
336	19	11	4	\N	\N	4	\N
3360	2	6	66	\N	\N	18	6
3361	20	7	66	\N	\N	18	6
3362	2	16	66	\N	\N	18	6
3363	16	18	66	\N	\N	18	6
3364	21	20	66	\N	\N	18	6
3365	16	23	66	\N	\N	18	6
3366	7	24	66	\N	\N	18	6
3367	1	28	66	\N	\N	18	6
3368	1	39	66	\N	\N	18	6
3369	\N	49	66	t	Found by Chazz Hesselein at Port Orchard Airport/Quarry on 1/5/17	18	6
337	32	15	4	\N	\N	4	\N
3370	1	119	66	\N	\N	18	6
3371	12	120	66	\N	\N	18	6
3372	1	132	66	\N	\N	18	6
3373	2	134	66	\N	\N	18	6
3374	1	135	66	\N	\N	18	6
3375	4	137	66	\N	\N	18	6
3376	6	151	66	\N	\N	18	6
3377	43	153	66	\N	\N	18	6
3378	9	154	66	\N	\N	18	6
3379	36	156	66	\N	\N	18	6
338	1	16	4	\N	\N	4	\N
3380	4	164	66	\N	\N	18	6
3381	1	166	66	\N	\N	18	6
3382	1	167	66	\N	\N	18	6
3383	1	69	66	\N	\N	18	6
3384	4	76	66	\N	\N	18	6
3385	2	79	66	\N	\N	18	6
3386	1	82	66	\N	\N	18	6
3387	15	86	66	\N	\N	18	6
3388	1	95	66	\N	\N	18	6
3389	8	112	66	\N	\N	18	6
339	4	17	4	\N	\N	4	\N
3390	8	170	66	\N	\N	18	6
3391	2	171	66	\N	\N	18	6
3392	30	174	66	\N	\N	18	6
3393	94	176	66	\N	\N	18	6
3394	7	186	66	\N	\N	18	6
3395	45	189	66	\N	\N	18	6
3396	5	190	66	\N	\N	18	6
3397	15	191	66	\N	\N	18	6
3398	12	194	66	\N	\N	18	6
3399	10	196	66	\N	\N	18	6
34	11	61	1	\N	\N	1	\N
340	2963	18	4	\N	\N	4	\N
3400	7	199	66	\N	\N	18	6
3401	8	205	66	\N	\N	18	6
3402	70	207	66	\N	\N	18	6
3403	75	208	66	\N	\N	18	6
3404	5	211	66	\N	\N	18	6
3405	1	159	66	\N	\N	18	6
3406	1	51	67	\N	\N	18	3
3407	3	131	67	\N	\N	18	3
3408	2	135	67	\N	\N	18	3
3409	1	137	67	\N	\N	18	3
341	716	20	4	\N	\N	4	\N
3410	2	156	67	\N	\N	18	3
3411	1	158	67	\N	\N	18	3
3412	1	161	67	\N	\N	18	3
3413	5	189	67	\N	\N	18	3
3414	5	191	67	\N	\N	18	3
3415	1	194	67	\N	\N	18	3
3416	2	196	67	\N	\N	18	3
3417	1	204	67	\N	\N	18	3
3418	3	208	67	\N	\N	18	3
3419	3	131	68	\N	\N	18	3
342	10	22	4	\N	\N	4	\N
3420	1	137	68	\N	\N	18	3
3421	1	151	68	\N	\N	18	3
3422	2	153	68	\N	\N	18	3
3423	3	158	68	\N	\N	18	3
3424	1	161	68	\N	\N	18	3
3425	1	164	68	\N	\N	18	3
3426	1	73	68	\N	\N	18	3
3427	3	170	68	\N	\N	18	3
3428	2	189	68	\N	\N	18	3
3429	2	194	68	\N	\N	18	3
343	2	23	4	\N	\N	4	\N
3430	2	196	68	\N	\N	18	3
3431	1	204	68	\N	\N	18	3
3432	48	7	69	\N	\N	18	3
3433	0	34	69	\N	Reported 14, likely duplication of QH boat team	18	3
3434	0	39	69	\N	Reported 7, likely duplication of QH boat team	18	3
3435	0	41	69	\N	Reported 6, likely duplication of QH boat team	18	3
3436	0	44	69	\N	Reported 20, likely duplication of QH boat team	18	3
3437	\N	51	69	t	\N	18	3
3438	0	59	69	\N	Reported 1, likely duplication of QH boat team	18	3
3439	20	117	69	\N	\N	18	3
344	24	24	4	\N	\N	4	\N
3440	8	131	69	\N	\N	18	3
3441	1	132	69	\N	\N	18	3
3442	2	134	69	\N	\N	18	3
3443	1	135	69	\N	\N	18	3
3444	7	137	69	\N	\N	18	3
3445	4	151	69	\N	\N	18	3
3446	15	153	69	\N	\N	18	3
3447	7	156	69	\N	\N	18	3
3448	3	164	69	\N	\N	18	3
3449	2	76	69	\N	\N	18	3
345	37	28	4	\N	\N	4	\N
3450	2	79	69	\N	\N	18	3
3451	1	106	69	\N	\N	18	3
3452	8	174	69	\N	\N	18	3
3453	4	176	69	\N	\N	18	3
3454	28	189	69	\N	\N	18	3
3455	22	191	69	\N	\N	18	3
3456	1	194	69	\N	\N	18	3
3457	20	196	69	\N	\N	18	3
3458	1	204	69	\N	\N	18	3
3459	3	207	69	\N	\N	18	3
346	337	29	4	\N	\N	4	\N
3460	5	211	69	\N	\N	18	3
3461	1	33	70	\N	\N	18	3
3462	15	34	70	\N	\N	18	3
3463	1	35	70	\N	\N	18	3
3464	28	39	70	\N	\N	18	3
3465	30	40	70	\N	\N	18	3
3466	3	41	70	\N	\N	18	3
3467	20	45	70	\N	\N	18	3
3468	1	55	70	\N	\N	18	3
3469	10	59	70	\N	\N	18	3
347	7	30	4	\N	\N	4	\N
3470	1	60	70	\N	\N	18	3
3471	14	131	70	\N	\N	18	3
3472	1	132	70	\N	\N	18	3
3473	3	135	70	\N	\N	18	3
3474	9	137	70	\N	\N	18	3
3475	1	141	70	\N	\N	18	3
3476	1	145	70	\N	\N	18	3
3477	4	151	70	\N	\N	18	3
3478	46	153	70	\N	\N	18	3
3479	21	156	70	\N	\N	18	3
348	17	33	4	\N	\N	4	\N
3480	24	158	70	\N	\N	18	3
3481	2	163	70	\N	\N	18	3
3482	8	164	70	\N	\N	18	3
3483	3	167	70	\N	\N	18	3
3484	2	65	70	\N	\N	18	3
3485	3	66	70	\N	\N	18	3
3486	1	67	70	\N	\N	18	3
3487	1	68	70	\N	\N	18	3
3488	5	76	70	\N	\N	18	3
3489	4	77	70	\N	\N	18	3
349	1479	34	4	\N	\N	4	\N
3490	2	79	70	\N	\N	18	3
3491	1	100	70	\N	\N	18	3
3492	1	103	70	\N	\N	18	3
3493	2	106	70	\N	\N	18	3
3494	21	112	70	\N	\N	18	3
3495	25	113	70	\N	\N	18	3
3496	1	116	70	\N	\N	18	3
3497	11	170	70	\N	\N	18	3
3498	8	171	70	\N	\N	18	3
3499	3	173	70	\N	\N	18	3
35	2478	62	1	\N	\N	1	\N
350	621	35	4	\N	\N	4	\N
3500	52	174	70	\N	\N	18	3
3501	3	175	70	\N	\N	18	3
3502	12	176	70	\N	\N	18	3
3503	31	178	70	\N	\N	18	3
3504	10	181	70	\N	\N	18	3
3505	1	186	70	\N	\N	18	3
3506	69	189	70	\N	\N	18	3
3507	1	190	70	\N	\N	18	3
3508	14	191	70	\N	\N	18	3
3509	9	194	70	\N	\N	18	3
351	14	36	4	\N	\N	4	\N
3510	12	196	70	\N	\N	18	3
3511	1	204	70	\N	\N	18	3
3512	2	205	70	\N	\N	18	3
3513	30	208	70	\N	\N	18	3
3514	30	131	71	\N	\N	18	3
3515	5	5	72	\N	\N	18	3
3516	6	7	72	\N	\N	18	3
3517	13	18	72	\N	\N	18	3
3518	57	34	72	\N	\N	18	3
3519	2	36	72	\N	\N	18	3
352	715	39	4	\N	\N	4	\N
3520	23	39	72	\N	\N	18	3
3521	14	40	72	\N	\N	18	3
3522	4	41	72	\N	\N	18	3
3523	0	44	72	\N	Reported 70 from Bob's house, likely duplication of QH boat team	18	3
3524	4	45	72	\N	\N	18	3
3525	1	59	72	\N	\N	18	3
3526	1	60	72	\N	\N	18	3
3527	8	131	72	\N	\N	18	3
3528	3	137	72	\N	\N	18	3
3529	\N	148	72	t	\N	18	3
353	381	40	4	\N	\N	4	\N
3530	1	151	72	\N	\N	18	3
3531	7	153	72	\N	\N	18	3
3532	1	154	72	\N	\N	18	3
3533	10	156	72	\N	\N	18	3
3534	10	158	72	\N	\N	18	3
3535	2	161	72	\N	\N	18	3
3536	1	163	72	\N	\N	18	3
3537	1	67	72	\N	\N	18	3
3538	1	69	72	\N	\N	18	3
3539	2	76	72	\N	\N	18	3
354	154	41	4	\N	\N	4	\N
3540	1	77	72	\N	\N	18	3
3541	1	79	72	\N	\N	18	3
3542	13	86	72	\N	\N	18	3
3543	13	112	72	\N	\N	18	3
3544	\N	170	72	t	\N	18	3
3545	5	171	72	\N	\N	18	3
3546	\N	173	72	t	\N	18	3
3547	30	174	72	\N	\N	18	3
3548	10	176	72	\N	\N	18	3
3549	45	178	72	\N	\N	18	3
355	49	42	4	\N	\N	4	\N
3550	1	186	72	\N	\N	18	3
3551	42	189	72	\N	\N	18	3
3552	20	191	72	\N	\N	18	3
3553	3	194	72	\N	\N	18	3
3554	5	196	72	\N	\N	18	3
3555	16	204	72	\N	\N	18	3
3556	24	7	73	\N	\N	18	3
3557	3	17	73	\N	\N	18	3
3558	416	18	73	\N	\N	18	3
3559	9	20	73	\N	\N	18	3
356	99	43	4	\N	\N	4	\N
3560	5	29	73	\N	\N	18	3
3561	6	34	73	\N	\N	18	3
3562	35	35	73	\N	\N	18	3
3563	13	39	73	\N	\N	18	3
3564	13	40	73	\N	\N	18	3
3565	3	41	73	\N	\N	18	3
3566	1	43	73	\N	\N	18	3
3567	3	44	73	\N	\N	18	3
3568	14	45	73	\N	\N	18	3
3569	1	55	73	\N	\N	18	3
357	30	44	4	\N	\N	4	\N
3570	\N	58	73	t	Reported by Ed from 1/4/17	18	3
3571	14	59	73	\N	\N	18	3
3572	1	60	73	\N	\N	18	3
3573	3	117	73	\N	\N	18	3
3574	10	118	73	\N	\N	18	3
3575	1	131	73	\N	\N	18	3
3576	1	135	73	\N	\N	18	3
3577	5	151	73	\N	\N	18	3
3578	17	153	73	\N	\N	18	3
3579	6	156	73	\N	\N	18	3
358	189	45	4	\N	\N	4	\N
3580	3	158	73	\N	\N	18	3
3581	1	161	73	\N	\N	18	3
3582	1	164	73	\N	\N	18	3
3583	8	66	73	\N	\N	18	3
3584	3	76	73	\N	\N	18	3
3585	2	77	73	\N	\N	18	3
3586	2	79	73	\N	\N	18	3
3587	22	106	73	\N	\N	18	3
3588	10	112	73	\N	\N	18	3
3589	3	171	73	\N	\N	18	3
359	114	47	4	\N	\N	4	\N
3590	8	174	73	\N	\N	18	3
3591	1	175	73	\N	\N	18	3
3592	3	176	73	\N	\N	18	3
3593	1	181	73	\N	\N	18	3
3594	1	186	73	\N	\N	18	3
3595	36	189	73	\N	\N	18	3
3596	3	190	73	\N	\N	18	3
3597	7	191	73	\N	\N	18	3
3598	3	194	73	\N	\N	18	3
3599	8	196	73	\N	\N	18	3
36	5	65	1	\N	\N	1	\N
360	2	49	4	\N	\N	4	\N
3600	12	204	73	\N	\N	18	3
3601	4	205	73	\N	\N	18	3
3602	4	208	73	\N	\N	18	3
3603	2	211	73	\N	\N	18	3
3604	122	7	74	\N	\N	18	7
3605	2	15	74	\N	\N	18	7
3606	1	17	74	\N	\N	18	7
3607	203	18	74	\N	\N	18	7
3608	166	20	74	\N	\N	18	7
3609	25	22	74	\N	\N	18	7
361	7	50	4	\N	\N	4	\N
3610	8	23	74	\N	\N	18	7
3611	16	24	74	\N	\N	18	7
3612	29	28	74	\N	\N	18	7
3613	60	29	74	\N	\N	18	7
3614	8	33	74	\N	\N	18	7
3615	148	34	74	\N	\N	18	7
3616	1	37	74	\N	\N	18	7
3617	49	39	74	\N	\N	18	7
3618	33	40	74	\N	\N	18	7
3619	5	41	74	\N	\N	18	7
362	30	51	4	\N	\N	4	\N
3620	5	43	74	\N	\N	18	7
3621	30	45	74	\N	\N	18	7
3622	39	59	74	\N	\N	18	7
3623	2	60	74	\N	\N	18	7
3624	2	61	74	\N	\N	18	7
3625	52	117	74	\N	\N	18	7
3626	5	119	74	\N	\N	18	7
3627	11	120	74	\N	\N	18	7
3628	1	126	74	\N	\N	18	7
3629	19	131	74	\N	\N	18	7
363	16	53	4	\N	\N	4	\N
3630	3	132	74	\N	\N	18	7
3631	1	134	74	\N	\N	18	7
3632	10	135	74	\N	\N	18	7
3633	27	137	74	\N	\N	18	7
3634	1	141	74	\N	\N	18	7
3635	1	149	74	\N	\N	18	7
3636	37	151	74	\N	\N	18	7
3637	2	152	74	\N	\N	18	7
3638	368	153	74	\N	\N	18	7
3639	3	154	74	\N	\N	18	7
364	117	54	4	\N	\N	4	\N
3640	94	156	74	\N	\N	18	7
3641	28	158	74	\N	\N	18	7
3642	23	160	74	\N	\N	18	7
3643	15	161	74	\N	\N	18	7
3644	3	163	74	\N	\N	18	7
3645	15	164	74	\N	\N	18	7
3646	7	167	74	\N	\N	18	7
3647	1	62	74	\N	\N	18	7
3648	106	66	74	\N	\N	18	7
3649	5	67	74	\N	\N	18	7
365	53	55	4	\N	\N	4	\N
3650	3	69	74	\N	\N	18	7
3651	1	73	74	\N	\N	18	7
3652	11	76	74	\N	\N	18	7
3653	4	77	74	\N	\N	18	7
3654	5	79	74	\N	\N	18	7
3655	2	86	74	\N	\N	18	7
3656	3	92	74	\N	\N	18	7
3657	26	106	74	\N	\N	18	7
3658	118	112	74	\N	\N	18	7
3659	5	113	74	\N	\N	18	7
366	2	57	4	\N	\N	4	\N
3660	14	116	74	\N	\N	18	7
3661	\N	32	74	t	Found by Ken Brown at Purdy Spit on 1/5/17	18	7
3662	1	85	74	\N	\N	18	7
3663	94	170	74	\N	\N	18	7
3664	25	171	74	\N	\N	18	7
3665	226	174	74	\N	\N	18	7
3666	54	175	74	\N	\N	18	7
3667	93	176	74	\N	\N	18	7
3668	1	181	74	\N	\N	18	7
3669	4	184	74	\N	\N	18	7
367	20	58	4	\N	\N	4	\N
3670	17	186	74	\N	\N	18	7
3671	257	189	74	\N	\N	18	7
3672	1	190	74	\N	\N	18	7
3673	7	191	74	\N	\N	18	7
3674	35	194	74	\N	\N	18	7
3675	69	196	74	\N	\N	18	7
3676	64	199	74	\N	\N	18	7
3677	29	204	74	\N	\N	18	7
3678	4	205	74	\N	\N	18	7
3679	40	207	74	\N	\N	18	7
368	582	59	4	\N	\N	4	\N
3680	7	208	74	\N	\N	18	7
3681	10	210	74	\N	\N	18	7
3682	29	211	74	\N	\N	18	7
3683	1	135	75	\N	\N	18	7
3684	1	137	75	\N	\N	18	7
3685	1	156	75	\N	\N	18	7
3686	3	158	75	\N	\N	18	7
3687	\N	160	75	t	\N	18	7
3688	2	161	75	\N	\N	18	7
3689	1	167	75	\N	\N	18	7
369	127	60	4	\N	\N	4	\N
3690	1	171	75	\N	\N	18	7
3691	2	175	75	\N	\N	18	7
3692	4	189	75	\N	\N	18	7
3693	3	196	75	\N	\N	18	7
3694	11	7	76	\N	\N	18	4
3695	3	17	76	\N	\N	18	4
3696	487	18	76	\N	\N	18	4
3697	2	20	76	\N	\N	18	4
3698	36	29	76	\N	\N	18	4
3699	324	34	76	\N	\N	18	4
37	435	66	1	\N	\N	1	\N
370	6	61	4	\N	\N	4	\N
3700	183	35	76	\N	\N	18	4
3701	12	36	76	\N	\N	18	4
3702	226	39	76	\N	\N	18	4
3703	294	40	76	\N	\N	18	4
3704	79	41	76	\N	\N	18	4
3705	146	44	76	\N	\N	18	4
3706	120	45	76	\N	\N	18	4
3707	7	53	76	\N	\N	18	4
3708	3	54	76	\N	\N	18	4
3709	1	55	76	\N	\N	18	4
371	3347	62	4	\N	\N	4	\N
3710	1	57	76	\N	\N	18	4
3711	1	58	76	\N	\N	18	4
3712	90	59	76	\N	\N	18	4
3713	1	61	76	\N	\N	18	4
3714	15	117	76	\N	\N	18	4
3715	2	132	76	\N	\N	18	4
3716	1	144	76	\N	\N	18	4
3717	1	145	76	\N	Peregrine came from direction of Pt. Robinson, crossing Qharbor just even with Raab's Lagoon and headed toward Burton 	18	4
3718	6	153	76	\N	Passerines seen on walk up from dock to Vashon Hwy	18	4
3719	3	156	76	\N	Passerines seen on walk up from dock to Vashon Hwy	18	4
372	12	65	4	\N	\N	4	\N
3720	1	62	76	\N	\N	18	4
3721	33	65	76	\N	\N	18	4
3722	62	66	76	\N	\N	18	4
3723	1	67	76	\N	\N	18	4
3724	1	68	76	\N	\N	18	4
3725	3	69	76	\N	\N	18	4
3726	4	76	76	\N	\N	18	4
3727	1	79	76	\N	\N	18	4
3728	5	86	76	\N	\N	18	4
3729	1	88	76	\N	\N	18	4
373	667	66	4	\N	\N	4	\N
3730	1	100	76	\N	\N	18	4
3731	1	103	76	\N	Only seen by Cheryl	18	4
3732	76	106	76	\N	\N	18	4
3733	127	112	76	\N	\N	18	4
3734	1	113	76	\N	\N	18	4
3735	4	116	76	\N	\N	18	4
3736	1	170	76	\N	Passerines seen on walk up from dock to Vashon Hwy	18	4
3737	3	174	76	\N	Passerines seen on walk up from dock to Vashon Hwy	18	4
3738	3	189	76	\N	Passerines seen on walk up from dock to Vashon Hwy	18	4
3739	1	141	77	\N	\N	18	1
374	46	67	4	\N	\N	4	\N
3740	1	153	77	\N	\N	18	1
3741	1	174	77	\N	\N	18	1
3742	6	28	78	\N	\N	18	1
3743	29	34	78	\N	\N	18	1
3744	23	39	78	\N	\N	18	1
3745	7	40	78	\N	\N	18	1
3746	1	41	78	\N	\N	18	1
3747	3	43	78	\N	\N	18	1
3748	7	45	78	\N	\N	18	1
3749	1	53	78	\N	\N	18	1
375	42	68	4	\N	\N	4	\N
3750	1	55	78	\N	\N	18	1
3751	12	59	78	\N	\N	18	1
3752	3	60	78	\N	\N	18	1
3753	1	117	78	\N	\N	18	1
3754	3	131	78	\N	\N	18	1
3755	1	134	78	\N	\N	18	1
3756	3	137	78	\N	\N	18	1
3757	8	153	78	\N	\N	18	1
3758	1	154	78	\N	\N	18	1
3759	6	156	78	\N	\N	18	1
376	46	69	4	\N	\N	4	\N
3760	7	158	78	\N	\N	18	1
3761	2	160	78	\N	\N	18	1
3762	1	164	78	\N	\N	18	1
3763	11	65	78	\N	\N	18	1
3764	2	66	78	\N	\N	18	1
3765	2	67	78	\N	\N	18	1
3766	2	76	78	\N	\N	18	1
3767	1	77	78	\N	\N	18	1
3768	2	79	78	\N	\N	18	1
3769	4	100	78	\N	From Gary Shugart: 4 out of my area north of North End dock	18	1
377	10	72	4	\N	\N	4	\N
3770	10	112	78	\N	\N	18	1
3771	4	116	78	\N	\N	18	1
3772	2	170	78	\N	\N	18	1
3773	13	174	78	\N	\N	18	1
3774	6	175	78	\N	\N	18	1
3775	2	176	78	\N	\N	18	1
3776	1	186	78	\N	\N	18	1
3777	11	189	78	\N	\N	18	1
3778	4	191	78	\N	\N	18	1
3779	3	194	78	\N	\N	18	1
378	6	73	4	\N	\N	4	\N
3780	7	196	78	\N	\N	18	1
3781	5	204	78	\N	\N	18	1
3782	1	211	78	\N	\N	18	1
3783	38	18	79	\N	\N	18	1
3784	1	33	79	\N	\N	18	1
3785	16	34	79	\N	\N	18	1
3786	11	39	79	\N	\N	18	1
3787	23	40	79	\N	\N	18	1
3788	4	45	79	\N	\N	18	1
3789	3	53	79	\N	\N	18	1
379	2	75	4	\N	\N	4	\N
3790	3	55	79	\N	\N	18	1
3791	18	59	79	\N	\N	18	1
3792	6	60	79	\N	\N	18	1
3793	1	61	79	\N	\N	18	1
3794	15	117	79	\N	7 from Ed in town	18	1
3795	4	119	79	\N	4 from Ed in town	18	1
3796	1	126	79	\N	\N	18	1
3797	10	131	79	\N	\N	18	1
3798	1	132	79	\N	\N	18	1
3799	1	134	79	\N	\N	18	1
38	18	67	1	\N	\N	1	\N
380	21	76	4	\N	\N	4	\N
3800	1	135	79	\N	1 from Karen Ripley's feeder count	18	1
3801	2	137	79	\N	1 from Karen Ripley's feeder count, 1 from Ed in town	18	1
3802	1	141	79	\N	\N	18	1
3803	1	145	79	\N	\N	18	1
3804	13	151	79	\N	\N	18	1
3805	31	153	79	\N	6 from Ed in town	18	1
3806	7	154	79	\N	\N	18	1
3807	9	156	79	\N	\N	18	1
3808	21	158	79	\N	3 from Ed in town	18	1
3809	8	161	79	\N	\N	18	1
381	16	79	4	\N	\N	4	\N
3810	9	164	79	\N	\N	18	1
3811	2	167	79	\N	\N	18	1
3812	1	66	79	\N	\N	18	1
3813	7	76	79	\N	\N	18	1
3814	3	77	79	\N	\N	18	1
3815	2	79	79	\N	1 from Ed in town	18	1
3816	1	100	79	\N	\N	18	1
3817	11	106	79	\N	\N	18	1
3818	10	112	79	\N	\N	18	1
3819	1	113	79	\N	\N	18	1
382	3	82	4	\N	\N	4	\N
3820	20	116	79	\N	\N	18	1
3821	21	170	79	\N	1 from Ed in town	18	1
3822	6	171	79	\N	\N	18	1
3823	1	173	79	\N	1 from Karen Ripley's feeder count	18	1
3824	33	174	79	\N	1 from Ed in town	18	1
3825	13	175	79	\N	\N	18	1
3826	36	176	79	\N	16 from Ed in town	18	1
3827	8	186	79	\N	1 from Ed in town	18	1
3828	1	188	79	\N	\N	18	1
3829	124	189	79	\N	10 from Ed in town	18	1
383	269	83	4	\N	\N	4	\N
3830	54	191	79	\N	14 from Ed in town	18	1
3831	27	194	79	\N	4 from Ed in town	18	1
3832	18	196	79	\N	\N	18	1
3833	4	204	79	\N	\N	18	1
3834	1	205	79	\N	\N	18	1
3835	1	207	79	\N	1 from Karen Ripley's feeder count	18	1
3836	11	208	79	\N	\N	18	1
3837	14	211	79	\N	14 from Ed in town	18	1
3838	3	131	80	\N	\N	18	1
3839	1	40	81	\N	\N	18	1
384	49	86	4	\N	\N	4	\N
3840	1	53	81	\N	\N	18	1
3841	2	59	81	\N	\N	18	1
3842	3	131	81	\N	\N	18	1
3843	1	134	81	\N	\N	18	1
3844	6	153	81	\N	\N	18	1
3845	1	154	81	\N	\N	18	1
3846	1	156	81	\N	\N	18	1
3847	2	158	81	\N	\N	18	1
3848	1	161	81	\N	\N	18	1
3849	1	167	81	\N	\N	18	1
385	5	87	4	\N	\N	4	\N
3850	2	76	81	\N	\N	18	1
3851	12	112	81	\N	\N	18	1
3852	2	170	81	\N	\N	18	1
3853	8	189	81	\N	\N	18	1
3854	2	194	81	\N	\N	18	1
3855	1	196	81	\N	\N	18	1
3856	1	207	81	\N	\N	18	1
3857	1	208	81	\N	\N	18	1
3858	3	126	82	\N	\N	18	1
3859	2	131	82	\N	\N	18	1
386	6	88	4	\N	\N	4	\N
3860	3	156	82	\N	\N	18	1
3861	2	158	82	\N	\N	18	1
3862	3	161	82	\N	\N	18	1
3863	10	189	82	\N	\N	18	1
3864	1	194	82	\N	\N	18	1
3865	4	196	82	\N	\N	18	1
3866	4	205	82	\N	\N	18	1
3867	3	16	83	\N	\N	18	1
3868	31	20	83	\N	\N	18	1
3869	17	24	83	\N	\N	18	1
387	37	89	4	\N	\N	4	\N
3870	3	30	83	\N	\N	18	1
3871	10	39	83	\N	\N	18	1
3872	1	40	83	\N	\N	18	1
3873	25	117	83	\N	\N	18	1
3874	1	132	83	\N	\N	18	1
3875	6	153	83	\N	\N	18	1
3876	1	66	83	\N	\N	18	1
3877	1	76	83	\N	\N	18	1
3878	2	86	83	\N	\N	18	1
3879	10	106	83	\N	\N	18	1
388	45	91	4	\N	\N	4	\N
3880	1	112	83	\N	\N	18	1
3881	8	176	83	\N	\N	18	1
3882	1	196	83	\N	\N	18	1
3883	3	131	84	\N	\N	18	1
3884	2	151	84	\N	\N	18	1
3885	4	156	84	\N	\N	18	1
3886	3	158	84	\N	\N	18	1
3887	2	161	84	\N	\N	18	1
3888	1	164	84	\N	\N	18	1
3889	5	189	84	\N	\N	18	1
389	125	92	4	\N	\N	4	\N
3890	3	196	84	\N	\N	18	1
3891	6	204	84	\N	\N	18	1
3892	1	211	84	\N	\N	18	1
3893	1	126	85	\N	\N	18	1
3894	2	131	86	\N	\N	18	1
3895	1	137	86	\N	\N	18	1
3896	2	151	86	\N	\N	18	1
3897	5	158	86	\N	\N	18	1
3898	2	161	86	\N	\N	18	1
3899	1	171	86	\N	\N	18	1
39	5	68	1	\N	\N	1	\N
390	2	95	4	\N	\N	4	\N
3900	1	186	86	\N	\N	18	1
3901	10	189	86	\N	\N	18	1
3902	4	191	86	\N	\N	18	1
3903	3	194	86	\N	\N	18	1
3904	3	196	86	\N	\N	18	1
3905	3	204	86	\N	\N	18	1
3906	4	131	87	\N	\N	18	1
3907	3	156	87	\N	\N	18	1
3908	4	158	87	\N	\N	18	1
3909	2	161	87	\N	\N	18	1
391	15	98	4	\N	\N	4	\N
3910	1	164	87	\N	\N	18	1
3911	1	72	87	\N	\N	18	1
3912	2	76	87	\N	\N	18	1
3913	2	186	87	\N	\N	18	1
3914	24	189	87	\N	\N	18	1
3915	1	194	87	\N	\N	18	1
3916	6	196	87	\N	\N	18	1
3917	1	204	87	\N	\N	18	1
3918	5	7	88	\N	\N	18	1
3919	4	18	88	\N	\N	18	1
392	109	99	4	\N	\N	4	\N
3920	7	20	88	\N	\N	18	1
3921	2	28	88	\N	\N	18	1
3922	9	39	88	\N	\N	18	1
3923	1	59	88	\N	\N	18	1
3924	1	126	88	\N	\N	18	1
3925	4	131	88	\N	\N	18	1
3926	1	134	88	\N	\N	18	1
3927	3	137	88	\N	\N	18	1
3928	4	151	88	\N	\N	18	1
3929	13	153	88	\N	\N	18	1
393	30	100	4	\N	\N	4	\N
3930	8	154	88	\N	\N	18	1
3931	19	156	88	\N	\N	18	1
3932	12	158	88	\N	\N	18	1
3933	6	161	88	\N	\N	18	1
3934	3	163	88	\N	\N	18	1
3935	8	164	88	\N	\N	18	1
3936	1	167	88	\N	\N	18	1
3937	1	66	88	\N	\N	18	1
3938	1	72	88	\N	\N	18	1
3939	1	76	88	\N	\N	18	1
394	4	101	4	\N	\N	4	\N
3940	1	79	88	\N	1 from Ed, N of 204th St.	18	1
3941	\N	95	88	t	\N	18	1
3942	1	112	88	\N	\N	18	1
3943	2	116	88	\N	\N	18	1
3944	10	170	88	\N	\N	18	1
3945	2	171	88	\N	\N	18	1
3946	17	174	88	\N	\N	18	1
3947	2	175	88	\N	\N	18	1
3948	20	176	88	\N	\N	18	1
3949	2	186	88	\N	\N	18	1
395	104	103	4	\N	\N	4	\N
3950	33	189	88	\N	\N	18	1
3951	1	190	88	\N	\N	18	1
3952	24	191	88	\N	\N	18	1
3953	8	194	88	\N	\N	18	1
3954	15	196	88	\N	\N	18	1
3955	1	199	88	\N	\N	18	1
3956	1	204	88	\N	\N	18	1
3957	6	206	88	\N	\N	18	1
3958	20	207	88	\N	\N	18	1
3959	4	211	88	\N	\N	18	1
396	2	104	4	\N	\N	4	\N
3960	2	5	89	\N	\N	18	1
3961	1	17	89	\N	\N	18	1
3962	164	18	89	\N	\N	18	1
3963	52	20	89	\N	\N	18	1
3964	2	23	89	\N	\N	18	1
3965	14	28	89	\N	\N	18	1
3966	8	33	89	\N	\N	18	1
3967	3	34	89	\N	\N	18	1
3968	6	35	89	\N	\N	18	1
3969	23	39	89	\N	\N	18	1
397	267	105	4	\N	\N	4	\N
3970	41	40	89	\N	\N	18	1
3971	2	41	89	\N	\N	18	1
3972	3	44	89	\N	\N	18	1
3973	3	45	89	\N	\N	18	1
3974	19	47	89	\N	\N	18	1
3975	2	53	89	\N	\N	18	1
3976	3	55	89	\N	\N	18	1
3977	6	58	89	\N	\N	18	1
3978	28	59	89	\N	\N	18	1
3979	5	60	89	\N	\N	18	1
398	316	106	4	\N	\N	4	\N
3980	8	117	89	\N	\N	18	1
3981	2	131	89	\N	\N	18	1
3982	1	132	89	\N	\N	18	1
3983	2	134	89	\N	\N	18	1
3984	2	135	89	\N	\N	18	1
3985	6	137	89	\N	\N	18	1
3986	4	151	89	\N	\N	18	1
3987	35	153	89	\N	\N	18	1
3988	19	156	89	\N	\N	18	1
3989	1	158	89	\N	\N	18	1
399	5	107	4	\N	\N	4	\N
3990	24	160	89	\N	\N	18	1
3991	3	161	89	\N	\N	18	1
3992	8	164	89	\N	\N	18	1
3993	2	167	89	\N	\N	18	1
3994	2	62	89	\N	\N	18	1
3995	3	66	89	\N	\N	18	1
3996	1	69	89	\N	\N	18	1
3997	2	76	89	\N	\N	18	1
3998	1	77	89	\N	\N	18	1
3999	1	82	89	\N	\N	18	1
4	8	17	1	\N	\N	1	\N
40	28	69	1	\N	\N	1	\N
400	2	108	4	\N	\N	4	\N
4000	41	83	89	\N	\N	18	1
4001	1	99	89	\N	\N	18	1
4002	1	100	89	\N	\N	18	1
4003	8	111	89	\N	\N	18	1
4004	27	112	89	\N	\N	18	1
4005	29	113	89	\N	\N	18	1
4006	25	170	89	\N	\N	18	1
4007	8	171	89	\N	\N	18	1
4008	23	174	89	\N	\N	18	1
4009	3	176	89	\N	\N	18	1
401	\N	109	4	t	\N	4	\N
4010	2	181	89	\N	\N	18	1
4011	9	189	89	\N	\N	18	1
4012	10	194	89	\N	\N	18	1
4013	4	196	89	\N	\N	18	1
4014	2	199	89	\N	\N	18	1
4015	12	204	89	\N	\N	18	1
4016	6	211	89	\N	\N	18	1
4017	\N	17	90	t	\N	18	1
4018	\N	18	90	t	\N	18	1
4019	4	20	90	\N	\N	18	1
402	1	110	4	\N	\N	4	\N
4020	\N	39	90	t	\N	18	1
4021	\N	51	90	t	\N	18	1
4022	2	118	90	\N	\N	18	1
4023	\N	126	90	t	\N	18	1
4024	2	131	90	\N	\N	18	1
4025	\N	137	90	t	\N	18	1
4026	1	141	90	\N	\N	18	1
4027	\N	151	90	t	\N	18	1
4028	2	153	90	\N	\N	18	1
4029	1	154	90	\N	\N	18	1
403	839	112	4	\N	\N	4	\N
4030	4	158	90	\N	\N	18	1
4031	4	161	90	\N	\N	18	1
4032	1	72	90	\N	\N	18	1
4033	\N	76	90	t	\N	18	1
4034	2	79	90	\N	\N	18	1
4035	2	86	90	\N	\N	18	1
4036	8	174	90	\N	\N	18	1
4037	1	175	90	\N	\N	18	1
4038	1	184	90	\N	\N	18	1
4039	26	189	90	\N	\N	18	1
404	2	113	4	\N	\N	4	\N
4040	2	191	90	\N	\N	18	1
4041	2	196	90	\N	\N	18	1
4042	5	205	90	\N	\N	18	1
4043	5	207	90	\N	\N	18	1
4044	5	211	90	\N	\N	18	1
4045	8	117	91	\N	8 from Ed at Friars feeder	18	1
4046	8	131	91	\N	3 from Ed at Friars feeder	18	1
4047	4	137	91	\N	\N	18	1
4048	1	144	91	\N	\N	18	1
4049	6	153	91	\N	2 from team, 6 from Ed at Friars feeder	18	1
405	291	116	4	\N	\N	4	\N
4050	13	156	91	\N	\N	18	1
4051	5	158	91	\N	\N	18	1
4052	14	160	91	\N	\N	18	1
4053	1	167	91	\N	\N	18	1
4054	1	73	91	\N	\N	18	1
4055	1	171	91	\N	\N	18	1
4056	370	174	91	\N	\N	18	1
4057	41	176	91	\N	\N	18	1
4058	3	181	91	\N	\N	18	1
4059	18	189	91	\N	8 from Ed at Friars feeder	18	1
406	248	117	4	\N	\N	4	\N
4060	9	191	91	\N	2 from Ed at Friars feeder	18	1
4061	3	194	91	\N	1 from Ed at Friars feeder	18	1
4062	6	196	91	\N	1 from team, 2 from Ed at Friars feeder	18	1
4063	26	199	91	\N	\N	18	1
4064	4	204	91	\N	4 from Ed at Friars feeder	18	1
4065	4	208	91	\N	\N	18	1
4066	30	18	92	\N	\N	18	1
4067	8	20	92	\N	\N	18	1
4068	9	34	92	\N	\N	18	1
4069	7	39	92	\N	\N	18	1
407	9	118	4	\N	\N	4	\N
4070	3	40	92	\N	\N	18	1
4071	3	41	92	\N	\N	18	1
4072	1	45	92	\N	\N	18	1
4073	4	53	92	\N	\N	18	1
4074	16	59	92	\N	\N	18	1
4075	2	60	92	\N	\N	18	1
4076	2	61	92	\N	\N	18	1
4077	1	131	92	\N	\N	18	1
4078	1	132	92	\N	\N	18	1
4079	1	134	92	\N	\N	18	1
408	20	120	4	\N	\N	4	\N
4080	8	137	92	\N	\N	18	1
4081	3	151	92	\N	\N	18	1
4082	13	153	92	\N	\N	18	1
4083	1	154	92	\N	\N	18	1
4084	6	156	92	\N	\N	18	1
4085	1	158	92	\N	\N	18	1
4086	4	161	92	\N	\N	18	1
4087	1	163	92	\N	\N	18	1
4088	7	164	92	\N	\N	18	1
4089	11	66	92	\N	\N	18	1
409	1	122	4	\N	\N	4	\N
4090	7	67	92	\N	\N	18	1
4091	1	69	92	\N	\N	18	1
4092	1	73	92	\N	\N	18	1
4093	1	76	92	\N	\N	18	1
4094	4	86	92	\N	\N	18	1
4095	2	87	92	\N	\N	18	1
4096	48	106	92	\N	\N	18	1
4097	15	112	92	\N	\N	18	1
4098	2	170	92	\N	\N	18	1
4099	59	174	92	\N	\N	18	1
41	4	72	1	\N	\N	1	\N
410	8	124	4	\N	\N	4	\N
4100	3	175	92	\N	\N	18	1
4101	33	176	92	\N	\N	18	1
4102	7	189	92	\N	\N	18	1
4103	5	194	92	\N	\N	18	1
4104	5	196	92	\N	\N	18	1
4105	7	208	92	\N	\N	18	1
4106	2	20	93	\N	\N	18	2
4107	1	40	93	\N	\N	18	2
4108	1	126	93	\N	\N	18	2
4109	\N	129	93	t	\N	18	2
411	1	126	4	\N	\N	4	\N
4110	2	131	93	\N	\N	18	2
4111	1	135	93	\N	\N	18	2
4112	1	137	93	\N	\N	18	2
4113	1	141	93	\N	\N	18	2
4114	2	153	93	\N	\N	18	2
4115	1	154	93	\N	\N	18	2
4116	12	156	93	\N	\N	18	2
4117	10	158	93	\N	\N	18	2
4118	2	161	93	\N	\N	18	2
4119	1	163	93	\N	\N	18	2
412	2	129	4	\N	\N	4	\N
4120	2	164	93	\N	\N	18	2
4121	1	72	93	\N	\N	18	2
4122	14	170	93	\N	\N	18	2
4123	1	171	93	\N	\N	18	2
4124	2	174	93	\N	\N	18	2
4125	14	189	93	\N	\N	18	2
4126	3	191	93	\N	\N	18	2
4127	2	194	93	\N	\N	18	2
4128	6	196	93	\N	\N	18	2
4129	4	204	93	\N	\N	18	2
413	2	130	4	\N	\N	4	\N
4130	3	205	93	\N	\N	18	2
4131	2	207	93	\N	\N	18	2
4132	2	208	93	\N	\N	18	2
4133	2	20	94	\N	\N	18	2
4134	1	126	94	\N	\N	18	2
4135	2	137	94	\N	\N	18	2
4136	2	151	94	\N	\N	18	2
4137	1	154	94	\N	\N	18	2
4138	4	156	94	\N	\N	18	2
4139	2	158	94	\N	\N	18	2
414	30	131	4	\N	\N	4	\N
4140	2	161	94	\N	\N	18	2
4141	2	164	94	\N	\N	18	2
4142	1	167	94	\N	\N	18	2
4143	2	186	94	\N	\N	18	2
4144	10	189	94	\N	\N	18	2
4145	1	194	94	\N	\N	18	2
4146	6	196	94	\N	\N	18	2
4147	20	7	95	\N	\N	18	2
4148	8	20	95	\N	\N	18	2
4149	1	39	95	\N	\N	18	2
415	49	132	4	\N	\N	4	\N
4150	4	41	95	\N	\N	18	2
4151	1	43	95	\N	\N	18	2
4152	88	44	95	\N	\N	18	2
4153	2	118	95	\N	\N	18	2
4154	15	131	95	\N	\N	18	2
4155	1	132	95	\N	\N	18	2
4156	3	134	95	\N	\N	18	2
4157	2	135	95	\N	\N	18	2
4158	14	137	95	\N	\N	18	2
4159	2	141	95	\N	\N	18	2
416	4	134	4	\N	\N	4	\N
4160	1	149	95	\N	\N	18	2
4161	9	151	95	\N	\N	18	2
4162	35	153	95	\N	\N	18	2
4163	6	154	95	\N	\N	18	2
4164	45	156	95	\N	\N	18	2
4165	47	158	95	\N	\N	18	2
4166	10	161	95	\N	\N	18	2
4167	1	163	95	\N	\N	18	2
4168	7	164	95	\N	\N	18	2
4169	5	167	95	\N	\N	18	2
417	37	135	4	\N	\N	4	\N
4170	2	66	95	\N	\N	18	2
4171	3	69	95	\N	\N	18	2
4172	1	72	95	\N	\N	18	2
4173	4	76	95	\N	\N	18	2
4174	1	77	95	\N	\N	18	2
4175	4	79	95	\N	\N	18	2
4176	2	82	95	\N	\N	18	2
4177	1	95	95	\N	\N	18	2
4178	1	112	95	\N	\N	18	2
4179	62	170	95	\N	\N	18	2
418	5	136	4	\N	\N	4	\N
4180	20	171	95	\N	\N	18	2
4181	201	174	95	\N	\N	18	2
4182	15	175	95	\N	\N	18	2
4183	69	176	95	\N	\N	18	2
4184	8	178	95	\N	\N	18	2
4185	8	186	95	\N	\N	18	2
4186	156	189	95	\N	\N	18	2
4187	14	190	95	\N	\N	18	2
4188	40	191	95	\N	\N	18	2
4189	37	194	95	\N	\N	18	2
419	115	139	4	\N	\N	4	\N
4190	4	195	95	\N	\N	18	2
4191	35	196	95	\N	\N	18	2
4192	1	199	95	\N	\N	18	2
4193	6	204	95	\N	\N	18	2
4194	3	205	95	\N	\N	18	2
4195	119	207	95	\N	\N	18	2
4196	3	208	95	\N	\N	18	2
4197	12	211	95	\N	\N	18	2
4198	4	118	96	\N	\N	18	2
4199	1	135	96	\N	\N	18	2
42	3	73	1	\N	\N	1	\N
420	27	141	4	\N	\N	4	\N
4200	2	137	96	\N	\N	18	2
4201	1	141	96	\N	\N	18	2
4202	1	151	96	\N	\N	18	2
4203	2	153	96	\N	\N	18	2
4204	2	156	96	\N	\N	18	2
4205	4	158	96	\N	\N	18	2
4206	2	161	96	\N	\N	18	2
4207	2	168	96	\N	Reported as 2 BEWR w/ note: 2 hopping on back deck – could have been Winter Wren	18	2
4208	1	72	96	\N	\N	18	2
4209	1	175	96	\N	\N	18	2
421	1	144	4	\N	\N	4	\N
4210	5	189	96	\N	\N	18	2
4211	3	194	96	\N	\N	18	2
4212	6	196	96	\N	\N	18	2
4213	8	207	96	\N	\N	18	2
4214	3	208	96	\N	\N	18	2
4215	2	211	96	\N	\N	18	2
4216	1	197	96	\N	Reported as WCSP w/ question mark	18	2
4217	4	131	97	\N	\N	18	2
4218	1	135	97	\N	\N	18	2
4219	1	156	97	\N	\N	18	2
422	9	149	4	\N	\N	4	\N
4220	7	158	97	\N	\N	18	2
4221	2	161	97	\N	\N	18	2
4222	6	189	97	\N	\N	18	2
4223	3	194	97	\N	\N	18	2
4224	6	196	97	\N	\N	18	2
4225	7	197	97	\N	\N	18	2
4226	120	18	98	\N	\N	18	2
4227	6	20	98	\N	\N	18	2
4228	6	34	98	\N	\N	18	2
4229	28	39	98	\N	\N	18	2
423	220	151	4	\N	\N	4	\N
4230	21	40	98	\N	\N	18	2
4231	3	41	98	\N	\N	18	2
4232	2	44	98	\N	\N	18	2
4233	11	45	98	\N	\N	18	2
4234	15	59	98	\N	\N	18	2
4235	3	61	98	\N	\N	18	2
4236	3	132	98	\N	\N	18	2
4237	1	137	98	\N	\N	18	2
4238	4	154	98	\N	\N	18	2
4239	3	164	98	\N	\N	18	2
424	1	152	4	\N	\N	4	\N
4240	8	66	98	\N	\N	18	2
4241	1	69	98	\N	\N	18	2
4242	1	76	98	\N	\N	18	2
4243	1	79	98	\N	\N	18	2
4244	2	86	98	\N	\N	18	2
4245	50	106	98	\N	\N	18	2
4246	2	112	98	\N	\N	18	2
4247	8	113	98	\N	3 HERG changed to WEGU x GWGU after checking w/ Kip	18	2
4248	2	194	98	\N	\N	18	2
4249	1	134	99	\N	\N	18	2
425	1499	153	4	\N	\N	4	\N
4250	1	149	99	\N	\N	18	2
4251	1	154	99	\N	\N	18	2
4252	6	158	99	\N	\N	18	2
4253	1	161	99	\N	\N	18	2
4254	1	163	99	\N	\N	18	2
4255	2	164	99	\N	\N	18	2
4256	12	170	99	\N	\N	18	2
4257	1	171	99	\N	\N	18	2
4258	1	194	99	\N	\N	18	2
4259	2	196	99	\N	\N	18	2
426	17	154	4	\N	\N	4	\N
4260	2	131	100	\N	\N	18	2
4261	1	135	100	\N	\N	18	2
4262	2	171	100	\N	\N	18	2
4263	2	184	100	\N	\N	18	2
4264	1	137	101	\N	\N	18	2
4265	1	156	101	\N	\N	18	2
4266	4	158	101	\N	\N	18	2
4267	1	161	101	\N	\N	18	2
4268	1	164	101	\N	\N	18	2
4269	1	186	101	\N	\N	18	2
427	270	156	4	\N	\N	4	\N
4270	6	189	101	\N	\N	18	2
4271	3	196	101	\N	\N	18	2
4272	4	205	101	\N	\N	18	2
4273	5	34	102	\N	\N	18	2
4274	5	39	102	\N	\N	18	2
4275	2	40	102	\N	\N	18	2
4276	1	41	102	\N	\N	18	2
4277	4	42	102	\N	\N	18	2
4278	6	117	102	\N	\N	18	2
4279	1	137	102	\N	\N	18	2
428	394	158	4	\N	\N	4	\N
4280	3	141	102	\N	\N	18	2
4281	1	156	102	\N	\N	18	2
4282	1	161	102	\N	\N	18	2
4283	3	164	102	\N	\N	18	2
4284	21	66	102	\N	\N	18	2
4285	3	67	102	\N	\N	18	2
4286	1	76	102	\N	\N	18	2
4287	2	77	102	\N	\N	18	2
4288	2	79	102	\N	\N	18	2
4289	1	112	102	\N	\N	18	2
429	162	160	4	\N	\N	4	\N
4290	11	116	102	\N	\N	18	2
4291	7	170	102	\N	\N	18	2
4292	1	171	102	\N	\N	18	2
4293	85	174	102	\N	\N	18	2
4294	1	178	102	\N	\N	18	2
4295	9	189	102	\N	\N	18	2
4296	1	194	102	\N	\N	18	2
4297	1	196	102	\N	\N	18	2
4298	32	7	103	\N	\N	18	2
4299	42	18	103	\N	\N	18	2
43	25	76	1	\N	\N	1	\N
430	75	161	4	\N	\N	4	\N
4300	2	20	103	\N	\N	18	2
4301	1	35	103	\N	\N	18	2
4302	8	39	103	\N	\N	18	2
4303	8	40	103	\N	\N	18	2
4304	6	43	103	\N	6 from Ed at Lisabeula	18	2
4305	\N	51	103	t	\N	18	2
4306	1	53	103	\N	1 from Ed at Lisabeula	18	2
4307	1	55	103	\N	1 from Ed at Lisabeula	18	2
4308	5	59	103	\N	\N	18	2
4309	1	60	103	\N	1 from Ed at Lisabeula	18	2
431	20	163	4	\N	\N	4	\N
4310	15	117	103	\N	\N	18	2
4311	6	131	103	\N	\N	18	2
4312	1	132	103	\N	1 from Ed at Lisabeula	18	2
4313	2	134	103	\N	\N	18	2
4314	1	135	103	\N	\N	18	2
4315	4	137	103	\N	\N	18	2
4316	2	143	103	\N	\N	18	2
4317	8	153	103	\N	\N	18	2
4318	2	154	103	\N	\N	18	2
4319	14	156	103	\N	\N	18	2
432	92	165	4	\N	\N	4	\N
4320	6	158	103	\N	\N	18	2
4321	6	161	103	\N	\N	18	2
4322	1	163	103	\N	\N	18	2
4323	8	164	103	\N	\N	18	2
4324	6	66	103	\N	\N	18	2
4325	11	67	103	\N	6 from team, 11 from Ed at Reddings Beach	18	2
4326	2	68	103	\N	\N	18	2
4327	1	71	103	\N	\N	18	2
4328	2	72	103	\N	\N	18	2
4329	1	73	103	\N	\N	18	2
433	2	166	4	\N	\N	4	\N
4330	1	76	103	\N	\N	18	2
4331	3	79	103	\N	\N	18	2
4332	7	86	103	\N	1 from team, 7 from Ed at Lisabeula	18	2
4333	1	87	103	\N	\N	18	2
4334	1	99	103	\N	1 from Ed at Lisabeula	18	2
4335	1	103	103	\N	1 from Ed at Lisabeula	18	2
4336	3	106	103	\N	\N	18	2
4337	18	112	103	\N	12 erroneously reported as CAGU	18	2
4338	2	116	103	\N	\N	18	2
4339	18	170	103	\N	\N	18	2
434	65	167	4	\N	\N	4	\N
4340	8	171	103	\N	\N	18	2
4341	36	174	103	\N	\N	18	2
4342	3	176	103	\N	\N	18	2
4343	8	178	103	\N	\N	18	2
4344	58	189	103	\N	\N	18	2
4345	10	191	103	\N	\N	18	2
4346	6	194	103	\N	\N	18	2
4347	10	196	103	\N	\N	18	2
4348	2	204	103	\N	\N	18	2
4349	2	205	103	\N	\N	18	2
435	4	168	4	\N	\N	4	\N
4350	6	207	103	\N	\N	18	2
4351	1	6	104	\N	Cackling Goose was in with a flock of Canada Geese.  Another flock of Canada Geese had 2 domestic Swan Geese.  	19	5
4352	50	7	104	\N	\N	19	5
4353	9	17	104	\N	\N	19	5
4354	2370	18	104	\N	\N	19	5
4355	34	20	104	\N	\N	19	5
4356	7	29	104	\N	\N	19	5
4357	5	33	104	\N	\N	19	5
4358	49	34	104	\N	\N	19	5
4359	1	35	104	\N	\N	19	5
436	1	169	4	\N	\N	4	\N
4360	38	39	104	\N	\N	19	5
4361	77	40	104	\N	\N	19	5
4362	1	41	104	\N	\N	19	5
4363	6	43	104	\N	\N	19	5
4364	55	45	104	\N	\N	19	5
4365	4	53	104	\N	\N	19	5
4366	1	54	104	\N	\N	19	5
4367	10	59	104	\N	\N	19	5
4368	8	117	104	\N	\N	19	5
4369	\N	119	104	t	\N	19	5
437	529	170	4	\N	\N	4	\N
4370	6	131	104	\N	\N	19	5
4371	3	132	104	\N	\N	19	5
4372	1	137	104	\N	\N	19	5
4373	2	151	104	\N	\N	19	5
4374	31	153	104	\N	\N	19	5
4375	5	154	104	\N	\N	19	5
4376	7	156	104	\N	\N	19	5
4377	1	161	104	\N	\N	19	5
4378	2	164	104	\N	\N	19	5
4379	1	167	104	\N	\N	19	5
438	217	171	4	\N	\N	4	\N
4380	1	65	104	\N	\N	19	5
4381	29	66	104	\N	\N	19	5
4382	5	67	104	\N	\N	19	5
4383	9	68	104	\N	\N	19	5
4384	4	69	104	\N	\N	19	5
4385	2	76	104	\N	An Adult Bald Eagle was carrying nesting materials. 	19	5
4386	4	89	104	\N	\N	19	5
4387	8	100	104	\N	\N	19	5
4388	187	106	104	\N	\N	19	5
4389	1	109	104	\N	\N	19	5
439	2	173	4	\N	\N	4	\N
4390	2	110	104	\N	\N	19	5
4391	18	111	104	\N	\N	19	5
4392	16	112	104	\N	\N	19	5
4393	8	113	104	\N	\N	19	5
4394	67	174	104	\N	\N	19	5
4395	15	176	104	\N	\N	19	5
4396	2	186	104	\N	\N	19	5
4397	25	189	104	\N	\N	19	5
4398	1	190	104	\N	\N	19	5
4399	5	191	104	\N	\N	19	5
44	13	79	1	\N	\N	1	\N
440	1065	174	4	\N	\N	4	\N
4400	7	194	104	\N	\N	19	5
4401	4	196	104	\N	\N	19	5
4402	19	199	104	\N	\N	19	5
4403	6	204	104	\N	\N	19	5
4404	3	211	104	\N	\N	19	5
4405	19	18	105	\N	\N	19	5
4406	2	20	105	\N	\N	19	5
4407	2	28	105	\N	\N	19	5
4408	1	33	105	\N	\N	19	5
4409	22	34	105	\N	\N	19	5
441	77	175	4	\N	\N	4	\N
4410	15	39	105	\N	\N	19	5
4411	23	40	105	\N	\N	19	5
4412	4	41	105	\N	\N	19	5
4413	12	43	105	\N	\N	19	5
4414	8	44	105	\N	\N	19	5
4415	2	45	105	\N	\N	19	5
4416	2	54	105	\N	\N	19	5
4417	27	59	105	\N	\N	19	5
4418	1	60	105	\N	\N	19	5
4419	6	117	105	\N	\N	19	5
442	1146	176	4	\N	\N	4	\N
4420	1	119	105	\N	\N	19	5
4421	4	120	105	\N	\N	19	5
4422	1	131	105	\N	\N	19	5
4423	2	132	105	\N	\N	19	5
4424	1	135	105	\N	\N	19	5
4425	3	137	105	\N	\N	19	5
4426	1	145	105	\N	\N	19	5
4427	5	151	105	\N	\N	19	5
4428	18	153	105	\N	\N	19	5
4429	1	154	105	\N	\N	19	5
443	4	178	4	\N	\N	4	\N
4430	2	158	105	\N	\N	19	5
4431	1	164	105	\N	\N	19	5
4432	4	62	105	\N	\N	19	5
4433	16	66	105	\N	\N	19	5
4434	1	67	105	\N	\N	19	5
4435	2	69	105	\N	\N	19	5
4436	2	76	105	\N	\N	19	5
4437	1	79	105	\N	\N	19	5
4438	6	86	105	\N	\N	19	5
4439	16	112	105	\N	\N	19	5
444	3	179	4	\N	\N	4	\N
4440	14	170	105	\N	\N	19	5
4441	35	174	105	\N	\N	19	5
4442	1	175	105	\N	\N	19	5
4443	60	176	105	\N	\N	19	5
4444	1	186	105	\N	\N	19	5
4445	45	189	105	\N	\N	19	5
4446	2	191	105	\N	\N	19	5
4447	4	194	105	\N	\N	19	5
4448	5	196	105	\N	\N	19	5
4449	5	204	105	\N	\N	19	5
445	11	184	4	\N	\N	4	\N
4450	2	205	105	\N	\N	19	5
4451	4	211	105	\N	\N	19	5
4452	9	15	106	\N	\N	19	6
4453	40	18	106	\N	\N	19	6
4454	42	20	106	\N	\N	19	6
4455	12	28	106	\N	\N	19	6
4456	30	39	106	\N	\N	19	6
4457	12	40	106	\N	\N	19	6
4458	2	41	106	\N	\N	19	6
4459	3	43	106	\N	\N	19	6
446	189	186	4	\N	\N	4	\N
4460	1	45	106	\N	\N	19	6
4461	1	131	106	\N	\N	19	6
4462	4	132	106	\N	\N	19	6
4463	1	134	106	\N	\N	19	6
4464	6	137	106	\N	\N	19	6
4465	1	141	106	\N	\N	19	6
4466	16	151	106	\N	\N	19	6
4467	117	153	106	\N	\N	19	6
4468	6	154	106	\N	\N	19	6
4469	7	156	106	\N	\N	19	6
447	1113	189	4	\N	\N	4	\N
4470	1	158	106	\N	\N	19	6
4471	1	161	106	\N	\N	19	6
4472	2	164	106	\N	\N	19	6
4473	4	66	106	\N	\N	19	6
4474	2	67	106	\N	\N	19	6
4475	4	69	106	\N	\N	19	6
4476	2	76	106	\N	\N	19	6
4477	2	77	106	\N	\N	19	6
4478	1	79	106	\N	\N	19	6
4479	1	103	106	\N	\N	19	6
448	7	190	4	\N	\N	4	\N
4480	2	106	106	\N	\N	19	6
4481	4	112	106	\N	\N	19	6
4482	3	113	106	\N	\N	19	6
4483	10	170	106	\N	\N	19	6
4484	1	171	106	\N	\N	19	6
4485	91	174	106	\N	\N	19	6
4486	5	175	106	\N	\N	19	6
4487	78	176	106	\N	\N	19	6
4488	4	186	106	\N	\N	19	6
4489	34	189	106	\N	\N	19	6
449	63	191	4	\N	\N	4	\N
4490	4	190	106	\N	\N	19	6
4491	5	191	106	\N	\N	19	6
4492	6	194	106	\N	\N	19	6
4493	15	196	106	\N	\N	19	6
4494	1	204	106	\N	\N	19	6
4495	2	205	106	\N	\N	19	6
4496	85	207	106	\N	\N	19	6
4497	10	211	106	\N	\N	19	6
4498	1	21	106	\N	\N	19	6
4499	31	7	107	\N	\N	19	6
45	685	83	1	\N	\N	1	\N
450	3	193	4	\N	\N	4	\N
4500	3	15	107	\N	\N	19	6
4501	21	18	107	\N	\N	19	6
4502	90	20	107	\N	\N	19	6
4503	21	28	107	\N	\N	19	6
4504	6	29	107	\N	\N	19	6
4505	11	30	107	\N	\N	19	6
4506	46	39	107	\N	\N	19	6
4507	20	43	107	\N	\N	19	6
4508	195	44	107	\N	\N	19	6
4509	26	47	107	\N	\N	19	6
451	604	194	4	\N	\N	4	\N
4510	58	58	107	\N	\N	19	6
4511	3	131	107	\N	\N	19	6
4512	1	134	107	\N	\N	19	6
4513	1	136	107	\N	\N	19	6
4514	10	137	107	\N	\N	19	6
4515	9	151	107	\N	\N	19	6
4516	44	153	107	\N	\N	19	6
4517	2	154	107	\N	\N	19	6
4518	26	156	107	\N	\N	19	6
4519	1	163	107	\N	\N	19	6
452	451	196	4	\N	\N	4	\N
4520	1	167	107	\N	\N	19	6
4521	40	66	107	\N	\N	19	6
4522	3	69	107	\N	\N	19	6
4523	1	79	107	\N	\N	19	6
4524	100	83	107	\N	\N	19	6
4525	6	86	107	\N	\N	19	6
4526	4	112	107	\N	\N	19	6
4527	2	170	107	\N	\N	19	6
4528	1	171	107	\N	\N	19	6
4529	1	174	107	\N	\N	19	6
453	364	199	4	\N	\N	4	\N
4530	15	176	107	\N	\N	19	6
4531	1	186	107	\N	\N	19	6
4532	26	189	107	\N	\N	19	6
4533	3	191	107	\N	\N	19	6
4534	7	194	107	\N	\N	19	6
4535	6	196	107	\N	\N	19	6
4536	14	199	107	\N	\N	19	6
4537	1	122	108	\N	\N	19	6
4538	2	124	108	\N	\N	19	6
4539	2	126	108	\N	\N	19	6
454	10	201	4	\N	\N	4	\N
4540	1	129	108	\N	\N	19	6
4541	3	86	108	\N	\N	19	6
4542	4	95	108	\N	\N	19	6
4543	1	174	108	\N	\N	19	6
4544	1	194	108	\N	\N	19	6
4545	6	137	109	\N	\N	19	6
4546	2	141	109	\N	\N	19	6
4547	3	151	109	\N	\N	19	6
4548	8	156	109	\N	\N	19	6
4549	4	158	109	\N	\N	19	6
455	\N	202	4	t	\N	4	\N
4550	2	161	109	\N	\N	19	6
4551	1	163	109	\N	\N	19	6
4552	1	79	109	\N	\N	19	6
4553	29	174	109	\N	\N	19	6
4554	150	176	109	\N	\N	19	6
4555	2	186	109	\N	\N	19	6
4556	30	189	109	\N	\N	19	6
4557	11	7	110	\N	\N	19	6
4558	2	16	110	\N	\N	19	6
4559	32	20	110	\N	\N	19	6
456	298	204	4	\N	\N	4	\N
4560	6	39	110	\N	\N	19	6
4561	6	43	110	\N	\N	19	6
4562	1	58	110	\N	\N	19	6
4563	13	120	110	\N	\N	19	6
4564	2	131	110	\N	\N	19	6
4565	2	135	110	\N	\N	19	6
4566	12	137	110	\N	\N	19	6
4567	11	151	110	\N	\N	19	6
4568	38	153	110	\N	\N	19	6
4569	23	156	110	\N	\N	19	6
457	56	205	4	\N	\N	4	\N
4570	4	158	110	\N	\N	19	6
4571	5	164	110	\N	\N	19	6
4572	2	166	110	\N	\N	19	6
4573	2	167	110	\N	\N	19	6
4574	2	69	110	\N	\N	19	6
4575	1	72	110	\N	\N	19	6
4576	5	76	110	\N	\N	19	6
4577	4	79	110	\N	\N	19	6
4578	1	82	110	\N	\N	19	6
4579	2	83	110	\N	\N	19	6
458	26	206	4	\N	\N	4	\N
4580	3	95	110	\N	\N	19	6
4581	2	112	110	\N	\N	19	6
4582	4	171	110	\N	\N	19	6
4583	96	174	110	\N	\N	19	6
4584	1	175	110	\N	\N	19	6
4585	173	176	110	\N	\N	19	6
4586	10	178	110	\N	\N	19	6
4587	2	181	110	\N	\N	19	6
4588	8	186	110	\N	\N	19	6
4589	118	189	110	\N	\N	19	6
459	1111	207	4	\N	\N	4	\N
4590	8	190	110	\N	\N	19	6
4591	23	191	110	\N	\N	19	6
4592	23	194	110	\N	\N	19	6
4593	13	196	110	\N	\N	19	6
4594	49	199	110	\N	\N	19	6
4595	14	204	110	\N	\N	19	6
4596	16	207	110	\N	\N	19	6
4597	18	211	110	\N	\N	19	6
4598	9	33	111	\N	\N	19	3
4599	10	34	111	\N	\N	19	3
46	80	86	1	\N	\N	1	\N
460	37	208	4	\N	\N	4	\N
4600	14	39	111	\N	\N	19	3
4601	27	40	111	\N	\N	19	3
4602	5	41	111	\N	\N	19	3
4603	3	43	111	\N	\N	19	3
4604	17	45	111	\N	\N	19	3
4605	3	53	111	\N	\N	19	3
4606	23	59	111	\N	\N	19	3
4607	6	60	111	\N	\N	19	3
4608	22	131	111	\N	\N	19	3
4609	1	132	111	\N	\N	19	3
461	20	210	4	\N	\N	4	\N
4610	3	135	111	\N	\N	19	3
4611	9	137	111	\N	\N	19	3
4612	2	144	111	\N	\N	19	3
4613	1	149	111	\N	\N	19	3
4614	3	151	111	\N	\N	19	3
4615	99	153	111	\N	\N	19	3
4616	1	154	111	\N	\N	19	3
4617	15	156	111	\N	\N	19	3
4618	24	158	111	\N	\N	19	3
4619	33	160	111	\N	\N	19	3
462	123	211	4	\N	\N	4	\N
4620	3	161	111	\N	\N	19	3
4621	6	163	111	\N	\N	19	3
4622	7	164	111	\N	\N	19	3
4623	2	167	111	\N	\N	19	3
4624	3	65	111	\N	\N	19	3
4625	4	66	111	\N	\N	19	3
4626	1	67	111	\N	\N	19	3
4627	1	75	111	\N	\N	19	3
4628	7	76	111	\N	\N	19	3
4629	1	77	111	\N	\N	19	3
463	2	2	5	\N	\N	5	\N
4630	1	79	111	\N	\N	19	3
4631	1	100	111	\N	\N	19	3
4632	3	106	111	\N	\N	19	3
4633	10	112	111	\N	\N	19	3
4634	34	113	111	\N	\N	19	3
4635	13	170	111	\N	\N	19	3
4636	5	171	111	\N	\N	19	3
4637	2	173	111	\N	\N	19	3
4638	648	174	111	\N	\N	19	3
4639	2	175	111	\N	\N	19	3
464	151	7	5	\N	\N	5	\N
4640	1	176	111	\N	\N	19	3
4641	164	178	111	\N	\N	19	3
4642	1	179	111	\N	\N	19	3
4643	11	181	111	\N	\N	19	3
4644	7	186	111	\N	\N	19	3
4645	79	189	111	\N	\N	19	3
4646	12	191	111	\N	\N	19	3
4647	19	194	111	\N	\N	19	3
4648	12	196	111	\N	\N	19	3
4649	3	204	111	\N	\N	19	3
465	11	15	5	\N	\N	5	\N
4650	20	207	111	\N	\N	19	3
4651	59	7	112	\N	\N	19	3
4652	7	20	112	\N	\N	19	3
4653	6	39	112	\N	\N	19	3
4654	2	59	112	\N	\N	19	3
4655	5	131	112	\N	\N	19	3
4656	1	134	112	\N	\N	19	3
4657	1	137	112	\N	\N	19	3
4658	5	151	112	\N	\N	19	3
4659	27	153	112	\N	\N	19	3
466	3	16	5	\N	\N	5	\N
4660	2	154	112	\N	\N	19	3
4661	16	156	112	\N	\N	19	3
4662	25	158	112	\N	\N	19	3
4663	5	161	112	\N	\N	19	3
4664	2	164	112	\N	\N	19	3
4665	1	69	112	\N	\N	19	3
4666	1	75	112	\N	\N	19	3
4667	1	76	112	\N	\N	19	3
4668	1	77	112	\N	\N	19	3
4669	11	106	112	\N	\N	19	3
467	11	17	5	\N	\N	5	\N
4670	3	112	112	\N	\N	19	3
4671	3	113	112	\N	\N	19	3
4672	2	170	112	\N	\N	19	3
4673	1	171	112	\N	\N	19	3
4674	147	174	112	\N	\N	19	3
4675	38	176	112	\N	\N	19	3
4676	66	178	112	\N	\N	19	3
4677	6	181	112	\N	\N	19	3
4678	3	186	112	\N	\N	19	3
4679	103	189	112	\N	\N	19	3
468	2900	18	5	\N	\N	5	\N
4680	10	190	112	\N	\N	19	3
4681	15	191	112	\N	\N	19	3
4682	12	194	112	\N	\N	19	3
4683	16	196	112	\N	\N	19	3
4684	6	204	112	\N	\N	19	3
4685	1	205	112	\N	\N	19	3
4686	6	211	112	\N	\N	19	3
4687	5	7	113	\N	\N	19	3
4688	22	18	113	\N	\N	19	3
4689	28	20	113	\N	\N	19	3
469	1001	20	5	\N	\N	5	\N
4690	2	24	113	\N	\N	19	3
4691	17	29	113	\N	\N	19	3
4692	38	34	113	\N	2 from KVI checklist	19	3
4693	1	35	113	\N	1 from KVI checklist	19	3
4694	43	39	113	\N	6 from KVI checklist	19	3
4695	29	40	113	\N	3 from KVI checklist	19	3
4696	9	41	113	\N	1 from KVI checklist	19	3
4697	1	43	113	\N	\N	19	3
4698	41	45	113	\N	15 from KVI checklist	19	3
4699	4	53	113	\N	1 from KVI checklist	19	3
47	2	87	1	\N	\N	1	\N
470	36	22	5	\N	\N	5	\N
4700	2	54	113	\N	\N	19	3
4701	2	55	113	\N	\N	19	3
4702	28	59	113	\N	6 from KVI checklist	19	3
4703	9	60	113	\N	3 from KVI checklist	19	3
4704	15	61	113	\N	\N	19	3
4705	15	117	113	\N	\N	19	3
4706	6	119	113	\N	\N	19	3
4707	24	131	113	\N	\N	19	3
4708	1	134	113	\N	\N	19	3
4709	1	135	113	\N	\N	19	3
471	22	23	5	\N	\N	5	\N
4710	3	137	113	\N	\N	19	3
4711	45	153	113	\N	\N	19	3
4712	3	154	113	\N	\N	19	3
4713	5	156	113	\N	\N	19	3
4714	5	158	113	\N	\N	19	3
4715	3	161	113	\N	\N	19	3
4716	1	164	113	\N	\N	19	3
4717	2	167	113	\N	\N	19	3
4718	2	62	113	\N	2 from KVI checklist	19	3
4719	15	66	113	\N	\N	19	3
472	143	24	5	\N	\N	5	\N
4720	2	67	113	\N	1 from KVI checklist	19	3
4721	2	69	113	\N	\N	19	3
4722	5	76	113	\N	\N	19	3
4723	6	77	113	\N	\N	19	3
4724	2	79	113	\N	\N	19	3
4725	3	86	113	\N	\N	19	3
4726	1	87	113	\N	\N	19	3
4727	1	88	113	\N	\N	19	3
4728	1	100	113	\N	\N	19	3
4729	3	105	113	\N	\N	19	3
473	8	28	5	\N	\N	5	\N
4730	9	106	113	\N	\N	19	3
4731	12	112	113	\N	3 from KVI checklist	19	3
4732	8	113	113	\N	\N	19	3
4733	4	170	113	\N	\N	19	3
4734	2	171	113	\N	\N	19	3
4735	146	174	113	\N	\N	19	3
4736	14	178	113	\N	\N	19	3
4737	14	186	113	\N	\N	19	3
4738	22	189	113	\N	\N	19	3
4739	1	190	113	\N	\N	19	3
474	196	29	5	\N	\N	5	\N
4740	12	191	113	\N	\N	19	3
4741	13	194	113	\N	\N	19	3
4742	16	196	113	\N	\N	19	3
4743	13	204	113	\N	\N	19	3
4744	1	205	113	\N	\N	19	3
4745	25	207	113	\N	\N	19	3
4746	15	211	113	\N	\N	19	3
4747	5	7	114	\N	\N	19	3
4748	4	131	114	\N	\N	19	3
4749	1	135	114	\N	1 m	19	3
475	8	33	5	\N	\N	5	\N
4750	1	137	114	\N	\N	19	3
4751	2	156	114	\N	\N	19	3
4752	1	158	114	\N	\N	19	3
4753	1	161	114	\N	\N	19	3
4754	17	189	114	\N	\N	19	3
4755	2	191	114	\N	\N	19	3
4756	2	194	114	\N	\N	19	3
4757	1	196	114	\N	\N	19	3
4758	2	204	114	\N	\N	19	3
4759	2	211	114	\N	\N	19	3
476	935	34	5	\N	\N	5	\N
4760	3	131	115	\N	2 m, 1 f	19	3
4761	2	156	115	\N	\N	19	3
4762	3	158	115	\N	\N	19	3
4763	1	161	115	\N	\N	19	3
4764	2	163	115	\N	\N	19	3
4765	1	164	115	\N	\N	19	3
4766	1	167	115	\N	\N	19	3
4767	2	76	115	\N	\N	19	3
4768	1	174	115	\N	\N	19	3
4769	2	175	115	\N	\N	19	3
477	294	35	5	\N	\N	5	\N
4770	1	186	115	\N	\N	19	3
4771	4	189	115	\N	\N	19	3
4772	1	194	115	\N	\N	19	3
4773	3	196	115	\N	1 m, 2 f/imm	19	3
4774	4	205	115	\N	2 m, 2 f/imm	19	3
4775	2	131	116	\N	2 m	19	3
4776	1	151	116	\N	\N	19	3
4777	2	158	116	\N	\N	19	3
4778	1	161	116	\N	\N	19	3
4779	10	189	116	\N	\N	19	3
478	6	36	5	\N	\N	5	\N
4780	1	190	116	\N	\N	19	3
4781	9	191	116	\N	\N	19	3
4782	2	196	116	\N	\N	19	3
4783	6	204	116	\N	\N	19	3
4784	2	205	116	\N	2 m	19	3
4785	7	207	116	\N	\N	19	3
4786	2	211	116	\N	\N	19	3
4787	2	131	117	\N	\N	19	3
4788	7	158	117	\N	\N	19	3
4789	6	189	117	\N	\N	19	3
479	398	39	5	\N	\N	5	\N
4790	4	194	117	\N	\N	19	3
4791	2	196	117	\N	\N	19	3
4792	27	131	118	\N	\N	19	3
4793	2	131	119	\N	1 m, 1 f	19	3
4794	9	153	119	\N	flyovers	19	3
4795	1	154	119	\N	heard	19	3
4796	2	156	119	\N	\N	19	3
4797	5	158	119	\N	\N	19	3
4798	2	161	119	\N	\N	19	3
4799	9	174	119	\N	\N	19	3
48	1	88	1	\N	\N	1	\N
480	175	40	5	\N	\N	5	\N
4800	5	175	119	\N	at least 3 males	19	3
4801	30	178	119	\N	flyover	19	3
4802	2	186	119	\N	\N	19	3
4803	6	189	119	\N	\N	19	3
4804	1	194	119	\N	\N	19	3
4805	3	196	119	\N	2 m, 1 f	19	3
4806	3	204	119	\N	1 m, 2 f	19	3
4807	144	7	120	\N	\N	19	7
4808	14	15	120	\N	\N	19	7
4809	1	17	120	\N	\N	19	7
481	122	41	5	\N	\N	5	\N
4810	117	18	120	\N	\N	19	7
4811	183	20	120	\N	\N	19	7
4812	36	23	120	\N	\N	19	7
4813	40	24	120	\N	\N	19	7
4814	14	28	120	\N	\N	19	7
4815	90	29	120	\N	\N	19	7
4816	5	33	120	\N	\N	19	7
4817	72	34	120	\N	\N	19	7
4818	2	35	120	\N	\N	19	7
4819	109	39	120	\N	\N	19	7
482	5	42	5	\N	\N	5	\N
4820	87	40	120	\N	\N	19	7
4821	8	41	120	\N	\N	19	7
4822	8	43	120	\N	\N	19	7
4823	37	44	120	\N	\N	19	7
4824	28	45	120	\N	\N	19	7
4825	2	54	120	\N	\N	19	7
4826	1	58	120	\N	\N	19	7
4827	59	59	120	\N	\N	19	7
4828	1	60	120	\N	\N	19	7
4829	6	118	120	\N	\N	19	7
483	73	43	5	\N	\N	5	\N
4830	1	120	120	\N	\N	19	7
4831	20	131	120	\N	\N	19	7
4832	4	132	120	\N	\N	19	7
4833	2	134	120	\N	\N	19	7
4834	4	135	120	\N	\N	19	7
4835	2	136	120	\N	\N	19	7
4836	33	137	120	\N	\N	19	7
4837	2	141	120	\N	\N	19	7
4838	1	149	120	\N	\N	19	7
4839	69	151	120	\N	\N	19	7
484	277	44	5	\N	\N	5	\N
4840	1	152	120	\N	\N	19	7
4841	217	153	120	\N	\N	19	7
4842	6	154	120	\N	\N	19	7
4843	96	156	120	\N	\N	19	7
4844	36	158	120	\N	\N	19	7
4845	12	160	120	\N	\N	19	7
4846	11	161	120	\N	\N	19	7
4847	1	163	120	\N	\N	19	7
4848	13	164	120	\N	\N	19	7
4849	2	167	120	\N	\N	19	7
485	205	45	5	\N	\N	5	\N
4850	53	66	120	\N	\N	19	7
4851	6	67	120	\N	\N	19	7
4852	3	69	120	\N	\N	19	7
4853	12	76	120	\N	\N	19	7
4854	2	77	120	\N	\N	19	7
4855	6	79	120	\N	\N	19	7
4856	12	86	120	\N	\N	19	7
4857	1	87	120	\N	\N	19	7
4858	2	88	120	\N	\N	19	7
4859	967	106	120	\N	\N	19	7
486	1	47	5	\N	\N	5	\N
4860	4	107	120	\N	\N	19	7
4861	9	112	120	\N	\N	19	7
4862	58	113	120	\N	\N	19	7
4863	170	116	120	\N	\N	19	7
4864	25	170	120	\N	\N	19	7
4865	7	171	120	\N	\N	19	7
4866	1	173	120	\N	\N	19	7
4867	373	174	120	\N	\N	19	7
4868	49	175	120	\N	\N	19	7
4869	107	176	120	\N	\N	19	7
487	1	49	5	\N	\N	5	\N
4870	2	181	120	\N	\N	19	7
4871	1	184	120	\N	\N	19	7
4872	21	186	120	\N	\N	19	7
4873	282	189	120	\N	\N	19	7
4874	1	190	120	\N	\N	19	7
4875	20	191	120	\N	\N	19	7
4876	57	194	120	\N	\N	19	7
4877	37	196	120	\N	\N	19	7
4878	21	199	120	\N	\N	19	7
4879	3	204	120	\N	\N	19	7
488	11	51	5	\N	\N	5	\N
4880	1	205	120	\N	\N	19	7
4881	12	207	120	\N	\N	19	7
4882	10	211	120	\N	\N	19	7
4883	\N	126	121	t	\N	19	7
4884	4	156	121	\N	\N	19	7
4885	6	158	121	\N	\N	19	7
4886	2	161	121	\N	\N	19	7
4887	1	163	121	\N	\N	19	7
4888	\N	72	121	t	\N	19	7
4889	1	171	121	\N	\N	19	7
489	10	53	5	\N	\N	5	\N
4890	1	184	121	\N	\N	19	7
4891	1	186	121	\N	\N	19	7
4892	20	189	121	\N	\N	19	7
4893	3	194	121	\N	\N	19	7
4894	1	196	121	\N	\N	19	7
4895	19	7	122	\N	\N	19	4
4896	76	18	122	\N	\N	19	4
4897	68	20	122	\N	\N	19	4
4898	52	29	122	\N	\N	19	4
4899	462	34	122	\N	\N	19	4
49	68	91	1	\N	\N	1	\N
490	6	54	5	\N	\N	5	\N
4900	313	35	122	\N	\N	19	4
4901	4	36	122	\N	\N	19	4
4902	191	39	122	\N	\N	19	4
4903	352	40	122	\N	\N	19	4
4904	94	41	122	\N	\N	19	4
4905	2	43	122	\N	\N	19	4
4906	155	44	122	\N	\N	19	4
4907	215	45	122	\N	\N	19	4
4908	2	46	122	\N	\N	19	4
4909	28	53	122	\N	\N	19	4
491	6	55	5	\N	\N	5	\N
4910	2	58	122	\N	\N	19	4
4911	130	59	122	\N	\N	19	4
4912	5	60	122	\N	\N	19	4
4913	1	131	122	\N	\N	19	4
4914	9	132	122	\N	Kingfishers were well spread out, don't think they're duplicates of our own counting	19	4
4915	19	153	122	\N	\N	19	4
4916	114	65	122	\N	\N	19	4
4917	48	66	122	\N	\N	19	4
4918	10	67	122	\N	\N	19	4
4919	2	68	122	\N	\N	19	4
492	1	57	5	\N	\N	5	\N
4920	6	69	122	\N	\N	19	4
4921	6	76	122	\N	2 adults on trees at Dockton that might be counted by Bob, several were seen that could have flown over other territories - EP: reducing count from 12 to 6, and immature count from 4 to 2 as BAEA adjustments for all areas of Vashon/Maury	19	4
4922	2	77	122	\N	\N	19	4
4923	1	86	122	\N	\N	19	4
4924	1	99	122	\N	\N	19	4
4925	5	100	122	\N	\N	19	4
4926	1	101	122	\N	\N	19	4
4927	2	103	122	\N	\N	19	4
4928	24	106	122	\N	\N	19	4
4929	1	107	122	\N	\N	19	4
493	2	58	5	\N	\N	5	\N
4930	1	109	122	\N	\N	19	4
4931	99	112	122	\N	\N	19	4
4932	9	116	122	\N	\N	19	4
4933	126	174	122	\N	primarily at Burton peninsula south of Jenkins pt.	19	4
4934	6	176	122	\N	\N	19	4
4935	15	210	122	\N	\N	19	4
4936	4	15	123	\N	\N	19	1
4937	12	28	123	\N	\N	19	1
4938	11	34	123	\N	\N	19	1
4939	55	39	123	\N	\N	19	1
494	164	59	5	\N	\N	5	\N
4940	4	40	123	\N	\N	19	1
4941	5	41	123	\N	\N	19	1
4942	10	43	123	\N	\N	19	1
4943	1	45	123	\N	\N	19	1
4944	1	55	123	\N	\N	19	1
4945	8	59	123	\N	\N	19	1
4946	7	117	123	\N	\N	19	1
4947	\N	131	123	t	\N	19	1
4948	1	144	123	\N	Originally reported as PEFA, changed to MERL after reviewing photo	19	1
4949	2	151	123	\N	\N	19	1
495	42	60	5	\N	\N	5	\N
4950	14	153	123	\N	\N	19	1
4951	1	154	123	\N	\N	19	1
4952	3	156	123	\N	\N	19	1
4953	18	158	123	\N	\N	19	1
4954	15	160	123	\N	\N	19	1
4955	1	167	123	\N	\N	19	1
4956	1	62	123	\N	\N	19	1
4957	7	65	123	\N	\N	19	1
4958	6	66	123	\N	\N	19	1
4959	4	67	123	\N	\N	19	1
496	1	61	5	\N	\N	5	\N
4960	1	69	123	\N	\N	19	1
4961	1	71	123	\N	\N	19	1
4962	5	76	123	\N	\N	19	1
4963	1	77	123	\N	\N	19	1
4964	1	79	123	\N	\N	19	1
4965	20	112	123	\N	\N	19	1
4966	10	174	123	\N	\N	19	1
4967	1	175	123	\N	\N	19	1
4968	30	176	123	\N	\N	19	1
4969	\N	184	123	t	\N	19	1
497	599	62	5	\N	\N	5	\N
4970	2	186	123	\N	\N	19	1
4971	26	189	123	\N	\N	19	1
4972	2	191	123	\N	\N	19	1
4973	2	194	123	\N	\N	19	1
4974	1	196	123	\N	\N	19	1
4975	2	204	123	\N	\N	19	1
4976	\N	207	123	t	\N	19	1
4977	195	6	124	\N	\N	19	1
4978	6	7	124	\N	\N	19	1
4979	1	17	124	\N	\N	19	1
498	2	65	5	\N	\N	5	\N
4980	11	18	124	\N	\N	19	1
4981	4	20	124	\N	\N	19	1
4982	30	34	124	\N	\N	19	1
4983	16	39	124	\N	\N	19	1
4984	19	40	124	\N	\N	19	1
4985	1	41	124	\N	\N	19	1
4986	1	45	124	\N	\N	19	1
4987	2	55	124	\N	\N	19	1
4988	34	59	124	\N	\N	19	1
4989	10	60	124	\N	\N	19	1
499	652	66	5	\N	\N	5	\N
4990	2	117	124	\N	\N	19	1
4991	1	119	124	\N	\N	19	1
4992	1	126	124	\N	Barred Owl at Judy's (out-of-'our'-area about 7:15 p.m)	19	1
4993	8	131	124	\N	\N	19	1
4994	3	134	124	\N	\N	19	1
4995	2	135	124	\N	\N	19	1
4996	7	137	124	\N	\N	19	1
4997	7	151	124	\N	\N	19	1
4998	71	153	124	\N	\N	19	1
4999	4	154	124	\N	\N	19	1
5	2798	18	1	\N	\N	1	\N
50	3	96	1	\N	\N	1	\N
500	16	67	5	\N	\N	5	\N
5000	13	156	124	\N	\N	19	1
5001	32	158	124	\N	\N	19	1
5002	7	161	124	\N	\N	19	1
5003	1	163	124	\N	\N	19	1
5004	8	164	124	\N	\N	19	1
5005	5	167	124	\N	\N	19	1
5006	1	66	124	\N	\N	19	1
5007	1	73	124	\N	\N	19	1
5008	9	76	124	\N	\N	19	1
5009	3	77	124	\N	\N	19	1
501	54	68	5	\N	\N	5	\N
5010	2	79	124	\N	\N	19	1
5011	1	86	124	\N	Judy's in a.m.	19	1
5012	35	106	124	\N	\N	19	1
5013	46	112	124	\N	\N	19	1
5014	3	113	124	\N	\N	19	1
5015	9	170	124	\N	\N	19	1
5016	7	171	124	\N	\N	19	1
5017	320	174	124	\N	\N	19	1
5018	1	175	124	\N	\N	19	1
5019	14	176	124	\N	\N	19	1
502	39	69	5	\N	\N	5	\N
5020	36	178	124	\N	\N	19	1
5021	2	181	124	\N	\N	19	1
5022	7	186	124	\N	\N	19	1
5023	85	189	124	\N	\N	19	1
5024	24	191	124	\N	\N	19	1
5025	22	194	124	\N	\N	19	1
5026	15	196	124	\N	\N	19	1
5027	3	204	124	\N	\N	19	1
5028	52	207	124	\N	\N	19	1
5029	8	20	125	\N	\N	19	1
503	6	72	5	\N	\N	5	\N
5030	3	24	125	\N	\N	19	1
5031	54	117	125	\N	\N	19	1
5032	2	132	125	\N	\N	19	1
5033	1	134	125	\N	\N	19	1
5034	1	137	125	\N	\N	19	1
5035	1	151	125	\N	\N	19	1
5036	37	153	125	\N	\N	19	1
5037	1	156	125	\N	\N	19	1
5038	1	161	125	\N	\N	19	1
5039	1	69	125	\N	\N	19	1
504	1	73	5	\N	\N	5	\N
5040	2	76	125	\N	\N	19	1
5041	1	77	125	\N	\N	19	1
5042	8	86	125	\N	\N	19	1
5043	2	171	125	\N	\N	19	1
5044	21	174	125	\N	\N	19	1
5045	2	175	125	\N	\N	19	1
5046	30	176	125	\N	\N	19	1
5047	2	186	125	\N	\N	19	1
5048	25	189	125	\N	\N	19	1
5049	3	194	125	\N	\N	19	1
505	32	76	5	\N	\N	5	\N
5050	10	211	125	\N	\N	19	1
5051	\N	13	125	t	From Steve Rose on 1/2/18	19	1
5052	1	126	126	\N	\N	19	1
5053	1	129	126	\N	NSWO was in Vashon South sector	19	1
5054	0	76	126	\N	Originally reported 1 BAEA heard @ KOMO towers, but almost certainly counted by VN East team during daylight	19	1
5055	10	7	127	\N	\N	19	1
5056	8	18	127	\N	\N	19	1
5057	7	20	127	\N	\N	19	1
5058	1	31	127	\N	\N	19	1
5059	6	39	127	\N	\N	19	1
506	18	79	5	\N	\N	5	\N
5060	18	41	127	\N	\N	19	1
5061	4	131	127	\N	\N	19	1
5062	1	132	127	\N	\N	19	1
5063	2	134	127	\N	\N	19	1
5064	1	135	127	\N	\N	19	1
5065	3	137	127	\N	\N	19	1
5066	3	151	127	\N	\N	19	1
5067	10	153	127	\N	\N	19	1
5068	22	154	127	\N	\N	19	1
5069	56	156	127	\N	\N	19	1
507	2	82	5	\N	\N	5	\N
5070	7	158	127	\N	\N	19	1
5071	1	161	127	\N	\N	19	1
5072	7	164	127	\N	\N	19	1
5073	5	167	127	\N	\N	19	1
5074	2	72	127	\N	\N	19	1
5075	3	79	127	\N	\N	19	1
5076	2	87	127	\N	\N	19	1
5077	2	116	127	\N	\N	19	1
5078	9	170	127	\N	\N	19	1
5079	82	174	127	\N	\N	19	1
508	96	86	5	\N	\N	5	\N
5080	9	175	127	\N	\N	19	1
5081	1	184	127	\N	\N	19	1
5082	45	189	127	\N	\N	19	1
5083	10	191	127	\N	\N	19	1
5084	15	194	127	\N	\N	19	1
5085	8	196	127	\N	\N	19	1
5086	1	204	127	\N	\N	19	1
5087	25	207	127	\N	\N	19	1
5088	7	211	127	\N	\N	19	1
5089	17	7	128	\N	Originally 5, increased to 17 from Howells' list	19	1
509	5	87	5	\N	\N	5	\N
5090	1	17	128	\N	\N	19	1
5091	480	18	128	\N	\N	19	1
5092	70	20	128	\N	\N	19	1
5093	2	28	128	\N	\N	19	1
5094	5	33	128	\N	\N	19	1
5095	60	34	128	\N	\N	19	1
5096	45	35	128	\N	\N	19	1
5097	31	39	128	\N	\N	19	1
5098	44	40	128	\N	\N	19	1
5099	20	41	128	\N	\N	19	1
51	41	99	1	\N	\N	1	\N
510	2	88	5	\N	\N	5	\N
5100	2	43	128	\N	\N	19	1
5101	28	44	128	\N	Originally 2, increased to 28 from Howells' list	19	1
5102	5	45	128	\N	\N	19	1
5103	3	47	128	\N	Originally 1, increased to 3 from Howells' list	19	1
5104	2	53	128	\N	\N	19	1
5105	7	55	128	\N	\N	19	1
5106	5	58	128	\N	\N	19	1
5107	19	59	128	\N	\N	19	1
5108	5	60	128	\N	\N	19	1
5109	2	117	128	\N	\N	19	1
511	9	89	5	\N	\N	5	\N
5110	2	131	128	\N	\N	19	1
5111	1	132	128	\N	\N	19	1
5112	7	137	128	\N	\N	19	1
5113	1	144	128	\N	\N	19	1
5114	2	151	128	\N	\N	19	1
5115	52	153	128	\N	\N	19	1
5116	3	154	128	\N	\N	19	1
5117	10	156	128	\N	\N	19	1
5118	1	161	128	\N	\N	19	1
5119	2	163	128	\N	\N	19	1
512	67	91	5	\N	\N	5	\N
5120	6	164	128	\N	\N	19	1
5121	3	66	128	\N	\N	19	1
5122	1	69	128	\N	\N	19	1
5123	1	76	128	\N	\N	19	1
5124	50	83	128	\N	Originally 1, increased to 50 from Howells' list	19	1
5125	2	92	128	\N	\N	19	1
5126	2	100	128	\N	\N	19	1
5127	7	106	128	\N	\N	19	1
5128	4	112	128	\N	\N	19	1
5129	19	113	128	\N	\N	19	1
513	38	92	5	\N	\N	5	\N
5130	20	116	128	\N	Originally 14, increased to 20 w/ 6 CAGU from Howells' list	19	1
5131	3	170	128	\N	\N	19	1
5132	3	171	128	\N	\N	19	1
5133	49	174	128	\N	\N	19	1
5134	1	175	128	\N	\N	19	1
5135	3	176	128	\N	\N	19	1
5136	3	181	128	\N	\N	19	1
5137	2	186	128	\N	\N	19	1
5138	3	189	128	\N	\N	19	1
5139	3	190	128	\N	\N	19	1
514	1	93	5	\N	\N	5	\N
5140	8	194	128	\N	\N	19	1
5141	2	196	128	\N	\N	19	1
5142	2	199	128	\N	\N	19	1
5143	3	204	128	\N	\N	19	1
5144	8	211	128	\N	\N	19	1
5145	2	17	129	\N	1 m, 1 f	19	1
5146	50	18	129	\N	25 m, 25 f	19	1
5147	54	20	129	\N	27 m, 27 f	19	1
5148	2	39	129	\N	1 m, 1 f	19	1
5149	4	131	129	\N	\N	19	1
515	6	94	5	\N	\N	5	\N
5150	3	137	129	\N	\N	19	1
5151	6	153	129	\N	\N	19	1
5152	1	154	129	\N	\N	19	1
5153	6	158	129	\N	\N	19	1
5154	5	160	129	\N	\N	19	1
5155	2	161	129	\N	\N	19	1
5156	2	76	129	\N	CW 12 riding thermals	19	1
5157	5	79	129	\N	\N	19	1
5158	8	174	129	\N	\N	19	1
5159	25	189	129	\N	\N	19	1
516	2	95	5	\N	\N	5	\N
5160	4	191	129	\N	\N	19	1
5161	3	194	129	\N	\N	19	1
5162	5	196	129	\N	\N	19	1
5163	2	205	129	\N	\N	19	1
5164	5	207	129	\N	\N	19	1
5165	1	5	130	\N	BRAN seen by Ed on ferry, adding boat time & distance for this observation	19	1
5166	9	119	130	\N	\N	19	1
5167	7	131	130	\N	\N	19	1
5168	6	137	130	\N	\N	19	1
5169	16	153	130	\N	\N	19	1
517	4	99	5	\N	\N	5	\N
5170	10	156	130	\N	\N	19	1
5171	11	158	130	\N	\N	19	1
5172	1	164	130	\N	\N	19	1
5173	1	73	130	\N	\N	19	1
5174	2	76	130	\N	\N	19	1
5175	1	79	130	\N	\N	19	1
5176	6	170	130	\N	\N	19	1
5177	2	171	130	\N	\N	19	1
5178	1	173	130	\N	\N	19	1
5179	262	174	130	\N	\N	19	1
518	6	100	5	\N	\N	5	\N
5180	8	181	130	\N	all Myrtle	19	1
5181	7	186	130	\N	\N	19	1
5182	36	189	130	\N	\N	19	1
5183	28	191	130	\N	\N	19	1
5184	1	193	130	\N	\N	19	1
5185	12	194	130	\N	\N	19	1
5186	20	196	130	\N	\N	19	1
5187	11	199	130	\N	\N	19	1
5188	6	204	130	\N	\N	19	1
5189	20	210	130	\N	\N	19	1
519	1	101	5	\N	\N	5	\N
5190	18	211	130	\N	\N	19	1
5191	89	18	131	\N	\N	19	1
5192	9	20	131	\N	\N	19	1
5193	9	34	131	\N	\N	19	1
5194	2	35	131	\N	\N	19	1
5195	11	39	131	\N	\N	19	1
5196	29	40	131	\N	\N	19	1
5197	18	59	131	\N	\N	19	1
5198	2	122	131	\N	Recorded by VNC owl box camera	19	1
5199	6	131	131	\N	\N	19	1
52	11	100	1	\N	\N	1	\N
520	6	103	5	\N	\N	5	\N
5200	2	132	131	\N	\N	19	1
5201	1	135	131	\N	\N	19	1
5202	3	137	131	\N	\N	19	1
5203	1	141	131	\N	\N	19	1
5204	1	151	131	\N	\N	19	1
5205	6	153	131	\N	\N	19	1
5206	1	154	131	\N	\N	19	1
5207	2	156	131	\N	\N	19	1
5208	7	158	131	\N	\N	19	1
5209	1	163	131	\N	\N	19	1
521	4	105	5	\N	\N	5	\N
5210	1	167	131	\N	\N	19	1
5211	6	65	131	\N	\N	19	1
5212	10	66	131	\N	\N	19	1
5213	1	72	131	\N	\N	19	1
5214	3	79	131	\N	\N	19	1
5215	2	87	131	\N	\N	19	1
5216	37	106	131	\N	\N	19	1
5217	10	112	131	\N	\N	19	1
5218	1	170	131	\N	\N	19	1
5219	2	171	131	\N	\N	19	1
522	377	106	5	\N	\N	5	\N
5220	8	174	131	\N	\N	19	1
5221	1	175	131	\N	\N	19	1
5222	15	189	131	\N	\N	19	1
5223	20	191	131	\N	\N	19	1
5224	10	194	131	\N	\N	19	1
5225	6	196	131	\N	\N	19	1
5226	8	204	131	\N	\N	19	1
5227	8	205	131	\N	\N	19	1
5228	\N	172	131	t	Seen by Shannon Kachel at his house on Sylvan Beach Rd	19	1
5229	1	141	132	\N	\N	19	1
523	5	107	5	\N	\N	5	\N
5230	1	153	132	\N	\N	19	1
5231	1	131	133	\N	\N	19	1
5232	1	154	133	\N	\N	19	1
5233	3	158	133	\N	\N	19	1
5234	5	161	133	\N	\N	19	1
5235	4	189	133	\N	\N	19	1
5236	2	194	133	\N	\N	19	1
5237	2	196	133	\N	\N	19	1
5238	1	211	133	\N	\N	19	1
5239	30	117	134	\N	\N	19	1
524	6	109	5	\N	\N	5	\N
5240	6	131	134	\N	\N	19	1
5241	1	135	134	\N	\N	19	1
5242	2	137	134	\N	\N	19	1
5243	2	151	134	\N	\N	19	1
5244	7	153	134	\N	\N	19	1
5245	4	156	134	\N	\N	19	1
5246	3	158	134	\N	\N	19	1
5247	1	161	134	\N	\N	19	1
5248	4	186	134	\N	\N	19	1
5249	40	189	134	\N	\N	19	1
525	546	112	5	\N	\N	5	\N
5250	2	190	134	\N	\N	19	1
5251	4	191	134	\N	\N	19	1
5252	2	194	134	\N	\N	19	1
5253	2	196	134	\N	\N	19	1
5254	7	199	134	\N	\N	19	1
5255	2	204	134	\N	\N	19	1
5256	6	208	134	\N	\N	19	1
5257	\N	140	134	t	\N	19	1
5258	3	131	135	\N	\N	19	1
5259	2	137	135	\N	\N	19	1
526	5	113	5	\N	\N	5	\N
5260	3	151	135	\N	\N	19	1
5261	1	154	135	\N	\N	19	1
5262	4	158	135	\N	\N	19	1
5263	1	161	135	\N	\N	19	1
5264	1	72	135	\N	\N	19	1
5265	16	189	135	\N	\N	19	1
5266	6	194	135	\N	\N	19	1
5267	5	196	135	\N	\N	19	1
5268	2	131	136	\N	\N	19	1
5269	3	137	136	\N	2 m, 1 f	19	1
527	130	116	5	\N	\N	5	\N
5270	2	151	136	\N	\N	19	1
5271	1	156	136	\N	\N	19	1
5272	5	158	136	\N	\N	19	1
5273	1	161	136	\N	1 m	19	1
5274	2	174	136	\N	\N	19	1
5275	10	189	136	\N	\N	19	1
5276	1	190	136	\N	\N	19	1
5277	4	191	136	\N	\N	19	1
5278	3	194	136	\N	\N	19	1
5279	4	196	136	\N	\N	19	1
528	190	117	5	\N	\N	5	\N
5280	4	204	136	\N	2 m, 2 f	19	1
5281	1	207	136	\N	\N	19	1
5282	3	131	137	\N	\N	19	1
5283	1	134	137	\N	\N	19	1
5284	1	137	137	\N	\N	19	1
5285	1	141	137	\N	\N	19	1
5286	2	153	137	\N	\N	19	1
5287	4	158	137	\N	\N	19	1
5288	2	161	137	\N	\N	19	1
5289	1	171	137	\N	\N	19	1
529	6	118	5	\N	\N	5	\N
5290	7	174	137	\N	\N	19	1
5291	2	186	137	\N	\N	19	1
5292	20	189	137	\N	\N	19	1
5293	3	191	137	\N	\N	19	1
5294	2	194	137	\N	\N	19	1
5295	5	196	137	\N	\N	19	1
5296	5	205	137	\N	\N	19	1
5297	2	18	138	\N	1 m, 1 f	19	2
5298	1	39	138	\N	1 f	19	2
5299	2	131	138	\N	\N	19	2
53	49	103	1	\N	\N	1	\N
530	12	120	5	\N	\N	5	\N
5300	1	135	138	\N	\N	19	2
5301	5	153	138	\N	\N	19	2
5302	16	156	138	\N	\N	19	2
5303	10	158	138	\N	\N	19	2
5304	2	160	138	\N	\N	19	2
5305	2	161	138	\N	\N	19	2
5306	1	164	138	\N	\N	19	2
5307	6	170	138	\N	\N	19	2
5308	2	171	138	\N	\N	19	2
5309	22	189	138	\N	\N	19	2
531	1	126	5	\N	\N	5	\N
5310	4	194	138	\N	\N	19	2
5311	6	196	138	\N	\N	19	2
5312	1	204	138	\N	\N	19	2
5313	1	205	138	\N	\N	19	2
5314	49	7	139	\N	\N	19	2
5315	40	18	139	\N	\N	19	2
5316	18	20	139	\N	\N	19	2
5317	1	28	139	\N	\N	19	2
5318	1	39	139	\N	\N	19	2
5319	1	40	139	\N	\N	19	2
532	32	131	5	\N	\N	5	\N
5320	17	131	139	\N	\N	19	2
5321	1	132	139	\N	\N	19	2
5322	2	134	139	\N	\N	19	2
5323	3	135	139	\N	\N	19	2
5324	5	137	139	\N	\N	19	2
5325	1	144	139	\N	\N	19	2
5326	2	149	139	\N	\N	19	2
5327	7	151	139	\N	\N	19	2
5328	59	153	139	\N	\N	19	2
5329	41	154	139	\N	\N	19	2
533	20	132	5	\N	\N	5	\N
5330	47	156	139	\N	\N	19	2
5331	35	158	139	\N	\N	19	2
5332	20	160	139	\N	\N	19	2
5333	7	161	139	\N	\N	19	2
5334	2	163	139	\N	\N	19	2
5335	16	164	139	\N	\N	19	2
5336	3	167	139	\N	\N	19	2
5337	2	69	139	\N	\N	19	2
5338	4	76	139	\N	\N	19	2
5339	1	77	139	\N	\N	19	2
534	20	134	5	\N	\N	5	\N
5340	\N	79	139	t	\N	19	2
5341	4	82	139	\N	\N	19	2
5342	3	86	139	\N	\N	19	2
5343	7	112	139	\N	\N	19	2
5344	37	170	139	\N	\N	19	2
5345	13	171	139	\N	\N	19	2
5346	238	174	139	\N	\N	19	2
5347	4	175	139	\N	\N	19	2
5348	33	176	139	\N	\N	19	2
5349	12	181	139	\N	\N	19	2
535	34	135	5	\N	\N	5	\N
5350	2	186	139	\N	\N	19	2
5351	146	189	139	\N	\N	19	2
5352	6	190	139	\N	\N	19	2
5353	33	191	139	\N	\N	19	2
5354	10	194	139	\N	\N	19	2
5355	\N	195	139	t	\N	19	2
5356	12	196	139	\N	\N	19	2
5357	29	199	139	\N	\N	19	2
5358	62	204	139	\N	\N	19	2
5359	1	205	139	\N	\N	19	2
536	7	136	5	\N	\N	5	\N
5360	4	206	139	\N	\N	19	2
5361	31	207	139	\N	\N	19	2
5362	13	211	139	\N	\N	19	2
5363	13	7	140	\N	\N	19	2
5364	52	18	140	\N	\N	19	2
5365	12	34	140	\N	\N	19	2
5366	5	39	140	\N	\N	19	2
5367	1	40	140	\N	\N	19	2
5368	25	44	140	\N	\N	19	2
5369	30	45	140	\N	\N	19	2
537	80	139	5	\N	\N	5	\N
5370	2	55	140	\N	\N	19	2
5371	2	132	140	\N	\N	19	2
5372	3	137	140	\N	\N	19	2
5373	1	154	140	\N	\N	19	2
5374	2	164	140	\N	\N	19	2
5375	23	66	140	\N	\N	19	2
5376	1	77	140	\N	\N	19	2
5377	2	86	140	\N	\N	19	2
5378	65	106	140	\N	\N	19	2
5379	31	113	140	\N	\N	19	2
538	11	141	5	\N	\N	5	\N
5380	22	174	140	\N	\N	19	2
5381	33	189	140	\N	\N	19	2
5382	6	194	140	\N	\N	19	2
5383	8	34	141	\N	\N	19	2
5384	5	39	141	\N	\N	19	2
5385	6	40	141	\N	\N	19	2
5386	25	45	141	\N	\N	19	2
5387	1	134	141	\N	\N	19	2
5388	2	135	141	\N	\N	19	2
5389	5	137	141	\N	\N	19	2
539	4	143	5	\N	\N	5	\N
5390	1	141	141	\N	\N	19	2
5391	1	144	141	\N	\N	19	2
5392	3	153	141	\N	\N	19	2
5393	7	164	141	\N	\N	19	2
5394	8	66	141	\N	\N	19	2
5395	10	67	141	\N	\N	19	2
5396	1	76	141	\N	\N	19	2
5397	1	77	141	\N	\N	19	2
5398	1	79	141	\N	\N	19	2
5399	1	171	141	\N	\N	19	2
54	41	104	1	\N	\N	1	\N
540	1	144	5	\N	\N	5	\N
5400	48	174	141	\N	\N	19	2
5401	1	175	141	\N	\N	19	2
5402	1	176	141	\N	\N	19	2
5403	5	186	141	\N	\N	19	2
5404	27	189	141	\N	\N	19	2
5405	1	194	141	\N	\N	19	2
5406	7	196	141	\N	\N	19	2
5407	10	7	142	\N	\N	19	2
5408	70	18	142	\N	\N	19	2
5409	15	20	142	\N	\N	19	2
541	3	145	5	\N	\N	5	\N
5410	2	28	142	\N	\N	19	2
5411	7	39	142	\N	\N	19	2
5412	1	40	142	\N	\N	19	2
5413	4	42	142	\N	\N	19	2
5414	2	54	142	\N	\N	19	2
5415	4	59	142	\N	\N	19	2
5416	25	117	142	\N	\N	19	2
5417	3	131	142	\N	\N	19	2
5418	1	132	142	\N	\N	19	2
5419	2	134	142	\N	Originally 1, added 1 from Bianca	19	2
542	6	149	5	\N	\N	5	\N
5420	14	137	142	\N	\N	19	2
5421	2	143	142	\N	1 m, 1 f	19	2
5422	7	151	142	\N	\N	19	2
5423	15	153	142	\N	\N	19	2
5424	2	154	142	\N	\N	19	2
5425	1	156	142	\N	\N	19	2
5426	17	158	142	\N	\N	19	2
5427	5	161	142	\N	\N	19	2
5428	2	163	142	\N	\N	19	2
5429	13	164	142	\N	Originally 12, added 1 from Bianca	19	2
543	168	151	5	\N	\N	5	\N
5430	3	167	142	\N	\N	19	2
5431	12	66	142	\N	\N	19	2
5432	1	67	142	\N	\N	19	2
5433	1	72	142	\N	SSHA from Richard Rogers @ Wax Orchards fields	19	2
5434	5	76	142	\N	\N	19	2
5435	1	77	142	\N	\N	19	2
5436	2	79	142	\N	\N	19	2
5437	1	87	142	\N	\N	19	2
5438	1	106	142	\N	\N	19	2
5439	4	113	142	\N	\N	19	2
544	903	153	5	\N	\N	5	\N
5440	1	116	142	\N	\N	19	2
5441	15	170	142	\N	Originally 10, added 5 from Bianca	19	2
5442	9	171	142	\N	\N	19	2
5443	1	173	142	\N	\N	19	2
5444	376	174	142	\N	Originally 375, added 1 from Bianca	19	2
5445	5	175	142	\N	\N	19	2
5446	20	176	142	\N	\N	19	2
5447	63	178	142	\N	\N	19	2
5448	2	186	142	\N	\N	19	2
5449	60	189	142	\N	\N	19	2
545	16	154	5	\N	\N	5	\N
5450	5	191	142	\N	\N	19	2
5451	15	194	142	\N	Originally 14, added 1 from Bianca	19	2
5452	18	196	142	\N	Originally 14, added 4 from Bianca	19	2
5453	60	207	142	\N	\N	19	2
5454	4	121	142	\N	\N	19	2
5455	1	126	143	\N	Was originally “owl sp.”, changed to BADO after talking w/ Sue	19	2
5456	1	131	143	\N	\N	19	2
5457	2	137	143	\N	\N	19	2
5458	2	151	143	\N	\N	19	2
5459	1	154	143	\N	\N	19	2
546	335	156	5	\N	\N	5	\N
5460	1	156	143	\N	\N	19	2
5461	2	158	143	\N	\N	19	2
5462	2	161	143	\N	\N	19	2
5463	1	164	143	\N	\N	19	2
5464	1	72	143	\N	Was originally NOHA, changed to SSHA after talking w/ Sue	19	2
5465	2	174	143	\N	\N	19	2
5466	2	186	143	\N	\N	19	2
5467	8	189	143	\N	\N	19	2
5468	1	194	143	\N	\N	19	2
5469	4	196	143	\N	\N	19	2
547	423	158	5	\N	\N	5	\N
5470	4	118	144	\N	\N	19	2
5471	1	131	144	\N	\N	19	2
5472	1	137	144	\N	\N	19	2
5473	1	141	144	\N	\N	19	2
5474	1	151	144	\N	\N	19	2
5475	3	153	144	\N	\N	19	2
5476	2	156	144	\N	\N	19	2
5477	2	158	144	\N	\N	19	2
5478	1	161	144	\N	\N	19	2
5479	1	73	144	\N	\N	19	2
548	12	160	5	\N	\N	5	\N
5480	1	175	144	\N	\N	19	2
5481	2	189	144	\N	\N	19	2
5482	5	207	144	\N	\N	19	2
5483	7	20	145	\N	\N	19	2
5484	3	131	146	\N	1 m, 2 f	19	2
5485	2	135	146	\N	1 m, 1 f	19	2
5486	8	158	146	\N	\N	19	2
5487	1	161	146	\N	\N	19	2
5488	5	190	146	\N	\N	19	2
5489	2	191	146	\N	\N	19	2
549	84	161	5	\N	\N	5	\N
5490	3	194	146	\N	\N	19	2
5491	3	196	146	\N	\N	19	2
5492	3	207	146	\N	\N	19	2
5493	1	126	147	\N	\N	19	2
5494	1	131	147	\N	1 m	19	2
5495	2	158	147	\N	\N	19	2
5496	4	164	147	\N	\N	19	2
5497	2	189	147	\N	1 m, 1 f	19	2
5498	2	194	147	\N	\N	19	2
5499	3	196	147	\N	\N	19	2
55	1	105	1	\N	\N	1	\N
550	8	163	5	\N	\N	5	\N
5500	\N	84	148	t	\N	19	2
5501	4	174	149	\N	\N	19	2
5502	3	186	149	\N	\N	19	2
5503	18	189	149	\N	\N	19	2
5504	6	196	149	\N	\N	19	2
5505	29	7	150	\N	\N	20	5
5506	6	17	150	\N	\N	20	5
5507	1330	18	150	\N	\N	20	5
5508	30	20	150	\N	\N	20	5
5509	9	24	150	\N	\N	20	5
551	73	165	5	\N	\N	5	\N
5510	8	33	150	\N	\N	20	5
5511	71	34	150	\N	\N	20	5
5512	24	39	150	\N	\N	20	5
5513	56	40	150	\N	\N	20	5
5514	2	41	150	\N	\N	20	5
5515	4	43	150	\N	\N	20	5
5516	65	44	150	\N	\N	20	5
5517	15	45	150	\N	\N	20	5
5518	1	53	150	\N	\N	20	5
5519	4	54	150	\N	\N	20	5
552	2	166	5	\N	\N	5	\N
5520	24	59	150	\N	\N	20	5
5521	5	60	150	\N	\N	20	5
5522	3	131	150	\N	\N	20	5
5523	6	132	150	\N	\N	20	5
5524	5	137	150	\N	\N	20	5
5525	13	153	150	\N	\N	20	5
5526	2	154	150	\N	\N	20	5
5527	6	156	150	\N	\N	20	5
5528	8	158	150	\N	\N	20	5
5529	5	160	150	\N	\N	20	5
553	36	167	5	\N	\N	5	\N
5530	2	161	150	\N	\N	20	5
5531	1	163	150	\N	\N	20	5
5532	1	164	150	\N	\N	20	5
5533	3	167	150	\N	\N	20	5
5534	76	65	150	\N	\N	20	5
5535	107	66	150	\N	\N	20	5
5536	10	67	150	\N	\N	20	5
5537	5	68	150	\N	\N	20	5
5538	4	69	150	\N	\N	20	5
5539	2	76	150	\N	\N	20	5
554	256	170	5	\N	\N	5	\N
5540	2	86	150	\N	\N	20	5
5541	19	89	150	\N	\N	20	5
5542	4	99	150	\N	\N	20	5
5543	12	100	150	\N	\N	20	5
5544	81	106	150	\N	\N	20	5
5545	7	109	150	\N	\N	20	5
5546	9	111	150	\N	\N	20	5
5547	32	112	150	\N	\N	20	5
5548	15	113	150	\N	\N	20	5
5549	45	116	150	\N	\N	20	5
555	116	171	5	\N	\N	5	\N
5550	3	170	150	\N	\N	20	5
5551	4	171	150	\N	\N	20	5
5552	28	174	150	\N	\N	20	5
5553	5	176	150	\N	\N	20	5
5554	6	186	150	\N	\N	20	5
5555	34	189	150	\N	\N	20	5
5556	2	190	150	\N	\N	20	5
5557	14	191	150	\N	\N	20	5
5558	19	194	150	\N	\N	20	5
5559	13	196	150	\N	\N	20	5
556	19	173	5	\N	\N	5	\N
5560	8	199	150	\N	\N	20	5
5561	3	204	150	\N	\N	20	5
5562	2	208	150	\N	\N	20	5
5563	13	211	150	\N	\N	20	5
5564	2	1	150	\N	\N	20	5
5565	1	6	151	\N	\N	20	5
5566	1	18	151	\N	\N	20	5
5567	2	20	151	\N	\N	20	5
5568	5	34	151	\N	\N	20	5
5569	1	37	151	\N	\N	20	5
557	903	174	5	\N	\N	5	\N
5570	1	40	151	\N	\N	20	5
5571	3	43	151	\N	\N	20	5
5572	1	59	151	\N	\N	20	5
5573	2	117	151	\N	\N	20	5
5574	7	120	151	\N	\N	20	5
5575	5	131	151	\N	\N	20	5
5576	1	134	151	\N	\N	20	5
5577	1	135	151	\N	\N	20	5
5578	7	137	151	\N	\N	20	5
5579	1	141	151	\N	\N	20	5
558	214	175	5	\N	\N	5	\N
5580	1	149	151	\N	\N	20	5
5581	16	151	151	\N	\N	20	5
5582	3	153	151	\N	\N	20	5
5583	2	154	151	\N	\N	20	5
5584	23	156	151	\N	\N	20	5
5585	20	158	151	\N	\N	20	5
5586	12	160	151	\N	\N	20	5
5587	5	161	151	\N	\N	20	5
5588	2	163	151	\N	\N	20	5
5589	5	164	151	\N	\N	20	5
559	555	176	5	\N	\N	5	\N
5590	2	167	151	\N	\N	20	5
5591	9	66	151	\N	\N	20	5
5592	1	72	151	\N	\N	20	5
5593	1	73	151	\N	\N	20	5
5594	1	76	151	\N	\N	20	5
5595	2	79	151	\N	\N	20	5
5596	1	100	151	\N	\N	20	5
5597	5	112	151	\N	\N	20	5
5598	37	170	151	\N	\N	20	5
5599	3	171	151	\N	\N	20	5
56	150	106	1	\N	\N	1	\N
560	1	178	5	\N	\N	5	\N
5600	43	174	151	\N	\N	20	5
5601	14	175	151	\N	\N	20	5
5602	20	176	151	\N	\N	20	5
5603	7	186	151	\N	\N	20	5
5604	88	189	151	\N	\N	20	5
5605	15	191	151	\N	\N	20	5
5606	20	194	151	\N	\N	20	5
5607	10	196	151	\N	\N	20	5
5608	4	199	151	\N	\N	20	5
5609	2	204	151	\N	\N	20	5
561	1	179	5	\N	\N	5	\N
5610	38	205	151	\N	\N	20	5
5611	20	207	151	\N	\N	20	5
5612	2	208	151	\N	\N	20	5
5613	18	7	152	\N	\N	20	6
5614	22	15	152	\N	\N	20	6
5615	3	18	152	\N	\N	20	6
5616	84	20	152	\N	\N	20	6
5617	252	28	152	\N	\N	20	6
5618	3	30	152	\N	\N	20	6
5619	1	34	152	\N	\N	20	6
562	1	183	5	\N	\N	5	\N
5620	38	39	152	\N	\N	20	6
5621	11	40	152	\N	\N	20	6
5622	8	43	152	\N	\N	20	6
5623	1	47	152	\N	\N	20	6
5624	1	58	152	\N	\N	20	6
5625	13	59	152	\N	\N	20	6
5626	11	120	152	\N	\N	20	6
5627	2	131	152	\N	\N	20	6
5628	4	132	152	\N	\N	20	6
5629	1	134	152	\N	\N	20	6
563	5	184	5	\N	\N	5	\N
5630	2	135	152	\N	\N	20	6
5631	5	137	152	\N	\N	20	6
5632	1	141	152	\N	\N	20	6
5633	6	151	152	\N	\N	20	6
5634	17	153	152	\N	\N	20	6
5635	3	154	152	\N	\N	20	6
5636	10	156	152	\N	\N	20	6
5637	5	158	152	\N	\N	20	6
5638	9	161	152	\N	\N	20	6
5639	2	163	152	\N	\N	20	6
564	255	186	5	\N	\N	5	\N
5640	4	164	152	\N	\N	20	6
5641	1	166	152	\N	\N	20	6
5642	7	66	152	\N	\N	20	6
5643	6	69	152	\N	\N	20	6
5644	3	76	152	\N	\N	20	6
5645	3	79	152	\N	\N	20	6
5646	6	86	152	\N	\N	20	6
5647	1	87	152	\N	\N	20	6
5648	2	103	152	\N	\N	20	6
5649	21	106	152	\N	\N	20	6
565	5	188	5	\N	\N	5	\N
5650	6	112	152	\N	\N	20	6
5651	7	113	152	\N	\N	20	6
5652	2	21	152	\N	\N	20	6
5653	25	170	152	\N	\N	20	6
5654	4	171	152	\N	\N	20	6
5655	22	174	152	\N	\N	20	6
5656	1	175	152	\N	\N	20	6
5657	4	176	152	\N	\N	20	6
5658	3	186	152	\N	\N	20	6
5659	38	189	152	\N	\N	20	6
566	1302	189	5	\N	\N	5	\N
5660	22	194	152	\N	\N	20	6
5661	11	196	152	\N	\N	20	6
5662	57	199	152	\N	\N	20	6
5663	5	204	152	\N	\N	20	6
5664	100	207	152	\N	\N	20	6
5665	10	208	152	\N	\N	20	6
5666	1	6	153	\N	\N	20	6
5667	28	7	153	\N	\N	20	6
5668	1	16	153	\N	\N	20	6
5669	17	18	153	\N	\N	20	6
567	7	190	5	\N	\N	5	\N
5670	161	20	153	\N	\N	20	6
5671	13	22	153	\N	\N	20	6
5672	4	23	153	\N	\N	20	6
5673	1	26	153	\N	\N	20	6
5674	45	29	153	\N	\N	20	6
5675	26	30	153	\N	\N	20	6
5676	72	39	153	\N	\N	20	6
5677	16	43	153	\N	\N	20	6
5678	10	44	153	\N	\N	20	6
5679	1	47	153	\N	\N	20	6
568	124	191	5	\N	\N	5	\N
5680	35	58	153	\N	\N	20	6
5681	\N	118	153	t	\N	20	6
5682	1	131	153	\N	\N	20	6
5683	5	132	153	\N	\N	20	6
5684	1	136	153	\N	\N	20	6
5685	3	137	153	\N	\N	20	6
5686	2	149	153	\N	\N	20	6
5687	6	151	153	\N	\N	20	6
5688	17	153	153	\N	\N	20	6
5689	3	154	153	\N	\N	20	6
569	1	193	5	\N	\N	5	\N
5690	12	156	153	\N	\N	20	6
5691	2	158	153	\N	\N	20	6
5692	1	161	153	\N	\N	20	6
5693	1	163	153	\N	\N	20	6
5694	3	167	153	\N	\N	20	6
5695	21	66	153	\N	\N	20	6
5696	2	69	153	\N	\N	20	6
5697	1	73	153	\N	\N	20	6
5698	2	76	153	\N	\N	20	6
5699	145	83	153	\N	\N	20	6
57	12	108	1	\N	\N	1	\N
570	882	194	5	\N	\N	5	\N
5700	2	86	153	\N	\N	20	6
5701	6	112	153	\N	\N	20	6
5702	1	21	153	\N	\N	20	6
5703	2	170	153	\N	\N	20	6
5704	49	174	153	\N	\N	20	6
5705	15	176	153	\N	\N	20	6
5706	4	186	153	\N	\N	20	6
5707	25	189	153	\N	\N	20	6
5708	5	190	153	\N	\N	20	6
5709	4	194	153	\N	\N	20	6
571	576	196	5	\N	\N	5	\N
5710	3	196	153	\N	\N	20	6
5711	2	199	153	\N	\N	20	6
5712	2	205	153	\N	\N	20	6
5713	40	207	153	\N	\N	20	6
5714	18	208	153	\N	\N	20	6
5715	4	20	154	\N	\N	20	6
5716	1	124	154	\N	\N	20	6
5717	3	126	154	\N	\N	20	6
5718	1	129	154	\N	\N	20	6
5719	1	154	154	\N	\N	20	6
572	61	199	5	\N	\N	5	\N
5720	1	82	154	\N	\N	20	6
5721	4	86	154	\N	\N	20	6
5722	4	95	154	\N	\N	20	6
5723	10	174	154	\N	\N	20	6
5724	1	186	154	\N	\N	20	6
5725	4	194	154	\N	\N	20	6
5726	1	125	154	\N	\N	20	6
5727	2	120	155	\N	\N	20	6
5728	1	135	155	\N	\N	20	6
5729	2	136	155	\N	\N	20	6
573	10	201	5	\N	\N	5	\N
5730	2	137	155	\N	\N	20	6
5731	2	141	155	\N	\N	20	6
5732	50	153	155	\N	\N	20	6
5733	10	156	155	\N	\N	20	6
5734	36	174	155	\N	\N	20	6
5735	3	186	155	\N	\N	20	6
5736	54	189	155	\N	\N	20	6
5737	7	194	155	\N	\N	20	6
5738	5	7	156	\N	\N	20	6
5739	4	16	156	\N	\N	20	6
574	364	204	5	\N	\N	5	\N
5740	20	18	156	\N	\N	20	6
5741	43	20	156	\N	\N	20	6
5742	4	22	156	\N	\N	20	6
5743	12	24	156	\N	\N	20	6
5744	4	39	156	\N	\N	20	6
5745	4	43	156	\N	\N	20	6
5746	1	119	156	\N	\N	20	6
5747	1	120	156	\N	\N	20	6
5748	4	131	156	\N	\N	20	6
5749	1	132	156	\N	\N	20	6
575	24	205	5	\N	\N	5	\N
5750	1	134	156	\N	\N	20	6
5751	6	137	156	\N	\N	20	6
5752	1	141	156	\N	\N	20	6
5753	1	149	156	\N	\N	20	6
5754	6	151	156	\N	\N	20	6
5755	6	153	156	\N	\N	20	6
5756	2	154	156	\N	\N	20	6
5757	22	156	156	\N	\N	20	6
5758	2	158	156	\N	\N	20	6
5759	2	163	156	\N	\N	20	6
576	43	206	5	\N	\N	5	\N
5760	2	166	156	\N	\N	20	6
5761	3	167	156	\N	\N	20	6
5762	1	69	156	\N	\N	20	6
5763	1	73	156	\N	\N	20	6
5764	4	76	156	\N	\N	20	6
5765	5	79	156	\N	\N	20	6
5766	1	82	156	\N	\N	20	6
5767	3	95	156	\N	\N	20	6
5768	5	112	156	\N	\N	20	6
5769	4	170	156	\N	\N	20	6
577	454	207	5	\N	\N	5	\N
5770	3	171	156	\N	\N	20	6
5771	63	174	156	\N	\N	20	6
5772	117	176	156	\N	\N	20	6
5773	10	186	156	\N	\N	20	6
5774	66	189	156	\N	\N	20	6
5775	3	190	156	\N	\N	20	6
5776	18	191	156	\N	\N	20	6
5777	31	194	156	\N	\N	20	6
5778	17	196	156	\N	\N	20	6
5779	64	199	156	\N	\N	20	6
578	65	208	5	\N	\N	5	\N
5780	6	201	156	\N	\N	20	6
5781	40	203	156	\N	\N	20	6
5782	1	204	156	\N	\N	20	6
5783	100	207	156	\N	\N	20	6
5784	19	208	156	\N	\N	20	6
5785	4	211	156	\N	\N	20	6
5786	2	7	157	\N	\N	20	3
5787	2	33	157	\N	\N	20	3
5788	13	34	157	\N	\N	20	3
5789	50	39	157	\N	\N	20	3
579	182	211	5	\N	\N	5	\N
5790	55	40	157	\N	\N	20	3
5791	1	41	157	\N	\N	20	3
5792	80	44	157	\N	\N	20	3
5793	20	45	157	\N	\N	20	3
5794	2	53	157	\N	\N	20	3
5795	8	54	157	\N	\N	20	3
5796	31	59	157	\N	\N	20	3
5797	4	60	157	\N	\N	20	3
5798	17	131	157	\N	\N	20	3
5799	3	135	157	\N	\N	20	3
58	20	109	1	\N	\N	1	\N
580	357	7	6	\N	\N	6	\N
5800	11	137	157	\N	\N	20	3
5801	2	141	157	\N	\N	20	3
5802	1	144	157	\N	\N	20	3
5803	1	145	157	\N	\N	20	3
5804	\N	149	157	t	\N	20	3
5805	5	151	157	\N	\N	20	3
5806	47	153	157	\N	\N	20	3
5807	2	154	157	\N	\N	20	3
5808	9	156	157	\N	\N	20	3
5809	20	158	157	\N	\N	20	3
581	88	15	6	\N	\N	6	\N
5810	12	160	157	\N	\N	20	3
5811	2	161	157	\N	\N	20	3
5812	2	163	157	\N	\N	20	3
5813	5	164	157	\N	\N	20	3
5814	4	167	157	\N	\N	20	3
5815	8	65	157	\N	\N	20	3
5816	12	66	157	\N	\N	20	3
5817	1	72	157	\N	\N	20	3
5818	1	73	157	\N	\N	20	3
5819	4	76	157	\N	Removed 1 adult BAEA recorded in eBird, as was very likely seen at other location(s)	20	3
582	13	17	6	\N	\N	6	\N
5820	3	77	157	\N	\N	20	3
5821	1	79	157	\N	\N	20	3
5822	3	87	157	\N	\N	20	3
5823	1	99	157	\N	\N	20	3
5824	2	100	157	\N	\N	20	3
5825	13	103	157	\N	\N	20	3
5826	12	106	157	\N	\N	20	3
5827	2	109	157	\N	\N	20	3
5828	3	112	157	\N	\N	20	3
5829	28	113	157	\N	\N	20	3
583	3078	18	6	\N	\N	6	\N
5830	9	170	157	\N	\N	20	3
5831	16	171	157	\N	\N	20	3
5832	213	174	157	\N	\N	20	3
5833	3	175	157	\N	\N	20	3
5834	9	176	157	\N	\N	20	3
5835	43	178	157	\N	\N	20	3
5836	\N	179	157	t	\N	20	3
5837	12	181	157	\N	\N	20	3
5838	10	186	157	\N	\N	20	3
5839	33	189	157	\N	\N	20	3
584	587	20	6	\N	\N	6	\N
5840	21	191	157	\N	\N	20	3
5841	41	194	157	\N	\N	20	3
5842	15	196	157	\N	\N	20	3
5843	20	204	157	\N	\N	20	3
5844	1	207	157	\N	\N	20	3
5845	16	208	157	\N	\N	20	3
5846	1	172	157	\N	\N	20	3
5847	79	7	158	\N	\N	20	3
5848	15	18	158	\N	\N	20	3
5849	15	20	158	\N	\N	20	3
585	14	22	6	\N	\N	6	\N
5850	8	34	158	\N	\N	20	3
5851	11	39	158	\N	\N	20	3
5852	4	45	158	\N	\N	20	3
5853	5	59	158	\N	\N	20	3
5854	1	60	158	\N	\N	20	3
5855	8	131	158	\N	\N	20	3
5856	2	134	158	\N	\N	20	3
5857	2	135	158	\N	\N	20	3
5858	1	136	158	\N	\N	20	3
5859	18	137	158	\N	\N	20	3
586	6	23	6	\N	\N	6	\N
5860	1	141	158	\N	\N	20	3
5861	4	151	158	\N	\N	20	3
5862	23	153	158	\N	\N	20	3
5863	1	154	158	\N	\N	20	3
5864	24	156	158	\N	\N	20	3
5865	15	158	158	\N	\N	20	3
5866	1	160	158	\N	\N	20	3
5867	5	161	158	\N	\N	20	3
5868	2	167	158	\N	\N	20	3
5869	1	168	158	\N	\N	20	3
587	18	24	6	\N	\N	6	\N
5870	2	69	158	\N	\N	20	3
5871	1	73	158	\N	\N	20	3
5872	1	75	158	\N	\N	20	3
5873	2	76	158	\N	\N	20	3
5874	1	77	158	\N	\N	20	3
5875	1	79	158	\N	\N	20	3
5876	2	112	158	\N	\N	20	3
5877	4	113	158	\N	\N	20	3
5878	11	116	158	\N	\N	20	3
5879	3	170	158	\N	\N	20	3
588	1	26	6	\N	\N	6	\N
5880	8	171	158	\N	\N	20	3
5881	139	174	158	\N	\N	20	3
5882	6	175	158	\N	\N	20	3
5883	13	176	158	\N	\N	20	3
5884	10	181	158	\N	\N	20	3
5885	5	186	158	\N	\N	20	3
5886	90	189	158	\N	\N	20	3
5887	10	190	158	\N	\N	20	3
5888	5	191	158	\N	\N	20	3
5889	29	194	158	\N	\N	20	3
589	27	28	6	\N	\N	6	\N
5890	12	196	158	\N	\N	20	3
5891	1	204	158	\N	\N	20	3
5892	1	205	158	\N	\N	20	3
5893	73	207	158	\N	\N	20	3
5894	3	208	158	\N	\N	20	3
5895	7	211	158	\N	\N	20	3
5896	21	7	159	\N	\N	20	3
5897	3	17	159	\N	\N	20	3
5898	520	18	159	\N	\N	20	3
5899	5	20	159	\N	\N	20	3
59	25	111	1	\N	\N	1	\N
590	146	29	6	\N	\N	6	\N
5900	12	29	159	\N	\N	20	3
5901	12	34	159	\N	\N	20	3
5902	1	35	159	\N	\N	20	3
5903	44	39	159	\N	\N	20	3
5904	3	41	159	\N	\N	20	3
5905	1	43	159	\N	\N	20	3
5906	9	44	159	\N	\N	20	3
5907	13	45	159	\N	\N	20	3
5908	3	55	159	\N	\N	20	3
5909	66	59	159	\N	\N	20	3
591	5	30	6	\N	\N	6	\N
5910	2	60	159	\N	\N	20	3
5911	24	117	159	\N	\N	20	3
5912	5	119	159	\N	\N	20	3
5913	11	131	159	\N	\N	20	3
5914	1	132	159	\N	\N	20	3
5915	1	134	159	\N	\N	20	3
5916	2	135	159	\N	\N	20	3
5917	7	137	159	\N	\N	20	3
5918	72	153	159	\N	\N	20	3
5919	1	154	159	\N	\N	20	3
592	\N	33	6	t	\N	6	\N
5920	12	156	159	\N	\N	20	3
5921	6	158	159	\N	\N	20	3
5922	5	160	159	\N	\N	20	3
5923	2	161	159	\N	\N	20	3
5924	2	164	159	\N	\N	20	3
5925	24	66	159	\N	\N	20	3
5926	1	69	159	\N	\N	20	3
5927	1	73	159	\N	\N	20	3
5928	10	76	159	\N	\N	20	3
5929	2	79	159	\N	\N	20	3
593	654	34	6	\N	\N	6	\N
5930	\N	88	159	t	\N	20	3
5931	\N	105	159	t	\N	20	3
5932	31	106	159	\N	\N	20	3
5933	1	109	159	\N	\N	20	3
5934	2	112	159	\N	\N	20	3
5935	1	113	159	\N	\N	20	3
5936	1	170	159	\N	\N	20	3
5937	6	171	159	\N	\N	20	3
5938	66	174	159	\N	\N	20	3
5939	1	176	159	\N	\N	20	3
594	443	35	6	\N	\N	6	\N
5940	4	181	159	\N	\N	20	3
5941	6	186	159	\N	\N	20	3
5942	20	189	159	\N	\N	20	3
5943	4	191	159	\N	\N	20	3
5944	16	194	159	\N	\N	20	3
5945	8	196	159	\N	\N	20	3
5946	4	204	159	\N	\N	20	3
5947	45	208	159	\N	\N	20	3
5948	4	211	159	\N	\N	20	3
5949	3	131	160	\N	\N	20	3
595	25	36	6	\N	\N	6	\N
5950	1	135	160	\N	1 female	20	3
5951	\N	137	160	t	\N	20	3
5952	1	151	160	\N	\N	20	3
5953	1	153	160	\N	\N	20	3
5954	2	156	160	\N	\N	20	3
5955	1	158	160	\N	\N	20	3
5956	\N	161	160	t	\N	20	3
5957	4	174	160	\N	\N	20	3
5958	9	189	160	\N	\N	20	3
5959	3	191	160	\N	\N	20	3
596	450	39	6	\N	\N	6	\N
5960	1	194	160	\N	\N	20	3
5961	2	196	160	\N	\N	20	3
5962	3	204	160	\N	\N	20	3
5963	4	207	160	\N	\N	20	3
5964	7	208	160	\N	\N	20	3
5965	2	131	161	\N	\N	20	3
5966	1	137	161	\N	\N	20	3
5967	1	151	161	\N	\N	20	3
5968	2	153	161	\N	\N	20	3
5969	2	156	161	\N	\N	20	3
597	158	40	6	\N	\N	6	\N
5970	7	158	161	\N	\N	20	3
5971	2	161	161	\N	\N	20	3
5972	2	163	161	\N	\N	20	3
5973	1	164	161	\N	\N	20	3
5974	1	76	161	\N	\N	20	3
5975	1	186	161	\N	\N	20	3
5976	3	189	161	\N	1 F, 2 M	20	3
5977	1	194	161	\N	\N	20	3
5978	4	196	161	\N	\N	20	3
5979	21	131	162	\N	\N	20	3
598	118	41	6	\N	\N	6	\N
5980	2	131	163	\N	\N	20	3
5981	2	137	163	\N	\N	20	3
5982	4	154	163	\N	\N	20	3
5983	7	156	163	\N	\N	20	3
5984	11	158	163	\N	\N	20	3
5985	4	160	163	\N	\N	20	3
5986	6	161	163	\N	\N	20	3
5987	3	170	163	\N	\N	20	3
5988	6	174	163	\N	\N	20	3
5989	4	175	163	\N	\N	20	3
599	3	42	6	\N	\N	6	\N
5990	1	186	163	\N	\N	20	3
5991	6	189	163	\N	\N	20	3
5992	7	194	163	\N	\N	20	3
5993	6	196	163	\N	\N	20	3
5994	135	7	164	\N	\N	20	7
5995	8	15	164	\N	\N	20	7
5996	2	17	164	\N	\N	20	7
5997	144	18	164	\N	\N	20	7
5998	199	20	164	\N	\N	20	7
5999	38	23	164	\N	\N	20	7
6	870	20	1	\N	\N	1	\N
60	696	112	1	\N	\N	1	\N
600	17	43	6	\N	\N	6	\N
6000	50	24	164	\N	\N	20	7
6001	60	29	164	\N	\N	20	7
6002	35	30	164	\N	\N	20	7
6003	390	34	164	\N	\N	20	7
6004	4	36	164	\N	\N	20	7
6005	98	39	164	\N	\N	20	7
6006	82	40	164	\N	\N	20	7
6007	32	41	164	\N	\N	20	7
6008	22	43	164	\N	\N	20	7
6009	2	44	164	\N	\N	20	7
601	545	44	6	\N	\N	6	\N
6010	73	45	164	\N	\N	20	7
6011	2	58	164	\N	\N	20	7
6012	39	59	164	\N	\N	20	7
6013	1	60	164	\N	\N	20	7
6014	44	117	164	\N	\N	20	7
6015	1	118	164	\N	\N	20	7
6016	28	119	164	\N	\N	20	7
6017	10	120	164	\N	\N	20	7
6018	29	131	164	\N	\N	20	7
6019	8	132	164	\N	\N	20	7
602	79	45	6	\N	\N	6	\N
6020	5	134	164	\N	\N	20	7
6021	8	135	164	\N	\N	20	7
6022	3	136	164	\N	\N	20	7
6023	43	137	164	\N	\N	20	7
6024	9	141	164	\N	\N	20	7
6025	1	143	164	\N	\N	20	7
6026	12	149	164	\N	\N	20	7
6027	40	151	164	\N	\N	20	7
6028	4	152	164	\N	\N	20	7
6029	229	153	164	\N	\N	20	7
603	4	47	6	\N	\N	6	\N
6030	8	154	164	\N	\N	20	7
6031	83	156	164	\N	\N	20	7
6032	77	158	164	\N	\N	20	7
6033	33	160	164	\N	\N	20	7
6034	52	161	164	\N	\N	20	7
6035	4	163	164	\N	\N	20	7
6036	61	164	164	\N	\N	20	7
6037	20	167	164	\N	\N	20	7
6038	27	62	164	\N	\N	20	7
6039	22	66	164	\N	\N	20	7
604	11	51	6	\N	\N	6	\N
6040	3	67	164	\N	\N	20	7
6041	3	69	164	\N	\N	20	7
6042	2	72	164	\N	\N	20	7
6043	3	73	164	\N	\N	20	7
6044	10	76	164	\N	\N	20	7
6045	4	77	164	\N	\N	20	7
6046	6	79	164	\N	\N	20	7
6047	8	86	164	\N	\N	20	7
6048	35	92	164	\N	\N	20	7
6049	1	95	164	\N	\N	20	7
605	6	53	6	\N	\N	6	\N
6050	1	100	164	\N	\N	20	7
6051	12	103	164	\N	\N	20	7
6052	103	106	164	\N	\N	20	7
6053	44	107	164	\N	\N	20	7
6054	58	112	164	\N	\N	20	7
6055	20	113	164	\N	\N	20	7
6056	30	116	164	\N	\N	20	7
6057	170	170	164	\N	\N	20	7
6058	40	171	164	\N	\N	20	7
6059	1	173	164	\N	\N	20	7
606	2	54	6	\N	\N	6	\N
6060	284	174	164	\N	\N	20	7
6061	23	175	164	\N	\N	20	7
6062	77	176	164	\N	\N	20	7
6063	1	181	164	\N	\N	20	7
6064	4	184	164	\N	\N	20	7
6065	34	186	164	\N	\N	20	7
6066	376	189	164	\N	\N	20	7
6067	3	190	164	\N	\N	20	7
6068	36	191	164	\N	\N	20	7
6069	1	193	164	\N	\N	20	7
607	8	55	6	\N	\N	6	\N
6070	170	194	164	\N	\N	20	7
6071	126	196	164	\N	\N	20	7
6072	31	204	164	\N	\N	20	7
6073	9	205	164	\N	\N	20	7
6074	165	207	164	\N	\N	20	7
6075	38	208	164	\N	\N	20	7
6076	17	211	164	\N	\N	20	7
6077	1	124	165	\N	calling at one a.m. from very close by	20	7
6078	2	134	165	\N	one at feeder, one in tree	20	7
6079	\N	135	165	t	\N	20	7
608	19	58	6	\N	\N	6	\N
6080	\N	136	165	t	\N	20	7
6081	2	141	165	\N	1m, 1f	20	7
6082	2	154	165	\N	flying over and calling	20	7
6083	6	156	165	\N	\N	20	7
6084	6	158	165	\N	\N	20	7
6085	3	160	165	\N	\N	20	7
6086	2	161	165	\N	1m, 1f	20	7
6087	1	163	165	\N	in a tree	20	7
6088	2	167	165	\N	Pacific coastal ssp	20	7
6089	5	174	165	\N	in yard	20	7
609	172	59	6	\N	\N	6	\N
6090	2	175	165	\N	both f	20	7
6091	\N	184	165	t	\N	20	7
6092	1	186	165	\N	sooty	20	7
6093	22	189	165	\N	Oregon, and an even mix of m/f	20	7
6094	\N	193	165	t	\N	20	7
6095	3	194	165	\N	\N	20	7
6096	4	196	165	\N	2m, 2f	20	7
6097	2	140	165	\N	both f and both intergrade with red shafts and red nape	20	7
6098	21	7	166	\N	\N	20	4
6099	1	17	166	\N	\N	20	4
61	20	113	1	\N	\N	1	\N
610	32	60	6	\N	\N	6	\N
6100	131	18	166	\N	\N	20	4
6101	32	20	166	\N	\N	20	4
6102	32	29	166	\N	\N	20	4
6103	403	34	166	\N	\N	20	4
6104	226	35	166	\N	\N	20	4
6105	5	36	166	\N	\N	20	4
6106	292	39	166	\N	\N	20	4
6107	546	40	166	\N	\N	20	4
6108	155	41	166	\N	\N	20	4
6109	2	43	166	\N	\N	20	4
611	16	61	6	\N	\N	6	\N
6110	181	44	166	\N	\N	20	4
6111	108	45	166	\N	\N	20	4
6112	5	53	166	\N	\N	20	4
6113	1	54	166	\N	\N	20	4
6114	3	55	166	\N	\N	20	4
6115	150	59	166	\N	\N	20	4
6116	2	60	166	\N	\N	20	4
6117	1	117	166	\N	\N	20	4
6118	5	132	166	\N	\N	20	4
6119	1	145	166	\N	Peregrine on Vashon side near mouth of harbor	20	4
612	416	62	6	\N	\N	6	\N
6120	75	65	166	\N	\N	20	4
6121	33	66	166	\N	\N	20	4
6122	6	67	166	\N	\N	20	4
6123	1	69	166	\N	\N	20	4
6124	1	73	166	\N	immature at Jensen Pt.	20	4
6125	1	79	166	\N	near Portgage	20	4
6126	2	87	166	\N	 one on north shorebetween Judd Creek and Burton, one by Mileta Creek	20	4
6127	2	99	166	\N	\N	20	4
6128	10	100	166	\N	\N	20	4
6129	17	103	166	\N	\N	20	4
613	42	65	6	\N	\N	6	\N
6130	42	106	166	\N	\N	20	4
6131	3	109	166	\N	\N	20	4
6132	56	112	166	\N	\N	20	4
6133	11	113	166	\N	\N	20	4
6134	1	4	166	\N	low flyover, calling, by Burton	20	4
6135	1	3	166	\N	1 Greylag X Barnacle? Domestic hybrid with Canada Geese on Quartermaster	20	4
6136	2	15	167	\N	\N	20	1
6137	38	20	167	\N	\N	20	1
6138	2	24	167	\N	\N	20	1
6139	8	28	167	\N	\N	20	1
614	442	66	6	\N	\N	6	\N
6140	1	33	167	\N	\N	20	1
6141	8	34	167	\N	\N	20	1
6142	21	39	167	\N	\N	20	1
6143	1	42	167	\N	\N	20	1
6144	3	43	167	\N	\N	20	1
6145	3	45	167	\N	\N	20	1
6146	2	55	167	\N	\N	20	1
6147	14	59	167	\N	\N	20	1
6148	4	117	167	\N	\N	20	1
6149	1	119	167	\N	\N	20	1
615	6	67	6	\N	\N	6	\N
6150	4	132	167	\N	\N	20	1
6151	1	135	167	\N	\N	20	1
6152	1	137	167	\N	\N	20	1
6153	8	153	167	\N	\N	20	1
6154	1	154	167	\N	\N	20	1
6155	10	158	167	\N	\N	20	1
6156	5	161	167	\N	\N	20	1
6157	1	164	167	\N	\N	20	1
6158	27	65	167	\N	\N	20	1
6159	4	66	167	\N	\N	20	1
616	26	69	6	\N	\N	6	\N
6160	9	67	167	\N	\N	20	1
6161	1	69	167	\N	\N	20	1
6162	1	73	167	\N	\N	20	1
6163	1	76	167	\N	\N	20	1
6164	4	95	167	\N	\N	20	1
6165	1	100	167	\N	\N	20	1
6166	25	112	167	\N	\N	20	1
6167	1	170	167	\N	\N	20	1
6168	2	171	167	\N	\N	20	1
6169	13	174	167	\N	\N	20	1
617	3	72	6	\N	\N	6	\N
6170	3	175	167	\N	\N	20	1
6171	25	176	167	\N	\N	20	1
6172	2	189	167	\N	\N	20	1
6173	10	194	167	\N	\N	20	1
6174	4	196	167	\N	\N	20	1
6175	38	7	168	\N	\N	20	1
6176	2	13	168	\N	\N	20	1
6177	5	33	168	\N	\N	20	1
6178	9	34	168	\N	\N	20	1
6179	11	39	168	\N	\N	20	1
618	2	73	6	\N	\N	6	\N
6180	7	40	168	\N	\N	20	1
6181	4	43	168	\N	\N	20	1
6182	15	45	168	\N	\N	20	1
6183	2	54	168	\N	\N	20	1
6184	8	55	168	\N	\N	20	1
6185	49	59	168	\N	\N	20	1
6186	16	60	168	\N	\N	20	1
6187	8	117	168	\N	\N	20	1
6188	9	131	168	\N	\N	20	1
6189	1	135	168	\N	\N	20	1
619	1	75	6	\N	\N	6	\N
6190	12	137	168	\N	\N	20	1
6191	1	141	168	\N	\N	20	1
6192	1	149	168	\N	\N	20	1
6193	4	151	168	\N	\N	20	1
6194	59	153	168	\N	\N	20	1
6195	3	154	168	\N	\N	20	1
6196	6	156	168	\N	\N	20	1
6197	62	158	168	\N	\N	20	1
6198	11	161	168	\N	\N	20	1
6199	1	163	168	\N	\N	20	1
62	302	116	1	\N	\N	1	\N
620	23	76	6	\N	\N	6	\N
6200	12	164	168	\N	\N	20	1
6201	5	167	168	\N	\N	20	1
6202	8	66	168	\N	\N	20	1
6203	1	69	168	\N	\N	20	1
6204	7	76	168	\N	\N	20	1
6205	3	77	168	\N	\N	20	1
6206	3	79	168	\N	\N	20	1
6207	1	86	168	\N	\N	20	1
6208	1	87	168	\N	\N	20	1
6209	2	100	168	\N	\N	20	1
621	19	79	6	\N	\N	6	\N
6210	18	106	168	\N	\N	20	1
6211	2	107	168	\N	\N	20	1
6212	14	112	168	\N	Originally 6, added 8 WEGU/GWGU	20	1
6213	15	113	168	\N	Originally 6, added 9 WEGU/GWGU	20	1
6214	6	116	168	\N	\N	20	1
6215	46	170	168	\N	\N	20	1
6216	28	171	168	\N	\N	20	1
6217	198	174	168	\N	\N	20	1
6218	8	175	168	\N	\N	20	1
6219	6	176	168	\N	\N	20	1
622	5	82	6	\N	\N	6	\N
6220	12	181	168	\N	\N	20	1
6221	1	186	168	\N	\N	20	1
6222	58	189	168	\N	\N	20	1
6223	6	191	168	\N	\N	20	1
6224	53	194	168	\N	\N	20	1
6225	12	196	168	\N	\N	20	1
6226	6	204	168	\N	\N	20	1
6227	38	207	168	\N	\N	20	1
6228	4	208	168	\N	\N	20	1
6229	11	20	169	\N	\N	20	1
623	14	83	6	\N	\N	6	\N
6230	3	24	169	\N	\N	20	1
6231	10	153	169	\N	\N	20	1
6232	2	69	169	\N	\N	20	1
6233	3	76	169	\N	\N	20	1
6234	8	86	169	\N	\N	20	1
6235	2	112	169	\N	\N	20	1
6236	3	113	169	\N	\N	20	1
6237	3	211	169	\N	\N	20	1
6238	1	122	170	\N	Heard to northwest from Old Mill Rd south of 236th St – in Vashon South sector	20	1
6239	8	126	170	\N	1 seen on 244th St east of 59th Ave, 1 heard to south from Westside Hwy north of 121st Ave, 3 pairs responded to playback at entrance to Judd Creek Loop Trail, at Fisher Pond parking lot, and at Burma Rd when playing for NSWO – 1 in Maury/Tramp sector, 2 in Vashon South sector	20	1
624	59	86	6	\N	\N	6	\N
6240	1	129	170	\N	Responded to playback at Burma Rd	20	1
6241	5	7	171	\N	\N	20	1
6242	2	20	171	\N	\N	20	1
6243	9	37	171	\N	\N	20	1
6244	1	39	171	\N	\N	20	1
6245	3	43	171	\N	\N	20	1
6246	1	58	171	\N	\N	20	1
6247	15	131	171	\N	2 from Bottoms feeder	20	1
6248	1	132	171	\N	\N	20	1
6249	1	134	171	\N	\N	20	1
625	5	87	6	\N	\N	6	\N
6250	1	135	171	\N	\N	20	1
6251	5	137	171	\N	\N	20	1
6252	2	151	171	\N	\N	20	1
6253	34	153	171	\N	\N	20	1
6254	30	154	171	\N	\N	20	1
6255	21	156	171	\N	2 from Bottoms feeder	20	1
6256	20	158	171	\N	2 from Bottoms feeder	20	1
6257	19	160	171	\N	\N	20	1
6258	9	161	171	\N	2 from Bottoms feeder	20	1
6259	2	163	171	\N	\N	20	1
626	3	88	6	\N	\N	6	\N
6260	10	164	171	\N	\N	20	1
6261	2	167	171	\N	\N	20	1
6262	1	67	171	\N	\N	20	1
6263	1	76	171	\N	\N	20	1
6264	2	77	171	\N	\N	20	1
6265	3	79	171	\N	\N	20	1
6266	2	116	171	\N	\N	20	1
6267	3	170	171	\N	2 originally noted as “kinglet sp.”	20	1
6268	2	171	171	\N	\N	20	1
6269	147	174	171	\N	\N	20	1
627	43	89	6	\N	\N	6	\N
6270	7	175	171	\N	\N	20	1
6271	12	176	171	\N	\N	20	1
6272	1	186	171	\N	1 from Bottoms feeder	20	1
6273	67	189	171	\N	5 from Bottoms feeder	20	1
6274	8	191	171	\N	\N	20	1
6275	33	194	171	\N	3 from Bottoms feeder	20	1
6276	15	196	171	\N	3 from Bottoms feeder	20	1
6277	1	199	171	\N	\N	20	1
6278	2	204	171	\N	1 from Bottoms feeder	20	1
6279	5	205	171	\N	5 from Bottoms feeder	20	1
628	5	90	6	\N	\N	6	\N
6280	4	206	171	\N	\N	20	1
6281	26	207	171	\N	\N	20	1
6282	1	208	171	\N	\N	20	1
6283	8	211	171	\N	\N	20	1
6284	80	18	172	\N	\N	20	1
6285	70	20	172	\N	\N	20	1
6286	6	33	172	\N	\N	20	1
6287	70	34	172	\N	\N	20	1
6288	12	35	172	\N	\N	20	1
6289	18	39	172	\N	\N	20	1
629	39	91	6	\N	\N	6	\N
6290	43	40	172	\N	\N	20	1
6291	15	41	172	\N	\N	20	1
6292	35	44	172	\N	\N	20	1
6293	11	45	172	\N	\N	20	1
6294	32	47	172	\N	\N	20	1
6295	1	53	172	\N	\N	20	1
6296	6	55	172	\N	\N	20	1
6297	2	58	172	\N	\N	20	1
6298	21	59	172	\N	\N	20	1
6299	8	60	172	\N	\N	20	1
63	263	117	1	\N	\N	1	\N
630	1	92	6	\N	\N	6	\N
6300	5	117	172	\N	\N	20	1
6301	2	131	172	\N	\N	20	1
6302	1	135	172	\N	\N	20	1
6303	13	137	172	\N	\N	20	1
6304	2	151	172	\N	\N	20	1
6305	37	153	172	\N	\N	20	1
6306	15	156	172	\N	\N	20	1
6307	5	158	172	\N	\N	20	1
6308	1	161	172	\N	\N	20	1
6309	3	163	172	\N	\N	20	1
631	4	95	6	\N	\N	6	\N
6310	2	164	172	\N	\N	20	1
6311	1	166	172	\N	\N	20	1
6312	6	167	172	\N	\N	20	1
6313	2	62	172	\N	\N	20	1
6314	7	66	172	\N	\N	20	1
6315	1	69	172	\N	\N	20	1
6316	1	76	172	\N	\N	20	1
6317	3	83	172	\N	\N	20	1
6318	1	100	172	\N	\N	20	1
6319	1	106	172	\N	\N	20	1
632	1	99	6	\N	\N	6	\N
6320	3	109	172	\N	\N	20	1
6321	7	112	172	\N	\N	20	1
6322	11	113	172	\N	\N	20	1
6323	13	116	172	\N	\N	20	1
6324	19	170	172	\N	\N	20	1
6325	4	171	172	\N	\N	20	1
6326	\N	173	172	t	\N	20	1
6327	13	174	172	\N	\N	20	1
6328	9	176	172	\N	\N	20	1
6329	8	181	172	\N	\N	20	1
633	4	100	6	\N	\N	6	\N
6330	18	189	172	\N	\N	20	1
6331	16	194	172	\N	\N	20	1
6332	1	196	172	\N	\N	20	1
6333	1	199	172	\N	\N	20	1
6334	11	204	172	\N	\N	20	1
6335	10	208	172	\N	\N	20	1
6336	9	211	172	\N	\N	20	1
6337	40	18	173	\N	\N	20	1
6338	23	20	173	\N	\N	20	1
6339	1	39	173	\N	\N	20	1
634	2	101	6	\N	\N	6	\N
6340	\N	126	173	t	\N	20	1
6341	2	131	173	\N	\N	20	1
6342	1	135	173	\N	\N	20	1
6343	2	137	173	\N	\N	20	1
6344	14	151	173	\N	\N	20	1
6345	2	153	173	\N	\N	20	1
6346	2	154	173	\N	\N	20	1
6347	2	156	173	\N	\N	20	1
6348	3	158	173	\N	\N	20	1
6349	1	161	173	\N	\N	20	1
635	5	103	6	\N	\N	6	\N
6350	7	164	173	\N	\N	20	1
6351	1	79	173	\N	\N	20	1
6352	40	174	173	\N	\N	20	1
6353	14	189	173	\N	\N	20	1
6354	10	190	173	\N	\N	20	1
6355	2	191	173	\N	\N	20	1
6356	1	194	173	\N	\N	20	1
6357	7	196	173	\N	\N	20	1
6358	1	205	173	\N	\N	20	1
6359	10	211	173	\N	\N	20	1
636	100	105	6	\N	\N	6	\N
6360	2	117	174	\N	\N	20	1
6361	16	131	174	\N	\N	20	1
6362	8	137	174	\N	\N	20	1
6363	2	141	174	\N	\N	20	1
6364	2	144	174	\N	Merlins: a very dark bird and a light one	20	1
6365	50	153	174	\N	\N	20	1
6366	3	154	174	\N	\N	20	1
6367	26	156	174	\N	\N	20	1
6368	13	158	174	\N	\N	20	1
6369	6	161	174	\N	\N	20	1
637	150	106	6	\N	\N	6	\N
6370	3	167	174	\N	\N	20	1
6371	1	73	174	\N	\N	20	1
6372	3	76	174	\N	\N	20	1
6373	1	77	174	\N	\N	20	1
6374	1	79	174	\N	\N	20	1
6375	1	95	174	\N	\N	20	1
6376	19	170	174	\N	\N	20	1
6377	9	171	174	\N	\N	20	1
6378	493	174	174	\N	365 robins of the total were noted in the half hour or so before dusk heading west	20	1
6379	45	176	174	\N	\N	20	1
638	6	107	6	\N	\N	6	\N
6380	4	178	174	\N	\N	20	1
6381	9	181	174	\N	\N	20	1
6382	12	186	174	\N	\N	20	1
6383	82	189	174	\N	\N	20	1
6384	27	191	174	\N	\N	20	1
6385	1	193	174	\N	\N	20	1
6386	19	194	174	\N	\N	20	1
6387	13	196	174	\N	\N	20	1
6388	8	199	174	\N	\N	20	1
6389	12	204	174	\N	\N	20	1
639	4	109	6	\N	\N	6	\N
6390	4	205	174	\N	\N	20	1
6391	25	207	174	\N	\N	20	1
6392	4	208	174	\N	\N	20	1
6393	19	211	174	\N	\N	20	1
6394	2	20	175	\N	\N	20	1
6395	16	34	175	\N	\N	20	1
6396	9	39	175	\N	\N	20	1
6397	1	40	175	\N	\N	20	1
6398	2	41	175	\N	\N	20	1
6399	2	44	175	\N	\N	20	1
64	4	118	1	\N	\N	1	\N
640	1	110	6	\N	\N	6	\N
6400	7	53	175	\N	\N	20	1
6401	1	55	175	\N	\N	20	1
6402	13	59	175	\N	\N	20	1
6403	1	135	175	\N	\N	20	1
6404	4	137	175	\N	\N	20	1
6405	1	141	175	\N	\N	20	1
6406	4	151	175	\N	\N	20	1
6407	100	153	175	\N	\N	20	1
6408	2	154	175	\N	\N	20	1
6409	1	156	175	\N	\N	20	1
641	350	112	6	\N	\N	6	\N
6410	1	161	175	\N	\N	20	1
6411	1	167	175	\N	\N	20	1
6412	9	62	175	\N	\N	20	1
6413	17	66	175	\N	\N	20	1
6414	11	67	175	\N	\N	20	1
6415	2	69	175	\N	\N	20	1
6416	1	87	175	\N	\N	20	1
6417	350	106	175	\N	\N	20	1
6418	5	112	175	\N	\N	20	1
6419	102	116	175	\N	Originally recorded as CAGU, changed to gull sp. after discussion w/ Charlie due to less than 100% certainty of ID	20	1
642	25	113	6	\N	\N	6	\N
6420	4	170	175	\N	\N	20	1
6421	9	174	175	\N	\N	20	1
6422	14	189	175	\N	\N	20	1
6423	1	190	175	\N	\N	20	1
6424	2	191	175	\N	\N	20	1
6425	11	194	175	\N	\N	20	1
6426	2	196	175	\N	\N	20	1
6427	3	204	175	\N	\N	20	1
6428	4	208	175	\N	\N	20	1
6429	1	211	175	\N	\N	20	1
643	168	116	6	\N	\N	6	\N
6430	2	156	176	\N	\N	20	1
6431	1	158	176	\N	\N	20	1
6432	2	161	176	\N	\N	20	1
6433	1	163	176	\N	\N	20	1
6434	8	189	176	\N	\N	20	1
6435	3	196	176	\N	\N	20	1
6436	1	205	176	\N	\N	20	1
6437	1	131	177	\N	\N	20	1
6438	1	134	177	\N	\N	20	1
6439	2	137	177	\N	\N	20	1
644	179	117	6	\N	\N	6	\N
6440	1	154	177	\N	\N	20	1
6441	2	156	177	\N	\N	20	1
6442	1	158	177	\N	\N	20	1
6443	1	161	177	\N	\N	20	1
6444	1	164	177	\N	\N	20	1
6445	3	76	177	\N	\N	20	1
6446	7	189	177	\N	\N	20	1
6447	2	194	177	\N	\N	20	1
6448	1	196	177	\N	\N	20	1
6449	1	135	178	\N	\N	20	1
645	5	118	6	\N	\N	6	\N
6450	1	137	178	\N	\N	20	1
6451	2	151	178	\N	\N	20	1
6452	8	158	178	\N	\N	20	1
6453	2	161	178	\N	\N	20	1
6454	4	174	178	\N	\N	20	1
6455	12	189	178	\N	\N	20	1
6456	2	191	178	\N	\N	20	1
6457	2	194	178	\N	\N	20	1
6458	1	196	178	\N	\N	20	1
6459	3	204	178	\N	\N	20	1
646	7	120	6	\N	\N	6	\N
6460	4	205	178	\N	\N	20	1
6461	3	131	179	\N	\N	20	1
6462	1	137	179	\N	\N	20	1
6463	2	151	179	\N	\N	20	1
6464	1	174	179	\N	\N	20	1
6465	1	196	179	\N	\N	20	1
6466	3	131	180	\N	\N	20	1
6467	3	137	180	\N	\N	20	1
6468	3	151	180	\N	\N	20	1
6469	1	154	180	\N	\N	20	1
647	\N	122	6	t	\N	6	\N
6470	10	158	180	\N	\N	20	1
6471	2	161	180	\N	\N	20	1
6472	1	163	180	\N	\N	20	1
6473	1	164	180	\N	\N	20	1
6474	2	170	180	\N	\N	20	1
6475	15	189	180	\N	\N	20	1
6476	1	190	180	\N	\N	20	1
6477	4	194	180	\N	\N	20	1
6478	4	196	180	\N	\N	20	1
6479	16	205	180	\N	\N	20	1
648	3	124	6	\N	\N	6	\N
6480	2	131	181	\N	\N	20	1
6481	2	137	181	\N	\N	20	1
6482	1	144	181	\N	\N	20	1
6483	4	156	181	\N	\N	20	1
6484	2	158	181	\N	\N	20	1
6485	2	161	181	\N	\N	20	1
6486	6	174	181	\N	\N	20	1
6487	6	189	181	\N	\N	20	1
6488	2	191	181	\N	\N	20	1
6489	2	194	181	\N	\N	20	1
649	2	126	6	\N	\N	6	\N
6490	3	196	181	\N	\N	20	1
6491	4	204	181	\N	\N	20	1
6492	3	131	182	\N	\N	20	1
6493	1	154	182	\N	\N	20	1
6494	3	158	182	\N	\N	20	1
6495	2	161	182	\N	\N	20	1
6496	\N	72	182	t	\N	20	1
6497	1	76	182	\N	\N	20	1
6498	1	77	182	\N	\N	20	1
6499	1	174	182	\N	\N	20	1
65	\N	123	1	t	\N	1	\N
650	1	129	6	\N	\N	6	\N
6500	2	186	182	\N	\N	20	1
6501	25	189	182	\N	\N	20	1
6502	1	194	182	\N	\N	20	1
6503	5	196	182	\N	\N	20	1
6504	2	204	182	\N	1 male, 1 female	20	1
6505	1	208	182	\N	\N	20	1
6506	2	20	183	\N	\N	20	2
6507	1	40	183	\N	\N	20	2
6508	4	131	183	\N	\N	20	2
6509	1	141	183	\N	\N	20	2
651	27	131	6	\N	\N	6	\N
6510	1	151	183	\N	\N	20	2
6511	5	153	183	\N	\N	20	2
6512	2	156	183	\N	\N	20	2
6513	3	158	183	\N	\N	20	2
6514	2	161	183	\N	\N	20	2
6515	3	164	183	\N	\N	20	2
6516	1	167	183	\N	\N	20	2
6517	1	69	183	\N	\N	20	2
6518	1	79	183	\N	\N	20	2
6519	5	170	183	\N	\N	20	2
652	24	132	6	\N	\N	6	\N
6520	10	174	183	\N	\N	20	2
6521	6	189	183	\N	\N	20	2
6522	2	194	183	\N	\N	20	2
6523	8	196	183	\N	\N	20	2
6524	20	7	184	\N	\N	20	2
6525	30	18	184	\N	\N	20	2
6526	2	20	184	\N	Judd Creek Bridge	20	2
6527	2	39	184	\N	Judd Creek Bridge	20	2
6528	1	40	184	\N	\N	20	2
6529	1	41	184	\N	Judd Creek Bridge	20	2
653	3	134	6	\N	\N	6	\N
6530	20	44	184	\N	Judd Creek Bridge	20	2
6531	12	45	184	\N	Judd Creek Bridge	20	2
6532	1	117	184	\N	\N	20	2
6533	10	131	184	\N	\N	20	2
6534	6	132	184	\N	\N	20	2
6535	1	134	184	\N	\N	20	2
6536	2	135	184	\N	\N	20	2
6537	12	137	184	\N	\N	20	2
6538	18	151	184	\N	\N	20	2
6539	25	153	184	\N	\N	20	2
654	20	135	6	\N	\N	6	\N
6540	13	154	184	\N	\N	20	2
6541	37	156	184	\N	\N	20	2
6542	26	158	184	\N	\N	20	2
6543	19	161	184	\N	\N	20	2
6544	2	163	184	\N	\N	20	2
6545	7	164	184	\N	\N	20	2
6546	1	166	184	\N	\N	20	2
6547	8	167	184	\N	\N	20	2
6548	1	69	184	\N	\N	20	2
6549	1	72	184	\N	\N	20	2
655	5	136	6	\N	\N	6	\N
6550	2	76	184	\N	\N	20	2
6551	1	77	184	\N	\N	20	2
6552	4	79	184	\N	\N	20	2
6553	3	82	184	\N	\N	20	2
6554	1	86	184	\N	\N	20	2
6555	1	112	184	\N	\N	20	2
6556	45	170	184	\N	\N	20	2
6557	5	171	184	\N	\N	20	2
6558	1	173	184	\N	\N	20	2
6559	72	174	184	\N	\N	20	2
656	71	139	6	\N	\N	6	\N
6560	3	175	184	\N	\N	20	2
6561	8	176	184	\N	\N	20	2
6562	6	181	184	\N	\N	20	2
6563	7	186	184	\N	\N	20	2
6564	159	189	184	\N	\N	20	2
6565	2	190	184	\N	\N	20	2
6566	22	191	184	\N	\N	20	2
6567	31	194	184	\N	\N	20	2
6568	2	195	184	\N	\N	20	2
6569	21	196	184	\N	\N	20	2
657	9	141	6	\N	\N	6	\N
6570	19	199	184	\N	\N	20	2
6571	7	204	184	\N	\N	20	2
6572	2	205	184	\N	\N	20	2
6573	25	207	184	\N	\N	20	2
6574	5	208	184	\N	\N	20	2
6575	6	211	184	\N	\N	20	2
6576	1	7	185	\N	\N	20	2
6577	3	39	185	\N	\N	20	2
6578	12	40	185	\N	\N	20	2
6579	2	41	185	\N	\N	20	2
658	1	143	6	\N	\N	6	\N
6580	12	44	185	\N	\N	20	2
6581	8	45	185	\N	\N	20	2
6582	17	59	185	\N	\N	20	2
6583	2	61	185	\N	\N	20	2
6584	5	131	185	\N	\N	20	2
6585	2	154	185	\N	\N	20	2
6586	5	158	185	\N	\N	20	2
6587	1	168	185	\N	\N	20	2
6588	18	66	185	\N	\N	20	2
6589	2	69	185	\N	\N	20	2
659	1	144	6	\N	\N	6	\N
6590	5	86	185	\N	\N	20	2
6591	46	106	185	\N	\N	20	2
6592	28	113	185	\N	\N	20	2
6593	6	189	185	\N	\N	20	2
6594	1	194	185	\N	\N	20	2
6595	10	34	186	\N	\N	20	2
6596	9	39	186	\N	\N	20	2
6597	3	40	186	\N	\N	20	2
6598	4	41	186	\N	\N	20	2
6599	30	45	186	\N	\N	20	2
66	5	124	1	\N	\N	1	\N
660	1	145	6	\N	\N	6	\N
6600	2	46	186	\N	\N	20	2
6601	1	59	186	\N	\N	20	2
6602	1	131	186	\N	\N	20	2
6603	2	132	186	\N	\N	20	2
6604	5	137	186	\N	\N	20	2
6605	4	153	186	\N	\N	20	2
6606	1	154	186	\N	\N	20	2
6607	2	158	186	\N	\N	20	2
6608	2	161	186	\N	\N	20	2
6609	2	164	186	\N	\N	20	2
661	5	149	6	\N	\N	6	\N
6610	1	62	186	\N	\N	20	2
6611	54	66	186	\N	\N	20	2
6612	5	67	186	\N	\N	20	2
6613	7	68	186	\N	\N	20	2
6614	1	76	186	\N	\N	20	2
6615	12	106	186	\N	\N	20	2
6616	34	112	186	\N	\N	20	2
6617	21	116	186	\N	\N	20	2
6618	2	170	186	\N	\N	20	2
6619	5	171	186	\N	\N	20	2
662	93	151	6	\N	\N	6	\N
6620	4	174	186	\N	\N	20	2
6621	10	175	186	\N	\N	20	2
6622	3	176	186	\N	\N	20	2
6623	1	186	186	\N	\N	20	2
6624	19	189	186	\N	\N	20	2
6625	1	191	186	\N	\N	20	2
6626	7	194	186	\N	\N	20	2
6627	9	196	186	\N	\N	20	2
6628	2	7	187	\N	\N	20	2
6629	14	18	187	\N	\N	20	2
663	925	153	6	\N	\N	6	\N
6630	2	20	187	\N	\N	20	2
6631	12	39	187	\N	\N	20	2
6632	11	40	187	\N	\N	20	2
6633	4	43	187	\N	\N	20	2
6634	10	59	187	\N	\N	20	2
6635	3	60	187	\N	\N	20	2
6636	23	117	187	\N	\N	20	2
6637	4	131	187	\N	\N	20	2
6638	10	137	187	\N	\N	20	2
6639	1	141	187	\N	\N	20	2
664	10	154	6	\N	\N	6	\N
6640	2	143	187	\N	\N	20	2
6641	2	149	187	\N	\N	20	2
6642	5	151	187	\N	\N	20	2
6643	9	153	187	\N	\N	20	2
6644	1	154	187	\N	\N	20	2
6645	12	156	187	\N	\N	20	2
6646	25	158	187	\N	\N	20	2
6647	9	161	187	\N	\N	20	2
6648	3	163	187	\N	\N	20	2
6649	19	164	187	\N	\N	20	2
665	270	156	6	\N	\N	6	\N
6650	5	167	187	\N	\N	20	2
6651	1	65	187	\N	\N	20	2
6652	10	66	187	\N	\N	20	2
6653	1	69	187	\N	\N	20	2
6654	1	71	187	\N	\N	20	2
6655	1	73	187	\N	\N	20	2
6656	2	76	187	\N	\N	20	2
6657	4	79	187	\N	\N	20	2
6658	1	87	187	\N	\N	20	2
6659	1	103	187	\N	\N	20	2
666	311	158	6	\N	\N	6	\N
6660	8	106	187	\N	\N	20	2
6661	14	113	187	\N	\N	20	2
6662	42	170	187	\N	\N	20	2
6663	9	171	187	\N	\N	20	2
6664	206	174	187	\N	\N	20	2
6665	1	175	187	\N	\N	20	2
6666	5	176	187	\N	\N	20	2
6667	4	186	187	\N	\N	20	2
6668	17	189	187	\N	\N	20	2
6669	3	191	187	\N	\N	20	2
667	90	160	6	\N	\N	6	\N
6670	23	194	187	\N	\N	20	2
6671	17	196	187	\N	\N	20	2
6672	2	199	187	\N	\N	20	2
6673	2	206	187	\N	\N	20	2
6674	51	207	187	\N	\N	20	2
6675	1	138	187	\N	\N	20	2
6676	1	137	188	\N	\N	20	2
6677	1	141	188	\N	\N	20	2
6678	1	151	188	\N	\N	20	2
6679	2	154	188	\N	\N	20	2
668	57	161	6	\N	\N	6	\N
6680	2	156	188	\N	\N	20	2
6681	5	158	188	\N	\N	20	2
6682	2	161	188	\N	\N	20	2
6683	2	167	188	\N	\N	20	2
6684	1	72	188	\N	\N	20	2
6685	3	171	188	\N	\N	20	2
6686	2	174	188	\N	\N	20	2
6687	1	186	188	\N	\N	20	2
6688	8	189	188	\N	\N	20	2
6689	1	191	188	\N	\N	20	2
669	2	162	6	\N	\N	6	\N
6690	1	194	188	\N	\N	20	2
6691	5	196	188	\N	\N	20	2
6692	2	207	188	\N	\N	20	2
6693	28	20	189	\N	\N	20	2
6694	3	131	190	\N	\N	20	2
6695	1	135	190	\N	1 M	20	2
6696	1	137	190	\N	\N	20	2
6697	5	158	190	\N	\N	20	2
6698	3	161	190	\N	\N	20	2
6699	10	189	190	\N	\N	20	2
67	1	129	1	\N	\N	1	\N
670	16	163	6	\N	\N	6	\N
6700	2	191	190	\N	1 M, 1 F	20	2
6701	1	194	190	\N	\N	20	2
6702	3	196	190	\N	\N	20	2
6703	3	131	191	\N	\N	20	2
6704	3	137	191	\N	\N	20	2
6705	2	153	191	\N	\N	20	2
6706	5	156	191	\N	\N	20	2
6707	3	171	191	\N	\N	20	2
6708	2	174	191	\N	\N	20	2
6709	5	176	191	\N	\N	20	2
671	82	165	6	\N	\N	6	\N
6710	2	186	191	\N	\N	20	2
6711	7	189	191	\N	\N	20	2
6712	1	191	191	\N	\N	20	2
6713	3	194	191	\N	\N	20	2
6714	3	196	191	\N	\N	20	2
6715	1	207	191	\N	\N	20	2
6716	43	7	192	\N	\N	21	5
6717	2	17	192	\N	\N	21	5
6718	2055	18	192	\N	\N	21	5
6719	39	20	192	\N	\N	21	5
672	1	166	6	\N	\N	6	\N
6720	3	24	192	\N	\N	21	5
6721	24	30	192	\N	\N	21	5
6722	9	33	192	\N	\N	21	5
6723	82	34	192	\N	\N	21	5
6724	3	35	192	\N	\N	21	5
6725	23	39	192	\N	\N	21	5
6726	86	40	192	\N	\N	21	5
6727	6	41	192	\N	\N	21	5
6728	3	43	192	\N	\N	21	5
6729	16	44	192	\N	\N	21	5
673	46	167	6	\N	\N	6	\N
6730	32	45	192	\N	\N	21	5
6731	2	54	192	\N	\N	21	5
6732	13	59	192	\N	\N	21	5
6733	4	60	192	\N	\N	21	5
6734	2	131	192	\N	\N	21	5
6735	3	132	192	\N	\N	21	5
6736	1	135	192	\N	\N	21	5
6737	2	137	192	\N	\N	21	5
6738	5	153	192	\N	\N	21	5
6739	1	154	192	\N	\N	21	5
674	330	170	6	\N	\N	6	\N
6740	3	156	192	\N	\N	21	5
6741	4	164	192	\N	\N	21	5
6742	1	167	192	\N	\N	21	5
6743	27	66	192	\N	\N	21	5
6744	10	67	192	\N	\N	21	5
6745	3	69	192	\N	\N	21	5
6746	2	76	192	\N	\N	21	5
6747	3	77	192	\N	\N	21	5
6748	38	89	192	\N	\N	21	5
6749	2	90	192	\N	\N	21	5
675	154	171	6	\N	\N	6	\N
6750	7	100	192	\N	\N	21	5
6751	1	103	192	\N	\N	21	5
6752	141	106	192	\N	\N	21	5
6753	7	109	192	\N	\N	21	5
6754	16	111	192	\N	\N	21	5
6755	24	112	192	\N	\N	21	5
6756	3	113	192	\N	\N	21	5
6757	17	174	192	\N	\N	21	5
6758	16	176	192	\N	\N	21	5
6759	1	186	192	\N	\N	21	5
676	2	173	6	\N	\N	6	\N
6760	19	189	192	\N	\N	21	5
6761	8	194	192	\N	\N	21	5
6762	27	199	192	\N	\N	21	5
6763	6	211	192	\N	\N	21	5
6764	2	1	192	\N	\N	21	5
6765	2	21	192	\N	\N	21	5
6766	26	7	193	\N	\N	21	5
6767	2	131	193	\N	\N	21	5
6768	1	135	193	\N	\N	21	5
6769	2	149	193	\N	\N	21	5
677	827	174	6	\N	\N	6	\N
6770	3	151	193	\N	\N	21	5
6771	3	153	193	\N	\N	21	5
6772	4	154	193	\N	\N	21	5
6773	8	156	193	\N	\N	21	5
6774	18	158	193	\N	\N	21	5
6775	23	160	193	\N	\N	21	5
6776	3	161	193	\N	\N	21	5
6777	1	163	193	\N	\N	21	5
6778	3	164	193	\N	\N	21	5
6779	1	79	193	\N	\N	21	5
678	78	175	6	\N	\N	6	\N
6780	45	170	193	\N	\N	21	5
6781	4	171	193	\N	\N	21	5
6782	2	174	193	\N	\N	21	5
6783	12	176	193	\N	\N	21	5
6784	15	186	193	\N	\N	21	5
6785	35	189	193	\N	\N	21	5
6786	2	191	193	\N	\N	21	5
6787	12	194	193	\N	\N	21	5
6788	22	196	193	\N	\N	21	5
6789	10	199	193	\N	\N	21	5
679	847	176	6	\N	\N	6	\N
6790	10	204	193	\N	\N	21	5
6791	2	208	193	\N	\N	21	5
6792	8	18	194	\N	\N	21	5
6793	3	34	194	\N	\N	21	5
6794	5	39	194	\N	\N	21	5
6795	1	40	194	\N	\N	21	5
6796	2	43	194	\N	\N	21	5
6797	2	45	194	\N	\N	21	5
6798	5	59	194	\N	\N	21	5
6799	1	126	194	\N	\N	21	5
68	4	131	1	\N	\N	1	\N
680	15	178	6	\N	\N	6	\N
6800	13	131	194	\N	\N	21	5
6801	1	132	194	\N	\N	21	5
6802	1	136	194	\N	\N	21	5
6803	2	137	194	\N	\N	21	5
6804	1	141	194	\N	\N	21	5
6805	5	149	194	\N	\N	21	5
6806	12	151	194	\N	\N	21	5
6807	17	153	194	\N	\N	21	5
6808	6	154	194	\N	\N	21	5
6809	72	156	194	\N	\N	21	5
681	2	179	6	\N	\N	6	\N
6810	45	158	194	\N	\N	21	5
6811	15	161	194	\N	\N	21	5
6812	4	163	194	\N	\N	21	5
6813	14	164	194	\N	\N	21	5
6814	3	167	194	\N	\N	21	5
6815	14	66	194	\N	\N	21	5
6816	1	72	194	\N	\N	21	5
6817	1	76	194	\N	\N	21	5
6818	1	77	194	\N	\N	21	5
6819	1	79	194	\N	\N	21	5
682	2	184	6	\N	\N	6	\N
6820	9	106	194	\N	\N	21	5
6821	2	107	194	\N	\N	21	5
6822	1	111	194	\N	\N	21	5
6823	2	112	194	\N	\N	21	5
6824	3	113	194	\N	\N	21	5
6825	103	170	194	\N	\N	21	5
6826	7	171	194	\N	\N	21	5
6827	44	174	194	\N	\N	21	5
6828	3	175	194	\N	\N	21	5
6829	32	176	194	\N	\N	21	5
683	94	186	6	\N	\N	6	\N
6830	5	184	194	\N	\N	21	5
6831	24	186	194	\N	\N	21	5
6832	102	189	194	\N	\N	21	5
6833	6	191	194	\N	\N	21	5
6834	51	194	194	\N	\N	21	5
6835	40	196	194	\N	\N	21	5
6836	11	204	194	\N	\N	21	5
6837	2	206	194	\N	\N	21	5
6838	81	7	195	\N	\N	21	6
6839	47	20	195	\N	\N	21	6
684	1	188	6	\N	\N	6	\N
6840	18	39	195	\N	\N	21	6
6841	22	40	195	\N	\N	21	6
6842	2	41	195	\N	\N	21	6
6843	8	43	195	\N	\N	21	6
6844	1	45	195	\N	\N	21	6
6845	5	120	195	\N	\N	21	6
6846	4	131	195	\N	\N	21	6
6847	1	132	195	\N	\N	21	6
6848	1	135	195	\N	\N	21	6
6849	11	137	195	\N	\N	21	6
685	782	189	6	\N	\N	6	\N
6850	4	151	195	\N	\N	21	6
6851	52	153	195	\N	\N	21	6
6852	3	154	195	\N	\N	21	6
6853	8	156	195	\N	\N	21	6
6854	5	158	195	\N	\N	21	6
6855	20	160	195	\N	\N	21	6
6856	1	161	195	\N	\N	21	6
6857	1	164	195	\N	\N	21	6
6858	5	66	195	\N	\N	21	6
6859	3	69	195	\N	\N	21	6
686	2	190	6	\N	\N	6	\N
6860	3	76	195	\N	\N	21	6
6861	3	77	195	\N	\N	21	6
6862	1	86	195	\N	\N	21	6
6863	1	87	195	\N	\N	21	6
6864	3	106	195	\N	\N	21	6
6865	1	109	195	\N	\N	21	6
6866	11	112	195	\N	\N	21	6
6867	4	113	195	\N	\N	21	6
6868	8	170	195	\N	\N	21	6
6869	7	171	195	\N	\N	21	6
687	85	191	6	\N	\N	6	\N
6870	11	174	195	\N	\N	21	6
6871	5	175	195	\N	\N	21	6
6872	2	184	195	\N	\N	21	6
6873	2	186	195	\N	\N	21	6
6874	76	189	195	\N	\N	21	6
6875	1	190	195	\N	\N	21	6
6876	4	191	195	\N	\N	21	6
6877	13	194	195	\N	\N	21	6
6878	12	196	195	\N	\N	21	6
6879	1	199	195	\N	\N	21	6
688	3	193	6	\N	\N	6	\N
6880	10	204	195	\N	\N	21	6
6881	140	207	195	\N	\N	21	6
6882	2	208	195	\N	\N	21	6
6883	\N	2	196	t	\N	21	6
6884	\N	47	196	t	\N	21	6
6885	4	7	196	\N	\N	21	6
6886	2	15	196	\N	\N	21	6
6887	4	22	196	\N	\N	21	6
6888	4	18	196	\N	\N	21	6
6889	96	20	196	\N	\N	21	6
689	288	194	6	\N	\N	6	\N
6890	1	26	196	\N	\N	21	6
6891	515	28	196	\N	\N	21	6
6892	3	29	196	\N	\N	21	6
6893	67	30	196	\N	\N	21	6
6894	42	39	196	\N	\N	21	6
6895	3	40	196	\N	\N	21	6
6896	20	43	196	\N	\N	21	6
6897	55	44	196	\N	\N	21	6
6898	46	58	196	\N	\N	21	6
6899	1	120	196	\N	\N	21	6
69	29	132	1	\N	\N	1	\N
690	2	195	6	\N	\N	6	\N
6900	80	83	196	\N	\N	21	6
6901	6	86	196	\N	\N	21	6
6902	5	112	196	\N	\N	21	6
6903	20	66	196	\N	\N	21	6
6904	1	69	196	\N	\N	21	6
6905	1	73	196	\N	\N	21	6
6906	1	76	196	\N	\N	21	6
6907	2	132	196	\N	\N	21	6
6908	1	134	196	\N	\N	21	6
6909	2	136	196	\N	\N	21	6
691	248	196	6	\N	\N	6	\N
6910	5	137	196	\N	\N	21	6
6911	1	145	196	\N	\N	21	6
6912	12	151	196	\N	\N	21	6
6913	5	153	196	\N	\N	21	6
6914	8	156	196	\N	\N	21	6
6915	15	158	196	\N	\N	21	6
6916	5	170	196	\N	\N	21	6
6917	1	171	196	\N	\N	21	6
6918	1	163	196	\N	\N	21	6
6919	1	164	196	\N	\N	21	6
692	120	199	6	\N	\N	6	\N
6920	1	166	196	\N	\N	21	6
6921	1	167	196	\N	\N	21	6
6922	18	176	196	\N	\N	21	6
6923	50	174	196	\N	\N	21	6
6924	1	207	196	\N	\N	21	6
6925	35	189	196	\N	\N	21	6
6926	5	194	196	\N	\N	21	6
6927	6	196	196	\N	\N	21	6
6928	10	199	196	\N	\N	21	6
6929	2	86	197	\N	\N	21	6
693	13	201	6	\N	\N	6	\N
6930	1	69	197	\N	\N	21	6
6931	1	124	197	\N	\N	21	6
6932	1	166	197	\N	\N	21	6
6933	6	174	197	\N	\N	21	6
6934	1	194	197	\N	\N	21	6
6935	3	189	198	\N	\N	21	6
6936	8	194	198	\N	\N	21	6
6937	3	211	198	\N	\N	21	6
6938	1	6	199	\N	\N	21	6
6939	104	7	199	\N	\N	21	6
694	261	204	6	\N	\N	6	\N
6940	2	15	199	\N	\N	21	6
6941	7	16	199	\N	\N	21	6
6942	216	20	199	\N	\N	21	6
6943	1	23	199	\N	\N	21	6
6944	26	24	199	\N	\N	21	6
6945	3	39	199	\N	\N	21	6
6946	4	43	199	\N	\N	21	6
6947	4	119	199	\N	\N	21	6
6948	6	131	199	\N	\N	21	6
6949	1	82	199	\N	\N	21	6
695	27	205	6	\N	\N	6	\N
6950	2	95	199	\N	\N	21	6
6951	12	112	199	\N	\N	21	6
6952	1	73	199	\N	\N	21	6
6953	3	76	199	\N	\N	21	6
6954	3	79	199	\N	\N	21	6
6955	1	134	199	\N	\N	21	6
6956	1	135	199	\N	\N	21	6
6957	8	137	199	\N	\N	21	6
6958	1	143	199	\N	\N	21	6
6959	5	151	199	\N	\N	21	6
696	35	206	6	\N	\N	6	\N
6960	10	153	199	\N	\N	21	6
6961	12	154	199	\N	\N	21	6
6962	37	156	199	\N	\N	21	6
6963	24	158	199	\N	\N	21	6
6964	27	170	199	\N	\N	21	6
6965	3	171	199	\N	\N	21	6
6966	4	163	199	\N	\N	21	6
6967	3	164	199	\N	\N	21	6
6968	407	176	199	\N	\N	21	6
6969	6	175	199	\N	\N	21	6
697	889	207	6	\N	\N	6	\N
6970	62	174	199	\N	\N	21	6
6971	6	211	199	\N	\N	21	6
6972	170	207	199	\N	\N	21	6
6973	2	208	199	\N	\N	21	6
6974	3	186	199	\N	\N	21	6
6975	144	189	199	\N	\N	21	6
6976	1	190	199	\N	\N	21	6
6977	14	191	199	\N	\N	21	6
6978	11	194	199	\N	\N	21	6
6979	10	196	199	\N	\N	21	6
698	11	208	6	\N	\N	6	\N
6980	113	199	199	\N	\N	21	6
6981	14	33	200	\N	\N	21	3
6982	12	34	200	\N	\N	21	3
6983	43	39	200	\N	\N	21	3
6984	47	40	200	\N	\N	21	3
6985	1	41	200	\N	\N	21	3
6986	3	44	200	\N	\N	21	3
6987	24	45	200	\N	\N	21	3
6988	1	46	200	\N	\N	21	3
6989	34	59	200	\N	\N	21	3
699	67	211	6	\N	\N	6	\N
6990	7	60	200	\N	\N	21	3
6991	13	131	200	\N	\N	21	3
6992	1	87	200	\N	\N	21	3
6993	7	100	200	\N	\N	21	3
6994	4	103	200	\N	\N	21	3
6995	176	106	200	\N	\N	21	3
6996	6	112	200	\N	\N	21	3
6997	47	113	200	\N	\N	21	3
6998	2	54	200	\N	\N	21	3
6999	1	57	200	\N	\N	21	3
7	1	23	1	\N	\N	1	\N
70	6	134	1	\N	\N	1	\N
700	60	5	7	\N	\N	7	\N
7000	2	65	200	\N	\N	21	3
7001	3	67	200	\N	\N	21	3
7002	5	66	200	\N	\N	21	3
7003	5	68	200	\N	\N	21	3
7004	1	75	200	\N	\N	21	3
7005	5	76	200	\N	Removed 2 presumed duplicate observations	21	3
7006	1	77	200	\N	\N	21	3
7007	2	79	200	\N	\N	21	3
7008	2	135	200	\N	\N	21	3
7009	1	141	200	\N	\N	21	3
701	350	7	7	\N	\N	7	\N
7010	12	137	200	\N	\N	21	3
7011	1	149	200	\N	\N	21	3
7012	108	153	200	\N	\N	21	3
7013	2	154	200	\N	\N	21	3
7014	35	156	200	\N	\N	21	3
7015	45	158	200	\N	\N	21	3
7016	42	160	200	\N	\N	21	3
7017	7	170	200	\N	\N	21	3
7018	6	171	200	\N	\N	21	3
7019	5	161	200	\N	\N	21	3
702	30	15	7	\N	\N	7	\N
7020	2	163	200	\N	\N	21	3
7021	4	164	200	\N	\N	21	3
7022	1	167	200	\N	\N	21	3
7023	1	173	200	\N	\N	21	3
7024	26	174	200	\N	\N	21	3
7025	6	204	200	\N	\N	21	3
7026	1	205	200	\N	\N	21	3
7027	26	207	200	\N	\N	21	3
7028	2	208	200	\N	\N	21	3
7029	1	186	200	\N	\N	21	3
703	2	16	7	\N	\N	7	\N
7030	51	189	200	\N	\N	21	3
7031	13	191	200	\N	\N	21	3
7032	17	194	200	\N	\N	21	3
7033	15	196	200	\N	\N	21	3
7034	1	179	200	\N	\N	21	3
7035	49	7	201	\N	\N	21	3
7036	15	18	201	\N	\N	21	3
7037	9	20	201	\N	\N	21	3
7038	47	34	201	\N	\N	21	3
7039	11	39	201	\N	\N	21	3
704	4	17	7	\N	\N	7	\N
7040	2	40	201	\N	\N	21	3
7041	5	41	201	\N	\N	21	3
7042	1	45	201	\N	\N	21	3
7043	4	59	201	\N	\N	21	3
7044	1	60	201	\N	\N	21	3
7045	12	131	201	\N	\N	21	3
7046	1	134	201	\N	\N	21	3
7047	11	137	201	\N	\N	21	3
7048	11	153	201	\N	\N	21	3
7049	6	154	201	\N	\N	21	3
705	1761	18	7	\N	\N	7	\N
7050	9	156	201	\N	Reported 10 unknown chickadee species - allocated 5 to each	21	3
7051	43	158	201	\N	Reported 10 unknown chickadee species - allocated 5 to each	21	3
7052	1	160	201	\N	\N	21	3
7053	1	161	201	\N	\N	21	3
7054	3	163	201	\N	\N	21	3
7055	1	164	201	\N	\N	21	3
7056	2	66	201	\N	\N	21	3
7057	6	76	201	\N	\N	21	3
7058	1	77	201	\N	\N	21	3
7059	2	79	201	\N	\N	21	3
706	341	20	7	\N	\N	7	\N
7060	4	86	201	\N	\N	21	3
7061	1	112	201	\N	\N	21	3
7062	9	116	201	\N	\N	21	3
7063	6	170	201	\N	\N	21	3
7064	16	171	201	\N	\N	21	3
7065	83	174	201	\N	\N	21	3
7066	1	175	201	\N	\N	21	3
7067	13	176	201	\N	\N	21	3
7068	1	186	201	\N	\N	21	3
7069	53	189	201	\N	\N	21	3
707	13	22	7	\N	\N	7	\N
7070	8	191	201	\N	\N	21	3
7071	17	194	201	\N	\N	21	3
7072	10	196	201	\N	\N	21	3
7073	1	204	201	\N	\N	21	3
7074	1	205	201	\N	\N	21	3
7075	5	211	201	\N	\N	21	3
7076	2	7	202	\N	\N	21	3
7077	2	16	202	\N	\N	21	3
7078	262	18	202	\N	12 from KVI/Ellisport list	21	3
7079	8	20	202	\N	2 from KVI/Ellisport list	21	3
708	10	23	7	\N	\N	7	\N
7080	9	29	202	\N	7 from KVI/Ellisport list	21	3
7081	45	34	202	\N	18 from KVI/Ellisport list	21	3
7082	4	35	202	\N	1 from KVI/Ellisport list	21	3
7083	\N	38	202	t	\N	21	3
7084	53	39	202	\N	38 from KVI/Ellisport list	21	3
7085	44	40	202	\N	4 from KVI/Ellisport list	21	3
7086	3	41	202	\N	\N	21	3
7087	1	44	202	\N	\N	21	3
7088	30	45	202	\N	4 from KVI/Ellisport list	21	3
7089	1	53	202	\N	\N	21	3
709	18	24	7	\N	\N	7	\N
7090	3	55	202	\N	\N	21	3
7091	30	59	202	\N	4 from KVI/Ellisport list	21	3
7092	16	60	202	\N	1 from KVI/Ellisport list	21	3
7093	1	61	202	\N	\N	21	3
7094	12	117	202	\N	\N	21	3
7095	6	119	202	\N	\N	21	3
7096	9	131	202	\N	\N	21	3
7097	1	134	202	\N	\N	21	3
7098	6	137	202	\N	\N	21	3
7099	1	141	202	\N	\N	21	3
71	10	135	1	\N	\N	1	\N
710	36	28	7	\N	\N	7	\N
7100	1	144	202	\N	\N	21	3
7101	2	151	202	\N	\N	21	3
7102	14	153	202	\N	\N	21	3
7103	5	154	202	\N	\N	21	3
7104	18	156	202	\N	\N	21	3
7105	18	158	202	\N	\N	21	3
7106	16	160	202	\N	\N	21	3
7107	3	161	202	\N	\N	21	3
7108	3	163	202	\N	\N	21	3
7109	5	164	202	\N	\N	21	3
711	150	29	7	\N	\N	7	\N
7110	4	167	202	\N	\N	21	3
7111	14	66	202	\N	3 from KVI/Ellisport list	21	3
7112	1	67	202	\N	\N	21	3
7113	5	69	202	\N	\N	21	3
7114	1	73	202	\N	\N	21	3
7115	13	76	202	\N	\N	21	3
7116	1	77	202	\N	\N	21	3
7117	4	79	202	\N	\N	21	3
7118	1	88	202	\N	\N	21	3
7119	2	100	202	\N	\N	21	3
712	10	30	7	\N	\N	7	\N
7120	\N	105	202	t	\N	21	3
7121	16	106	202	\N	\N	21	3
7122	2	109	202	\N	\N	21	3
7123	23	112	202	\N	\N	21	3
7124	7	113	202	\N	\N	21	3
7125	35	170	202	\N	\N	21	3
7126	5	171	202	\N	\N	21	3
7127	3	173	202	\N	\N	21	3
7128	69	174	202	\N	\N	21	3
7129	4	175	202	\N	\N	21	3
713	5	33	7	\N	\N	7	\N
7130	56	176	202	\N	\N	21	3
7131	16	186	202	\N	\N	21	3
7132	86	189	202	\N	\N	21	3
7133	4	190	202	\N	\N	21	3
7134	16	191	202	\N	\N	21	3
7135	19	194	202	\N	\N	21	3
7136	16	196	202	\N	\N	21	3
7137	5	204	202	\N	\N	21	3
7138	2	205	202	\N	\N	21	3
7139	60	207	202	\N	\N	21	3
714	741	34	7	\N	\N	7	\N
7140	28	208	202	\N	\N	21	3
7141	3	131	203	\N	\N	21	3
7142	2	135	203	\N	\N	21	3
7143	1	137	203	\N	\N	21	3
7144	3	156	203	\N	\N	21	3
7145	2	161	203	\N	\N	21	3
7146	\N	73	203	t	Sat 1/4 - 1	21	3
7147	17	189	203	\N	\N	21	3
7148	1	191	203	\N	\N	21	3
7149	2	194	203	\N	\N	21	3
715	389	35	7	\N	\N	7	\N
7150	1	196	203	\N	\N	21	3
7151	1	204	203	\N	\N	21	3
7152	24	131	204	\N	\N	21	3
7153	54	6	205	\N	\N	21	7
7154	47	7	205	\N	\N	21	7
7155	45	15	205	\N	\N	21	7
7156	94	18	205	\N	\N	21	7
7157	196	20	205	\N	\N	21	7
7158	6	22	205	\N	\N	21	7
7159	20	23	205	\N	\N	21	7
716	2	36	7	\N	\N	7	\N
7160	25	24	205	\N	\N	21	7
7161	60	28	205	\N	\N	21	7
7162	70	29	205	\N	\N	21	7
7163	323	34	205	\N	\N	21	7
7164	1	35	205	\N	\N	21	7
7165	1	36	205	\N	\N	21	7
7166	165	39	205	\N	\N	21	7
7167	138	40	205	\N	\N	21	7
7168	13	41	205	\N	\N	21	7
7169	22	43	205	\N	\N	21	7
717	2	38	7	\N	\N	7	\N
7170	8	44	205	\N	\N	21	7
7171	36	45	205	\N	\N	21	7
7172	1	53	205	\N	\N	21	7
7173	43	59	205	\N	\N	21	7
7174	1	60	205	\N	\N	21	7
7175	4	117	205	\N	\N	21	7
7176	1	119	205	\N	\N	21	7
7177	6	120	205	\N	\N	21	7
7178	1	126	205	\N	\N	21	7
7179	25	131	205	\N	1 removed due to area coverage duplication	21	7
718	470	39	7	\N	\N	7	\N
7180	4	132	205	\N	\N	21	7
7181	1	134	205	\N	\N	21	7
7182	2	135	205	\N	\N	21	7
7183	31	137	205	\N	2 removed due to area coverage duplication	21	7
7184	4	141	205	\N	\N	21	7
7185	1	143	205	\N	\N	21	7
7186	1	149	205	\N	\N	21	7
7187	15	151	205	\N	\N	21	7
7188	106	153	205	\N	\N	21	7
7189	5	154	205	\N	\N	21	7
719	285	40	7	\N	\N	7	\N
7190	101	156	205	\N	5 removed due to area coverage duplication	21	7
7191	59	158	205	\N	8 removed due to area coverage duplication	21	7
7192	25	160	205	\N	\N	21	7
7193	10	161	205	\N	\N	21	7
7194	6	163	205	\N	\N	21	7
7195	24	164	205	\N	\N	21	7
7196	1	166	205	\N	\N	21	7
7197	9	167	205	\N	\N	21	7
7198	26	66	205	\N	\N	21	7
7199	6	67	205	\N	\N	21	7
72	\N	136	1	t	\N	1	\N
720	203	41	7	\N	\N	7	\N
7200	3	69	205	\N	\N	21	7
7201	1	73	205	\N	\N	21	7
7202	1	75	205	\N	\N	21	7
7203	7	76	205	\N	\N	21	7
7204	3	77	205	\N	\N	21	7
7205	7	86	205	\N	\N	21	7
7206	1	87	205	\N	\N	21	7
7207	9	92	205	\N	\N	21	7
7208	175	106	205	\N	\N	21	7
7209	3	107	205	\N	\N	21	7
721	4	42	7	\N	\N	7	\N
7210	48	112	205	\N	\N	21	7
7211	13	113	205	\N	\N	21	7
7212	15	116	205	\N	\N	21	7
7213	113	170	205	\N	\N	21	7
7214	10	171	205	\N	\N	21	7
7215	3	173	205	\N	\N	21	7
7216	146	174	205	\N	\N	21	7
7217	7	175	205	\N	\N	21	7
7218	166	176	205	\N	\N	21	7
7219	1	184	205	\N	\N	21	7
722	24	43	7	\N	\N	7	\N
7220	9	186	205	\N	1 removed due to area coverage duplication	21	7
7221	1	188	205	\N	\N	21	7
7222	324	189	205	\N	20 removed due to area coverage duplication	21	7
7223	26	191	205	\N	\N	21	7
7224	1	193	205	\N	\N	21	7
7225	100	194	205	\N	2 removed due to area coverage duplication	21	7
7226	57	196	205	\N	1 removed due to area coverage duplication	21	7
7227	10	199	205	\N	\N	21	7
7228	21	204	205	\N	\N	21	7
7229	34	207	205	\N	80 removed due to area coverage duplication	21	7
723	36	44	7	\N	\N	7	\N
7230	1	208	205	\N	2 removed due to area coverage duplication	21	7
7231	5	209	205	\N	\N	21	7
7232	6	211	205	\N	\N	21	7
7233	39	7	206	\N	\N	21	4
7234	48	18	206	\N	\N	21	4
7235	39	20	206	\N	\N	21	4
7236	45	29	206	\N	\N	21	4
7237	276	34	206	\N	\N	21	4
7238	127	35	206	\N	\N	21	4
7239	4	36	206	\N	\N	21	4
724	149	45	7	\N	\N	7	\N
7240	146	39	206	\N	\N	21	4
7241	181	40	206	\N	\N	21	4
7242	65	41	206	\N	\N	21	4
7243	3	43	206	\N	\N	21	4
7244	142	44	206	\N	\N	21	4
7245	68	45	206	\N	\N	21	4
7246	6	53	206	\N	\N	21	4
7247	116	59	206	\N	\N	21	4
7248	1	60	206	\N	\N	21	4
7249	5	61	206	\N	\N	21	4
725	16	47	7	\N	\N	7	\N
7250	4	132	206	\N	\N	21	4
7251	8	153	206	\N	\N	21	4
7252	2	154	206	\N	\N	21	4
7253	\N	62	206	t	Count week records from Bob Hawkins and Harsi and Ezra Parker	21	4
7254	84	65	206	\N	\N	21	4
7255	28	66	206	\N	\N	21	4
7256	6	67	206	\N	\N	21	4
7257	3	69	206	\N	\N	21	4
7258	6	76	206	\N	\N	21	4
7259	1	100	206	\N	\N	21	4
726	10	50	7	\N	\N	7	\N
7260	28	106	206	\N	\N	21	4
7261	45	112	206	\N	Ezra feel free to change to Olympic Gull, we just counted GW Gull type without checking otherwise	21	4
7262	3	15	207	\N	3 from Ed	21	1
7263	8	20	207	\N	\N	21	1
7264	4	28	207	\N	\N	21	1
7265	1	33	207	\N	\N	21	1
7266	10	34	207	\N	\N	21	1
7267	24	39	207	\N	\N	21	1
7268	7	40	207	\N	\N	21	1
7269	2	41	207	\N	\N	21	1
727	12	51	7	\N	\N	7	\N
7270	2	43	207	\N	\N	21	1
7271	3	45	207	\N	\N	21	1
7272	1	55	207	\N	\N	21	1
7273	25	59	207	\N	\N	21	1
7274	8	60	207	\N	\N	21	1
7275	10	117	207	\N	\N	21	1
7276	1	131	207	\N	\N	21	1
7277	1	132	207	\N	\N	21	1
7278	5	137	207	\N	\N	21	1
7279	11	153	207	\N	\N	21	1
728	1	52	7	\N	\N	7	\N
7280	12	158	207	\N	\N	21	1
7281	1	161	207	\N	\N	21	1
7282	1	164	207	\N	\N	21	1
7283	1	167	207	\N	\N	21	1
7284	9	65	207	\N	\N	21	1
7285	12	66	207	\N	\N	21	1
7286	5	67	207	\N	\N	21	1
7287	2	76	207	\N	\N	21	1
7288	4	79	207	\N	1 from Ed	21	1
7289	1	87	207	\N	\N	21	1
729	6	53	7	\N	\N	7	\N
7290	7	100	207	\N	\N	21	1
7291	59	106	207	\N	\N	21	1
7292	2	112	207	\N	\N	21	1
7293	20	116	207	\N	\N	21	1
7294	1	170	207	\N	\N	21	1
7295	2	171	207	\N	\N	21	1
7296	10	174	207	\N	\N	21	1
7297	4	184	207	\N	\N	21	1
7298	1	186	207	\N	\N	21	1
7299	36	189	207	\N	\N	21	1
73	28	139	1	\N	\N	1	\N
730	8	54	7	\N	\N	7	\N
7300	1	191	207	\N	\N	21	1
7301	1	194	207	\N	\N	21	1
7302	4	196	207	\N	\N	21	1
7303	\N	129	208	t	\N	21	1
7304	2	131	208	\N	\N	21	1
7305	2	137	208	\N	\N	21	1
7306	1	153	208	\N	\N	21	1
7307	1	154	208	\N	\N	21	1
7308	15	156	208	\N	\N	21	1
7309	3	158	208	\N	\N	21	1
731	18	55	7	\N	\N	7	\N
7310	1	163	208	\N	\N	21	1
7311	2	170	208	\N	\N	21	1
7312	20	174	208	\N	\N	21	1
7313	33	189	208	\N	\N	21	1
7314	3	191	208	\N	\N	21	1
7315	1	193	208	\N	\N	21	1
7316	3	194	208	\N	\N	21	1
7317	3	196	208	\N	\N	21	1
7318	2	204	208	\N	1 M, 1 F	21	1
7319	2	208	208	\N	\N	21	1
732	40	58	7	\N	\N	7	\N
7320	19	7	209	\N	\N	21	1
7321	2	18	209	\N	\N	21	1
7322	4	20	209	\N	\N	21	1
7323	19	34	209	\N	\N	21	1
7324	6	35	209	\N	\N	21	1
7325	24	39	209	\N	\N	21	1
7326	24	40	209	\N	\N	21	1
7327	25	45	209	\N	\N	21	1
7328	1	55	209	\N	\N	21	1
7329	48	59	209	\N	\N	21	1
733	190	59	7	\N	\N	7	\N
7330	52	60	209	\N	\N	21	1
7331	1	117	209	\N	\N	21	1
7332	1	119	209	\N	\N	21	1
7333	22	131	209	\N	\N	21	1
7334	1	132	209	\N	\N	21	1
7335	2	135	209	\N	\N	21	1
7336	8	137	209	\N	\N	21	1
7337	1	141	209	\N	\N	21	1
7338	1	149	209	\N	\N	21	1
7339	11	151	209	\N	\N	21	1
734	46	60	7	\N	\N	7	\N
7340	22	153	209	\N	\N	21	1
7341	17	156	209	\N	\N	21	1
7342	58	158	209	\N	\N	21	1
7343	4	161	209	\N	\N	21	1
7344	1	163	209	\N	\N	21	1
7345	8	164	209	\N	\N	21	1
7346	2	167	209	\N	\N	21	1
7347	1	65	209	\N	\N	21	1
7348	4	66	209	\N	\N	21	1
7349	1	73	209	\N	\N	21	1
735	602	62	7	\N	\N	7	\N
7350	4	76	209	\N	\N	21	1
7351	2	77	209	\N	\N	21	1
7352	1	79	209	\N	\N	21	1
7353	1	87	209	\N	\N	21	1
7354	2	99	209	\N	\N	21	1
7355	5	100	209	\N	\N	21	1
7356	2	103	209	\N	\N	21	1
7357	40	106	209	\N	\N	21	1
7358	10	113	209	\N	32 reported as Western/Glaucous-winged Gull	21	1
7359	45	170	209	\N	\N	21	1
736	1	65	7	\N	\N	7	\N
7360	8	171	209	\N	\N	21	1
7361	51	174	209	\N	\N	21	1
7362	1	175	209	\N	\N	21	1
7363	4	176	209	\N	\N	21	1
7364	1	181	209	\N	\N	21	1
7365	2	186	209	\N	\N	21	1
7366	122	189	209	\N	\N	21	1
7367	14	191	209	\N	\N	21	1
7368	33	194	209	\N	\N	21	1
7369	21	196	209	\N	\N	21	1
737	163	66	7	\N	\N	7	\N
7370	16	204	209	\N	\N	21	1
7371	1	205	209	\N	\N	21	1
7372	16	207	209	\N	\N	21	1
7373	1	208	209	\N	\N	21	1
7374	4	18	210	\N	\N	21	1
7375	15	20	210	\N	\N	21	1
7376	2	131	210	\N	\N	21	1
7377	1	132	210	\N	\N	21	1
7378	3	137	210	\N	\N	21	1
7379	62	153	210	\N	\N	21	1
738	20	67	7	\N	\N	7	\N
7380	5	158	210	\N	\N	21	1
7381	2	161	210	\N	\N	21	1
7382	1	163	210	\N	\N	21	1
7383	2	69	210	\N	\N	21	1
7384	5	76	210	\N	\N	21	1
7385	1	77	210	\N	\N	21	1
7386	3	86	210	\N	\N	21	1
7387	8	112	210	\N	\N	21	1
7388	1	173	210	\N	\N	21	1
7389	2	174	210	\N	\N	21	1
739	25	69	7	\N	\N	7	\N
7390	1	175	210	\N	\N	21	1
7391	8	189	210	\N	\N	21	1
7392	2	194	210	\N	\N	21	1
7393	4	196	210	\N	\N	21	1
7394	2	204	210	\N	\N	21	1
7395	2	126	211	\N	\N	21	1
7396	85	7	212	\N	\N	21	1
7397	6	18	212	\N	\N	21	1
7398	3	20	212	\N	\N	21	1
7399	11	28	212	\N	\N	21	1
74	10	141	1	\N	\N	1	\N
740	2	70	7	\N	\N	7	\N
7400	9	39	212	\N	\N	21	1
7401	1	40	212	\N	\N	21	1
7402	5	131	212	\N	\N	21	1
7403	5	137	212	\N	\N	21	1
7404	1	143	212	\N	1 male from Ed	21	1
7405	3	151	212	\N	\N	21	1
7406	14	153	212	\N	\N	21	1
7407	5	154	212	\N	\N	21	1
7408	13	156	212	\N	\N	21	1
7409	10	158	212	\N	\N	21	1
741	7	72	7	\N	\N	7	\N
7410	3	161	212	\N	\N	21	1
7411	6	163	212	\N	\N	21	1
7412	10	164	212	\N	\N	21	1
7413	2	167	212	\N	\N	21	1
7414	1	75	212	\N	\N	21	1
7415	2	79	212	\N	\N	21	1
7416	4	86	212	\N	\N	21	1
7417	2	116	212	\N	\N	21	1
7418	20	170	212	\N	\N	21	1
7419	4	171	212	\N	\N	21	1
742	5	73	7	\N	\N	7	\N
7420	85	174	212	\N	\N	21	1
7421	1	175	212	\N	\N	21	1
7422	26	176	212	\N	\N	21	1
7423	4	186	212	\N	\N	21	1
7424	85	189	212	\N	\N	21	1
7425	15	191	212	\N	\N	21	1
7426	15	194	212	\N	\N	21	1
7427	21	196	212	\N	\N	21	1
7428	3	199	212	\N	\N	21	1
7429	6	204	212	\N	\N	21	1
743	3	75	7	\N	\N	7	\N
7430	11	211	212	\N	\N	21	1
7431	2	17	213	\N	\N	21	1
7432	149	18	213	\N	\N	21	1
7433	48	20	213	\N	\N	21	1
7434	3	33	213	\N	\N	21	1
7435	10	34	213	\N	\N	21	1
7436	19	35	213	\N	\N	21	1
7437	1	38	213	\N	\N	21	1
7438	26	39	213	\N	\N	21	1
7439	12	40	213	\N	\N	21	1
744	27	76	7	\N	\N	7	\N
7440	9	41	213	\N	\N	21	1
7441	3	44	213	\N	\N	21	1
7442	10	45	213	\N	\N	21	1
7443	5	55	213	\N	\N	21	1
7444	13	58	213	\N	\N	21	1
7445	14	59	213	\N	\N	21	1
7446	12	60	213	\N	\N	21	1
7447	2	117	213	\N	\N	21	1
7448	1	131	213	\N	\N	21	1
7449	1	144	213	\N	\N	21	1
745	19	79	7	\N	\N	7	\N
7450	11	153	213	\N	\N	21	1
7451	12	156	213	\N	\N	21	1
7452	2	163	213	\N	\N	21	1
7453	3	164	213	\N	\N	21	1
7454	1	167	213	\N	\N	21	1
7455	11	66	213	\N	\N	21	1
7456	2	67	213	\N	\N	21	1
7457	2	69	213	\N	\N	21	1
7458	8	83	213	\N	\N	21	1
7459	7	106	213	\N	\N	21	1
746	4	82	7	\N	\N	7	\N
7460	20	112	213	\N	\N	21	1
7461	8	113	213	\N	\N	21	1
7462	27	116	213	\N	\N	21	1
7463	12	170	213	\N	\N	21	1
7464	4	171	213	\N	\N	21	1
7465	12	174	213	\N	\N	21	1
7466	2	186	213	\N	\N	21	1
7467	4	189	213	\N	\N	21	1
7468	4	191	213	\N	\N	21	1
7469	8	194	213	\N	\N	21	1
747	61	83	7	\N	\N	7	\N
7470	4	196	213	\N	\N	21	1
7471	1	199	213	\N	\N	21	1
7472	7	204	213	\N	\N	21	1
7473	4	211	213	\N	\N	21	1
7474	8	18	214	\N	\N	21	1
7475	19	20	214	\N	\N	21	1
7476	2	39	214	\N	\N	21	1
7477	2	131	214	\N	\N	21	1
7478	1	135	214	\N	\N	21	1
7479	1	137	214	\N	\N	21	1
748	42	86	7	\N	\N	7	\N
7480	12	158	214	\N	\N	21	1
7481	6	161	214	\N	\N	21	1
7482	1	77	214	\N	\N	21	1
7483	1	79	214	\N	\N	21	1
7484	1	171	214	\N	\N	21	1
7485	23	174	214	\N	\N	21	1
7486	41	189	214	\N	\N	21	1
7487	3	191	214	\N	\N	21	1
7488	1	194	214	\N	\N	21	1
7489	4	204	214	\N	\N	21	1
749	3	87	7	\N	\N	7	\N
7490	4	205	214	\N	\N	21	1
7491	1	211	214	\N	\N	21	1
7492	1	7	215	\N	\N	21	1
7493	3	20	215	\N	\N	21	1
7494	5	43	215	\N	From Jim & Leslie: 2 M, 2 F, 1 immature	21	1
7495	1	117	215	\N	\N	21	1
7496	1	119	215	\N	\N	21	1
7497	9	131	215	\N	(4 at Roseballen)	21	1
7498	1	134	215	\N	\N	21	1
7499	1	135	215	\N	\N	21	1
75	3	149	1	\N	\N	1	\N
750	51	89	7	\N	\N	7	\N
7500	2	137	215	\N	From Jim & Leslie	21	1
7501	5	151	215	\N	\N	21	1
7502	10	153	215	\N	\N	21	1
7503	4	154	215	\N	\N	21	1
7504	19	156	215	\N	(4 at Roseballen)	21	1
7505	9	158	215	\N	\N	21	1
7506	12	160	215	\N	From Jim & Leslie	21	1
7507	2	161	215	\N	\N	21	1
7508	1	164	215	\N	\N	21	1
7509	1	167	215	\N	\N	21	1
751	1	90	7	\N	\N	7	\N
7510	1	75	215	\N	\N	21	1
7511	2	95	215	\N	\N	21	1
7512	2	170	215	\N	(2 at Roseballen)	21	1
7513	2	171	215	\N	\N	21	1
7514	35	174	215	\N	(2 at Roseballen)	21	1
7515	3	176	215	\N	\N	21	1
7516	4	186	215	\N	(1 at Roseballen)	21	1
7517	97	189	215	\N	(10 at Roseballen)	21	1
7518	22	191	215	\N	(12 at Roseballen)	21	1
7519	16	194	215	\N	(2 at Roseballen)	21	1
752	128	91	7	\N	\N	7	\N
7520	15	196	215	\N	(2 at Roseballen)	21	1
7521	14	199	215	\N	\N	21	1
7522	8	204	215	\N	(2 at Roseballen)	21	1
7523	6	207	215	\N	(1 at Roseballen)	21	1
7524	2	208	215	\N	(2 at Roseballen)	21	1
7525	31	211	215	\N	\N	21	1
7526	1	7	216	\N	\N	21	1
7527	25	18	216	\N	\N	21	1
7528	2	20	216	\N	\N	21	1
7529	11	34	216	\N	\N	21	1
753	54	92	7	\N	\N	7	\N
7530	8	39	216	\N	\N	21	1
7531	6	40	216	\N	\N	21	1
7532	3	41	216	\N	\N	21	1
7533	5	59	216	\N	\N	21	1
7534	2	131	216	\N	\N	21	1
7535	3	132	216	\N	\N	21	1
7536	6	137	216	\N	\N	21	1
7537	1	153	216	\N	\N	21	1
7538	2	156	216	\N	\N	21	1
7539	9	158	216	\N	\N	21	1
754	4	95	7	\N	\N	7	\N
7540	1	164	216	\N	\N	21	1
7541	10	66	216	\N	\N	21	1
7542	4	67	216	\N	\N	21	1
7543	2	69	216	\N	\N	21	1
7544	2	76	216	\N	\N	21	1
7545	1	79	216	\N	\N	21	1
7546	1	87	216	\N	\N	21	1
7547	71	106	216	\N	\N	21	1
7548	13	112	216	\N	\N	21	1
7549	2	171	216	\N	\N	21	1
755	2	97	7	\N	\N	7	\N
7550	19	174	216	\N	\N	21	1
7551	4	175	216	\N	\N	21	1
7552	11	176	216	\N	\N	21	1
7553	14	189	216	\N	\N	21	1
7554	2	190	216	\N	\N	21	1
7555	5	194	216	\N	\N	21	1
7556	6	196	216	\N	\N	21	1
7557	20	204	216	\N	\N	21	1
7558	50	207	216	\N	\N	21	1
7559	\N	126	217	t	1 heard night before the count	21	1
756	8	98	7	\N	\N	7	\N
7560	1	156	217	\N	\N	21	1
7561	8	158	217	\N	\N	21	1
7562	1	161	217	\N	\N	21	1
7563	1	174	217	\N	\N	21	1
7564	11	189	217	\N	\N	21	1
7565	1	194	217	\N	\N	21	1
7566	1	196	217	\N	\N	21	1
7567	6	204	217	\N	4 female 2 male (6 total)	21	1
7568	1	131	218	\N	1 hummingbird heard, no visual	21	1
7569	1	154	218	\N	\N	21	1
757	\N	99	7	t	\N	7	\N
7570	1	76	218	\N	\N	21	1
7571	1	79	218	\N	\N	21	1
7572	4	131	219	\N	\N	21	1
7573	1	137	219	\N	\N	21	1
7574	1	154	219	\N	\N	21	1
7575	2	156	219	\N	\N	21	1
7576	9	158	219	\N	\N	21	1
7577	3	161	219	\N	\N	21	1
7578	1	163	219	\N	\N	21	1
7579	1	164	219	\N	\N	21	1
758	7	100	7	\N	\N	7	\N
7580	1	73	219	\N	\N	21	1
7581	3	174	219	\N	\N	21	1
7582	2	175	219	\N	\N	21	1
7583	6	189	219	\N	\N	21	1
7584	1	190	219	\N	\N	21	1
7585	3	194	219	\N	\N	21	1
7586	2	196	219	\N	\N	21	1
7587	25	189	220	\N	\N	21	1
7588	2	191	220	\N	\N	21	1
7589	1	194	220	\N	\N	21	1
759	6	105	7	\N	\N	7	\N
7590	3	131	221	\N	\N	21	1
7591	2	137	221	\N	\N	21	1
7592	2	156	221	\N	\N	21	1
7593	13	158	221	\N	\N	21	1
7594	1	161	221	\N	\N	21	1
7595	1	163	221	\N	\N	21	1
7596	2	112	221	\N	\N	21	1
7597	2	174	221	\N	\N	21	1
7598	2	186	221	\N	\N	21	1
7599	4	189	221	\N	\N	21	1
76	68	151	1	\N	\N	1	\N
760	173	106	7	\N	\N	7	\N
7600	2	191	221	\N	\N	21	1
7601	2	194	221	\N	\N	21	1
7602	3	196	221	\N	\N	21	1
7603	4	204	221	\N	\N	21	1
7604	1	207	221	\N	\N	21	1
7605	2	158	222	\N	\N	21	1
7606	1	161	222	\N	\N	21	1
7607	1	175	222	\N	male	21	1
7608	17	189	222	\N	\N	21	1
7609	2	194	222	\N	\N	21	1
761	2	108	7	\N	\N	7	\N
7610	4	196	222	\N	\N	21	1
7611	\N	122	223	t	\N	21	1
7612	4	131	223	\N	\N	21	1
7613	2	137	223	\N	1 M, 1 F	21	1
7614	3	156	223	\N	\N	21	1
7615	5	158	223	\N	\N	21	1
7616	3	161	223	\N	\N	21	1
7617	1	171	223	\N	\N	21	1
7618	3	174	223	\N	\N	21	1
7619	1	184	223	\N	\N	21	1
762	1	110	7	\N	\N	7	\N
7620	1	186	223	\N	\N	21	1
7621	16	189	223	\N	\N	21	1
7622	3	194	223	\N	\N	21	1
7623	5	196	223	\N	\N	21	1
7624	2	204	223	\N	1 M, 1 F	21	1
7625	1	131	224	\N	\N	21	1
7626	1	154	224	\N	\N	21	1
7627	1	156	224	\N	\N	21	1
7628	3	158	224	\N	\N	21	1
7629	2	189	224	\N	\N	21	1
763	370	112	7	\N	\N	7	\N
7630	1	196	224	\N	\N	21	1
7631	2	205	224	\N	\N	21	1
7632	2	124	225	\N	\N	21	1
7633	3	131	225	\N	\N	21	1
7634	1	137	225	\N	\N	21	1
7635	1	151	225	\N	\N	21	1
7636	1	153	225	\N	\N	21	1
7637	1	156	225	\N	\N	21	1
7638	1	161	225	\N	\N	21	1
7639	1	164	225	\N	\N	21	1
764	57	113	7	\N	\N	7	\N
7640	5	170	225	\N	\N	21	1
7641	1	173	225	\N	\N	21	1
7642	1	174	225	\N	\N	21	1
7643	1	189	225	\N	\N	21	1
7644	2	194	225	\N	\N	21	1
7645	1	196	225	\N	\N	21	1
7646	51	7	226	\N	\N	21	2
7647	1	18	226	\N	\N	21	2
7648	34	20	226	\N	\N	21	2
7649	1	28	226	\N	\N	21	2
765	270	116	7	\N	\N	7	\N
7650	2	39	226	\N	\N	21	2
7651	2	43	226	\N	\N	21	2
7652	3	44	226	\N	\N	21	2
7653	7	131	226	\N	\N	21	2
7654	2	132	226	\N	\N	21	2
7655	1	134	226	\N	\N	21	2
7656	1	135	226	\N	\N	21	2
7657	10	137	226	\N	\N	21	2
7658	2	141	226	\N	\N	21	2
7659	1	148	226	\N	\N	21	2
766	174	117	7	\N	\N	7	\N
7660	4	151	226	\N	\N	21	2
7661	10	153	226	\N	\N	21	2
7662	10	154	226	\N	\N	21	2
7663	28	156	226	\N	\N	21	2
7664	37	158	226	\N	\N	21	2
7665	5	161	226	\N	\N	21	2
7666	1	163	226	\N	\N	21	2
7667	11	164	226	\N	\N	21	2
7668	1	166	226	\N	\N	21	2
7669	6	167	226	\N	\N	21	2
767	75	118	7	\N	\N	7	\N
7670	3	69	226	\N	\N	21	2
7671	2	75	226	\N	\N	21	2
7672	1	76	226	\N	Removed 1 presumed duplicate observation	21	2
7673	4	77	226	\N	Removed 1 presumed duplicate observation	21	2
7674	5	79	226	\N	\N	21	2
7675	1	82	226	\N	From Brian Bell	21	2
7676	2	86	226	\N	\N	21	2
7677	30	170	226	\N	\N	21	2
7678	9	171	226	\N	\N	21	2
7679	23	174	226	\N	\N	21	2
768	73	120	7	\N	\N	7	\N
7680	4	175	226	\N	\N	21	2
7681	17	176	226	\N	\N	21	2
7682	1	186	226	\N	\N	21	2
7683	135	189	226	\N	\N	21	2
7684	11	190	226	\N	\N	21	2
7685	11	191	226	\N	\N	21	2
7686	50	194	226	\N	\N	21	2
7687	2	195	226	\N	\N	21	2
7688	19	196	226	\N	\N	21	2
7689	7	199	226	\N	\N	21	2
769	2	123	7	\N	\N	7	\N
7690	5	204	226	\N	\N	21	2
7691	106	207	226	\N	\N	21	2
7692	6	211	226	\N	\N	21	2
7693	21	7	227	\N	\N	21	2
7694	16	18	227	\N	\N	21	2
7695	2	34	227	\N	\N	21	2
7696	2	39	227	\N	\N	21	2
7697	5	40	227	\N	\N	21	2
7698	2	44	227	\N	\N	21	2
7699	5	45	227	\N	\N	21	2
77	667	153	1	\N	\N	1	\N
770	2	124	7	\N	\N	7	\N
7700	3	59	227	\N	\N	21	2
7701	1	132	227	\N	\N	21	2
7702	3	154	227	\N	\N	21	2
7703	7	66	227	\N	\N	21	2
7704	1	69	227	\N	\N	21	2
7705	2	76	227	\N	\N	21	2
7706	1	77	227	\N	\N	21	2
7707	1	112	227	\N	\N	21	2
7708	7	116	227	\N	\N	21	2
7709	2	194	227	\N	\N	21	2
771	1	126	7	\N	\N	7	\N
7710	3	20	228	\N	\N	21	2
7711	6	34	228	\N	\N	21	2
7712	5	39	228	\N	\N	21	2
7713	30	40	228	\N	\N	21	2
7714	4	45	228	\N	\N	21	2
7715	1	137	228	\N	\N	21	2
7716	4	153	228	\N	\N	21	2
7717	1	154	228	\N	\N	21	2
7718	5	156	228	\N	\N	21	2
7719	5	158	228	\N	\N	21	2
772	2	129	7	\N	\N	7	\N
7720	1	163	228	\N	\N	21	2
7721	1	167	228	\N	\N	21	2
7722	1	168	228	\N	\N	21	2
7723	12	66	228	\N	\N	21	2
7724	1	67	228	\N	\N	21	2
7725	4	76	228	\N	\N	21	2
7726	1	103	228	\N	\N	21	2
7727	4	116	228	\N	\N	21	2
7728	1	171	228	\N	\N	21	2
7729	27	174	228	\N	\N	21	2
773	43	131	7	\N	\N	7	\N
7730	2	186	228	\N	\N	21	2
7731	30	189	228	\N	\N	21	2
7732	1	194	228	\N	\N	21	2
7733	1	196	228	\N	\N	21	2
7734	58	7	229	\N	\N	21	2
7735	38	18	229	\N	\N	21	2
7736	14	20	229	\N	\N	21	2
7737	4	34	229	\N	\N	21	2
7738	6	39	229	\N	\N	21	2
7739	4	40	229	\N	\N	21	2
774	17	132	7	\N	\N	7	\N
7740	10	41	229	\N	\N	21	2
7741	2	43	229	\N	\N	21	2
7742	3	45	229	\N	\N	21	2
7743	4	59	229	\N	\N	21	2
7744	6	60	229	\N	\N	21	2
7745	1	61	229	\N	\N	21	2
7746	15	117	229	\N	\N	21	2
7747	3	131	229	\N	\N	21	2
7748	1	132	229	\N	\N	21	2
7749	1	135	229	\N	\N	21	2
775	7	134	7	\N	\N	7	\N
7750	28	137	229	\N	\N	21	2
7751	2	143	229	\N	\N	21	2
7752	7	151	229	\N	\N	21	2
7753	28	153	229	\N	\N	21	2
7754	7	154	229	\N	\N	21	2
7755	10	156	229	\N	\N	21	2
7756	6	158	229	\N	\N	21	2
7757	7	160	229	\N	\N	21	2
7758	8	161	229	\N	\N	21	2
7759	4	163	229	\N	\N	21	2
776	19	135	7	\N	\N	7	\N
7760	34	164	229	\N	\N	21	2
7761	5	167	229	\N	\N	21	2
7762	4	66	229	\N	\N	21	2
7763	2	67	229	\N	\N	21	2
7764	\N	71	229	t	Count week record from Harsi & Ezra Parker	21	2
7765	4	76	229	\N	\N	21	2
7766	2	77	229	\N	\N	21	2
7767	4	79	229	\N	\N	21	2
7768	6	86	229	\N	\N	21	2
7769	1	100	229	\N	\N	21	2
777	3	136	7	\N	\N	7	\N
7770	2	106	229	\N	\N	21	2
7771	1	107	229	\N	\N	21	2
7772	13	113	229	\N	\N	21	2
7773	10	116	229	\N	\N	21	2
7774	58	170	229	\N	\N	21	2
7775	4	171	229	\N	\N	21	2
7776	187	174	229	\N	\N	21	2
7777	6	175	229	\N	\N	21	2
7778	95	176	229	\N	\N	21	2
7779	1	186	229	\N	\N	21	2
778	100	139	7	\N	\N	7	\N
7780	94	189	229	\N	\N	21	2
7781	4	191	229	\N	\N	21	2
7782	31	194	229	\N	\N	21	2
7783	24	196	229	\N	\N	21	2
7784	95	207	229	\N	\N	21	2
7785	2	137	230	\N	\N	21	2
7786	1	153	230	\N	\N	21	2
7787	4	156	230	\N	\N	21	2
7788	3	158	230	\N	\N	21	2
7789	2	161	230	\N	\N	21	2
779	12	141	7	\N	\N	7	\N
7790	1	76	230	\N	\N	21	2
7791	2	189	230	\N	\N	21	2
7792	1	204	230	\N	\N	21	2
7793	\N	124	231	t	\N	21	2
7794	4	131	231	\N	\N	21	2
7795	1	135	231	\N	\N	21	2
7796	3	137	231	\N	\N	21	2
7797	4	156	231	\N	\N	21	2
7798	22	158	231	\N	\N	21	2
7799	2	161	231	\N	\N	21	2
78	6	154	1	\N	\N	1	\N
780	1	143	7	\N	\N	7	\N
7800	1	164	231	\N	\N	21	2
7801	2	167	231	\N	\N	21	2
7802	4	171	231	\N	\N	21	2
7803	8	174	231	\N	\N	21	2
7804	\N	184	231	t	\N	21	2
7805	38	189	231	\N	\N	21	2
7806	4	194	231	\N	\N	21	2
7807	2	196	231	\N	\N	21	2
7808	5	204	231	\N	\N	21	2
7809	1	135	232	\N	\N	21	2
781	1	144	7	\N	\N	7	\N
7810	2	137	232	\N	\N	21	2
7811	1	141	232	\N	\N	21	2
7812	1	151	232	\N	\N	21	2
7813	1	154	232	\N	\N	21	2
7814	2	156	232	\N	\N	21	2
7815	4	158	232	\N	\N	21	2
7816	2	161	232	\N	\N	21	2
7817	1	168	232	\N	\N	21	2
7818	1	72	232	\N	\N	21	2
7819	2	79	232	\N	\N	21	2
782	\N	145	7	t	\N	7	\N
7820	2	171	232	\N	\N	21	2
7821	16	174	232	\N	\N	21	2
7822	1	175	232	\N	\N	21	2
7823	2	186	232	\N	\N	21	2
7824	8	189	232	\N	\N	21	2
7825	2	190	232	\N	\N	21	2
7826	1	194	232	\N	\N	21	2
7827	6	196	232	\N	\N	21	2
7828	3	131	233	\N	\N	21	2
7829	13	20	234	\N	\N	21	2
783	10	149	7	\N	\N	7	\N
7830	2	131	235	\N	\N	21	2
7831	2	135	235	\N	1 M, 1 F	21	2
7832	2	137	235	\N	\N	21	2
7833	1	141	235	\N	\N	21	2
7834	2	151	235	\N	\N	21	2
7835	2	156	235	\N	\N	21	2
7836	9	158	235	\N	\N	21	2
7837	1	161	235	\N	\N	21	2
7838	1	167	235	\N	\N	21	2
7839	20	174	235	\N	\N	21	2
784	152	151	7	\N	\N	7	\N
7840	1	175	235	\N	\N	21	2
7841	10	189	235	\N	\N	21	2
7842	2	191	235	\N	\N	21	2
7843	4	194	235	\N	\N	21	2
7844	4	196	235	\N	\N	21	2
7845	1	134	236	\N	\N	21	2
7846	1	135	236	\N	\N	21	2
7847	1	141	236	\N	\N	21	2
7848	1	149	236	\N	\N	21	2
7849	2	151	236	\N	\N	21	2
785	\N	152	7	t	\N	7	\N
7850	1	154	236	\N	\N	21	2
7851	6	158	236	\N	\N	21	2
7852	2	161	236	\N	\N	21	2
7853	3	164	236	\N	\N	21	2
7854	1	167	236	\N	\N	21	2
7855	1	79	236	\N	\N	21	2
7856	12	170	236	\N	\N	21	2
7857	2	171	236	\N	\N	21	2
7858	4	174	236	\N	\N	21	2
7859	1	186	236	\N	\N	21	2
786	987	153	7	\N	\N	7	\N
7860	3	194	236	\N	\N	21	2
7861	2	196	236	\N	\N	21	2
7862	12	207	236	\N	\N	21	2
7863	2	3	237	\N	\N	22	5
7864	60	7	237	\N	\N	22	5
7865	171	18	237	\N	\N	22	5
7866	10	20	237	\N	\N	22	5
7867	1	23	237	\N	Yukon Harbor: F	22	5
7868	8	24	237	\N	\N	22	5
7869	1	30	237	\N	\N	22	5
787	15	154	7	\N	\N	7	\N
7870	2	33	237	\N	\N	22	5
7871	67	34	237	\N	\N	22	5
7872	1	35	237	\N	Yukon Harbor: A M	22	5
7873	31	39	237	\N	Yukon Harbor: 6 F 1 M	22	5
7874	49	40	237	\N	\N	22	5
7875	6	43	237	\N	Yukon Harbor: F	22	5
7876	20	44	237	\N	\N	22	5
7877	34	45	237	\N	\N	22	5
7878	12	59	237	\N	\N	22	5
7879	7	60	237	\N	\N	22	5
788	252	156	7	\N	\N	7	\N
7880	3	120	237	\N	\N	22	5
7881	2	131	237	\N	\N	22	5
7882	38	89	237	\N	\N	22	5
7883	1	99	237	\N	\N	22	5
7884	1	100	237	\N	\N	22	5
7885	92	106	237	\N	\N	22	5
7886	3	112	237	\N	\N	22	5
7887	1	113	237	\N	\N	22	5
7888	36	114	237	\N	\N	22	5
7889	3	54	237	\N	\N	22	5
789	257	158	7	\N	\N	7	\N
7890	4	67	237	\N	\N	22	5
7891	51	66	237	\N	\N	22	5
7892	2	69	237	\N	\N	22	5
7893	1	76	237	\N	Middle School 8995 Southeast Sedgwick Road, Port Orchard: Heard	22	5
7894	1	77	237	\N	Yukon Harbor: 2 yr old	22	5
7895	5	132	237	\N	\N	22	5
7896	5	137	237	\N	\N	22	5
7897	4	151	237	\N	\N	22	5
7898	4	152	237	\N	\N	22	5
7899	20	153	237	\N	\N	22	5
79	163	156	1	\N	\N	1	\N
790	82	160	7	\N	\N	7	\N
7900	4	154	237	\N	\N	22	5
7901	5	156	237	\N	\N	22	5
7902	2	158	237	\N	\N	22	5
7903	4	170	237	\N	\N	22	5
7904	1	171	237	\N	\N	22	5
7905	2	163	237	\N	\N	22	5
7906	1	164	237	\N	\N	22	5
7907	1	176	237	\N	\N	22	5
7908	3	175	237	\N	\N	22	5
7909	16	174	237	\N	\N	22	5
791	65	161	7	\N	\N	7	\N
7910	3	211	237	\N	\N	22	5
7911	11	204	237	\N	\N	22	5
7912	100	207	237	\N	\N	22	5
7913	1	208	237	\N	\N	22	5
7914	4	186	237	\N	\N	22	5
7915	38	187	237	\N	\N	22	5
7916	27	194	237	\N	\N	22	5
7917	3	196	237	\N	\N	22	5
7918	11	199	237	\N	\N	22	5
7919	2	4	238	\N	Pic	22	5
792	18	163	7	\N	\N	7	\N
7920	1	2	238	\N	Pic	22	5
7921	9	6	238	\N	\N	22	5
7922	85	7	238	\N	\N	22	5
7923	2	8	238	\N	\N	22	5
7924	48	15	238	\N	Shocking aggregation in one pond area	22	5
7925	55	18	238	\N	\N	22	5
7926	330	20	238	\N	Estimated by tens & twenties in flooded fields	22	5
7927	1	23	238	\N	\N	22	5
7928	1	34	238	\N	\N	22	5
7929	4	39	238	\N	\N	22	5
793	92	165	7	\N	\N	7	\N
7930	1	131	238	\N	\N	22	5
7931	11	86	238	\N	\N	22	5
7932	2	95	238	\N	\N	22	5
7933	1	112	238	\N	\N	22	5
7934	1	66	238	\N	\N	22	5
7935	2	76	238	\N	\N	22	5
7936	1	79	238	\N	\N	22	5
7937	1	132	238	\N	\N	22	5
7938	1	135	238	\N	\N	22	5
7939	11	139	238	\N	\N	22	5
794	1	166	7	\N	\N	7	\N
7940	1	149	238	\N	\N	22	5
7941	14	151	238	\N	\N	22	5
7942	10	154	238	\N	\N	22	5
7943	26	156	238	\N	\N	22	5
7944	2	158	238	\N	\N	22	5
7945	17	160	238	\N	\N	22	5
7946	33	170	238	\N	\N	22	5
7947	18	171	238	\N	\N	22	5
7948	3	161	238	\N	\N	22	5
7949	1	163	238	\N	\N	22	5
795	28	167	7	\N	\N	7	\N
7950	2	164	238	\N	\N	22	5
7951	1	166	238	\N	\N	22	5
7952	2	167	238	\N	\N	22	5
7953	412	176	238	\N	\N	22	5
7954	7	175	238	\N	1 half albino (leukistic)  just south of Howe Farm at Salmonberry Creek crossing	22	5
7955	218	174	238	\N	\N	22	5
7956	5	205	238	\N	\N	22	5
7957	15	206	238	\N	\N	22	5
7958	65	207	238	\N	\N	22	5
7959	19	186	238	\N	\N	22	5
796	352	170	7	\N	\N	7	\N
7960	141	189	238	\N	1 half albino (leukistic) just south of Howe Farm at Salmonberry Creek crossing	22	5
7961	9	190	238	\N	\N	22	5
7962	8	191	238	\N	\N	22	5
7963	50	194	238	\N	\N	22	5
7964	1	195	238	\N	\N	22	5
7965	37	196	238	\N	\N	22	5
7966	187	199	238	\N	\N	22	5
7967	80	201	238	\N	Flocking with EUST and RWBL on horse pasturage and along wetlands	22	5
7968	1	20	239	\N	\N	22	5
7969	1	29	239	\N	\N	22	5
797	215	171	7	\N	\N	7	\N
7970	22	34	239	\N	\N	22	5
7971	2	35	239	\N	\N	22	5
7972	11	39	239	\N	\N	22	5
7973	29	40	239	\N	\N	22	5
7974	4	41	239	\N	\N	22	5
7975	1	43	239	\N	\N	22	5
7976	2	45	239	\N	\N	22	5
7977	6	59	239	\N	\N	22	5
7978	1	64	239	\N	\N	22	5
7979	2	119	239	\N	\N	22	5
798	2	173	7	\N	\N	7	\N
7980	8	131	239	\N	\N	22	5
7981	1	87	239	\N	\N	22	5
7982	4	106	239	\N	\N	22	5
7983	4	112	239	\N	\N	22	5
7984	4	113	239	\N	\N	22	5
7985	2	65	239	\N	\N	22	5
7986	1	67	239	\N	\N	22	5
7987	16	66	239	\N	\N	22	5
7988	1	69	239	\N	\N	22	5
7989	3	76	239	\N	\N	22	5
799	1737	174	7	\N	\N	7	\N
7990	2	77	239	\N	\N	22	5
7991	1	124	239	\N	\N	22	5
7992	1	135	239	\N	\N	22	5
7993	2	141	239	\N	\N	22	5
7994	1	137	239	\N	\N	22	5
7995	2	149	239	\N	\N	22	5
7996	10	151	239	\N	\N	22	5
7997	24	153	239	\N	\N	22	5
7998	6	154	239	\N	\N	22	5
7999	17	156	239	\N	\N	22	5
8	63	24	1	\N	\N	1	\N
80	\N	157	1	t	\N	1	\N
800	24	175	7	\N	\N	7	\N
8000	15	158	239	\N	\N	22	5
8001	9	160	239	\N	\N	22	5
8002	20	170	239	\N	\N	22	5
8003	18	171	239	\N	\N	22	5
8004	9	161	239	\N	\N	22	5
8005	4	163	239	\N	\N	22	5
8006	7	164	239	\N	\N	22	5
8007	2	167	239	\N	\N	22	5
8008	13	176	239	\N	\N	22	5
8009	4	175	239	\N	\N	22	5
801	3284	176	7	\N	\N	7	\N
8010	1	173	239	\N	\N	22	5
8011	28	174	239	\N	\N	22	5
8012	6	211	239	\N	\N	22	5
8013	6	204	239	\N	\N	22	5
8014	1	205	239	\N	\N	22	5
8015	17	207	239	\N	\N	22	5
8016	14	186	239	\N	\N	22	5
8017	75	189	239	\N	\N	22	5
8018	4	190	239	\N	\N	22	5
8019	31	191	239	\N	\N	22	5
802	151	178	7	\N	\N	7	\N
8020	32	194	239	\N	\N	22	5
8021	20	196	239	\N	\N	22	5
8022	1	199	239	\N	\N	22	5
8023	1	184	239	\N	\N	22	5
8024	\N	124	240	t	\N	22	5
8025	\N	126	240	t	\N	22	5
8026	1	131	240	\N	\N	22	5
8027	\N	134	240	t	male	22	5
8028	2	135	240	\N	1 m, 1 f	22	5
8029	\N	136	240	t	1 m, 1 f	22	5
803	8	184	7	\N	\N	7	\N
8030	1	137	240	\N	\N	22	5
8031	\N	141	240	t	\N	22	5
8032	2	151	240	\N	\N	22	5
8033	\N	153	240	t	\N	22	5
8034	\N	154	240	t	\N	22	5
8035	2	156	240	\N	\N	22	5
8036	3	158	240	\N	\N	22	5
8037	20	160	240	\N	\N	22	5
8038	1	161	240	\N	\N	22	5
8039	\N	167	240	t	\N	22	5
804	59	186	7	\N	\N	7	\N
8040	\N	171	240	t	\N	22	5
8041	3	174	240	\N	\N	22	5
8042	2	175	240	\N	\N	22	5
8043	1	184	240	\N	male	22	5
8044	1	186	240	\N	\N	22	5
8045	10	189	240	\N	\N	22	5
8046	3	196	240	\N	2 m, 1 f	22	5
8047	12	207	240	\N	\N	22	5
8048	1	210	240	\N	female	22	5
8049	3	7	241	\N	\N	22	6
805	2	188	7	\N	\N	7	\N
8050	12	15	241	\N	\N	22	6
8051	55	20	241	\N	\N	22	6
8052	20	28	241	\N	\N	22	6
8053	4	34	241	\N	\N	22	6
8054	51	39	241	\N	\N	22	6
8055	20	40	241	\N	\N	22	6
8056	9	43	241	\N	\N	22	6
8057	7	44	241	\N	\N	22	6
8058	6	45	241	\N	\N	22	6
8059	15	59	241	\N	\N	22	6
806	695	189	7	\N	\N	7	\N
8060	2	120	241	\N	\N	22	6
8061	3	131	241	\N	\N	22	6
8062	35	106	241	\N	\N	22	6
8063	13	112	241	\N	\N	22	6
8064	4	113	241	\N	\N	22	6
8065	1	55	241	\N	\N	22	6
8066	3	67	241	\N	\N	22	6
8067	10	66	241	\N	\N	22	6
8068	2	68	241	\N	\N	22	6
8069	4	76	241	\N	WAVA_CBC: 3 adult, 1 immature.	22	6
807	24	190	7	\N	\N	7	\N
8070	1	77	241	\N	WAVA_CBC: 3 adult, 1 immature.	22	6
8071	2	79	241	\N	\N	22	6
8072	2	132	241	\N	\N	22	6
8073	1	135	241	\N	\N	22	6
8074	1	141	241	\N	\N	22	6
8075	12	137	241	\N	\N	22	6
8076	13	151	241	\N	\N	22	6
8077	4	152	241	\N	\N	22	6
8078	20	153	241	\N	\N	22	6
8079	4	154	241	\N	\N	22	6
808	121	191	7	\N	\N	7	\N
8080	19	156	241	\N	\N	22	6
8081	10	158	241	\N	\N	22	6
8082	33	170	241	\N	\N	22	6
8083	10	171	241	\N	\N	22	6
8084	5	161	241	\N	\N	22	6
8085	2	163	241	\N	\N	22	6
8086	8	164	241	\N	\N	22	6
8087	1	166	241	\N	\N	22	6
8088	2	167	241	\N	\N	22	6
8089	20	176	241	\N	\N	22	6
809	2	193	7	\N	\N	7	\N
8090	22	175	241	\N	\N	22	6
8091	90	174	241	\N	\N	22	6
8092	16	204	241	\N	\N	22	6
8093	13	205	241	\N	\N	22	6
8094	144	207	241	\N	\N	22	6
8095	1	186	241	\N	\N	22	6
8096	2	186	241	\N	\N	22	6
8097	232	187	241	\N	\N	22	6
8098	1	188	241	\N	\N	22	6
8099	161	189	241	\N	\N	22	6
81	197	158	1	\N	\N	1	\N
810	237	194	7	\N	\N	7	\N
8100	15	191	241	\N	\N	22	6
8101	1	193	241	\N	\N	22	6
8102	44	194	241	\N	\N	22	6
8103	27	196	241	\N	\N	22	6
8104	16	199	241	\N	\N	22	6
8105	29	20	242	\N	\N	22	6
8106	105	28	242	\N	Long Lake (Kitsap Co.): 1 group of 60 south end, 25 north end, 20 scattered.	22	6
8107	26	29	242	\N	\N	22	6
8108	83	30	242	\N	\N	22	6
8109	10	31	242	\N	\N	22	6
811	1	195	7	\N	\N	7	\N
8110	227	39	242	\N	\N	22	6
8111	8	44	242	\N	\N	22	6
8112	39	58	242	\N	\N	22	6
8113	1	83	242	\N	\N	22	6
8114	2	112	242	\N	\N	22	6
8115	23	66	242	\N	\N	22	6
8116	1	73	242	\N	\N	22	6
8117	2	76	242	\N	\N	22	6
8118	2	132	242	\N	\N	22	6
8119	1	135	242	\N	\N	22	6
812	141	196	7	\N	\N	7	\N
8120	3	137	242	\N	\N	22	6
8121	4	151	242	\N	\N	22	6
8122	7	153	242	\N	\N	22	6
8123	2	154	242	\N	\N	22	6
8124	1	158	242	\N	\N	22	6
8125	1	164	242	\N	\N	22	6
8126	8	176	242	\N	\N	22	6
8127	16	174	242	\N	\N	22	6
8128	3	205	242	\N	\N	22	6
8129	45	207	242	\N	\N	22	6
813	210	199	7	\N	\N	7	\N
8130	11	189	242	\N	\N	22	6
8131	2	194	242	\N	\N	22	6
8132	4	196	242	\N	\N	22	6
8133	5	199	242	\N	\N	22	6
8134	1	20	243	\N	\N	22	6
8135	2	86	243	\N	\N	22	6
8136	99	7	244	\N	\N	22	6
8137	15	12	244	\N	\N	22	6
8138	6	15	244	\N	\N	22	6
8139	8	16	244	\N	\N	22	6
814	21	201	7	\N	\N	7	\N
8140	39	18	244	\N	\N	22	6
8141	152	20	244	\N	\N	22	6
8142	10	24	244	\N	\N	22	6
8143	20	25	244	\N	\N	22	6
8144	8	39	244	\N	\N	22	6
8145	1	40	244	\N	\N	22	6
8146	3	43	244	\N	\N	22	6
8147	2	44	244	\N	\N	22	6
8148	1	119	244	\N	\N	22	6
8149	15	120	244	\N	\N	22	6
815	175	204	7	\N	\N	7	\N
8150	4	131	244	\N	\N	22	6
8151	2	82	244	\N	\N	22	6
8152	1	95	244	\N	\N	22	6
8153	26	112	244	\N	\N	22	6
8154	1	69	244	\N	\N	22	6
8155	7	76	244	\N	\N	22	6
8156	4	79	244	\N	\N	22	6
8157	2	132	244	\N	\N	22	6
8158	2	134	244	\N	\N	22	6
8159	1	135	244	\N	\N	22	6
816	58	205	7	\N	\N	7	\N
8160	7	137	244	\N	\N	22	6
8161	2	143	244	\N	\N	22	6
8162	1	151	244	\N	\N	22	6
8163	30	153	244	\N	\N	22	6
8164	8	154	244	\N	\N	22	6
8165	10	156	244	\N	\N	22	6
8166	10	158	244	\N	\N	22	6
8167	4	171	244	\N	\N	22	6
8168	1	161	244	\N	\N	22	6
8169	1	164	244	\N	\N	22	6
817	3	206	7	\N	\N	7	\N
8170	1	166	244	\N	\N	22	6
8171	1	167	244	\N	\N	22	6
8172	98	176	244	\N	\N	22	6
8173	1	175	244	\N	\N	22	6
8174	162	174	244	\N	\N	22	6
8175	6	211	244	\N	\N	22	6
8176	14	204	244	\N	\N	22	6
8177	2	205	244	\N	\N	22	6
8178	208	207	244	\N	\N	22	6
8179	4	186	244	\N	\N	22	6
818	441	207	7	\N	\N	7	\N
8180	97	189	244	\N	\N	22	6
8181	1	190	244	\N	\N	22	6
8182	21	191	244	\N	\N	22	6
8183	22	194	244	\N	\N	22	6
8184	1	195	244	\N	\N	22	6
8185	3	196	244	\N	\N	22	6
8186	7	196	244	\N	\N	22	6
8187	76	199	244	\N	\N	22	6
8188	1	131	245	\N	\N	22	6
8189	1	137	245	\N	\N	22	6
819	140	208	7	\N	\N	7	\N
8190	3	158	245	\N	\N	22	6
8191	1	161	245	\N	\N	22	6
8192	8	189	245	\N	\N	22	6
8193	2	196	245	\N	\N	22	6
8194	11	207	245	\N	\N	22	6
8195	25	4	246	\N	\N	22	3
8196	\N	5	246	t	Point Robinson: 3 From Ezra Parker on 1/5	22	3
8197	25	10	246	\N	Point Robinson: Seen in silhouette amidst fog and rain.	22	3
8198	40	13	246	\N	4218 SW Luana Beach Rd, Vashon: Flying north up the sound.  Difficult to see through rain and fog, but swan profile unmistakable.	22	3
8199	2	20	246	\N	\N	22	3
82	22	160	1	\N	\N	1	\N
820	\N	209	7	t	\N	7	\N
8200	8	33	246	\N	\N	22	3
8201	10	34	246	\N	\N	22	3
8202	16	39	246	\N	\N	22	3
8203	14	40	246	\N	\N	22	3
8204	2	41	246	\N	\N	22	3
8205	7	45	246	\N	\N	22	3
8206	17	59	246	\N	\N	22	3
8207	1	60	246	\N	\N	22	3
8208	11	131	246	\N	\N	22	3
8209	1	99	246	\N	\N	22	3
821	4	210	7	\N	\N	7	\N
8210	\N	102	246	t	Point Robinson: 11 From Ezra Parker on 1/5	22	3
8211	2	106	246	\N	\N	22	3
8212	13	113	246	\N	\N	22	3
8213	1	55	246	\N	\N	22	3
8214	1	66	246	\N	\N	22	3
8215	1	69	246	\N	\N	22	3
8216	3	76	246	\N	4218 SW Luana Beach Rd, Vashon: Adult\nPoint Robinson: Originally reported as 1 Adult, decremented due to assumed overlap with count from Luana Beach Road	22	3
8217	3	79	246	\N	\N	22	3
8218	1	135	246	\N	\N	22	3
8219	10	137	246	\N	\N	22	3
822	85	211	7	\N	\N	7	\N
8220	1	144	246	\N	\N	22	3
8221	5	151	246	\N	\N	22	3
8222	16	153	246	\N	\N	22	3
8223	1	154	246	\N	\N	22	3
8224	11	156	246	\N	\N	22	3
8225	6	170	246	\N	\N	22	3
8226	4	171	246	\N	\N	22	3
8227	3	163	246	\N	\N	22	3
8228	2	164	246	\N	\N	22	3
8229	2	167	246	\N	\N	22	3
823	1	2	8	\N	\N	8	\N
8230	39	176	246	\N	\N	22	3
8231	47	175	246	\N	\N	22	3
8232	71	174	246	\N	\N	22	3
8233	\N	178	246	t	24101–24223 48th Pl SW, Vashon: From Sue Trevathan and Ezra Parker on 1/1	22	3
8234	3	204	246	\N	\N	22	3
8235	623	207	246	\N	\N	22	3
8236	2	186	246	\N	\N	22	3
8237	125	189	246	\N	\N	22	3
8238	41	191	246	\N	\N	22	3
8239	29	194	246	\N	\N	22	3
824	9	5	8	\N	\N	8	\N
8240	8	196	246	\N	\N	22	3
8241	2	181	246	\N	\N	22	3
8242	57	7	247	\N	\N	22	3
8243	8	20	247	\N	\N	22	3
8244	8	131	247	\N	\N	22	3
8245	1	134	247	\N	\N	22	3
8246	1	135	247	\N	\N	22	3
8247	4	137	247	\N	\N	22	3
8248	1	152	247	\N	\N	22	3
8249	12	153	247	\N	\N	22	3
825	3	6	8	\N	\N	8	\N
8250	3	154	247	\N	\N	22	3
8251	3	156	247	\N	\N	22	3
8252	4	158	247	\N	\N	22	3
8253	3	161	247	\N	\N	22	3
8254	1	164	247	\N	\N	22	3
8255	2	167	247	\N	\N	22	3
8256	1	69	247	\N	\N	22	3
8257	1	76	247	\N	\N	22	3
8258	15	116	247	\N	\N	22	3
8259	1	170	247	\N	\N	22	3
826	461	7	8	\N	\N	8	\N
8260	3	171	247	\N	\N	22	3
8261	99	174	247	\N	\N	22	3
8262	17	175	247	\N	\N	22	3
8263	259	189	247	\N	\N	22	3
8264	15	190	247	\N	\N	22	3
8265	45	191	247	\N	\N	22	3
8266	14	194	247	\N	\N	22	3
8267	7	196	247	\N	\N	22	3
8268	7	204	247	\N	\N	22	3
8269	1	205	247	\N	\N	22	3
827	19	15	8	\N	\N	8	\N
8270	227	207	247	\N	\N	22	3
8271	1	208	247	\N	\N	22	3
8272	12	211	247	\N	\N	22	3
8273	16	7	248	\N	\N	22	3
8274	119	18	248	\N	Ellisport, Vashon: Randy Turner reported 119 in the afternoon, difference from morning tally added here	22	3
8275	27	20	248	\N	Ellisport, Vashon: Randy Turner reported 2 in the afternoon, added here	22	3
8276	7	29	248	\N	\N	22	3
8277	1	30	248	\N	\N	22	3
8278	46	34	248	\N	\N	22	3
8279	4	35	248	\N	\N	22	3
828	15	16	8	\N	\N	8	\N
8280	59	39	248	\N	\N	22	3
8281	43	40	248	\N	\N	22	3
8282	6	41	248	\N	\N	22	3
8283	1	43	248	\N	\N	22	3
8284	2	44	248	\N	\N	22	3
8285	29	45	248	\N	\N	22	3
8286	36	59	248	\N	\N	22	3
8287	15	60	248	\N	\N	22	3
8288	9	61	248	\N	Portage, Vashon: Known population at this location	22	3
8289	6	117	248	\N	\N	22	3
829	9	17	8	\N	\N	8	\N
8290	8	119	248	\N	\N	22	3
8291	17	131	248	\N	\N	22	3
8292	2	86	248	\N	\N	22	3
8293	1	87	248	\N	\N	22	3
8294	1	88	248	\N	\N	22	3
8295	4	100	248	\N	\N	22	3
8296	2	103	248	\N	\N	22	3
8297	3	106	248	\N	Ellisport, Vashon: Randy Turner reported 3 in the afternoon, difference from morning tally for all locations on Tramp Harbor added here	22	3
8298	14	112	248	\N	Ellisport, Vashon: Randy Turner reported 30 in the afternoon, difference from morning tally for all locations on Tramp Harbor added here	22	3
8299	7	113	248	\N	\N	22	3
83	59	161	1	\N	\N	1	\N
830	2346	18	8	\N	\N	8	\N
8300	17	114	248	\N	\N	22	3
8301	3	55	248	\N	\N	22	3
8302	1	65	248	\N	\N	22	3
8303	4	67	248	\N	\N	22	3
8304	12	66	248	\N	\N	22	3
8305	4	69	248	\N	Ellisport, Vashon: Randy Turner reported 1 in the afternoon, added here	22	3
8306	1	72	248	\N	Upper Gold Beach, Vashon: Immature	22	3
8307	1	76	248	\N	Lower Gold Beach, Vashon: 1 adult, 1 immature	22	3
8308	2	77	248	\N	Rabbs Lagoon: Immature\nLower Gold Beach, Vashon: 1 adult, 1 immature	22	3
8309	3	79	248	\N	\N	22	3
831	471	20	8	\N	\N	8	\N
8310	2	132	248	\N	\N	22	3
8311	1	135	248	\N	\N	22	3
8312	9	137	248	\N	\N	22	3
8313	1	144	248	\N	\N	22	3
8314	7	151	248	\N	\N	22	3
8315	22	153	248	\N	Ellisport, Vashon: Randy Turner reported 7 in the afternoon, added here	22	3
8316	3	154	248	\N	\N	22	3
8317	8	156	248	\N	\N	22	3
8318	21	158	248	\N	Ellisport, Vashon: Randy Turner reported 3 in the afternoon, added here	22	3
8319	6	170	248	\N	\N	22	3
832	3	22	8	\N	\N	8	\N
8320	5	171	248	\N	\N	22	3
8321	9	161	248	\N	\N	22	3
8322	6	164	248	\N	\N	22	3
8323	1	167	248	\N	\N	22	3
8324	8	175	248	\N	\N	22	3
8325	3	173	248	\N	Portage, Vashon: 1 "poached" at Portage Marsh in VS East area	22	3
8326	41	174	248	\N	Ellisport, Vashon: Randy Turner reported 5 in the afternoon, added here	22	3
8327	3	211	248	\N	\N	22	3
8328	23	204	248	\N	\N	22	3
8329	6	205	248	\N	\N	22	3
833	51	24	8	\N	\N	8	\N
8330	498	207	248	\N	\N	22	3
8331	7	208	248	\N	\N	22	3
8332	3	186	248	\N	\N	22	3
8333	107	189	248	\N	Ellisport, Vashon: Randy Turner reported 2 in the afternoon, added here	22	3
8334	8	190	248	\N	\N	22	3
8335	23	191	248	\N	\N	22	3
8336	1	193	248	\N	\N	22	3
8337	29	194	248	\N	\N	22	3
8338	12	196	248	\N	\N	22	3
8339	4	181	248	\N	\N	22	3
834	4	27	8	\N	\N	8	\N
8340	4	183	248	\N	\N	22	3
8341	2	131	249	\N	\N	22	3
8342	1	135	249	\N	1 female plus 1 male CW	22	3
8343	1	137	249	\N	\N	22	3
8344	\N	141	249	t	female	22	3
8345	2	151	249	\N	\N	22	3
8346	\N	153	249	t	\N	22	3
8347	2	156	249	\N	\N	22	3
8348	4	158	249	\N	\N	22	3
8349	1	161	249	\N	\N	22	3
835	57	28	8	\N	\N	8	\N
8350	5	189	249	\N	\N	22	3
8351	4	191	249	\N	\N	22	3
8352	1	196	249	\N	\N	22	3
8353	31	207	249	\N	\N	22	3
8354	2	131	250	\N	\N	22	3
8355	1	151	250	\N	\N	22	3
8356	1	153	250	\N	\N	22	3
8357	3	158	250	\N	\N	22	3
8358	2	161	250	\N	\N	22	3
8359	1	186	250	\N	\N	22	3
836	124	29	8	\N	\N	8	\N
8360	5	189	250	\N	\N	22	3
8361	2	191	250	\N	\N	22	3
8362	6	194	250	\N	\N	22	3
8363	4	196	250	\N	\N	22	3
8364	5	204	250	\N	\N	22	3
8365	8	207	250	\N	\N	22	3
8366	2	131	251	\N	\N	22	3
8367	1	135	251	\N	\N	22	3
8368	3	137	251	\N	\N	22	3
8369	4	151	251	\N	\N	22	3
837	15	30	8	\N	\N	8	\N
8370	3	153	251	\N	\N	22	3
8371	2	154	251	\N	\N	22	3
8372	2	156	251	\N	\N	22	3
8373	8	158	251	\N	\N	22	3
8374	2	161	251	\N	\N	22	3
8375	1	171	251	\N	\N	22	3
8376	25	174	251	\N	\N	22	3
8377	6	175	251	\N	\N	22	3
8378	2	186	251	\N	\N	22	3
8379	30	189	251	\N	\N	22	3
838	2	31	8	\N	\N	8	\N
8380	1	193	251	\N	\N	22	3
8381	2	194	251	\N	\N	22	3
8382	2	196	251	\N	\N	22	3
8383	50	207	251	\N	\N	22	3
8384	15	7	252	\N	\N	22	3
8385	12	20	252	\N	\N	22	3
8386	1	131	252	\N	\N	22	3
8387	5	137	252	\N	\N	22	3
8388	1	151	252	\N	\N	22	3
8389	42	153	252	\N	\N	22	3
839	13	33	8	\N	\N	8	\N
8390	9	156	252	\N	\N	22	3
8391	2	158	252	\N	\N	22	3
8392	4	163	252	\N	\N	22	3
8393	1	164	252	\N	\N	22	3
8394	1	167	252	\N	\N	22	3
8395	1	72	252	\N	Originally reported 2	22	3
8396	\N	76	252	t	\N	22	3
8397	1	79	252	\N	Originally reported 2	22	3
8398	4	171	252	\N	\N	22	3
8399	39	174	252	\N	\N	22	3
84	9	163	1	\N	\N	1	\N
840	796	34	8	\N	\N	8	\N
8400	12	176	252	\N	\N	22	3
8401	36	189	252	\N	\N	22	3
8402	15	191	252	\N	\N	22	3
8403	5	194	252	\N	\N	22	3
8404	12	196	252	\N	\N	22	3
8405	2	204	252	\N	\N	22	3
8406	9	207	252	\N	\N	22	3
8407	4	208	252	\N	\N	22	3
8408	23	131	253	\N	\N	22	3
8409	1	126	254	\N	\N	22	3
841	634	35	8	\N	\N	8	\N
8410	6	131	254	\N	\N	22	3
8411	1	135	254	\N	\N	22	3
8412	2	137	254	\N	\N	22	3
8413	2	151	254	\N	\N	22	3
8414	4	153	254	\N	\N	22	3
8415	1	154	254	\N	\N	22	3
8416	4	156	254	\N	\N	22	3
8417	16	158	254	\N	\N	22	3
8418	6	161	254	\N	\N	22	3
8419	2	163	254	\N	\N	22	3
842	27	36	8	\N	\N	8	\N
8420	2	79	254	\N	\N	22	3
8421	2	171	254	\N	\N	22	3
8422	1	173	254	\N	\N	22	3
8423	2	174	254	\N	\N	22	3
8424	2	175	254	\N	\N	22	3
8425	1	186	254	\N	\N	22	3
8426	15	189	254	\N	\N	22	3
8427	6	194	254	\N	\N	22	3
8428	4	196	254	\N	\N	22	3
8429	2	205	254	\N	\N	22	3
843	10	37	8	\N	\N	8	\N
8430	60	207	254	\N	\N	22	3
8431	4	208	254	\N	\N	22	3
8432	3	131	255	\N	\N	22	3
8433	1	135	255	\N	\N	22	3
8434	1	137	255	\N	\N	22	3
8435	1	151	255	\N	\N	22	3
8436	6	158	255	\N	\N	22	3
8437	2	161	255	\N	\N	22	3
8438	2	189	255	\N	\N	22	3
8439	6	191	255	\N	\N	22	3
844	428	39	8	\N	\N	8	\N
8440	1	194	255	\N	\N	22	3
8441	2	196	255	\N	\N	22	3
8442	4	204	255	\N	\N	22	3
8443	14	208	255	\N	\N	22	3
8444	7	7	256	\N	\N	22	3
8445	0	41	256	\N	2 reported, but also recorded by MT East team	22	3
8446	0	59	256	\N	2 reported, but also recorded by MT East team	22	3
8447	1	60	256	\N	\N	22	3
8448	2	126	256	\N	\N	22	3
8449	2	131	256	\N	2 m	22	3
845	329	40	8	\N	\N	8	\N
8450	2	135	256	\N	2 f	22	3
8451	3	137	256	\N	1 m, 2 f	22	3
8452	1	144	256	\N	\N	22	3
8453	29	153	256	\N	\N	22	3
8454	2	154	256	\N	\N	22	3
8455	3	156	256	\N	\N	22	3
8456	6	158	256	\N	\N	22	3
8457	1	164	256	\N	\N	22	3
8458	0	66	256	\N	1 reported, but also recorded by MT East team	22	3
8459	0	69	256	\N	1 reported, but also recorded by MT East team	22	3
846	129	41	8	\N	\N	8	\N
8460	1	73	256	\N	\N	22	3
8461	0	76	256	\N	2 reported, but also recorded by MT East team	22	3
8462	3	77	256	\N	\N	22	3
8463	21	112	256	\N	26 reported, subtracted 5 recorded by MT East team	22	3
8464	6	174	256	\N	\N	22	3
8465	2	175	256	\N	\N	22	3
8466	1	184	256	\N	\N	22	3
8467	53	189	256	\N	\N	22	3
8468	2	194	256	\N	\N	22	3
8469	2	196	256	\N	\N	22	3
847	3	42	8	\N	\N	8	\N
8470	3	204	256	\N	3 f	22	3
8471	1500	207	256	\N	Estimated 1200-1800	22	3
8472	1	131	257	\N	\N	22	3
8473	1	135	257	\N	\N	22	3
8474	1	137	257	\N	Red-shafted	22	3
8475	1	153	257	\N	\N	22	3
8476	1	156	257	\N	\N	22	3
8477	2	158	257	\N	\N	22	3
8478	1	161	257	\N	\N	22	3
8479	1	76	257	\N	\N	22	3
848	116	43	8	\N	\N	8	\N
8480	10	174	257	\N	\N	22	3
8481	2	189	257	\N	\N	22	3
8482	2	194	257	\N	\N	22	3
8483	1	196	257	\N	\N	22	3
8484	2	204	257	\N	\N	22	3
8485	1	205	257	\N	\N	22	3
8486	14	207	257	\N	\N	22	3
8487	179	7	258	\N	\N	22	7
8488	1	17	258	\N	\N	22	7
8489	41	18	258	\N	\N	22	7
849	114	44	8	\N	\N	8	\N
8490	196	20	258	\N	\N	22	7
8491	17	28	258	\N	\N	22	7
8492	3	29	258	\N	\N	22	7
8493	76	31	258	\N	\N	22	7
8494	5	33	258	\N	\N	22	7
8495	590	34	258	\N	\N	22	7
8496	107	39	258	\N	\N	22	7
8497	88	40	258	\N	\N	22	7
8498	30	43	258	\N	\N	22	7
8499	6	44	258	\N	\N	22	7
85	91	165	1	\N	\N	1	\N
850	187	45	8	\N	\N	8	\N
8500	47	45	258	\N	\N	22	7
8501	1	57	258	\N	\N	22	7
8502	1	58	258	\N	\N	22	7
8503	20	59	258	\N	\N	22	7
8504	1	60	258	\N	\N	22	7
8505	3	118	258	\N	\N	22	7
8506	3	119	258	\N	\N	22	7
8507	1	120	258	\N	\N	22	7
8508	2	124	258	\N	\N	22	7
8509	1	126	258	\N	\N	22	7
851	48	47	8	\N	\N	8	\N
8510	33	131	258	\N	\N	22	7
8511	3	132	258	\N	\N	22	7
8512	2	134	258	\N	\N	22	7
8513	5	135	258	\N	\N	22	7
8514	1	136	258	\N	\N	22	7
8515	45	137	258	\N	\N	22	7
8516	3	141	258	\N	\N	22	7
8517	1	144	258	\N	\N	22	7
8518	1	145	258	\N	\N	22	7
8519	1	149	258	\N	\N	22	7
852	1	49	8	\N	\N	8	\N
8520	49	151	258	\N	\N	22	7
8521	111	153	258	\N	\N	22	7
8522	9	154	258	\N	\N	22	7
8523	92	156	258	\N	\N	22	7
8524	58	158	258	\N	\N	22	7
8525	31	160	258	\N	\N	22	7
8526	26	161	258	\N	\N	22	7
8527	9	163	258	\N	\N	22	7
8528	18	164	258	\N	\N	22	7
8529	1	166	258	\N	\N	22	7
853	2	51	8	\N	\N	8	\N
8530	7	167	258	\N	\N	22	7
8531	64	66	258	\N	\N	22	7
8532	8	67	258	\N	\N	22	7
8533	1	69	258	\N	\N	22	7
8534	4	72	258	\N	\N	22	7
8535	2	73	258	\N	\N	22	7
8536	10	76	258	\N	\N	22	7
8537	5	77	258	\N	\N	22	7
8538	1	79	258	\N	\N	22	7
8539	20	92	258	\N	\N	22	7
854	38	53	8	\N	\N	8	\N
8540	450	105	258	\N	\N	22	7
8541	5	106	258	\N	\N	22	7
8542	44	112	258	\N	\N	22	7
8543	43	113	258	\N	\N	22	7
8544	35	116	258	\N	\N	22	7
8545	73	170	258	\N	\N	22	7
8546	21	171	258	\N	\N	22	7
8547	3	173	258	\N	\N	22	7
8548	259	174	258	\N	\N	22	7
8549	53	175	258	\N	\N	22	7
855	27	54	8	\N	\N	8	\N
8550	19	176	258	\N	\N	22	7
8551	5	181	258	\N	\N	22	7
8552	4	184	258	\N	\N	22	7
8553	19	186	258	\N	\N	22	7
8554	1	188	258	\N	\N	22	7
8555	500	189	258	\N	\N	22	7
8556	39	191	258	\N	\N	22	7
8557	94	194	258	\N	\N	22	7
8558	69	196	258	\N	\N	22	7
8559	27	199	258	\N	\N	22	7
856	47	55	8	\N	\N	8	\N
8560	33	204	258	\N	\N	22	7
8561	5	205	258	\N	\N	22	7
8562	13	206	258	\N	\N	22	7
8563	1060	207	258	\N	\N	22	7
8564	1	211	258	\N	\N	22	7
8565	1	124	259	\N	\N	22	7
8566	1	134	259	\N	\N	22	7
8567	2	135	259	\N	1 m, 1 f	22	7
8568	2	136	259	\N	1 m, 1 f	22	7
8569	4	137	259	\N	\N	22	7
857	1	57	8	\N	\N	8	\N
8570	2	141	259	\N	1 m, 1 f	22	7
8571	4	151	259	\N	\N	22	7
8572	2	154	259	\N	\N	22	7
8573	5	156	259	\N	\N	22	7
8574	7	158	259	\N	\N	22	7
8575	22	160	259	\N	\N	22	7
8576	6	161	259	\N	\N	22	7
8577	5	163	259	\N	\N	22	7
8578	1	164	259	\N	\N	22	7
8579	1	171	259	\N	\N	22	7
858	66	58	8	\N	\N	8	\N
8580	1	173	259	\N	\N	22	7
8581	3	174	259	\N	\N	22	7
8582	5	175	259	\N	2 m, 3 f	22	7
8583	4	184	259	\N	3 m, 1 f	22	7
8584	12	189	259	\N	\N	22	7
8585	2	194	259	\N	\N	22	7
8586	4	196	259	\N	\N	22	7
8587	10	207	259	\N	\N	22	7
8588	4	120	260	\N	\N	22	7
8589	3	131	260	\N	\N	22	7
859	680	59	8	\N	\N	8	\N
8590	1	136	260	\N	\N	22	7
8591	2	137	260	\N	\N	22	7
8592	\N	141	260	t	\N	22	7
8593	\N	153	260	t	\N	22	7
8594	1	156	260	\N	\N	22	7
8595	1	158	260	\N	\N	22	7
8596	\N	160	260	t	\N	22	7
8597	1	161	260	\N	\N	22	7
8598	1	167	260	\N	\N	22	7
8599	\N	174	260	t	\N	22	7
86	51	167	1	\N	\N	1	\N
860	114	60	8	\N	\N	8	\N
8600	1	175	260	\N	\N	22	7
8601	45	189	260	\N	\N	22	7
8602	2	191	260	\N	\N	22	7
8603	1	194	260	\N	\N	22	7
8604	3	196	260	\N	\N	22	7
8605	3	204	260	\N	\N	22	7
8606	50	207	260	\N	\N	22	7
8607	20	208	260	\N	\N	22	7
8608	4	20	261	\N	\N	22	4
8609	10	29	261	\N	5 from Bob Hawkins at Dockton	22	4
861	15	61	8	\N	\N	8	\N
8610	481	34	261	\N	18 from Bob Hawkins at Dockton	22	4
8611	155	35	261	\N	1 from Bob Hawkins at Dockton	22	4
8612	\N	36	261	t	1 from Ezra Parker at Manzanita on 1/6	22	4
8613	141	39	261	\N	3 from Bob Hawkins at Dockton	22	4
8614	156	40	261	\N	19 from Bob Hawkins at Dockton	22	4
8615	124	41	261	\N	\N	22	4
8616	414	44	261	\N	3 from Bob Hawkins at Dockton, subtracted 20 recorded by Brit Myers at Judd Creek	22	4
8617	127	45	261	\N	\N	22	4
8618	130	59	261	\N	2 from Bob Hawkins at Dockton	22	4
8619	6	61	261	\N	\N	22	4
862	1057	62	8	\N	\N	8	\N
8620	\N	62	261	t	2 from Ezra Parker scoped in outer QH on 1/5	22	4
8621	4	86	261	\N	\N	22	4
8622	1	100	261	\N	\N	22	4
8623	33	106	261	\N	\N	22	4
8624	59	112	261	\N	\N	22	4
8625	15	116	261	\N	15 from Bob Hawkins at Dockton	22	4
8626	8	53	261	\N	\N	22	4
8627	1	54	261	\N	\N	22	4
8628	1	55	261	\N	\N	22	4
8629	73	65	261	\N	\N	22	4
863	38	65	8	\N	\N	8	\N
8630	4	67	261	\N	\N	22	4
8631	43	66	261	\N	\N	22	4
8632	1	69	261	\N	\N	22	4
8633	5	76	261	\N	\N	22	4
8634	2	77	261	\N	\N	22	4
8635	1	132	261	\N	\N	22	4
8636	1	131	262	\N	\N	22	1
8637	1	132	262	\N	\N	22	1
8638	3	137	262	\N	\N	22	1
8639	1	151	262	\N	\N	22	1
864	487	66	8	\N	\N	8	\N
8640	2	153	262	\N	\N	22	1
8641	3	156	262	\N	\N	22	1
8642	10	158	262	\N	\N	22	1
8643	1	161	262	\N	\N	22	1
8644	1	76	262	\N	\N	22	1
8645	1	77	262	\N	\N	22	1
8646	6	170	262	\N	\N	22	1
8647	18	174	262	\N	\N	22	1
8648	3	176	262	\N	\N	22	1
8649	1	184	262	\N	\N	22	1
865	13	67	8	\N	\N	8	\N
8650	1	186	262	\N	\N	22	1
8651	7	189	262	\N	\N	22	1
8652	1	191	262	\N	\N	22	1
8653	1	194	262	\N	\N	22	1
8654	3	196	262	\N	\N	22	1
8655	6	204	262	\N	\N	22	1
8656	100	207	262	\N	\N	22	1
8657	2	22	263	\N	\N	22	1
8658	5	24	263	\N	\N	22	1
8659	11	28	263	\N	\N	22	1
866	46	69	8	\N	\N	8	\N
8660	5	33	263	\N	Randy reported 4, Ed had 5 when waiting for return ferry to Fauntleroy	22	1
8661	15	34	263	\N	\N	22	1
8662	23	39	263	\N	\N	22	1
8663	1	40	263	\N	\N	22	1
8664	1	41	263	\N	\N	22	1
8665	3	45	263	\N	\N	22	1
8666	1	55	263	\N	\N	22	1
8667	7	59	263	\N	\N	22	1
8668	2	60	263	\N	\N	22	1
8669	23	117	263	\N	\N	22	1
867	1	71	8	\N	\N	8	\N
8670	1	131	263	\N	\N	22	1
8671	3	153	263	\N	\N	22	1
8672	1	158	263	\N	\N	22	1
8673	1	161	263	\N	\N	22	1
8674	1	167	263	\N	\N	22	1
8675	7	65	263	\N	\N	22	1
8676	12	66	263	\N	\N	22	1
8677	5	67	263	\N	\N	22	1
8678	2	76	263	\N	\N	22	1
8679	2	77	263	\N	\N	22	1
868	5	72	8	\N	\N	8	\N
8680	3	100	263	\N	\N	22	1
8681	1	112	263	\N	\N	22	1
8682	1	113	263	\N	\N	22	1
8683	6	116	263	\N	\N	22	1
8684	2	171	263	\N	\N	22	1
8685	5	174	263	\N	\N	22	1
8686	1	175	263	\N	\N	22	1
8687	1	176	263	\N	\N	22	1
8688	1	186	263	\N	\N	22	1
8689	2	189	263	\N	\N	22	1
869	11	73	8	\N	\N	8	\N
8690	9	194	263	\N	\N	22	1
8691	1	196	263	\N	\N	22	1
8692	20	207	263	\N	\N	22	1
8693	50	7	264	\N	\N	22	1
8694	2	43	264	\N	\N	22	1
8695	5	131	264	\N	\N	22	1
8696	3	137	264	\N	\N	22	1
8697	6	156	264	\N	\N	22	1
8698	1	158	264	\N	\N	22	1
8699	1	161	264	\N	\N	22	1
87	291	170	1	\N	\N	1	\N
870	1	74	8	\N	\N	8	\N
8700	1	72	264	\N	\N	22	1
8701	73	174	264	\N	\N	22	1
8702	1	175	264	\N	\N	22	1
8703	50	189	264	\N	\N	22	1
8704	1	193	264	\N	\N	22	1
8705	5	194	264	\N	\N	22	1
8706	9	196	264	\N	\N	22	1
8707	3	204	264	\N	\N	22	1
8708	67	207	264	\N	\N	22	1
8709	6	11	265	\N	Vashon Island--Wingehaven Park: Flock of 8 swans flying at 0948, silent. 2 were smaller then these 6.	22	1
871	42	76	8	\N	\N	8	\N
8710	2	12	265	\N	Vashon Island--Wingehaven Park: Flock of 8 swans flying at 0948, silent. 2 were smaller then the other 6	22	1
8711	13	13	265	\N	Dolphin Point N eighborhood, Vashon: 13 flying and calling at 1024 sounded like tundra	22	1
8712	3	18	265	\N	\N	22	1
8713	46	20	265	\N	Dilworth Road, Vashon: Flyover at 1447\nVan Olinda Ponds, Vashon: 9 Fly over, 5ponds	22	1
8714	2	33	265	\N	\N	22	1
8715	37	34	265	\N	Vashon Island--Wingehaven Park: 4,2,1	22	1
8716	21	39	265	\N	Glen Landing, Vashon: 2,4,1,2,\nVashon Island--Wingehaven Park: 1,3	22	1
8717	12	40	265	\N	Glen Landing, Vashon: 1,1,1,1\nVashon Island--Wingehaven Park: 7,1	22	1
8718	4	42	265	\N	\N	22	1
8719	2	44	265	\N	\N	22	1
872	14	79	8	\N	\N	8	\N
8720	18	45	265	\N	Glen Landing, Vashon: 2,1,1, 1,2,1,\nVashon Island--Wingehaven Park: 1,5,2,1	22	1
8721	38	59	265	\N	Glen Landing, Vashon: 1,14,2,1, 1,2,2,\nVashon Island--Wingehaven Park: 3,8	22	1
8722	16	60	265	\N	Glen Landing, Vashon: 1,1,2,2\nVashon Island--Wingehaven Park: 2,4,1,1	22	1
8723	6	61	265	\N	Vashon Island--Wingehaven Park: 1,2,1 body shorter, peak head, more black on face/head, bill thinner then HOGR	22	1
8724	14	131	265	\N	\N	22	1
8725	2	86	265	\N	Van Olinda Ponds, Vashon: Heard	22	1
8726	1	95	265	\N	Van Olinda Ponds, Vashon: Heard	22	1
8727	1	100	265	\N	\N	22	1
8728	1	104	265	\N	\N	22	1
8729	16	106	265	\N	Glen Landing, Vashon: 1,1,2	22	1
873	3	82	8	\N	\N	8	\N
8730	8	112	265	\N	\N	22	1
8731	4	113	265	\N	\N	22	1
8732	28	114	265	\N	\N	22	1
8733	19	116	265	\N	\N	22	1
8734	2	53	265	\N	\N	22	1
8735	1	54	265	\N	\N	22	1
8736	3	55	265	\N	\N	22	1
8737	3	65	265	\N	\N	22	1
8738	2	67	265	\N	\N	22	1
8739	5	66	265	\N	\N	22	1
874	295	83	8	\N	\N	8	\N
8740	1	68	265	\N	\N	22	1
8741	1	69	265	\N	Green Man Farm, Vashon: Top of tree	22	1
8742	4	76	265	\N	Van Olinda Ponds, Vashon: Adults at 1230\nDolphin Point N eighborhood, Vashon: 1 adult at 1114\nVashon Island--Wingehaven Park: 1 immature 0846, 1 adult 0906	22	1
8743	1	77	265	\N	Vashon Island--Wingehaven Park: 1 immature 0846, 1 adult 0906	22	1
8744	0	124	265	\N	Van Olinda Ponds, Vashon: Reported 1, but also counted by feeder other party in area	22	1
8745	1	134	265	\N	\N	22	1
8746	1	135	265	\N	\N	22	1
8747	1	135	265	\N	\N	22	1
8748	9	137	265	\N	\N	22	1
8749	1	140	265	\N	\N	22	1
875	44	86	8	\N	\N	8	\N
8750	1	144	265	\N	Dolphin Point N eighborhood, Vashon: At 1111	22	1
8751	1	145	265	\N	\N	22	1
8752	1	149	265	\N	\N	22	1
8753	1	151	265	\N	\N	22	1
8754	5	151	265	\N	\N	22	1
8755	18	153	265	\N	\N	22	1
8756	1	154	265	\N	\N	22	1
8757	13	156	265	\N	\N	22	1
8758	31	158	265	\N	\N	22	1
8759	20	170	265	\N	\N	22	1
876	4	87	8	\N	\N	8	\N
8760	15	171	265	\N	\N	22	1
8761	8	161	265	\N	\N	22	1
8762	5	163	265	\N	\N	22	1
8763	13	164	265	\N	\N	22	1
8764	6	167	265	\N	\N	22	1
8765	60	176	265	\N	\N	22	1
8766	37	175	265	\N	\N	22	1
8767	1	173	265	\N	\N	22	1
8768	153	174	265	\N	Dolphin Point N eighborhood, Vashon: 30,30	22	1
8769	1	211	265	\N	\N	22	1
877	1	88	8	\N	\N	8	\N
8770	8	204	265	\N	\N	22	1
8771	1	205	265	\N	\N	22	1
8772	5	206	265	\N	\N	22	1
8773	592	207	265	\N	Green Man Farm, Vashon: A couple pretty yellow and bright\nDolphin Point N eighborhood, Vashon: 15,20,30,35,45\nVashon Island--Wingehaven Park: 8,12,2,12,3,30	22	1
8774	1	186	265	\N	\N	22	1
8775	2	186	265	\N	\N	22	1
8776	50	187	265	\N	\N	22	1
8777	192	189	265	\N	8805 Southwest Dilworth Road, Vashon: 19,40\nGreen Man Farm, Vashon: Feeder\nOld Vashon Highway Southwest, Vashon: 11,6	22	1
8778	19	191	265	\N	\N	22	1
8779	1	193	265	\N	\N	22	1
878	29	89	8	\N	\N	8	\N
8780	57	194	265	\N	\N	22	1
8781	5	196	265	\N	\N	22	1
8782	10	196	265	\N	\N	22	1
8783	3	184	265	\N	\N	22	1
8784	1	131	266	\N	\N	22	1
8785	1	137	266	\N	\N	22	1
8786	5	153	266	\N	\N	22	1
8787	2	154	266	\N	\N	22	1
8788	14	158	266	\N	\N	22	1
8789	9	174	266	\N	\N	22	1
879	2	91	8	\N	\N	8	\N
8790	1	175	266	\N	\N	22	1
8791	18	189	266	\N	\N	22	1
8792	3	194	266	\N	\N	22	1
8793	2	196	266	\N	\N	22	1
8794	115	207	266	\N	\N	22	1
8795	1	131	267	\N	\N	22	1
8796	0	82	267	\N	Ellisport, Vashon: 1 responded to playback - “poached” at Ellis Creek Natural Area in VS East area	22	1
8797	2	69	267	\N	\N	22	1
8798	1	76	267	\N	KVI Beach (Vashon Island): Adult	22	1
8799	1	137	267	\N	\N	22	1
88	150	171	1	\N	\N	1	\N
880	75	92	8	\N	\N	8	\N
8800	2	151	267	\N	\N	22	1
8801	9	153	267	\N	\N	22	1
8802	1	156	267	\N	\N	22	1
8803	4	158	267	\N	\N	22	1
8804	1	160	267	\N	\N	22	1
8805	1	170	267	\N	\N	22	1
8806	18	174	267	\N	\N	22	1
8807	6	211	267	\N	\N	22	1
8808	2	204	267	\N	\N	22	1
8809	60	207	267	\N	\N	22	1
881	1	95	8	\N	\N	8	\N
8810	1	186	267	\N	\N	22	1
8811	2	189	267	\N	\N	22	1
8812	2	191	267	\N	\N	22	1
8813	6	194	267	\N	\N	22	1
8814	4	196	267	\N	\N	22	1
8815	1	124	268	\N	\N	22	1
8816	1	126	268	\N	\N	22	1
8817	2	131	268	\N	\N	22	1
8818	2	137	268	\N	\N	22	1
8819	2	151	268	\N	\N	22	1
882	1	99	8	\N	\N	8	\N
8820	1	153	268	\N	\N	22	1
8821	1	156	268	\N	\N	22	1
8822	4	158	268	\N	\N	22	1
8823	2	161	268	\N	\N	22	1
8824	1	164	268	\N	\N	22	1
8825	1	75	268	\N	\N	22	1
8826	1	76	268	\N	by ear	22	1
8827	6	174	268	\N	\N	22	1
8828	1	175	268	\N	\N	22	1
8829	6	189	268	\N	\N	22	1
883	15	100	8	\N	\N	8	\N
8830	10	191	268	\N	\N	22	1
8831	5	194	268	\N	\N	22	1
8832	6	196	268	\N	\N	22	1
8833	6	205	268	\N	4 red; 2 not 	22	1
8834	28	207	268	\N	\N	22	1
8835	1	86	269	\N	Vashon CBC Owling Route: Heard calling at Wax Orchards Airport	22	1
8836	4	126	269	\N	Vashon CBC Owling Route: One bird seen flying overhead at the Old Mill House driveway entrance in response to playback, did not call\nVashon CBC Owling Route: Pair responded to playback at Fisher Pond parking lot with caterwauling calls, seen flying back and forth overhead. Single bird heard calling distantly at 115th St parking lot for Island Center Forest.	22	1
8837	2	129	269	\N	Vashon CBC Owling Route: Responded to playback at the 115th St parking lot for Island Center Forest\nVashon CBC Owling Route: Responded to playback at Shawnee Rd just east of Old Mill Rd	22	1
8838	19	7	270	\N	\N	22	1
8839	4	18	270	\N	\N	22	1
884	1	101	8	\N	\N	8	\N
8840	5	20	270	\N	\N	22	1
8841	11	39	270	\N	\N	22	1
8842	10	40	270	\N	\N	22	1
8843	2	43	270	\N	\N	22	1
8844	2	131	270	\N	\N	22	1
8845	4	137	270	\N	\N	22	1
8846	1	144	270	\N	From Erik Steffens at Matsuda Farm	22	1
8847	6	151	270	\N	\N	22	1
8848	1	153	270	\N	\N	22	1
8849	7	154	270	\N	\N	22	1
885	3	103	8	\N	\N	8	\N
8850	13	156	270	\N	\N	22	1
8851	10	158	270	\N	\N	22	1
8852	8	161	270	\N	\N	22	1
8853	2	163	270	\N	\N	22	1
8854	10	164	270	\N	\N	22	1
8855	2	167	270	\N	\N	22	1
8856	4	76	270	\N	\N	22	1
8857	2	77	270	\N	\N	22	1
8858	2	116	270	\N	\N	22	1
8859	5	170	270	\N	\N	22	1
886	21	105	8	\N	\N	8	\N
8860	5	171	270	\N	\N	22	1
8861	1	173	270	\N	\N	22	1
8862	61	174	270	\N	\N	22	1
8863	7	175	270	\N	\N	22	1
8864	1	176	270	\N	\N	22	1
8865	7	186	270	\N	\N	22	1
8866	96	189	270	\N	\N	22	1
8867	10	191	270	\N	\N	22	1
8868	32	194	270	\N	\N	22	1
8869	18	196	270	\N	\N	22	1
887	334	106	8	\N	\N	8	\N
8870	5	204	270	\N	\N	22	1
8871	3	205	270	\N	\N	22	1
8872	164	207	270	\N	\N	22	1
8873	12	211	270	\N	\N	22	1
8874	1	17	271	\N	\N	22	1
8875	65	18	271	\N	\N	22	1
8876	36	20	271	\N	\N	22	1
8877	1	22	271	\N	\N	22	1
8878	1	28	271	\N	\N	22	1
8879	9	30	271	\N	\N	22	1
888	1	107	8	\N	\N	8	\N
8880	5	33	271	\N	\N	22	1
8881	26	34	271	\N	\N	22	1
8882	15	39	271	\N	\N	22	1
8883	12	40	271	\N	\N	22	1
8884	2	41	271	\N	\N	22	1
8885	16	44	271	\N	\N	22	1
8886	9	45	271	\N	\N	22	1
8887	3	47	271	\N	\N	22	1
8888	3	55	271	\N	\N	22	1
8889	12	58	271	\N	\N	22	1
889	2	108	8	\N	\N	8	\N
8890	10	59	271	\N	\N	22	1
8891	6	60	271	\N	\N	22	1
8892	1	131	271	\N	\N	22	1
8893	1	134	271	\N	\N	22	1
8894	1	135	271	\N	\N	22	1
8895	3	137	271	\N	\N	22	1
8896	26	153	271	\N	\N	22	1
8897	5	156	271	\N	\N	22	1
8898	2	161	271	\N	\N	22	1
8899	3	164	271	\N	\N	22	1
89	358	174	1	\N	\N	1	\N
890	1	111	8	\N	\N	8	\N
8900	2	66	271	\N	\N	22	1
8901	2	69	271	\N	\N	22	1
8902	3	76	271	\N	\N	22	1
8903	1	77	271	\N	\N	22	1
8904	5	83	271	\N	\N	22	1
8905	1	109	271	\N	\N	22	1
8906	19	112	271	\N	\N	22	1
8907	5	113	271	\N	\N	22	1
8908	6	116	271	\N	\N	22	1
8909	8	170	271	\N	\N	22	1
891	448	112	8	\N	\N	8	\N
8910	2	171	271	\N	\N	22	1
8911	17	174	271	\N	\N	22	1
8912	8	175	271	\N	\N	22	1
8913	5	176	271	\N	\N	22	1
8914	2	186	271	\N	\N	22	1
8915	33	189	271	\N	\N	22	1
8916	1	190	271	\N	\N	22	1
8917	16	191	271	\N	\N	22	1
8918	12	194	271	\N	\N	22	1
8919	2	196	271	\N	\N	22	1
892	55	113	8	\N	\N	8	\N
8920	2	199	271	\N	\N	22	1
8921	3	204	271	\N	\N	22	1
8922	2	211	271	\N	\N	22	1
8923	1	7	272	\N	\N	22	1
8924	50	18	272	\N	\N	22	1
8925	7	20	272	\N	\N	22	1
8926	3	131	272	\N	\N	22	1
8927	1	135	272	\N	\N	22	1
8928	5	137	272	\N	\N	22	1
8929	4	151	272	\N	\N	22	1
893	107	116	8	\N	\N	8	\N
8930	1	153	272	\N	\N	22	1
8931	2	154	272	\N	\N	22	1
8932	2	156	272	\N	\N	22	1
8933	6	161	272	\N	\N	22	1
8934	1	79	272	\N	Originally reported 3, unable to confirm simultaneous observation	22	1
8935	14	174	272	\N	\N	22	1
8936	4	186	272	\N	\N	22	1
8937	9	189	272	\N	\N	22	1
8938	0	193	272	\N	Awaiting details	22	1
8939	8	194	272	\N	Originally entered as LISP	22	1
894	176	117	8	\N	\N	8	\N
8940	5	196	272	\N	\N	22	1
8941	11	205	272	\N	\N	22	1
8942	94	207	272	\N	\N	22	1
8943	0	208	272	\N	Awaiting details	22	1
8944	1	211	272	\N	\N	22	1
8945	8	7	273	\N	\N	22	1
8946	20	117	273	\N	\N	22	1
8947	2	131	273	\N	\N	22	1
8948	1	135	273	\N	\N	22	1
8949	3	137	273	\N	\N	22	1
895	4	118	8	\N	\N	8	\N
8950	1	151	273	\N	\N	22	1
8951	16	153	273	\N	\N	22	1
8952	1	154	273	\N	\N	22	1
8953	3	156	273	\N	\N	22	1
8954	3	161	273	\N	\N	22	1
8955	1	167	273	\N	\N	22	1
8956	1	76	273	\N	\N	22	1
8957	2	170	273	\N	\N	22	1
8958	1	171	273	\N	\N	22	1
8959	17	174	273	\N	\N	22	1
896	87	120	8	\N	\N	8	\N
8960	1	175	273	\N	\N	22	1
8961	6	176	273	\N	\N	22	1
8962	12	189	273	\N	\N	22	1
8963	4	191	273	\N	\N	22	1
8964	5	194	273	\N	\N	22	1
8965	8	196	273	\N	\N	22	1
8966	6	199	273	\N	\N	22	1
8967	137	207	273	\N	\N	22	1
8968	17	211	273	\N	\N	22	1
8969	16	7	274	\N	\N	22	1
897	1	122	8	\N	\N	8	\N
8970	2	18	274	\N	\N	22	1
8971	8	20	274	\N	\N	22	1
8972	12	34	274	\N	\N	22	1
8973	2	35	274	\N	\N	22	1
8974	16	39	274	\N	\N	22	1
8975	17	40	274	\N	\N	22	1
8976	5	45	274	\N	\N	22	1
8977	1	53	274	\N	\N	22	1
8978	11	59	274	\N	\N	22	1
8979	1	131	274	\N	\N	22	1
898	1	123	8	\N	\N	8	\N
8980	3	132	274	\N	\N	22	1
8981	2	137	274	\N	\N	22	1
8982	2	151	274	\N	\N	22	1
8983	70	153	274	\N	\N	22	1
8984	14	158	274	\N	\N	22	1
8985	1	161	274	\N	\N	22	1
8986	21	66	274	\N	\N	22	1
8987	1	67	274	\N	\N	22	1
8988	1	77	274	\N	\N	22	1
8989	2	86	274	\N	\N	22	1
899	1	124	8	\N	\N	8	\N
8990	204	106	274	\N	\N	22	1
8991	\N	110	274	t	From Ezra Parker at Fern Cove on 1/6	22	1
8992	\N	111	274	t	From Ezra Parker at Fern Cove on 1/6	22	1
8993	13	112	274	\N	\N	22	1
8994	1	113	274	\N	\N	22	1
8995	1	171	274	\N	\N	22	1
8996	1	173	274	\N	\N	22	1
8997	48	174	274	\N	\N	22	1
8998	4	175	274	\N	\N	22	1
8999	11	176	274	\N	\N	22	1
9	2	26	1	\N	\N	1	\N
90	47	175	1	\N	\N	1	\N
900	5	126	8	\N	\N	8	\N
9000	86	189	274	\N	\N	22	1
9001	14	190	274	\N	\N	22	1
9002	11	194	274	\N	\N	22	1
9003	11	196	274	\N	\N	22	1
9004	1	204	274	\N	\N	22	1
9005	113	207	274	\N	\N	22	1
9006	35	208	274	\N	\N	22	1
9007	1	131	275	\N	\N	22	1
9008	1	137	275	\N	\N	22	1
9009	1	168	275	\N	\N	22	1
901	3	129	8	\N	\N	8	\N
9010	11	189	275	\N	\N	22	1
9011	1	196	275	\N	\N	22	1
9012	6	207	275	\N	\N	22	1
9013	3	131	276	\N	1 male	22	1
9014	1	137	276	\N	\N	22	1
9015	2	158	276	\N	\N	22	1
9016	0	79	276	\N	2  (heard them)	22	1
9017	4	174	276	\N	\N	22	1
9018	1	175	276	\N	\N	22	1
9019	3	189	276	\N	\N	22	1
902	78	131	8	\N	\N	8	\N
9020	1	196	276	\N	\N	22	1
9021	1	131	277	\N	\N	22	1
9022	2	156	277	\N	\N	22	1
9023	3	158	277	\N	\N	22	1
9024	1	161	277	\N	\N	22	1
9025	1	164	277	\N	\N	22	1
9026	1	174	277	\N	\N	22	1
9027	1	189	277	\N	\N	22	1
9028	1	194	277	\N	\N	22	1
9029	3	196	277	\N	\N	22	1
903	19	132	8	\N	\N	8	\N
9030	2	205	277	\N	\N	22	1
9031	12	207	277	\N	\N	22	1
9032	2	158	278	\N	\N	22	1
9033	1	164	278	\N	\N	22	1
9034	1	171	278	\N	\N	22	1
9035	23	174	278	\N	\N	22	1
9036	6	189	278	\N	\N	22	1
9037	1	194	278	\N	\N	22	1
9038	2	196	278	\N	\N	22	1
9039	2	207	278	\N	\N	22	1
904	11	134	8	\N	\N	8	\N
9040	1	135	279	\N	\N	22	1
9041	4	174	279	\N	\N	22	1
9042	9	189	279	\N	\N	22	1
9043	1	196	279	\N	\N	22	1
9044	2	197	279	\N	\N	22	1
9045	36	207	279	\N	\N	22	1
9046	9	7	280	\N	\N	22	1
9047	1	131	280	\N	\N	22	1
9048	1	134	280	\N	\N	22	1
9049	1	137	280	\N	\N	22	1
905	34	135	8	\N	\N	8	\N
9050	1	171	280	\N	\N	22	1
9051	137	174	280	\N	\N	22	1
9052	\N	126	281	t	\N	22	1
9053	1	137	281	\N	\N	22	1
9054	1	156	281	\N	\N	22	1
9055	7	189	281	\N	\N	22	1
9056	2	191	281	\N	\N	22	1
9057	1	194	281	\N	\N	22	1
9058	2	204	281	\N	\N	22	1
9059	6	207	281	\N	\N	22	1
906	4	136	8	\N	\N	8	\N
9060	1	7	282	\N	Call only	22	1
9061	\N	130	282	t	Call only	22	1
9062	2	131	282	\N	\N	22	1
9063	1	135	282	\N	\N	22	1
9064	1	151	282	\N	\N	22	1
9065	1	153	282	\N	\N	22	1
9066	8	158	282	\N	\N	22	1
9067	1	161	282	\N	\N	22	1
9068	1	163	282	\N	\N	22	1
9069	1	167	282	\N	\N	22	1
907	145	139	8	\N	\N	8	\N
9070	1	171	282	\N	\N	22	1
9071	1	175	282	\N	\N	22	1
9072	1	184	282	\N	\N	22	1
9073	12	189	282	\N	\N	22	1
9074	2	194	282	\N	\N	22	1
9075	3	196	282	\N	\N	22	1
9076	5	207	282	\N	\N	22	1
9077	1	123	283	\N	\N	22	1
9078	1	131	283	\N	m	22	1
9079	1	135	283	\N	f	22	1
908	16	141	8	\N	\N	8	\N
9080	1	151	283	\N	\N	22	1
9081	3	156	283	\N	\N	22	1
9082	2	158	283	\N	\N	22	1
9083	4	160	283	\N	\N	22	1
9084	4	161	283	\N	\N	22	1
9085	1	167	283	\N	\N	22	1
9086	5	174	283	\N	\N	22	1
9087	1	175	283	\N	\N	22	1
9088	2	189	283	\N	\N	22	1
9089	1	196	283	\N	\N	22	1
909	1	143	8	\N	\N	8	\N
9090	2	204	283	\N	1 m, 1 f	22	1
9091	23	207	283	\N	\N	22	1
9092	1	131	284	\N	F	22	1
9093	2	137	284	\N	1M 1F	22	1
9094	1	151	284	\N	\N	22	1
9095	2	158	284	\N	\N	22	1
9096	56	189	284	\N	\N	22	1
9097	1	190	284	\N	\N	22	1
9098	2	191	284	\N	\N	22	1
9099	4	194	284	\N	\N	22	1
91	836	176	1	\N	\N	1	\N
910	2	144	8	\N	\N	8	\N
9100	9	196	284	\N	\N	22	1
9101	3	204	284	\N	1M 2F	22	1
9102	3	207	284	\N	\N	22	1
9103	\N	7	285	t	\N	22	1
9104	2	131	285	\N	\N	22	1
9105	2	137	285	\N	\N	22	1
9106	3	151	285	\N	\N	22	1
9107	3	156	285	\N	\N	22	1
9108	3	158	285	\N	\N	22	1
9109	2	161	285	\N	\N	22	1
911	4	149	8	\N	\N	8	\N
9110	\N	76	285	t	\N	22	1
9111	1	170	285	\N	\N	22	1
9112	\N	171	285	t	\N	22	1
9113	1	174	285	\N	\N	22	1
9114	2	175	285	\N	\N	22	1
9115	3	186	285	\N	\N	22	1
9116	60	189	285	\N	\N	22	1
9117	1	193	285	\N	Tan morph	22	1
9118	4	194	285	\N	\N	22	1
9119	5	196	285	\N	\N	22	1
912	2	150	8	\N	\N	8	\N
9120	3	204	285	\N	\N	22	1
9121	8	207	285	\N	\N	22	1
9122	3	131	286	\N	\N	22	1
9123	1	135	286	\N	\N	22	1
9124	1	151	286	\N	\N	22	1
9125	1	158	286	\N	\N	22	1
9126	1	189	286	\N	\N	22	1
9127	2	196	286	\N	\N	22	1
9128	31	207	286	\N	\N	22	1
9129	2	131	287	\N	\N	22	1
913	170	151	8	\N	\N	8	\N
9130	1	135	287	\N	\N	22	1
9131	1	151	287	\N	\N	22	1
9132	1	154	287	\N	\N	22	1
9133	2	158	287	\N	\N	22	1
9134	2	161	287	\N	\N	22	1
9135	1	174	287	\N	\N	22	1
9136	1	175	287	\N	\N	22	1
9137	1	186	287	\N	\N	22	1
9138	49	189	287	\N	\N	22	1
9139	3	194	287	\N	\N	22	1
914	1291	153	8	\N	\N	8	\N
9140	2	196	287	\N	\N	22	1
9141	1	207	287	\N	\N	22	1
9142	1	126	288	\N	\N	22	1
9143	5	131	288	\N	\N	22	1
9144	1	134	288	\N	\N	22	1
9145	1	135	288	\N	\N	22	1
9146	4	137	288	\N	\N	22	1
9147	2	141	288	\N	\N	22	1
9148	2	151	288	\N	\N	22	1
9149	6	153	288	\N	\N	22	1
915	22	154	8	\N	\N	8	\N
9150	2	154	288	\N	\N	22	1
9151	2	156	288	\N	\N	22	1
9152	9	158	288	\N	\N	22	1
9153	4	161	288	\N	\N	22	1
9154	1	163	288	\N	\N	22	1
9155	1	76	288	\N	\N	22	1
9156	2	170	288	\N	\N	22	1
9157	2	171	288	\N	\N	22	1
9158	1	174	288	\N	\N	22	1
9159	3	175	288	\N	\N	22	1
916	293	156	8	\N	\N	8	\N
9160	1	184	288	\N	\N	22	1
9161	14	189	288	\N	\N	22	1
9162	2	194	288	\N	\N	22	1
9163	4	196	288	\N	\N	22	1
9164	2	205	288	\N	\N	22	1
9165	65	207	288	\N	\N	22	1
9166	2	43	289	\N	Male and female	22	1
9167	4	131	289	\N	\N	22	1
9168	2	137	289	\N	\N	22	1
9169	2	151	289	\N	\N	22	1
917	286	158	8	\N	\N	8	\N
9170	2	156	289	\N	\N	22	1
9171	2	161	289	\N	\N	22	1
9172	1	72	289	\N	\N	22	1
9173	1	170	289	\N	\N	22	1
9174	2	171	289	\N	\N	22	1
9175	1	173	289	\N	\N	22	1
9176	5	174	289	\N	\N	22	1
9177	1	175	289	\N	\N	22	1
9178	22	189	289	\N	Originally reported as Slate-colored	22	1
9179	3	194	289	\N	\N	22	1
918	104	160	8	\N	\N	8	\N
9180	3	196	289	\N	\N	22	1
9181	750	207	290	\N	\N	22	2
9182	4	7	291	\N	\N	22	2
9183	32	18	291	\N	\N	22	2
9184	1	28	291	\N	\N	22	2
9185	1	124	291	\N	\N	22	2
9186	6	131	291	\N	\N	22	2
9187	7	137	291	\N	\N	22	2
9188	4	143	291	\N	\N	22	2
9189	1	145	291	\N	\N	22	2
919	54	161	8	\N	\N	8	\N
9190	18	151	291	\N	\N	22	2
9191	35	153	291	\N	\N	22	2
9192	6	154	291	\N	\N	22	2
9193	40	156	291	\N	\N	22	2
9194	32	158	291	\N	\N	22	2
9195	18	161	291	\N	\N	22	2
9196	2	163	291	\N	\N	22	2
9197	15	164	291	\N	\N	22	2
9198	14	167	291	\N	\N	22	2
9199	1	82	291	\N	1 from Ezra Parker at Ellis Creek Natural Area	22	2
92	\N	180	1	t	\N	1	\N
920	17	163	8	\N	\N	8	\N
9200	10	170	291	\N	\N	22	2
9201	5	171	291	\N	\N	22	2
9202	1	173	291	\N	1 from Ezra Parker at Portage	22	2
9203	106	174	291	\N	\N	22	2
9204	34	175	291	\N	\N	22	2
9205	1	184	291	\N	\N	22	2
9206	10	186	291	\N	\N	22	2
9207	373	189	291	\N	\N	22	2
9208	8	191	291	\N	\N	22	2
9209	55	194	291	\N	\N	22	2
921	100	165	8	\N	\N	8	\N
9210	54	196	291	\N	\N	22	2
9211	15	199	291	\N	\N	22	2
9212	12	204	291	\N	\N	22	2
9213	1	205	291	\N	\N	22	2
9214	22	206	291	\N	\N	22	2
9215	332	207	291	\N	\N	22	2
9216	5	20	292	\N	\N	22	2
9217	3	34	292	\N	\N	22	2
9218	5	39	292	\N	\N	22	2
9219	16	40	292	\N	\N	22	2
922	5	166	8	\N	\N	8	\N
9220	14	44	292	\N	\N	22	2
9221	2	45	292	\N	\N	22	2
9222	9	59	292	\N	\N	22	2
9223	1	132	292	\N	\N	22	2
9224	12	66	292	\N	\N	22	2
9225	1	77	292	\N	\N	22	2
9226	26	116	292	\N	\N	22	2
9227	19	174	292	\N	\N	22	2
9228	4	189	292	\N	\N	22	2
9229	4	194	292	\N	\N	22	2
923	46	167	8	\N	\N	8	\N
9230	1	207	292	\N	\N	22	2
9231	1	131	293	\N	\N	22	2
9232	1	137	293	\N	\N	22	2
9233	2	153	293	\N	\N	22	2
9234	1	156	293	\N	\N	22	2
9235	1	158	293	\N	\N	22	2
9236	1	161	293	\N	\N	22	2
9237	1	167	293	\N	\N	22	2
9238	3	174	293	\N	\N	22	2
9239	3	176	293	\N	\N	22	2
924	437	170	8	\N	\N	8	\N
9240	1	179	293	\N	\N	22	2
9241	31	189	293	\N	\N	22	2
9242	0	193	293	\N	Unsure of ID, moved to sparrow sp.	22	2
9243	1	194	293	\N	\N	22	2
9244	1	196	293	\N	\N	22	2
9245	13	197	293	\N	\N	22	2
9246	2	204	293	\N	1M and 1F	22	2
9247	12	207	293	\N	\N	22	2
9248	2	211	293	\N	\N	22	2
9249	7	39	294	\N	\N	22	2
925	155	171	8	\N	\N	8	\N
9250	9	40	294	\N	\N	22	2
9251	1	132	294	\N	\N	22	2
9252	4	137	294	\N	\N	22	2
9253	3	141	294	\N	\N	22	2
9254	4	153	294	\N	\N	22	2
9255	3	156	294	\N	\N	22	2
9256	3	161	294	\N	\N	22	2
9257	1	167	294	\N	\N	22	2
9258	20	66	294	\N	\N	22	2
9259	2	76	294	\N	\N	22	2
926	5	173	8	\N	\N	8	\N
9260	1	79	294	\N	\N	22	2
9261	6	112	294	\N	\N	22	2
9262	3	170	294	\N	\N	22	2
9263	1	171	294	\N	\N	22	2
9264	26	174	294	\N	\N	22	2
9265	11	175	294	\N	\N	22	2
9266	1	186	294	\N	\N	22	2
9267	49	189	294	\N	\N	22	2
9268	21	194	294	\N	\N	22	2
9269	11	196	294	\N	\N	22	2
927	1147	174	8	\N	\N	8	\N
9270	63	207	294	\N	\N	22	2
9271	14	208	294	\N	\N	22	2
9272	35	7	295	\N	Vashon 115 St. and 238 Ave.: Flyover groups of 12 and 23.	22	2
9273	1	20	295	\N	\N	22	2
9274	21	39	295	\N	\N	22	2
9275	7	59	295	\N	\N	22	2
9276	15	117	295	\N	\N	22	2
9277	7	105	295	\N	Lisabuela Park: These were sitting on the water close to mid-channel, but on our side.  We could also see of hundreds of gulls circling on the far shore and hope the Kipsap group saw and identified them!	22	2
9278	9	106	295	\N	\N	22	2
9279	1	107	295	\N	\N	22	2
928	124	175	8	\N	\N	8	\N
9280	5	113	295	\N	\N	22	2
9281	12	116	295	\N	\N	22	2
9282	2	66	295	\N	\N	22	2
9283	1	77	295	\N	\N	22	2
9284	3	79	295	\N	\N	22	2
9285	1	137	295	\N	\N	22	2
9286	2	143	295	\N	\N	22	2
9287	6	151	295	\N	\N	22	2
9288	5	153	295	\N	\N	22	2
9289	1	154	295	\N	\N	22	2
929	1169	176	8	\N	\N	8	\N
9290	6	156	295	\N	\N	22	2
9291	24	158	295	\N	\N	22	2
9292	10	170	295	\N	\N	22	2
9293	4	171	295	\N	\N	22	2
9294	5	161	295	\N	\N	22	2
9295	3	163	295	\N	\N	22	2
9296	1	164	295	\N	\N	22	2
9297	1	167	295	\N	\N	22	2
9298	8	176	295	\N	\N	22	2
9299	66	175	295	\N	Vashon Reddings Beach & 240 St Loop: On road edges in mixed flocks; sometimes with SOSP, others with DEJU, and a few with AMRO	22	2
93	11	184	1	\N	\N	1	\N
930	1	178	8	\N	\N	8	\N
9300	1	173	295	\N	\N	22	2
9301	88	174	295	\N	\N	22	2
9302	2	204	295	\N	\N	22	2
9303	88	207	295	\N	\N	22	2
9304	1	186	295	\N	\N	22	2
9305	262	187	295	\N	Vashon 115 St. and 238 Ave.: In groups of 5, 15, 20, and 30.\nVashon Reddings Beach & 240 St Loop: On road edges in mixed flocks with different species; some with VATH, others with SOSP, others only DEJU.	22	2
9306	55	194	295	\N	Vashon Reddings Beach & 240 St Loop: On road edges in mixed flocks with different species	22	2
9307	23	196	295	\N	\N	22	2
9308	1	196	296	\N	\N	22	2
9309	25	207	296	\N	\N	22	2
931	11	183	8	\N	\N	8	\N
9310	1	211	296	\N	\N	22	2
9311	0	124	297	\N	Reported 1, but also counted by VS East field team in same area	22	2
9312	1	126	297	\N	\N	22	2
9313	1	131	297	\N	\N	22	2
9314	2	135	297	\N	\N	22	2
9315	2	137	297	\N	\N	22	2
9316	2	151	297	\N	\N	22	2
9317	1	154	297	\N	\N	22	2
9318	1	156	297	\N	\N	22	2
9319	6	158	297	\N	\N	22	2
932	8	184	8	\N	\N	8	\N
9320	2	161	297	\N	\N	22	2
9321	1	163	297	\N	\N	22	2
9322	2	164	297	\N	\N	22	2
9323	2	167	297	\N	\N	22	2
9324	1	77	297	\N	\N	22	2
9325	1	79	297	\N	\N	22	2
9326	5	174	297	\N	\N	22	2
9327	2	175	297	\N	\N	22	2
9328	1	186	297	\N	\N	22	2
9329	12	189	297	\N	\N	22	2
933	2	185	8	\N	\N	8	\N
9330	2	194	297	\N	\N	22	2
9331	4	196	297	\N	\N	22	2
9332	5	199	297	\N	\N	22	2
9333	3	207	297	\N	\N	22	2
9334	0	34	298	\N	4 ♂(2:45)	22	2
9335	0	39	298	\N	1 ♂ (3:00)	22	2
9336	0	40	298	\N	2 ♂ (2:15)	22	2
9337	0	41	298	\N	3=2 ♂ (11:15 ) 1 ♀ (3:00)	22	2
9338	0	59	298	\N	1 (10:15)	22	2
9339	1	153	298	\N	\N	22	2
934	236	186	8	\N	\N	8	\N
9340	2	156	298	\N	\N	22	2
9341	6	158	298	\N	\N	22	2
9342	1	161	298	\N	\N	22	2
9343	1	163	298	\N	\N	22	2
9344	0	112	298	\N	1 (11:15)	22	2
9345	8	189	298	\N	\N	22	2
9346	2	191	298	\N	\N	22	2
9347	2	194	298	\N	\N	22	2
9348	2	196	298	\N	2 ♂	22	2
9349	80	207	298	\N	\N	22	2
935	5	188	8	\N	\N	8	\N
9350	1	211	298	\N	1 ♀	22	2
9351	52	20	299	\N	\N	22	2
9352	2	131	300	\N	\N	22	2
9353	2	135	300	\N	\N	22	2
9354	1	137	300	\N	\N	22	2
9355	\N	151	300	t	\N	22	2
9356	\N	153	300	t	\N	22	2
9357	1	156	300	\N	\N	22	2
9358	8	158	300	\N	\N	22	2
9359	1	161	300	\N	\N	22	2
936	1451	189	8	\N	\N	8	\N
9360	\N	174	300	t	\N	22	2
9361	1	175	300	\N	\N	22	2
9362	\N	184	300	t	\N	22	2
9363	7	189	300	\N	\N	22	2
9364	3	191	300	\N	\N	22	2
9365	1	194	300	\N	\N	22	2
9366	3	196	300	\N	\N	22	2
9367	57	207	300	\N	\N	22	2
9368	1	126	301	\N	\N	22	2
9369	2	131	301	\N	1 m, 1 f	22	2
937	21	190	8	\N	\N	8	\N
9370	2	137	301	\N	1 m, 1 f	22	2
9371	1	151	301	\N	\N	22	2
9372	4	153	301	\N	\N	22	2
9373	6	158	301	\N	\N	22	2
9374	1	161	301	\N	\N	22	2
9375	1	167	301	\N	\N	22	2
9376	1	171	301	\N	\N	22	2
9377	1	174	301	\N	\N	22	2
9378	1	186	301	\N	\N	22	2
9379	9	189	301	\N	\N	22	2
938	164	191	8	\N	\N	8	\N
9380	3	191	301	\N	\N	22	2
9381	3	194	301	\N	\N	22	2
9382	5	196	301	\N	\N	22	2
9383	2	204	301	\N	\N	22	2
9384	16	207	301	\N	\N	22	2
9385	4	7	302	\N	\N	22	2
9386	20	44	302	\N	\N	22	2
9387	2	131	302	\N	\N	22	2
9388	1	132	302	\N	\N	22	2
9389	1	135	302	\N	\N	22	2
939	3	193	8	\N	\N	8	\N
9390	2	137	302	\N	\N	22	2
9391	1	141	302	\N	\N	22	2
9392	2	151	302	\N	\N	22	2
9393	1	153	302	\N	\N	22	2
9394	2	156	302	\N	\N	22	2
9395	3	160	302	\N	\N	22	2
9396	3	161	302	\N	\N	22	2
9397	1	75	302	\N	\N	22	2
9398	1	170	302	\N	\N	22	2
9399	3	174	302	\N	\N	22	2
94	35	186	1	\N	\N	1	\N
940	540	194	8	\N	\N	8	\N
9400	3	175	302	\N	\N	22	2
9401	15	189	302	\N	\N	22	2
9402	5	194	302	\N	\N	22	2
9403	3	196	302	\N	\N	22	2
9404	30	207	302	\N	\N	22	2
9405	1	210	302	\N	probably purple	22	2
9406	2	137	303	\N	\N	22	2
9407	1	151	303	\N	\N	22	2
9408	1	154	303	\N	\N	22	2
9409	20	158	303	\N	\N	22	2
941	3	195	8	\N	\N	8	\N
9410	2	161	303	\N	\N	22	2
9411	1	163	303	\N	\N	22	2
9412	3	164	303	\N	\N	22	2
9413	1	167	303	\N	\N	22	2
9414	1	75	303	\N	\N	22	2
9415	2	170	303	\N	\N	22	2
9416	1	171	303	\N	\N	22	2
9417	1	174	303	\N	\N	22	2
9418	1	175	303	\N	\N	22	2
9419	2	189	303	\N	\N	22	2
942	404	196	8	\N	\N	8	\N
9420	5	194	303	\N	\N	22	2
9421	2	196	303	\N	\N	22	2
9422	6	207	303	\N	\N	22	2
9423	1	131	304	\N	\N	22	2
9424	3	158	304	\N	\N	22	2
9425	3	161	304	\N	\N	22	2
9426	2	163	304	\N	\N	22	2
9427	1	164	304	\N	\N	22	2
9428	1	167	304	\N	\N	22	2
9429	14	170	304	\N	\N	22	2
943	91	199	8	\N	\N	8	\N
9430	5	174	304	\N	\N	22	2
9431	2	175	304	\N	\N	22	2
9432	1	186	304	\N	\N	22	2
9433	35	189	304	\N	\N	22	2
9434	3	194	304	\N	\N	22	2
9435	2	196	304	\N	\N	22	2
9436	1	197	304	\N	\N	22	2
9437	2	207	304	\N	\N	22	2
9438	\N	126	305	t	\N	22	2
9439	\N	131	305	t	\N	22	2
944	110	201	8	\N	\N	8	\N
9440	\N	137	305	t	\N	22	2
9441	1	156	305	\N	\N	22	2
9442	2	164	305	\N	\N	22	2
9443	3	170	305	\N	\N	22	2
9444	3	174	305	\N	\N	22	2
9445	15	189	305	\N	\N	22	2
9446	2	196	305	\N	\N	22	2
9447	2	204	305	\N	\N	22	2
9448	25	207	305	\N	\N	22	2
9449	13	7	306	\N	flying	22	2
945	1	202	8	\N	\N	8	\N
9450	4	131	306	\N	\N	22	2
9451	2	151	306	\N	\N	22	2
9452	2	156	306	\N	\N	22	2
9453	1	158	306	\N	\N	22	2
9454	2	161	306	\N	\N	22	2
9455	5	176	306	\N	\N	22	2
9456	17	189	306	\N	Originally reported as Slate-colored	22	2
9457	5	194	306	\N	\N	22	2
9458	3	196	306	\N	\N	22	2
9459	16	197	306	\N	2 originally reported as White-throated	22	2
946	1	203	8	\N	\N	8	\N
9460	2	204	306	\N	\N	22	2
9461	17	207	306	\N	\N	22	2
9462	1	7	307	\N	audio	22	2
9463	1	131	307	\N	male	22	2
9464	1	137	307	\N	audio	22	2
9465	2	154	307	\N	\N	22	2
9466	3	156	307	\N	\N	22	2
9467	1	161	307	\N	audio	22	2
9468	1	163	307	\N	\N	22	2
9469	1	164	307	\N	\N	22	2
947	293	204	8	\N	\N	8	\N
9470	3	170	307	\N	\N	22	2
9471	3	171	307	\N	1 male, 1, 1	22	2
9472	1	173	307	\N	\N	22	2
9473	1	174	307	\N	\N	22	2
9474	1	175	307	\N	\N	22	2
9475	10	189	307	\N	\N	22	2
9476	17	194	307	\N	5, 4, 3, 1, 1, 1, 1, 1	22	2
9477	5	196	307	\N	2, 1, 1, 1	22	2
9478	2	131	308	\N	\N	22	2
9479	2	156	308	\N	\N	22	2
948	49	205	8	\N	\N	8	\N
9480	1	161	308	\N	\N	22	2
9481	1	168	308	\N	\N	22	2
9482	2	174	308	\N	\N	22	2
9483	1	191	308	\N	\N	22	2
9484	1	194	308	\N	\N	22	2
9485	2	196	308	\N	\N	22	2
9486	6	207	308	\N	\N	22	2
9487	18	5	309	\N	\N	23	5
9488	20	7	309	\N	\N	23	5
9489	1	22	309	\N	\N	23	5
949	46	206	8	\N	\N	8	\N
9490	2	16	309	\N	\N	23	5
9491	1	17	309	\N	\N	23	5
9492	1066	18	309	\N	Harper Pier: Flying over towards harper estuary.\nWashington, US: Estimate by 10s\n8685 Southeast John Street, Port Orchard: Estimate by 10s\nYukon Harbor: Estimate by 10s	23	5
9493	40	20	309	\N	\N	23	5
9494	13	24	309	\N	\N	23	5
9495	44	29	309	\N	\N	23	5
9496	1	30	309	\N	Harper Pier: F, by herself	23	5
9497	6	33	309	\N	Harper Pier: 2m, 1f\nWashington, US: 1m, 2f	23	5
9498	117	34	309	\N	\N	23	5
9499	8	35	309	\N	\N	23	5
95	\N	188	1	t	\N	1	\N
950	376	207	8	\N	\N	8	\N
9500	94	39	309	\N	\N	23	5
9501	141	40	309	\N	\N	23	5
9502	2	41	309	\N	\N	23	5
9503	16	43	309	\N	3379 Southeast Olympiad Drive, Port Orchard: F	23	5
9504	5	44	309	\N	\N	23	5
9505	25	45	309	\N	\N	23	5
9506	31	59	309	\N	\N	23	5
9507	14	60	309	\N	\N	23	5
9508	1	131	309	\N	\N	23	5
9509	9	86	309	\N	\N	23	5
951	192	208	8	\N	\N	8	\N
9510	26	89	309	\N	\N	23	5
9511	1	87	309	\N	\N	23	5
9512	1	99	309	\N	\N	23	5
9513	8	100	309	\N	\N	23	5
9514	4	103	309	\N	\N	23	5
9515	58	106	309	\N	\N	23	5
9516	3	109	309	\N	\N	23	5
9517	8	112	309	\N	\N	23	5
9518	4	113	309	\N	\N	23	5
9519	4	114	309	\N	\N	23	5
952	89	211	8	\N	\N	8	\N
9520	29	116	309	\N	\N	23	5
9521	3	53	309	\N	\N	23	5
9522	15	54	309	\N	\N	23	5
9523	3	55	309	\N	\N	23	5
9524	8	65	309	\N	\N	23	5
9525	7	67	309	\N	\N	23	5
9526	20	66	309	\N	\N	23	5
9527	9	69	309	\N	\N	23	5
9528	1	73	309	\N	\N	23	5
9529	4	76	309	\N	Southworth Ferry Terminal: A, 0846\nHarper Park and estuary: Adults 1214 in tree	23	5
953	1	2	9	\N	\N	9	\N
9530	4	132	309	\N	\N	23	5
9531	1	137	309	\N	\N	23	5
9532	2	151	309	\N	\N	23	5
9533	1	152	309	\N	\N	23	5
9534	37	153	309	\N	\N	23	5
9535	1	156	309	\N	\N	23	5
9536	3	171	309	\N	\N	23	5
9537	3	170	309	\N	\N	23	5
9538	1	161	309	\N	\N	23	5
9539	5	164	309	\N	\N	23	5
954	11	6	9	\N	\N	9	\N
9540	17	176	309	\N	\N	23	5
9541	17	174	309	\N	\N	23	5
9542	1	211	309	\N	\N	23	5
9543	6	204	309	\N	\N	23	5
9544	1	205	309	\N	\N	23	5
9545	1	207	309	\N	\N	23	5
9546	4	186	309	\N	\N	23	5
9547	2	187	309	\N	\N	23	5
9548	1	189	309	\N	\N	23	5
9549	18	194	309	\N	\N	23	5
955	280	7	9	\N	\N	9	\N
9550	2	196	309	\N	\N	23	5
9551	4	196	309	\N	\N	23	5
9552	6	199	309	\N	\N	23	5
9553	8	15	310	\N	\N	23	5
9554	1	17	310	\N	\N	23	5
9555	95	18	310	\N	\N	23	5
9556	162	20	310	\N	2980 Long Lake Road Southeast, Port Orchard: Estimate by10s	23	5
9557	7	39	310	\N	\N	23	5
9558	1	43	310	\N	\N	23	5
9559	1	82	310	\N	3722 Long Lake Road Southeast, Port Orchard: Heard, a surprise!	23	5
956	\N	11	9	t	\N	9	\N
9560	1	86	310	\N	\N	23	5
9561	1	79	310	\N	\N	23	5
9562	1	134	310	\N	\N	23	5
9563	1	137	310	\N	\N	23	5
9564	7	153	310	\N	\N	23	5
9565	5	154	310	\N	\N	23	5
9566	2	156	310	\N	\N	23	5
9567	2	170	310	\N	\N	23	5
9568	1	163	310	\N	\N	23	5
9569	1	164	310	\N	\N	23	5
957	15	15	9	\N	\N	9	\N
9570	16	176	310	\N	\N	23	5
9571	1	175	310	\N	\N	23	5
9572	7	174	310	\N	\N	23	5
9573	2	186	310	\N	\N	23	5
9574	17	189	310	\N	\N	23	5
9575	9	194	310	\N	\N	23	5
9576	1	196	310	\N	\N	23	5
9577	15	199	310	\N	\N	23	5
9578	4	201	310	\N	\N	23	5
9579	6	39	311	\N	\N	23	5
958	4	16	9	\N	\N	9	\N
9580	9	40	311	\N	\N	23	5
9581	3	119	311	\N	\N	23	5
9582	9	120	311	\N	\N	23	5
9583	4	131	311	\N	\N	23	5
9584	2	106	311	\N	\N	23	5
9585	1	76	311	\N	\N	23	5
9586	1	77	311	\N	\N	23	5
9587	2	137	311	\N	Fraola Cemetery: 1 RSFL	23	5
9588	7	151	311	\N	\N	23	5
9589	1	154	311	\N	\N	23	5
959	8	17	9	\N	\N	9	\N
9590	1	156	311	\N	\N	23	5
9591	3	158	311	\N	\N	23	5
9592	12	175	311	\N	\N	23	5
9593	1	173	311	\N	\N	23	5
9594	23	174	311	\N	\N	23	5
9595	1	211	311	\N	\N	23	5
9596	3	204	311	\N	\N	23	5
9597	4	207	311	\N	\N	23	5
9598	3	186	311	\N	\N	23	5
9599	72	189	311	\N	\N	23	5
96	492	189	1	\N	\N	1	\N
960	3185	18	9	\N	\N	9	\N
9600	18	191	311	\N	\N	23	5
9601	7	194	311	\N	\N	23	5
9602	11	196	311	\N	\N	23	5
9603	\N	131	312	t	1 F, 1 M	23	5
9604	\N	135	312	t	1 F, 1 M	23	5
9605	\N	136	312	t	1 M	23	5
9606	2	137	312	\N	1 F, 1 M	23	5
9607	\N	141	312	t	1 M, 1 F	23	5
9608	\N	151	312	t	2	23	5
9609	1	156	312	\N	\N	23	5
961	834	20	9	\N	\N	9	\N
9610	8	158	312	\N	\N	23	5
9611	4	160	312	\N	\N	23	5
9612	2	161	312	\N	\N	23	5
9613	1	171	312	\N	\N	23	5
9614	5	174	312	\N	\N	23	5
9615	1	175	312	\N	\N	23	5
9616	1	186	312	\N	\N	23	5
9617	8	189	312	\N	7 reported as Slate-colored	23	5
9618	3	190	312	\N	\N	23	5
9619	5	194	312	\N	\N	23	5
962	17	22	9	\N	\N	9	\N
9620	4	196	312	\N	2 F, 2 M	23	5
9621	2	204	312	\N	\N	23	5
9622	2	205	312	\N	\N	23	5
9623	5	207	312	\N	\N	23	5
9624	1	131	313	\N	\N	23	6
9625	1	86	313	\N	\N	23	6
9626	3	137	313	\N	5795 SE Hovgaard Rd, Olalla US-WA (47.4472,-122.5766): 3 RSFL	23	6
9627	1	143	313	\N	\N	23	6
9628	1	151	313	\N	\N	23	6
9629	2	153	313	\N	\N	23	6
963	9	23	9	\N	\N	9	\N
9630	6	154	313	\N	\N	23	6
9631	1	164	313	\N	\N	23	6
9632	51	176	313	\N	\N	23	6
9633	11	175	313	\N	\N	23	6
9634	16	174	313	\N	\N	23	6
9635	30	207	313	\N	\N	23	6
9636	2	186	313	\N	\N	23	6
9637	10	189	313	\N	\N	23	6
9638	7	194	313	\N	\N	23	6
9639	1	196	313	\N	\N	23	6
964	24	24	9	\N	\N	9	\N
9640	2	199	313	\N	\N	23	6
9641	1	7	314	\N	\N	23	6
9642	1	21	314	\N	\N	23	6
9643	2	34	314	\N	\N	23	6
9644	12	39	314	\N	\N	23	6
9645	14	40	314	\N	\N	23	6
9646	7	43	314	\N	\N	23	6
9647	3	45	314	\N	\N	23	6
9648	1	59	314	\N	\N	23	6
9649	3	112	314	\N	\N	23	6
965	1	26	9	\N	\N	9	\N
9650	2	113	314	\N	\N	23	6
9651	3	116	314	\N	\N	23	6
9652	18	66	314	\N	\N	23	6
9653	3	69	314	\N	\N	23	6
9654	1	76	314	\N	Mace Lake: Adult	23	6
9655	1	132	314	\N	\N	23	6
9656	5	153	314	\N	\N	23	6
9657	1	154	314	\N	\N	23	6
9658	1	171	314	\N	\N	23	6
9659	2	174	314	\N	\N	23	6
966	40	28	9	\N	\N	9	\N
9660	2	194	314	\N	\N	23	6
9661	13	15	315	\N	\N	23	6
9662	3	22	315	\N	\N	23	6
9663	8	18	315	\N	\N	23	6
9664	45	20	315	\N	\N	23	6
9665	1	26	315	\N	\N	23	6
9666	225	28	315	\N	Vashon CBC, Kitsap West, Long   Lake, \n Port Orchard: Tried for accurate count. One flock of 175.	23	6
9667	19	30	315	\N	\N	23	6
9668	2	31	315	\N	\N	23	6
9669	37	39	315	\N	\N	23	6
967	161	29	9	\N	\N	9	\N
9670	7	43	315	\N	\N	23	6
9671	57	44	315	\N	\N	23	6
9672	1	47	315	\N	\N	23	6
9673	25	58	315	\N	\N	23	6
9674	9	83	315	\N	\N	23	6
9675	1	108	315	\N	\N	23	6
9676	4	112	315	\N	\N	23	6
9677	35	113	315	\N	\N	23	6
9678	4	114	315	\N	\N	23	6
9679	15	66	315	\N	\N	23	6
968	31	30	9	\N	\N	9	\N
9680	3	69	315	\N	\N	23	6
9681	1	71	315	\N	\N	23	6
9682	1	79	315	\N	\N	23	6
9683	5	139	315	\N	\N	23	6
9684	3	151	315	\N	\N	23	6
9685	18	153	315	\N	\N	23	6
9686	6	156	315	\N	\N	23	6
9687	3	158	315	\N	\N	23	6
9688	1	167	315	\N	\N	23	6
9689	16	174	315	\N	\N	23	6
969	20	31	9	\N	\N	9	\N
9690	1	204	315	\N	\N	23	6
9691	2	207	315	\N	\N	23	6
9692	1	186	315	\N	\N	23	6
9693	6	187	315	\N	\N	23	6
9694	2	194	315	\N	\N	23	6
9695	1	196	315	\N	\N	23	6
9696	1	199	315	\N	\N	23	6
9697	87	7	316	\N	\N	23	6
9698	2	18	316	\N	\N	23	6
9699	75	20	316	\N	\N	23	6
97	40	191	1	\N	\N	1	\N
970	15	33	9	\N	\N	9	\N
9700	1	23	316	\N	\N	23	6
9701	5	24	316	\N	\N	23	6
9702	2	25	316	\N	\N	23	6
9703	1	28	316	\N	\N	23	6
9704	8	39	316	\N	\N	23	6
9705	1	43	316	\N	\N	23	6
9706	2	120	316	\N	\N	23	6
9707	5	131	316	\N	\N	23	6
9708	1	82	316	\N	\N	23	6
9709	6	86	316	\N	\N	23	6
971	771	34	9	\N	\N	9	\N
9710	13	114	316	\N	\N	23	6
9711	4	69	316	\N	\N	23	6
9712	1	71	316	\N	\N	23	6
9713	2	76	316	\N	\N	23	6
9714	2	79	316	\N	\N	23	6
9715	1	135	316	\N	\N	23	6
9716	2	137	316	\N	\N	23	6
9717	1	139	316	\N	\N	23	6
9718	2	143	316	\N	\N	23	6
9719	7	151	316	\N	\N	23	6
972	447	35	9	\N	\N	9	\N
9720	7	153	316	\N	\N	23	6
9721	11	154	316	\N	\N	23	6
9722	20	156	316	\N	\N	23	6
9723	7	158	316	\N	\N	23	6
9724	1	171	316	\N	\N	23	6
9725	1	164	316	\N	\N	23	6
9726	217	176	316	\N	\N	23	6
9727	14	175	316	\N	\N	23	6
9728	1	173	316	\N	\N	23	6
9729	125	174	316	\N	\N	23	6
973	11	36	9	\N	\N	9	\N
9730	4	211	316	\N	\N	23	6
9731	8	204	316	\N	\N	23	6
9732	4	205	316	\N	\N	23	6
9733	46	207	316	\N	\N	23	6
9734	17	186	316	\N	\N	23	6
9735	83	187	316	\N	\N	23	6
9736	2	190	316	\N	\N	23	6
9737	29	191	316	\N	\N	23	6
9738	1	193	316	\N	\N	23	6
9739	8	194	316	\N	\N	23	6
974	544	39	9	\N	\N	9	\N
9740	11	196	316	\N	\N	23	6
9741	58	199	316	\N	Vashon CBC, Kitsap West, Port Orchard: 7	23	6
9742	1	135	317	\N	\N	23	6
9743	1	158	317	\N	\N	23	6
9744	1	161	317	\N	\N	23	6
9745	2	175	317	\N	1 male, 1 female	23	6
9746	3	186	317	\N	sooty	23	6
9747	8	189	317	\N	\N	23	6
9748	3	196	317	\N	\N	23	6
9749	3	120	318	\N	\N	23	6
975	291	40	9	\N	\N	9	\N
9750	1	131	318	\N	\N	23	6
9751	4	137	318	\N	\N	23	6
9752	6	151	318	\N	\N	23	6
9753	2	158	318	\N	\N	23	6
9754	1	72	318	\N	\N	23	6
9755	1	79	318	\N	\N	23	6
9756	8	174	318	\N	\N	23	6
9757	4	175	318	\N	\N	23	6
9758	21	189	318	\N	\N	23	6
9759	2	190	318	\N	\N	23	6
976	133	41	9	\N	\N	9	\N
9760	2	194	318	\N	\N	23	6
9761	2	196	318	\N	\N	23	6
9762	22	199	318	\N	\N	23	6
9763	4	204	318	\N	3 Red 1 Brown	23	6
9764	58	207	318	\N	\N	23	6
9765	4	33	319	\N	\N	23	3
9766	14	34	319	\N	\N	23	3
9767	22	39	319	\N	\N	23	3
9768	16	40	319	\N	\N	23	3
9769	7	45	319	\N	\N	23	3
977	77	43	9	\N	\N	9	\N
9770	8	59	319	\N	\N	23	3
9771	3	131	319	\N	\N	23	3
9772	4	153	319	\N	\N	23	3
9773	2	156	319	\N	\N	23	3
9774	16	158	319	\N	\N	23	3
9775	1	161	319	\N	\N	23	3
9776	3	163	319	\N	\N	23	3
9777	1	164	319	\N	\N	23	3
9778	5	66	319	\N	\N	23	3
9779	1	76	319	\N	\N	23	3
978	524	44	9	\N	\N	9	\N
9780	45	116	319	\N	\N	23	3
9781	1	170	319	\N	\N	23	3
9782	18	189	319	\N	\N	23	3
9783	9	194	319	\N	\N	23	3
9784	5	196	319	\N	\N	23	3
9785	4	204	319	\N	\N	23	3
9786	1	34	320	\N	\N	23	3
9787	6	39	320	\N	\N	23	3
9788	20	40	320	\N	\N	23	3
9789	2	41	320	\N	\N	23	3
979	86	45	9	\N	\N	9	\N
9790	13	45	320	\N	\N	23	3
9791	9	59	320	\N	\N	23	3
9792	1	60	320	\N	\N	23	3
9793	2	61	320	\N	\N	23	3
9794	9	131	320	\N	\N	23	3
9795	3	86	320	\N	\N	23	3
9796	1	93	320	\N	\N	23	3
9797	1	87	320	\N	\N	23	3
9798	1	100	320	\N	\N	23	3
9799	2	103	320	\N	\N	23	3
98	\N	193	1	t	\N	1	\N
980	17	47	9	\N	\N	9	\N
9800	4	104	320	\N	\N	23	3
9801	3	106	320	\N	\N	23	3
9802	1	107	320	\N	\N	23	3
9803	4	112	320	\N	\N	23	3
9804	11	113	320	\N	\N	23	3
9805	1	53	320	\N	\N	23	3
9806	1	67	320	\N	\N	23	3
9807	6	66	320	\N	\N	23	3
9808	3	76	320	\N	\N	23	3
9809	2	79	320	\N	\N	23	3
981	4	51	9	\N	\N	9	\N
9810	1	135	320	\N	\N	23	3
9811	2	141	320	\N	\N	23	3
9812	5	137	320	\N	\N	23	3
9813	4	151	320	\N	\N	23	3
9814	18	153	320	\N	\N	23	3
9815	10	156	320	\N	\N	23	3
9816	18	158	320	\N	\N	23	3
9817	17	160	320	\N	\N	23	3
9818	2	171	320	\N	\N	23	3
9819	5	170	320	\N	\N	23	3
982	76	53	9	\N	\N	9	\N
9820	3	161	320	\N	\N	23	3
9821	18	164	320	\N	\N	23	3
9822	6	167	320	\N	\N	23	3
9823	600	176	320	\N	\N	23	3
9824	2	175	320	\N	\N	23	3
9825	714	174	320	\N	\N	23	3
9826	2	177	320	\N	\N	23	3
9827	12	204	320	\N	\N	23	3
9828	87	207	320	\N	\N	23	3
9829	2	208	320	\N	\N	23	3
983	133	54	9	\N	\N	9	\N
9830	7	186	320	\N	\N	23	3
9831	13	186	320	\N	\N	23	3
9832	5	187	320	\N	\N	23	3
9833	1	188	320	\N	\N	23	3
9834	67	189	320	\N	\N	23	3
9835	3	190	320	\N	\N	23	3
9836	11	191	320	\N	\N	23	3
9837	36	194	320	\N	\N	23	3
9838	3	195	320	\N	\N	23	3
9839	10	196	320	\N	\N	23	3
984	28	55	9	\N	\N	9	\N
9840	1	200	320	\N	\N	23	3
9841	1	181	320	\N	\N	23	3
9842	3	183	320	\N	\N	23	3
9843	53	7	321	\N	\N	23	3
9844	2	18	321	\N	\N	23	3
9845	4	20	321	\N	\N	23	3
9846	5	131	321	\N	\N	23	3
9847	4	132	321	\N	\N	23	3
9848	1	134	321	\N	\N	23	3
9849	1	137	321	\N	\N	23	3
985	72	58	9	\N	\N	9	\N
9850	1	151	321	\N	\N	23	3
9851	1	152	321	\N	\N	23	3
9852	14	153	321	\N	\N	23	3
9853	2	154	321	\N	\N	23	3
9854	7	156	321	\N	\N	23	3
9855	8	158	321	\N	\N	23	3
9856	6	160	321	\N	\N	23	3
9857	2	161	321	\N	\N	23	3
9858	3	76	321	\N	\N	23	3
9859	2	79	321	\N	\N	23	3
986	334	59	9	\N	\N	9	\N
9860	3	86	321	\N	\N	23	3
9861	6	116	321	\N	\N	23	3
9862	6	170	321	\N	\N	23	3
9863	366	174	321	\N	\N	23	3
9864	8	175	321	\N	\N	23	3
9865	20	176	321	\N	\N	23	3
9866	180	178	321	\N	\N	23	3
9867	2	186	321	\N	\N	23	3
9868	65	189	321	\N	\N	23	3
9869	22	191	321	\N	\N	23	3
987	49	60	9	\N	\N	9	\N
9870	3	194	321	\N	\N	23	3
9871	3	196	321	\N	\N	23	3
9872	6	204	321	\N	\N	23	3
9873	31	211	321	\N	\N	23	3
9874	\N	18	322	t	\N	23	3
9875	3	20	322	\N	\N	23	3
9876	\N	39	322	t	\N	23	3
9877	\N	43	322	t	\N	23	3
9878	3	131	322	\N	\N	23	3
9879	\N	132	322	t	\N	23	3
988	7	61	9	\N	\N	9	\N
9880	1	134	322	\N	\N	23	3
9881	1	135	322	\N	\N	23	3
9882	12	137	322	\N	\N	23	3
9883	3	151	322	\N	\N	23	3
9884	35	153	322	\N	\N	23	3
9885	2	156	322	\N	\N	23	3
9886	1	158	322	\N	\N	23	3
9887	1	160	322	\N	\N	23	3
9888	\N	164	322	t	\N	23	3
9889	\N	66	322	t	\N	23	3
989	809	62	9	\N	\N	9	\N
9890	\N	69	322	t	\N	23	3
9891	1	79	322	\N	\N	23	3
9892	\N	86	322	t	\N	23	3
9893	\N	100	322	t	\N	23	3
9894	225	174	322	\N	approximate, numerous flocks nearly continuous single-direction flyover this morning.  More robins see in air and on farm than any day before!	23	3
9895	1	175	322	\N	\N	23	3
9896	160	176	322	\N	similar sightings as robin, but fewer total birds	23	3
9897	39	178	322	\N	perched together	23	3
9898	2	186	322	\N	\N	23	3
9899	32	189	322	\N	\N	23	3
99	190	194	1	\N	\N	1	\N
990	35	65	9	\N	\N	9	\N
9900	23	191	322	\N	\N	23	3
9901	\N	194	322	t	\N	23	3
9902	14	196	322	\N	\N	23	3
9903	1	204	322	\N	\N	23	3
9904	3	207	322	\N	\N	23	3
9905	1	200	322	\N	\N	23	3
9906	5	5	323	\N	\N	23	3
9907	1	6	323	\N	Rabbs Lagoon: Originally 1, removed due to duplication w/ earlier visit to location	23	3
9908	85	7	323	\N	Rabbs Lagoon: Originally 85, reduced to 25 due to duplication w/ earlier visit to location	23	3
9909	1	9	323	\N	Rabbs Lagoon: Originally 1, removed due to duplication w/ earlier visit to location	23	3
991	471	66	9	\N	\N	9	\N
9910	0	16	323	\N	Portage, Vashon: 1 "poached" at Portage Marsh in VS East area	23	3
9911	44	18	323	\N	\N	23	3
9912	1	20	323	\N	\N	23	3
9913	3	29	323	\N	\N	23	3
9914	1	30	323	\N	\N	23	3
9915	53	34	323	\N	\N	23	3
9916	3	35	323	\N	\N	23	3
9917	2	38	323	\N	\N	23	3
9918	51	39	323	\N	\N	23	3
9919	78	40	323	\N	\N	23	3
992	20	67	9	\N	\N	9	\N
9920	8	41	323	\N	\N	23	3
9921	2	43	323	\N	\N	23	3
9922	3	44	323	\N	\N	23	3
9923	30	45	323	\N	\N	23	3
9924	57	59	323	\N	\N	23	3
9925	36	60	323	\N	\N	23	3
9926	16	61	323	\N	Portage, Vashon: Groups of 13 and 2, a bit surprised to see so many -- dark cheeks, peaked heads, more pointed, slightly upturned bills compared to nearby HOGR	23	3
9927	31	117	323	\N	\N	23	3
9928	5	131	323	\N	\N	23	3
9929	0	82	323	\N	\N	23	3
993	21	69	9	\N	\N	9	\N
9930	3	86	323	\N	\N	23	3
9931	3	100	323	\N	\N	23	3
9932	6	103	323	\N	\N	23	3
9933	21	106	323	\N	\N	23	3
9934	0	107	323	\N	\N	23	3
9935	3	112	323	\N	\N	23	3
9936	7	113	323	\N	\N	23	3
9937	21	114	323	\N	\N	23	3
9938	1	53	323	\N	\N	23	3
9939	5	54	323	\N	\N	23	3
994	1	71	9	\N	\N	9	\N
9940	5	55	323	\N	\N	23	3
9941	5	67	323	\N	\N	23	3
9942	14	66	323	\N	\N	23	3
9943	2	69	323	\N	\N	23	3
9944	3	76	323	\N	Ellisport, Vashon: 1 adult\nPortage, Vashon: 1 adult removed as presumed duplicate w/ Ellisport observation\nRabbs Lagoon: 2 adult\nLower Gold Beach, Vashon: Immature	23	3
9945	2	77	323	\N	Ellisport, Vashon: 1 immature removed as presumed duplicate w/ Chautauqua Beach Neighborhood observation\nPortage, Vashon: 1 immature removed as presumed duplicate w/ Chautauqua Beach Neighborhood observation\nRabbs Lagoon: 1 immature	23	3
9946	2	79	323	\N	\N	23	3
9947	3	132	323	\N	\N	23	3
9948	1	134	323	\N	\N	23	3
9949	1	135	323	\N	\N	23	3
995	6	72	9	\N	\N	9	\N
9950	1	141	323	\N	\N	23	3
9951	3	137	323	\N	\N	23	3
9952	1	139	323	\N	\N	23	3
9953	3	151	323	\N	\N	23	3
9954	12	153	323	\N	\N	23	3
9955	1	154	323	\N	\N	23	3
9956	8	156	323	\N	\N	23	3
9957	8	158	323	\N	\N	23	3
9958	1	171	323	\N	\N	23	3
9959	11	170	323	\N	\N	23	3
996	5	73	9	\N	\N	9	\N
9960	2	161	323	\N	\N	23	3
9961	1	163	323	\N	\N	23	3
9962	2	164	323	\N	\N	23	3
9963	2	167	323	\N	\N	23	3
9964	24	176	323	\N	\N	23	3
9965	2	175	323	\N	\N	23	3
9966	607	174	323	\N	Rabbs Lagoon: Originally 25, reduced to 22 due to duplication w/ earlier visit to location	23	3
9967	80	178	323	\N	\N	23	3
9968	2	211	323	\N	\N	23	3
9969	9	204	323	\N	\N	23	3
997	81	76	9	\N	\N	9	\N
9970	1	205	323	\N	\N	23	3
9971	354	207	323	\N	\N	23	3
9972	6	186	323	\N	\N	23	3
9973	26	189	323	\N	\N	23	3
9974	5	190	323	\N	\N	23	3
9975	28	191	323	\N	\N	23	3
9976	16	194	323	\N	\N	23	3
9977	9	196	323	\N	Rabbs Lagoon: Originally 1, removed due to duplication w/ earlier visit to location	23	3
9978	1	181	323	\N	\N	23	3
9979	4	183	323	\N	\N	23	3
998	27	79	9	\N	\N	9	\N
9980	3	131	324	\N	\N	23	3
9981	1	135	324	\N	male	23	3
9982	1	137	324	\N	\N	23	3
9983	2	156	324	\N	\N	23	3
9984	2	161	324	\N	\N	23	3
9985	1	76	324	\N	\N	23	3
9986	3	189	324	\N	\N	23	3
9987	1	191	324	\N	\N	23	3
9988	1	194	324	\N	\N	23	3
9989	1	196	324	\N	\N	23	3
999	4	82	9	\N	\N	9	\N
9990	1	204	324	\N	\N	23	3
9991	23	207	324	\N	\N	23	3
9992	1	131	325	\N	\N	23	3
9993	1	137	325	\N	\N	23	3
9994	1	156	325	\N	\N	23	3
9995	2	158	325	\N	\N	23	3
9996	2	161	325	\N	\N	23	3
9997	1	186	325	\N	\N	23	3
9998	15	189	325	\N	\N	23	3
9999	2	190	325	\N	\N	23	3
\.


--
-- Dependencies: 217
-- Data for Name: observers; Type: TABLE DATA; Schema: public; Owner: ezra
--

COPY public.observers (id, first_name, last_name, email) FROM stdin;
2	Daniel	Froehlich	danielfroehlich@gmail.com
3	Lisa	Pedersen	lisa_mp52@yahoo.com
4	Chazz	Hesselein	chazz@hesselein.com
5	Donna	LaCasse	wildernesstrekkers9@gmail.com
6	Mary	Pearse	marpea72@gmail.com
7	Richard	Smethurst	\N
8	Kay	Schimke	dalekay@rockjock.com
9	Ken	Brown	kennethwbrown@hotmail.com
10	Ed	Pullen	edwardpullen@gmail.com
11	Wayne	Jackson	\N
12	Sharon	Aukland	sewsharon@comcast.net
13	Marie	Blichfeldt	bblichfeldt@centurytel.net
14	Alice	Bloch	alicebloch@comcast.net
15	Sharon	Helmick	sehelmick@comcast.net
16	Ezra	Parker	ezra@cfgrok.com
17	Harsi	Parker	hparker@solaceimages.com
20	Bob	Hawkins	rhawkins43@comcast.net
21	Michelle	Ramsden	mramsden_11@yahoo.com
22	Alan	Warneke	alanw.editingdr@comcast.net
23	Brian	Bell	bellasoc@isomedia.com
24	John	Friars	\N
25	Ellie	Friars	johnellie1@comcast.net
26	Mark	Friars	markonvashon@yahoo.com
27	Ben	Funkhouser	b.funkhouser@gmail.com
28	Art	Wang	artnancy@harbornet.com
30	John	Riegsecker	jriegsecker@pobox.com
31	Terry	Mace	woodmace@centurytel.net
32	Pat	Damron	shutterbugpat@gmail.com
34	Heather	Voboril	eyewaunabirdwatch@gmail.com
35	Carol	Smith	carolmsmith1@comcast.net
36	Ashley	Powell	aspowel0@uw.edu
37	Faye	McAdams Hands	zest4parus@hotmail.com
38	Diane	Yorgason-Quinn	avosetta@hotmail.com
39	Adam	Trent	\N
41	Ed	Swan	edswan2@comcast.net
42	Jean	Olson	orcajean@hotmail.com
43	Cheryl	Fultz	cherylf@deltawestern.com
47	Fran	Brooks	fran.brooks@comcast.net
49	Jeff	Nystuen	jeff.nystuen@gmail.com
50	Fran	O'Reilly	oreilly.frances7@gmail.com
51	Ann	Spiers	spiers@centurytel.net
52	Jean	Emmons	jemmons@me.com
53	Will	Dacus	\N
54	Lauren	Forrest	\N
55	Rayna	Holtz	raynaholtz@aol.com
56	Jay	Holtz	jtholtz@aol.com
57	Liz	Lewis	lizpots@gmail.com
60	Karen	Ripley	karenlouise@centurytel.net
63	Margie	Morgan	margiemorgan49@gmail.com
66	Ollie	Oliver	\N
67	Randy	Turner	lodnar@gmail.com
68	Linda	Peterson	lindatpeterson@gmail.com
69	Gary	Peterson	petersongary@comcast.net
70	Charlie	Crow	chacro@comcast.net
71	Anne	Bell	lannebell@gmail.com
72	Claudia	Hollander-Lucas	claudia@claudiahollander-lucas.com
73	Emma	Amiad	eamiad@vashonislandrealestate.com
75	Steve	Caldwell	caldvest@gmail.com
76	Jim	Evans	jimevans@centurytel.net
77	Kelly	Keenan	kellkeenan@yahoo.com
80	Kip	Schwarzmiller	zeke_1@netzero.com
82	Larry	Jensen	larryjpjensen@hotmail.com
83	Kathryn	True	kathryntrue1@gmail.com
84	Karen	Fevold	klfevold@hotmail.com
85	Osha	Sky	ohjosky@gmail.com
86	Diane	Sweetman	diane.sweetman1@gmail.com
87	John	Sweetman	jdsweet2002@aol.com
89	Richard	Rogers	richard@rogers-graphics.com
1	Gary	Shugart	gshugart@ups.edu
90	Eric	Dudley	egdudley@gmail.com
91	Mary Kay	Elfman	mkme@outlook.com
92	Katherine	Schimke	dkschimke@gmail.com
93	Mark	Merriman	\N
94	Madeline	Merriman	\N
95	Doug	Aukland	dcauk@comcast.net
96	Chris	Kerber	\N
18	Susan	McClellan	mcsukay@comcast.net
59	Sherry	Bottoms	sherryriverbottoms@yahoo.com
78	Bunny	Hatcher	pyewacket23@comcast.net
88	Lindsay	Hofman	linfishof@aol.com
65	Grace	Oliver	grace.ollie.oliver@gmail.com
33	Vaughn	Teeters	vateeters@netscape.net
46	Sharon	Metcalf	cousythecat@gmail.com
40	Pamela	Coons	pmcoons@aol.com
79	Dale	Korenek	dalek@windermere.com
44	Bruce	Haulman	bhaulman@aol.com
58	Dagny	Adamson	ajax1953@msn.com
61	Stephen	Rose	scnlrose@aol.com
81	Mary	Brennan	inxcapable@gmail.com
19	Bianca	Perla	bianca@vashonnaturecenter.org
64	Mary Fran	Lyons	maryfran.lyons@gmail.com
45	Randy	Smith	cousythecat@gmail.com
97	Rob	Piston	rpiston@zoho.com
74	Susan	DeNies	sue.denies@gmail.com
98	James	Hyde	jamesfchyde@gmail.com
99	Judy	Sarkisian	perfection@seanet.com
101	Cass	Dahlstrom	c.dahlstrom38@gmail.com
102	Melissa	Sherwood	medesh@gmail.com
103	Sarah	Guenther	sarahguenther8@gmail.com
104	Stephen	Snyder	sosman725@comcast.net
105	Vera	Cragin	vmcragin@comcast.net
107	Amanda	Flynn-Stach	afstach@yahoo.com
108	Susan	Boynton	seboynton@msn.com
29	Laurel	Parshall	kehlilanasnan@yahoo.com
109	Bill	Salyan	\N
111	Jerry	Messinger	\N
112	Jeff	Bronson	jbronson1@gmail.com
113	Jon	Anderson	festuca@comcast.net
114	Amy	Bogaard	\N
115	Madrone	Sky	\N
116	Brien	Meilleur	brienmeilleur@aol.com
119	Joanne	Ryan	mj10@comcast.net
120	Ron	Simons	simons-buss@earthlink.net
121	Carol	Butler	butlergu@yahoo.com
122	George	Butler	\N
123	Sarah	Driggs	sdriggs@comcast.net
124	Jim	Diers	jimdiers@comcast.net
125	Amy	Mandin	\N
126	Robert	Teagardin	rteagardin@comcast.net
127	Orion	Knowler	\N
128	Dave	Richardson	wohlheter2@aol.com
130	Shannon	Kachel	skachel@uw.edu
131	Mike	Feinstein	mike@feinsteins.net
133	Sue	Trevathan	mstrev30@gmail.com
134	Vicky	de Monterey Richoux	vdemrichoux@gmail.com
135	Jack	Durrett	jad333@gmail.com
137	Clark	Nebeker	\N
139	Michael	Sperazza	\N
140	Bruce	LaBar	blabar@harbornet.com
141	Leander	Swan	\N
142	Roger	Moyer	rogermoyer1@hotmail.com
143	William	Burton	billyburton.geo@gmail.com
144	Bob	Keller	atern@hotmail.com
146	Carri	Singer	\N
147	Therese	Smith	\N
150	Robbie	Howell	rchowell1931@gmail.com
151	Robert	Howell	\N
152	Laura	Bienen	biengers1@gmail.com
154	Wilson	Abbott	wilslide@gmail.com
155	Connie	Gorrell	\N
156	Virginia	Lohr	lohr@turbonet.com
157	Steve	Graham	sngraham98070@gmail.com
158	Ivy	Sacks	ivysacks@gmail.com
153	Hunter	Davis	chdvashon@gmail.com
160	Susan	Madden	zebragal@foxinternet.com
161	Mary Lynn	Buss	\N
162	Joe	Touhey	joetouhey@yahoo.com
163	Marc	Cordova	marccordova@mac.com
164	Tim	Finley	321timfin@gmail.com
165	Marcy	Summers	marcy@tompotika.org
136	Sue	Nebeker	blueberryhillfabrics@comcast.net
110	Dennis	Davidson	vashondavidsons@yahoo.com
106	Alex	Wang	axwang@hawaii.edu
166	Sammie	Buechner	sbuechner2@gmail.com
167	Cara	Borre	cmborre1@gmail.com
168	Asta	Tobiassen	atobiassen1@gmail.com
169	Nick	Hamill	njh1201@gmail.com
185	Vicki	Biltz	vickibiltz@gmail.com
170	Jim	O'Donnell	jossa@comcast.net
171	Ron	Post	ronpost4@gmail.com
172	Sarah	Peden	sarahpeden@yahoo.com
145	Julie	Burman	julieruthburman@gmail.com
173	Suzanne	Greenberg	suzanneggreenberg@gmail.com
174	Noah	Roselander	noah.roselander@gmail.com
175	Scott	Anderson	scottvicki1@hotmail.com
48	Michael	Elenko	michael.elenko@comcast.net
176	Nancy	Rose	\N
177	Brit	Myers	6ritmyers@gmail.com
178	Jacob	Miller	njja2m@icloud.com
179	Steve	Hunter	sbhunter@ncsce.org
180	Dave	Keenan	judgedavidkeenan@gmail.com
181	Eric	Newman	ericnewmanlaw@gmail.com
182	Eleanor	Newman	\N
183	Molly	Newman	\N
184	Brendan	McGarry	mcgbre04@gmail.com
129	Ron	Martin	remartingig@yahoo.com
186	Joanne	Saul	saulmill50@gmail.com
187	Kirsten	Tucker	kirsten@kirstenpix.com
188	Edie	Kroha	sparklegirl3181@q.com
189	Dick	Lazeres	dlazeres@att.net
190	Irma	O'Brien	\N
191	Leslie	Brown	jimandleslie@centurytel.net
149	Carol	Carlson-Ray	caray2@comcast.net
192	Margaret	Bickel	\N
100	Bob	Gibbs	rgibbs219@hotmail.com
118	Rita	Altamore	malachite777@comcast.net
159	Brad	Shinn	bradonvashon@gmail.com
138	Chris	Woods	cwoods2@mac.com
148	Andy	McCormick	andy_mcc@hotmail.com
62	Rich	Siegrist	richsieg@aol.com
195	Shana	Hirsch	shanalhirsch@gmail.com
196	Holly	Shull	frostflower2000@yahoo.com
197	Sylvia	Soholt	sylvia@sylvansanctuary.com
198	Sara	Van Fleet	saravanfleet@gmail.com
199	Lesley	Guddal	lesley.guddal@comcast.net
200	Keith	Guddal	\N
117	Steve	Macdonald	steven.c.macdonald@comcast.net
201	Nancy	Sutton	pithy816@gmail.com
202	Susan	Daniel	sdaniel537@aol.com
203	Gary	Beanland	\N
204	Wendy	Gibble	\N
205	Joy	Nelsen	janelsen@centurytel.net
206	Joe	Van Os	jvo@photosafaris.com
207	Cheryl	Weise	cheryl.weise@gmail.com
208	Dennis	Sherwood	\N
209	Joyce	Meyer	meyer2j@aol.com
210	Mike	West	cat88bird@gmail.com
211	Andy	Mauro	akamauro1@gmail.com
212	Clark	Rowland	crowland1965@gmail.com
213	Jody	Hess	jody1310@comcast.net
214	Jerry	Siegrist	steel4you@comcast.net
215	Chris	Rurik	chrisrurik@gmail.com
216	Melissa	Scott	tripledivide@hotmail.com
217	Carlyn	Roedell	carlyn22@msn.com
218	Michael	Roedell	\N
219	Bob	Sargent	robertkirksargent@gmail.com
220	Hannah	Rohrbacher	\N
221	Jean	Findlay	gfindlay@centurytel.net
222	Gilbert	Findlay	\N
223	Sarah Ann	Thompson	farlowia@gmail.com
224	Beth	White	4bethwhite4@gmail.com
225	Wayne	Sladek	sladekw@nventure.com
226	Crystal	McMahon	crystalmc63@gmail.com
227	David	Noble	\N
228	Elise	Harnois	elise.zuercher@gmail.com
229	Sheri	Clark	slclark27@gmail.com
230	Faye McAdams	Hands	zest4parus@hotmail.com
231	Linda	Sowers	lindalsowers@gmail.com
194	Dimitri	Hunter	dee1613@hotmail.com
193	Victoria	Hunter	vtor.hunter@gmail.com
232	Charles	Caldwell	caldwell.charles@gmail.com
233	Alice	Burns	alice_burns@hotmail.com
234	Laura	Dizazzo	dizazzolaura@gmail.com
235	Mem	Rippey	memrippey@me.com
236	Tom	Owens	owenssantosa@gmail.com
237	Deena	Eber	deenaeber@comcast.net
238	Kim	Cantrell	kimandcompany.kc@gmail.com
239	Betty	Hawkins	\N
240	John	Pierce	johnpi@outlook.com
241	Michael	Flaherty	mwflahe@gmail.com
242	William	Seagren	renaissancegeek@gmail.com
243	Cherry	Minkavage	cherrymink@hotmail.com
244	Joe	RouLaine	nobleopossum@outlook.com
245	Shep	Thorp	shepthorp@gmail.com
246	Inga	Rouches	inga@rouches.com
247	Kathleen	Fellbaum	\N
248	Jim	Flynn	thejimflynn@gmail.com
249	Jeremy	Lucas	jeremy.lucas79@gmail.com
250	Marissa	Benevente	\N
251	Alex	Koriath	koriath.alex@gmail.com
252	Cheryl	Richmond	hello@cherylrichmond.com
253	Dan	Willsie	\N
254	Carol	Ferch	\N
255	Catherine	Rokitka	catherinejoymusic@gmail.com
256	Debra	Paulsen	dlpvashon@gmail.com
257	Debra	Bolanos	dbbolanos63@gmail.com
258	Peter	Roberts	peter.c.roberts@gmail.com
259	Craig	Cummings	yakteachr@yahoo.com
260	Paul	Butkiewicz	\N
261	Maya	Butkiewicz	\N
132	Adria	Magrath	adriamagrath@gmail.com
262	Anna	Sander	annaksander@gmail.com
263	Caroline	Tucker	\N
264	Laurie	Tucker	lauriejm.tucker@gmail.com
265	Bruce	Hoeft	brucehoeft@gmail.com
266	George	Rurik	\N
267	Angela	Guy	angelaguy@att.net
268	Steve	Elston	stephen.elston@gmail.com
269	Vicky de Monterey	Richoux	vdemrichoux@gmail.com
270	Bob	Tucker	\N
271	Charlie	Daugherty	zagudabuda@gmail.com
272	Andrew	Davidson	andrewndavidson@gmail.com
273	Charlie	Caldwell	\N
274	Jody	Pritchard	jpritchard789@gmail.com
\.


--
-- Dependencies: 226
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: ezra
--

COPY public.schema_migrations (version) FROM stdin;
20210220185454
20160124220610
20160210204600
20160211043421
20160211102500
20160124220600
20160124220507
20160210232546
20160124220519
20160210204616
\.


--
-- Dependencies: 219
-- Data for Name: sectors; Type: TABLE DATA; Schema: public; Owner: ezra
--

COPY public.sectors (id, name, code, on_island) FROM stdin;
1	Vashon North	VN	t
2	Vashon South	VS	t
3	Maury/Tramp	MT	t
4	Quartermaster Harbor	QH	t
5	Kitsap East	KE	f
6	Kitsap West	KW	f
7	Pierce North	PN	f
\.


--
-- Dependencies: 221
-- Data for Name: surveys; Type: TABLE DATA; Schema: public; Owner: ezra
--

COPY public.surveys (id, date, year_id) FROM stdin;
1	2000-01-02	1
2	2000-12-31	2
3	2001-12-30	3
4	2003-01-05	4
5	2004-01-04	5
6	2005-01-02	6
7	2006-01-01	7
8	2006-12-31	8
9	2007-12-30	9
10	2008-12-28	10
11	2009-12-27	11
12	2011-01-02	12
13	2011-12-31	13
14	2012-12-30	14
15	2014-01-05	15
16	2015-01-04	16
17	2016-01-03	17
18	2017-01-02	18
19	2017-12-31	19
20	2018-12-30	20
21	2020-01-05	21
22	2021-01-03	22
23	2022-01-03	23
24	2023-01-02	24
25	2023-12-31	25
\.


--
-- Dependencies: 223
-- Data for Name: taxons; Type: TABLE DATA; Schema: public; Owner: ezra
--

COPY public.taxons (id, common_name, cbc_name, scientific_name, taxonomic_order, generic, active) FROM stdin;
1	Swan Goose (Domestic type)	Swan Goose (Domestic type)	Anser cygnoides (Domestic type)	1	\N	\N
2	Greater White-fronted Goose	Greater White-fronted Goose	Anser albifrons	2	\N	\N
3	Domestic goose sp.	Domestic goose sp. (Domestic type)	Anser sp. (Domestic type)	3	\N	\N
4	Snow Goose	Snow Goose	Chen caerulescens	4	\N	\N
5	Brant	Brant	Branta bernicla	5	\N	\N
6	Cackling Goose	Cackling Goose	Branta hutchinsii	6	\N	\N
7	Canada Goose	Canada Goose	Branta canadensis	7	\N	\N
8	Cackling/Canada Goose	Cackling/Canada Goose	Branta hutchinsii/canadensis	8	\N	\N
9	Domestic goose sp. x Canada Goose	Domestic goose sp. (Domestic type) x Canada Goose (hybrid)	Anser sp. (Domestic type) x Branta canadensis	9	\N	\N
10	goose sp.	goose sp.	Anser/Chen/Branta sp.	10	\N	\N
11	Trumpeter Swan	Trumpeter Swan	Cygnus buccinator	11	\N	\N
12	Tundra Swan	Tundra Swan	Cygnus columbianus	12	\N	\N
13	Trumpeter/Tundra Swan	Trumpeter/Tundra Swan	Cygnus buccinator/columbianus	13	\N	\N
14	Muscovy Duck (Domestic type)	Muscovy Duck (Domestic type)	Cairina moschata (Domestic type)	14	\N	\N
15	Wood Duck	Wood Duck	Aix sponsa	15	\N	\N
16	Gadwall	Gadwall	Anas strepera	16	\N	\N
17	Eurasian Wigeon	Eurasian Wigeon	Anas penelope	17	\N	\N
18	American Wigeon	American Wigeon	Anas americana	18	\N	\N
19	Eurasian x American Wigeon (hybrid)	Eurasian x American Wigeon (hybrid)	Anas penelope x americana	19	\N	\N
20	Mallard	Mallard	Anas platyrhynchos	20	\N	\N
21	Mallard (Domestic type)	Mallard (Domestic type)	Anas platyrhynchos (Domestic type)	21	\N	\N
22	Northern Shoveler	Northern Shoveler	Anas clypeata	22	\N	\N
23	Northern Pintail	Northern Pintail	Anas acuta	23	\N	\N
24	Green-winged Teal	Green-winged Teal (American)	Anas crecca carolinensis	24	\N	\N
25	dabbling duck sp.	dabbling duck sp.	Anas sp.	25	\N	\N
26	Canvasback	Canvasback	Aythya valisineria	26	\N	\N
27	Redhead	Redhead	Aythya americana	27	\N	\N
28	Ring-necked Duck	Ring-necked Duck	Aythya collaris	28	\N	\N
29	Greater Scaup	Greater Scaup	Aythya marila	29	\N	\N
30	Lesser Scaup	Lesser Scaup	Aythya affinis	30	\N	\N
31	scaup sp.	Greater/Lesser Scaup	Aythya marila/affinis	31	\N	\N
32	Common Eider	Common Eider	Somateria mollissima	32	\N	\N
33	Harlequin Duck	Harlequin Duck	Histrionicus histrionicus	33	\N	\N
34	Surf Scoter	Surf Scoter	Melanitta perspicillata	34	\N	\N
35	White-winged Scoter	White-winged Scoter	Melanitta fusca	35	\N	\N
36	Black Scoter	Black Scoter	Melanitta americana	36	\N	\N
37	scoter sp.	scoter sp.	Melanitta sp.	37	\N	\N
38	Long-tailed Duck	Long-tailed Duck	Clangula hyemalis	38	\N	\N
39	Bufflehead	Bufflehead	Bucephala albeola	39	\N	\N
40	Common Goldeneye	Common Goldeneye	Bucephala clangula	40	\N	\N
41	Barrow's Goldeneye	Barrow's Goldeneye	Bucephala islandica	41	\N	\N
42	goldeneye sp.	Common/Barrow's Goldeneye	Bucephala clangula/islandica	42	\N	\N
43	Hooded Merganser	Hooded Merganser	Lophodytes cucullatus	43	\N	\N
44	Common Merganser	Common Merganser	Mergus merganser	44	\N	\N
45	Red-breasted Merganser	Red-breasted Merganser	Mergus serrator	45	\N	\N
46	merganser sp.	Common/Red-breasted Merganser	Mergus merganser/serrator	46	\N	\N
47	Ruddy Duck	Ruddy Duck	Oxyura jamaicensis	47	\N	\N
48	duck sp.	duck sp.	Anatinae sp.	48	\N	\N
49	Mountain Quail	Mountain Quail	Oreortyx pictus	49	\N	\N
50	California Quail	California Quail	Callipepla californica	50	\N	\N
51	Ring-necked Pheasant	Ring-necked Pheasant	Phasianus colchicus	51	\N	\N
52	Ruffed Grouse	Ruffed Grouse	Bonasa umbellus	52	\N	\N
53	Red-throated Loon	Red-throated Loon	Gavia stellata	53	\N	\N
54	Pacific Loon	Pacific Loon	Gavia pacifica	54	\N	\N
55	Common Loon	Common Loon	Gavia immer	55	\N	\N
56	Yellow-billed Loon	Yellow-billed Loon	Gavia adamsii	56	\N	\N
57	loon sp.	loon sp.	Gavia sp.	57	\N	\N
58	Pied-billed Grebe	Pied-billed Grebe	Podilymbus podiceps	58	\N	\N
59	Horned Grebe	Horned Grebe	Podiceps auritus	59	\N	\N
60	Red-necked Grebe	Red-necked Grebe	Podiceps grisegena	60	\N	\N
61	Eared Grebe	Eared Grebe	Podiceps nigricollis	61	\N	\N
62	Western Grebe	Western Grebe	Aechmophorus occidentalis	62	\N	\N
63	Clark's Grebe	Clark's Grebe	Aechmophorus clarkii	63	\N	\N
64	grebe sp.	grebe sp.	Podicipedidae sp.	64	\N	\N
65	Brandt's Cormorant	Brandt's Cormorant	Phalacrocorax penicillatus	65	\N	\N
66	Double-crested Cormorant	Double-crested Cormorant	Phalacrocorax auritus	66	\N	\N
67	Pelagic Cormorant	Pelagic Cormorant	Phalacrocorax pelagicus	67	\N	\N
68	cormorant sp.	cormorant sp.	Phalacrocorax sp.	68	\N	\N
69	Great Blue Heron	Great Blue Heron (Blue form)	Ardea herodias [herodias Group]	69	\N	\N
70	Green Heron	Green Heron	Butorides virescens	70	\N	\N
71	Northern Harrier	Northern Harrier	Circus cyaneus	71	\N	\N
72	Sharp-shinned Hawk	Sharp-shinned Hawk	Accipiter striatus	72	\N	\N
73	Cooper's Hawk	Cooper's Hawk	Accipiter cooperii	73	\N	\N
74	Northern Goshawk	Northern Goshawk	Accipiter gentilis	74	\N	\N
75	Accipiter sp.	Accipiter sp.	Accipiter sp.	75	\N	\N
77	Bald Eagle immature	Bald Eagle	Haliaeetus leucocephalus	77	\N	\N
78	Red-shouldered Hawk	Red-shouldered Hawk	Buteo lineatus	78	\N	\N
79	Red-tailed Hawk	Red-tailed Hawk	Buteo jamaicensis	79	\N	\N
80	Rough-legged Hawk	Rough-legged Hawk	Buteo lagopus	80	\N	\N
81	Buteo sp.	Buteo sp.	Buteo sp.	81	\N	\N
82	Virginia Rail	Virginia Rail	Rallus limicola	82	\N	\N
83	American Coot	American Coot	Fulica americana	83	\N	\N
84	Sandhill Crane	Sandhill Crane	Antigone canadensis	84	\N	\N
85	Semipalmated Plover	Semipalmated Plover	Charadrius semipalmatus	85	\N	\N
86	Killdeer	Killdeer	Charadrius vociferus	86	\N	\N
87	Spotted Sandpiper	Spotted Sandpiper	Actitis macularius	87	\N	\N
88	Greater Yellowlegs	Greater Yellowlegs	Tringa melanoleuca	88	\N	\N
89	Black Turnstone	Black Turnstone	Arenaria melanocephala	89	\N	\N
90	Surfbird	Surfbird	Calidris virgata	90	\N	\N
91	Sanderling	Sanderling	Calidris alba	91	\N	\N
92	Dunlin	Dunlin	Calidris alpina	92	\N	\N
93	Least Sandpiper	Least Sandpiper	Calidris minutilla	93	\N	\N
94	Western Sandpiper	Western Sandpiper	Calidris mauri	94	\N	\N
95	Wilson's Snipe	Wilson's Snipe	Gallinago delicata	95	\N	\N
96	Wilson's/Common Snipe	Wilson's/Common Snipe	Gallinago delicata/gallinago	96	\N	\N
97	Red Phalarope	Red Phalarope	Phalaropus fulicarius	97	\N	\N
98	sandpiper sp.	Scolopacidae sp.	Scolopacidae sp.	98	\N	\N
99	Common Murre	Common Murre	Uria aalge	99	\N	\N
100	Pigeon Guillemot	Pigeon Guillemot	Cepphus columba	100	\N	\N
101	Marbled Murrelet	Marbled Murrelet	Brachyramphus marmoratus	101	\N	\N
102	Ancient Murrelet	Ancient Murrelet	Synthliboramphus antiquus	102	\N	\N
103	Rhinoceros Auklet	Rhinoceros Auklet	Cerorhinca monocerata	103	\N	\N
104	alcid sp.	alcid sp.	Alcidae sp.	104	\N	\N
105	Bonaparte's Gull	Bonaparte's Gull	Chroicocephalus philadelphia	105	\N	\N
107	Ring-billed Gull	Ring-billed Gull	Larus delawarensis	107	\N	\N
108	Western Gull	Western Gull	Larus occidentalis	108	\N	\N
109	California Gull	California Gull	Larus californicus	109	\N	\N
110	Herring Gull	Herring Gull	Larus argentatus	110	\N	\N
112	Glaucous-winged Gull	Glaucous-winged Gull	Larus glaucescens	112	\N	\N
113	Western x Glaucous-winged Gull	Western x Glaucous-winged Gull (hybrid)	Larus occidentalis x glaucescens	113	\N	\N
114	Western/Glaucous-winged Gull	Western/Glaucous-winged Gull	Larus occidentalis/glaucescens	114	\N	\N
115	Glaucous Gull	Glaucous Gull	Larus hyperboreus	115	\N	\N
116	gull sp.	gull sp.	Larinae sp.	116	\N	\N
117	Rock Pigeon	Rock Pigeon (Feral Pigeon)	Columba livia (Feral Pigeon)	117	\N	\N
118	Band-tailed Pigeon	Band-tailed Pigeon	Patagioenas fasciata	118	\N	\N
119	Eurasian Collared-Dove	Eurasian Collared-Dove	Streptopelia decaocto	119	\N	\N
120	Mourning Dove	Mourning Dove	Zenaida macroura	120	\N	\N
121	pigeon/dove sp.	pigeon/dove sp.	Columbidae sp.	121	\N	\N
122	Barn Owl	Barn Owl	Tyto alba	122	\N	\N
123	Western Screech-Owl	Western Screech-Owl	Megascops kennicottii	123	\N	\N
124	Great Horned Owl	Great Horned Owl	Bubo virginianus	124	\N	\N
125	Northern Pygmy-Owl	Northern Pygmy-Owl	Glaucidium gnoma	125	\N	\N
126	Barred Owl	Barred Owl	Strix varia	126	\N	\N
127	Long-eared Owl	Long-eared Owl	Asio otus	127	\N	\N
128	Short-eared Owl	Short-eared Owl	Asio flammeus	128	\N	\N
129	Northern Saw-whet Owl	Northern Saw-whet Owl	Aegolius acadicus	129	\N	\N
130	owl sp.	owl sp.	Strigiformes sp.	130	\N	\N
131	Anna's Hummingbird	Anna's Hummingbird	Calypte anna	131	\N	\N
132	Belted Kingfisher	Belted Kingfisher	Megaceryle alcyon	132	\N	\N
133	Acorn Woodpecker	Acorn Woodpecker	Melanerpes formicivorus	133	\N	\N
134	Red-breasted Sapsucker	Red-breasted Sapsucker	Sphyrapicus ruber	134	\N	\N
135	Downy Woodpecker	Downy Woodpecker	Picoides pubescens	135	\N	\N
136	Hairy Woodpecker	Hairy Woodpecker	Picoides villosus	136	\N	\N
137	Northern Flicker	Northern Flicker	Colaptes auratus	137	\N	\N
138	Northern Flicker (Yellow-shafted)	Northern Flicker (Yellow-shafted)	Colaptes auratus auratus/luteus	138	\N	\N
139	Northern Flicker (Red-shafted)	Northern Flicker (Red-shafted)	Colaptes auratus [cafer Group]	139	\N	\N
106	Short-billed Gull	Mew Gull	Larus canus	106	\N	\N
76	Bald Eagle	Bald Eagle	Haliaeetus leucocephalus	76	\N	\N
140	Northern Flicker (intergrade)	Northern Flicker (intergrade)	Colaptes auratus luteus x cafer	140	\N	\N
141	Pileated Woodpecker	Pileated Woodpecker	Dryocopus pileatus	141	\N	\N
142	woodpecker sp.	woodpecker sp.	Picidae sp.	142	\N	\N
143	American Kestrel	American Kestrel	Falco sparverius	143	\N	\N
144	Merlin	Merlin	Falco columbarius	144	\N	\N
145	Peregrine Falcon	Peregrine Falcon	Falco peregrinus	145	\N	\N
146	falcon sp.	small falcon sp.	Falco sp. (small falcon sp.)	146	\N	\N
147	Ash-throated Flycatcher	Ash-throated Flycatcher	Myiarchus cinerascens	147	\N	\N
148	Northern Shrike	Northern Shrike	Lanius excubitor	148	\N	\N
149	Hutton's Vireo	Hutton's Vireo	Vireo huttoni	149	\N	\N
150	Gray Jay	Gray Jay	Perisoreus canadensis	150	\N	\N
151	Steller's Jay	Steller's Jay	Cyanocitta stelleri	151	\N	\N
153	American Crow	American Crow	Corvus brachyrhynchos	153	\N	\N
154	Common Raven	Common Raven	Corvus corax	154	\N	\N
155	Violet-green Swallow	Violet-green Swallow	Tachycineta thalassina	155	\N	\N
156	Black-capped Chickadee	Black-capped Chickadee	Poecile atricapillus	156	\N	\N
157	Mountain Chickadee	Mountain Chickadee	Poecile gambeli	157	\N	\N
158	Chestnut-backed Chickadee	Chestnut-backed Chickadee	Poecile rufescens	158	\N	\N
159	chickadee sp.	chickadee sp.	Poecile sp.	159	\N	\N
160	Bushtit	Bushtit	Psaltriparus minimus	160	\N	\N
161	Red-breasted Nuthatch	Red-breasted Nuthatch	Sitta canadensis	161	\N	\N
162	White-breasted Nuthatch	White-breasted Nuthatch	Sitta carolinensis	162	\N	\N
163	Brown Creeper	Brown Creeper	Certhia americana	163	\N	\N
164	Pacific Wren	Pacific Wren	Troglodytes pacificus	164	\N	\N
165	Pacific/Winter Wren	Pacific/Winter Wren	Troglodytes pacificus/hiemalis	165	\N	\N
166	Marsh Wren	Marsh Wren	Cistothorus palustris	166	\N	\N
167	Bewick's Wren	Bewick's Wren	Thryomanes bewickii	167	\N	\N
168	wren sp.	wren sp.	Troglodytidae sp.	168	\N	\N
169	American Dipper	American Dipper	Cinclus mexicanus	169	\N	\N
170	Golden-crowned Kinglet	Golden-crowned Kinglet	Regulus satrapa	170	\N	\N
171	Ruby-crowned Kinglet	Ruby-crowned Kinglet	Regulus calendula	171	\N	\N
172	Townsend's Solitaire	Townsend's Solitaire	Myadestes townsendi	172	\N	\N
173	Hermit Thrush	Hermit Thrush	Catharus guttatus	173	\N	\N
174	American Robin	American Robin	Turdus migratorius	174	\N	\N
175	Varied Thrush	Varied Thrush	Ixoreus naevius	175	\N	\N
176	European Starling	European Starling	Sturnus vulgaris	176	\N	\N
177	American Pipit	American Pipit	Anthus rubescens	177	\N	\N
178	Cedar Waxwing	Cedar Waxwing	Bombycilla cedrorum	178	\N	\N
179	Orange-crowned Warbler	Orange-crowned Warbler	Oreothlypis celata	179	\N	\N
180	Palm Warbler	Palm Warbler	Setophaga palmarum	180	\N	\N
181	Yellow-rumped Warbler	Yellow-rumped Warbler	Setophaga coronata	181	\N	\N
182	Yellow-rumped Warbler (Myrtle)	Yellow-rumped Warbler (Myrtle)	Setophaga coronata coronata	182	\N	\N
183	Yellow-rumped Warbler (Audubon's)	Yellow-rumped Warbler (Audubon's)	Setophaga coronata auduboni	183	\N	\N
184	Townsend's Warbler	Townsend's Warbler	Setophaga townsendi	184	\N	\N
185	warbler sp.	warbler sp. (Parulidae sp.)	Parulidae sp.	185	\N	\N
186	Fox Sparrow	Fox Sparrow	Passerella iliaca	186	\N	\N
187	Dark-eyed Junco	Dark-eyed Junco	Junco hyemalis	187	\N	\N
188	Dark-eyed Junco (Slate-colored)	Dark-eyed Junco (Slate-colored)	Junco hyemalis hyemalis/carolinensis	188	\N	\N
189	Dark-eyed Junco (Oregon)	Dark-eyed Junco (Oregon)	Junco hyemalis [oreganus Group]	189	\N	\N
190	White-crowned Sparrow	White-crowned Sparrow	Zonotrichia leucophrys	190	\N	\N
191	Golden-crowned Sparrow	Golden-crowned Sparrow	Zonotrichia atricapilla	191	\N	\N
192	Harris's Sparrow	Harris's Sparrow	Zonotrichia querula	192	\N	\N
193	White-throated Sparrow	White-throated Sparrow	Zonotrichia albicollis	193	\N	\N
194	Song Sparrow	Song Sparrow	Melospiza melodia	194	\N	\N
195	Lincoln's Sparrow	Lincoln's Sparrow	Melospiza lincolnii	195	\N	\N
196	Spotted Towhee	Spotted Towhee	Pipilo maculatus	196	\N	\N
197	sparrow sp.	sparrow sp.	Emberizidae sp.	197	\N	\N
198	Black-headed Grosbeak	Black-headed Grosbeak	Pheucticus melanocephalus	198	\N	\N
199	Red-winged Blackbird	Red-winged Blackbird	Agelaius phoeniceus	199	\N	\N
200	Western Meadowlark	Western Meadowlark	Sturnella neglecta	200	\N	\N
201	Brewer's Blackbird	Brewer's Blackbird	Euphagus cyanocephalus	201	\N	\N
202	Brown-headed Cowbird	Brown-headed Cowbird	Molothrus ater	202	\N	\N
203	blackbird sp.	blackbird sp.	Icteridae sp.	203	\N	\N
204	House Finch	House Finch	Haemorhous mexicanus	204	\N	\N
205	Purple Finch	Purple Finch	Haemorhous purpureus	205	\N	\N
206	Red Crossbill	Red Crossbill	Loxia curvirostra	206	\N	\N
207	Pine Siskin	Pine Siskin	Spinus pinus	207	\N	\N
208	American Goldfinch	American Goldfinch	Spinus tristis	208	\N	\N
209	Evening Grosbeak	Evening Grosbeak	Coccothraustes vespertinus	209	\N	\N
210	finch sp.	finch sp.	Fringillidae sp.	210	\N	\N
211	House Sparrow	House Sparrow	Passer domesticus	211	\N	\N
152	California Scrub-Jay	Western Scrub-Jay	Aphelocoma californica	152	\N	\N
111	Iceland Gull (Thayer's)	Thayer's Gull	Larus thayeri	111	\N	\N
\.


--
-- Dependencies: 225
-- Data for Name: years; Type: TABLE DATA; Schema: public; Owner: ezra
--

COPY public.years (id, audubon_year, vashon_year) FROM stdin;
1	100	1
2	101	2
3	102	3
4	103	4
5	104	5
6	105	6
7	106	7
8	107	8
9	108	9
10	109	10
11	110	11
12	111	12
13	112	13
14	113	14
15	114	15
16	115	16
17	116	17
18	117	18
19	118	19
20	119	20
21	120	21
22	121	22
23	122	23
24	123	24
25	124	25
\.


--
-- Dependencies: 209
-- Name: areas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezra
--

SELECT pg_catalog.setval('public.areas_id_seq', 29, true);


--
-- Dependencies: 211
-- Name: checklists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezra
--

SELECT pg_catalog.setval('public.checklists_id_seq', 477, true);


--
-- Dependencies: 214
-- Name: observations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezra
--

SELECT pg_catalog.setval('public.observations_id_seq', 13677, true);


--
-- Dependencies: 216
-- Name: observers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezra
--

SELECT pg_catalog.setval('public.observers_id_seq', 274, true);


--
-- Dependencies: 218
-- Name: sectors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezra
--

SELECT pg_catalog.setval('public.sectors_id_seq', 7, true);


--
-- Dependencies: 220
-- Name: surveys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezra
--

SELECT pg_catalog.setval('public.surveys_id_seq', 25, true);


--
-- Dependencies: 222
-- Name: taxons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezra
--

SELECT pg_catalog.setval('public.taxons_id_seq', 211, true);


--
-- Dependencies: 224
-- Name: years_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezra
--

SELECT pg_catalog.setval('public.years_id_seq', 25, true);


--
-- Name: areas areas_pkey; Type: CONSTRAINT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.areas
    ADD CONSTRAINT areas_pkey PRIMARY KEY (id);


--
-- Name: checklists checklists_pkey; Type: CONSTRAINT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.checklists
    ADD CONSTRAINT checklists_pkey PRIMARY KEY (id);


--
-- Name: observations observations_pkey; Type: CONSTRAINT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.observations
    ADD CONSTRAINT observations_pkey PRIMARY KEY (id);


--
-- Name: observers observers_pkey; Type: CONSTRAINT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.observers
    ADD CONSTRAINT observers_pkey PRIMARY KEY (id);


--
-- Name: sectors sectors_pkey; Type: CONSTRAINT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_pkey PRIMARY KEY (id);


--
-- Name: surveys surveys_pkey; Type: CONSTRAINT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.surveys
    ADD CONSTRAINT surveys_pkey PRIMARY KEY (id);


--
-- Name: taxons taxons_pkey; Type: CONSTRAINT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.taxons
    ADD CONSTRAINT taxons_pkey PRIMARY KEY (id);


--
-- Name: years years_pkey; Type: CONSTRAINT; Schema: public; Owner: ezra
--

ALTER TABLE ONLY public.years
    ADD CONSTRAINT years_pkey PRIMARY KEY (id);


--
-- Name: index_areas_on_sector_id; Type: INDEX; Schema: public; Owner: ezra
--

CREATE INDEX index_areas_on_sector_id ON public.areas USING btree (sector_id);


--
-- Name: index_checklists_on_area_id; Type: INDEX; Schema: public; Owner: ezra
--

CREATE INDEX index_checklists_on_area_id ON public.checklists USING btree (area_id);


--
-- Name: index_checklists_on_sector_id; Type: INDEX; Schema: public; Owner: ezra
--

CREATE INDEX index_checklists_on_sector_id ON public.checklists USING btree (sector_id);


--
-- Name: index_checklists_on_survey_id; Type: INDEX; Schema: public; Owner: ezra
--

CREATE INDEX index_checklists_on_survey_id ON public.checklists USING btree (survey_id);


--
-- Name: index_observations_on_checklist_id; Type: INDEX; Schema: public; Owner: ezra
--

CREATE INDEX index_observations_on_checklist_id ON public.observations USING btree (checklist_id);


--
-- Name: index_observations_on_sector_id; Type: INDEX; Schema: public; Owner: ezra
--

CREATE INDEX index_observations_on_sector_id ON public.observations USING btree (sector_id);


--
-- Name: index_observations_on_survey_id; Type: INDEX; Schema: public; Owner: ezra
--

CREATE INDEX index_observations_on_survey_id ON public.observations USING btree (survey_id);


--
-- Name: index_observations_on_taxon_id; Type: INDEX; Schema: public; Owner: ezra
--

CREATE INDEX index_observations_on_taxon_id ON public.observations USING btree (taxon_id);


--
-- Name: index_surveys_on_year_id; Type: INDEX; Schema: public; Owner: ezra
--

CREATE INDEX index_surveys_on_year_id ON public.surveys USING btree (year_id);


--
-- Name: index_taxons_on_taxonomic_order; Type: INDEX; Schema: public; Owner: ezra
--

CREATE UNIQUE INDEX index_taxons_on_taxonomic_order ON public.taxons USING btree (taxonomic_order);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: ezra
--

CREATE UNIQUE INDEX unique_schema_migrations ON public.schema_migrations USING btree (version);



--
-- PostgreSQL database dump complete
--

