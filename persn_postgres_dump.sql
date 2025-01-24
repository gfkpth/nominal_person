--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.core_properties DROP CONSTRAINT syntactic_properties_languages_fk;
ALTER TABLE ONLY public.datasources DROP CONSTRAINT datasources_languages_fk;
ALTER TABLE ONLY public.article_properties DROP CONSTRAINT article_properties_languages_fk;
ALTER TABLE ONLY public.core_properties DROP CONSTRAINT syntactic_properties_pk;
ALTER TABLE ONLY public.languages DROP CONSTRAINT languages_unique;
ALTER TABLE ONLY public.languages DROP CONSTRAINT languages_pk;
ALTER TABLE public.languages ALTER COLUMN language_id DROP DEFAULT;
ALTER TABLE public.core_properties ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.languages_language_id_seq;
DROP TABLE public.languages;
DROP TABLE public.datasources;
DROP SEQUENCE public.core_properties_id_seq;
DROP TABLE public.core_properties;
DROP TABLE public.article_properties;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: article_properties; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.article_properties (
    language_id smallint NOT NULL,
    article_order character varying,
    demonstrative_w_article character varying,
    nominal_person_w_article character varying
);


--
-- Name: core_properties; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.core_properties (
    id smallint NOT NULL,
    language_id smallint NOT NULL,
    constituent_order character varying,
    constituent_order_wals character varying,
    adposition_order character varying,
    adposition_order_wals character varying,
    genitive_order character varying,
    genitive_order_wals character varying,
    demonstrative_order character varying,
    demonstrative_order_wals character varying,
    definite_article character varying,
    article_distinct_third boolean,
    demonstrative_as_third boolean,
    nominal_person boolean,
    apc_direction character varying,
    bound_person_direction character varying,
    person_allowed character varying,
    person_third_available character varying,
    number_allowed character varying,
    ppdc character varying
);


--
-- Name: core_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.core_properties_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: core_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.core_properties_id_seq OWNED BY public.core_properties.id;


--
-- Name: datasources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.datasources (
    language_id bigint,
    ref_short text,
    ref_pages text
);


--
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.languages (
    language_id smallint NOT NULL,
    lang_name character varying NOT NULL,
    glottocode character varying,
    walscode character varying,
    iso639_3 character varying,
    lat double precision,
    lon double precision,
    coord_notes text,
    area_wals character varying,
    area_glottolog character varying,
    sort_affiliation character varying,
    genus_wals character varying,
    family_genus character varying
);


--
-- Name: languages_language_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.languages_language_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: languages_language_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.languages_language_id_seq OWNED BY public.languages.language_id;


--
-- Name: core_properties id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_properties ALTER COLUMN id SET DEFAULT nextval('public.core_properties_id_seq'::regclass);


--
-- Name: languages language_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages ALTER COLUMN language_id SET DEFAULT nextval('public.languages_language_id_seq'::regclass);


--
-- Data for Name: article_properties; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.article_properties (language_id, article_order, demonstrative_w_article, nominal_person_w_article) FROM stdin;
20	NArt	n (demonstrative modifier), y („appositive“ dem.pronouns which follow the article)	y
27	ArtN	y	unclear
36	NArt	y	unclear
37	NArt	\N	y
39	NArt	y	y
41	NArt	n (or y, depending on analysis of demonstrative)	y
42	NArt	y? (no example given though)	y
45	NArt	y (optional)	y
46	NArt	y (optional)	y
49	ArtN	y (def agr)	y
50	ArtN	y (def agr)	y
51	ArtN	y (def. agreement)	y
55	ArtN	n?	n
61	NArt	y	y
62	ArtN	y (Art N Deict Part, if prenominal one combined form of article and deictic)	y
63	ArtN	y	y
64	ArtN	y	unclear
67	ArtN	y	n
68	ArtN	y	y
70	ArtN	y (optional)	\N
74	ArtN	no distinct dem.adjectives! [Art N Adv, the woman here]	n
75	ArtN	n	n
81	ArtN	y	n
84	\N	y (high register exception)	y
87	ArtN	n	n
88	ArtN	n	n
89	ArtN	n	n
90	ArtN	\N	y
91	ArtN	y	y
96	NArt	y	y
97	NArt	n (prenominal dem), y (postnominal dem)	y
98	ArtN	n (unless postnominal Dem)	y
99	ArtN	n (unless postnominal Dem)	y
100	ArtN	n (unless postnominal Dem?)	n
101	ArtN	n (unless postnominal Dem)	y
102	ArtN	n	n
103	ArtN	n	n
104	ArtN	n	n
106	NArt	n (prescriptive)	y
107	NArt	y (substandard?)	\N
108	NArt	y (substandard?)	y
112	NArt	n	n
113	ArtN	n	y
114	ArtN	n	y
124	ArtN	\N	y
125	NArt	y	y
127	ArtN	y	y
132	ArtN	y	n
\.


--
-- Data for Name: core_properties; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.core_properties (id, language_id, constituent_order, constituent_order_wals, adposition_order, adposition_order_wals, genitive_order, genitive_order_wals, demonstrative_order, demonstrative_order_wals, definite_article, article_distinct_third, demonstrative_as_third, nominal_person, apc_direction, bound_person_direction, person_allowed, person_third_available, number_allowed, ppdc) FROM stdin;
1	1	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	f	t	pre	n	all	y	non-sg	y
2	2	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	f	t	pre	n	all	y	non-sg	y
3	3	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	f	t	pre	n	all	y	all	\N
4	4	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	t	t	pre	n	all	y	non-sg	\N
5	5	OV	OV	pre	pre	NoDom	NoDom	DemN	DemN	n	f	t	t	pre	n	all	y	non-sg	\N
6	6	OV	OV	unclear	\N	GenN	GenN	DemN	DemN	n	f	f	t	pre	n	unclear	y	all	y
7	7	NC	No dominant order	post	\N	GenN	\N	NDem	\N	n	f	f	t	post	n	all	y	all	\N
8	8	OV	OV	NoAdpos	NoAdpos	GenN	GenN	mixed	mixed	\N	\N	\N	\N	\N	n	\N	\N	\N	\N
9	9	\N	\N	\N	\N	NoDom	NoDom	DemN	DemN	n	f	\N	\N	\N	n	\N	\N	\N	\N
10	10	OV	OV	post	post	GenN	GenN	NDem	NDem	n	f	f	t	both	n	all?	y	all?	y
11	11	OV	OV	unclear	\N	NoDom	NoDom	DemN	DemN	n	f	f	t	both	n	all?	y	all?	y (Haviland 1979: 73, (107))
12	12	OV	OV	pre	pre	NoDom	NoDom	mixed	mixed	n	f	f	t	both	n	all?	y	all	y
13	13	NC	No dominant order	NoAdpos	NoAdpos	GenN	GenN	DemN	DemN	n	f	f	t	pre	n	all	y	all	y
14	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
15	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
16	16	OV	OV	post	post	GenN	GenN	NDem	NDem	n	f	f	t	\N	post	all	y	all	y
17	17	OV	OV	post	post	GenN	GenN	NDem	\N	n	f	f	t	pre	n	no 3?	n?	non-sg	\N
18	18	OV	OV	post	post	GenN	GenN	mixed	mixed	n	f	f	t	both	n	all	y	nonum	\N
19	19	VO	VO	post	post	GenN	GenN	DemN	DemN	n	f	t	t	pre	post	all	y	all	n
20	20	OV	OV	post	post	GenN	GenN	NDem	\N	y (number, gender marking)	t	t	t	post	n	all	y	unclear	y
21	21	VO	\N	pre	\N	GenN	\N	NDem	\N	n	f	f	t	\N	pre	all	y	unclear	y
22	22	VO	VO	pre	pre	GenN	GenN	NDem	NDem	n	f	\N	t	pre	n	\N	\N	\N	\N
23	23	VO	VO	pre	pre	GenN	GenN	NDem	NDem	n	f	\N	t	pre	n	\N	\N	\N	y
24	24	VO	VO	pre	pre	NoDom	NoDom	NDem	NDem	n	f	f	t	post	n	all	y	unclear	\N
25	25	OV	\N	pre	\N	NoDom	\N	NDem	\N	n	f	f	t	pre	n	all	y	all?	y
26	26	OV	OV	post	post	GenN	GenN	NDem	NDem	\N	\N	\N	\N	\N	n	\N	\N	\N	\N
27	27	OV	OV	post	post	GenN	GenN	DemN	DemN	y? (Wegener 85ff. argues for distinction, but forms a identical except 3pl and an additional alternative form for 3sg.f determiner)	t	f	t	post	n	\N	\N	\N	y (Wegener 2012:86)
28	28	OV	\N	post	\N	GenN	\N	DemN	\N	n	f	f	t	pre	n	all	y	all	y
29	29	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	f	t	pre	n	unclear	y	all	\N
30	30	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	f	t	\N	post	all	y	all?	\N
31	31	OV	OV	post	post	GenN	GenN	DemN	DemN	n?	f	f	t	post	post	all	y	all	n
32	32	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	f	t	\N	post	all	y	all	n
33	33	OV	OV	post	post	GenN	GenN	DemN	\N	n	f	f	t	post	post	all	y	all	\N
34	34	OV	OV	post	post	GenN	GenN	NDem	NDem	n	f	f	t	post	n	all	y	all	y
35	35	OV	OV	post	post	GenN	GenN	NDem	NDem	n (oblig indef art)	f	f	t	post	n	all	y	all	no info
36	36	OV	OV	post	post	GenN	GenN	NDem	NDem	y (although possibly consisting of „near“ deictic e + „given marker“ -ng)	t	f	t	both	n	unclear	y	unclear	y
37	37	OV	OV	post	post	GenN	GenN	NDem	NDem	y (maybe specificity marker?)	t	f	t	post	n	only 3	only 3	nonum	\N
38	38	OV	\N	post	\N	GenN	\N	NDem	\N	n?	f	f	t	post	n	all?	y	all	y
39	39	OV	OV	NoDom	NoDom	GenN	GenN	NDem	NDem	y (actually 2: spec and def)	t	f	t	post	n	all?	y	nonum	\N
40	40	OV	\N	NoAdpos	\N	GenN	\N	NDem	\N	unclear (definite form of demonstrative?)	f	f	t	post	n	all	y	all	\N
41	41	OV	\N	NoAdpos	\N	GenN	\N	NDem	\N	y (2: spec, def) [dependent elements, only adnominally]	t	f	t	post	n	only 3	only 3	nonum	\N
42	42	OV	\N	post	\N	GenN	\N	NDem	\N	y, optional (2 distance distinction!)	t	f	t	post	n	unclear	y	all	\N
43	43	OV	\N	NoAdpos	\N	GenN	\N	NDem	\N	n	f	\N	\N	\N	n	\N	\N	\N	\N
44	44	OV	\N	NoAdpos	\N	GenN	\N	DemN	\N	n	f	f	t	post?	n	\N	\N	\N	\N
45	45	VO	VO	pre	pre	NGen	NGen	mixed	mixed	y	t	f	t	pre	n	all	y	all	y
46	46	VO	VO	pre	pre	NGen	NGen	NDem	NDem	y (Np final, usable after proper names, pronouns, demonstratives; identifies a noun phrase as belonging to the de dicto rather than a de re domain)	t	f	t	pre	n	all?	y	all?	\N
47	47	OV	\N	pre	\N	NGen	\N	NDem	\N	n	f	f	t	pre	n	\N	\N	\N	y
48	48	OV	\N	NoAdpos	\N	GenN	\N	DemN	\N	y (suffix)	t	f	t	pre	n	all?	all?	unclear	\N
49	49	VO	VO	pre	pre	NGen	NGen	NDem	NDem	y (affix, def agr)	t	f	t	pre	n	no 3	n	non-sg	\N
50	50	VO	VO	pre	pre	NGen	NGen	mixed	mixed	y (affix, def. agreement)	t	f	t	pre	n	no 3	n	non-sg	\N
51	51	VO	\N	pre	\N	NGen	\N	DemN	\N	y (affix on N and As; tendency to omit before adjective)	t	f	t	pre	n	no 3	n	all	\N
52	52	NC	\N	NoDom	\N	GenN	\N	DemN	\N	n	f	f	t	\N	post	\N	\N	\N	\N
53	53	unclear	\N	pre	pre	NGen	NGen	NDem	NDem	n	f	\N	t	both	n	\N	\N	unclear	\N
54	54	VO	VO	pre	pre	GenN	GenN	NDem	NDem	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
55	55	VO	VO	pre	pre	NGen	NGen	both	both	y	t	f	t	pre	n	all	y	all	\N
56	56	VO	VO	pre	pre	NGen	NGen	NDem	NDem	n	f	f	t	pre	n	all?	all?	all?	y
57	57	VO	\N	pre	\N	GenN	\N	NDem	\N	n	f	f	t	post	n	all	y	all	y
58	58	VO	\N	pre	\N	\N	\N	NDem	\N	y (suffix)	t	\N	\N	\N	n	\N	\N	\N	\N
59	59	VO	VO	pre	pre	NGen	NGen	NDem	NDem	y	t	\N	\N	\N	\N	\N	\N	\N	\N
60	60	VO	VO	pre	pre	NGen	NGen	NDem	NDem	n	f	f	t	pre	n	all	y	all	y
61	61	VO	\N	pre	\N	GenN	\N	NDem	\N	y	t	f	t	\N	post	all	y	non-sg	\N
62	62	VO	VO	pre	pre	NGen	NGen	mixed	mixed	y (specificity)	t	f	t	pre	n	all	y	all	y
63	63	VO	OV	pre	pre	NGen	NGen	NDem	NDem	y (specificity)	t	f	t	pre	n	all	y	all	y
64	64	VO	VO	pre	pre	NGen	\N	NDem	NDem	(y, specificity?)	t	f	t	pre	n	all?	y	unclear	\N
65	65	VO	VO	pre	pre	NoDom	NoDom	NDem	NDem	n	f	f	t	pre	n	all	y	non-sg?	unclear
66	66	VO	\N	pre	\N	NGen	\N	NDem	\N	n	f	f	t	pre	n	\N	\N	non-sg?	y
67	67	VO	VO	pre	pre	NGen	NGen	NDem	NDem	y	f	f	t	pre	n	all	y	all?	y
68	68	VO	VO	pre	pre	NGen	NGen	NDem	DemN	y (specific)	t	f	t	pre	n	all	y	unclear	y
69	69	VO	VO	pre	pre	NGen	NGen	NDem	NDem	y (specificity, knownness)	t	\N	\N	\N	n	\N	\N	\N	\N
70	70	VO	\N	\N	\N	\N	\N	NDem	\N	y (specificity, num)	t	\N	\N	\N	n	\N	\N	\N	\N
71	71	OV	OV	post	post	GenN	GenN	\N	\N	n	f	\N	f	\N	n	\N	\N	\N	\N
72	72	VO	VO	pre	pre	NGen	NGen	NDem	NDem	n	f	f	t	pre	n	only 3	only 3	unclear	n
73	73	OV	OV	post	post	GenN	GenN	DemN	\N	n	f	f	t	pre	n	\N	\N	\N	\N
74	74	VO	VO	pre	pre	NoDom	NoDom	NDem	NDem	y (=3rd)	f	f	t	pre	n	all	y	non-sg	y
75	75	VO	\N	pre	\N	GenN	\N	DemN	\N	y (but optional?)	t	f	t	pre	n	all	y	all	\N
76	76	VO	\N	pre	\N	GenN	\N	DemN	\N	n	f	f	t	pre	n	all	y	non-sg	\N
77	77	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	f	t	pre	n	all	y	non-sg?	\N
78	78	OV	OV	post	\N	GenN	GenN	DemN	DemN	n?	f	f	t	pre	n	all	y	non-sg?	\N
79	79	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	f	t	pre	n	all	y	non-sg	\N
80	80	OV	OV	post	post	GenN	GenN	mixed	mixed	n	f	t	t	post	n	all	y	all	\N
81	81	VO	VO	pre	pre	NGen	NGen	NDem	NDem	y	t	f	t	pre	n	no 3	n	non-sg	n
82	82	VO	VO	pre	pre	GenN	GenN	DemN	DemN	y (suffix)	t	t	t	pre	n	all	y	non-sg	\N
83	83	VO	VO	pre	pre	NGen	NGen	DemN	DemN	y	t	t	t	pre	n	all	y	non-sg	\N
84	84	VO	VO	pre	pre	NoDom	NoDom	DemN	DemN	y (N-suffix)	t	t	t	pre	n	all	y	non-sg	n
85	85	VO	VO	pre	pre	GenN	GenN	DemN	DemN	y (suffix(	t	t	t	pre	n	all	y	non-sg	\N
86	86	VO	\N	pre	\N	\N	\N	\N	\N	y	t	\N	\N	\N	n	\N	\N	\N	\N
87	87	OV	No dominant order	pre	pre	NGen	NGen	DemN	DemN	y	t	f	t	pre	n	no 3	n	non-sg	n
88	88	VO	VO	pre	pre	NoDom	NoDom	DemN	DemN	y	t	f	t	pre	n	no 3	n	non-sg	n
89	89	OV	No dominant order	pre	pre	NGen	NGen	DemN	DemN	y	t	f	t	pre	n	no 3	n	all	n
90	90	VO	\N	pre	\N	NGen	\N	DemN	\N	y	t	t	t	pre	n	all	y	all	\N
91	91	VO	VO	pre	pre	NGen	NGen	DemN	DemN	y	t	t	t	pre	n	all	y	all	n
92	92	OV	VO	post	post	GenN	GenN	DemN	DemN	n	f	t	t	pre	n	all	y	non-sg?	n
93	93	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	t	t	pre	n	all	y	non-sg?	\N
94	94	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	t	t	pre	n	all	y	non-sg?	\N
95	95	OV	OV	pre	pre	NGen	NGen	DemN	DemN	n	f	t	t	pre	n	all	y	non-sg	\N
96	96	VO	\N	pre	\N	NGen	\N	DemN	\N	y (suffix)	t	f	t	pre	n	\N	\N	\N	\N
97	97	VO	VO	pre	pre	NGen	NGen	mixed	mixed	y (suffix)	t	f	t	pre	n	all	y	non-sg	\N
98	98	VO	VO	pre	pre	NGen	NGen	DemN	DemN	y	t	f	t	pre	n	all?	all?	non-sg	\N
99	99	VO	\N	pre	\N	NGen	\N	DemN	\N	y	t	f	t	pre	n	no 3	n	non-sg	\N
100	100	VO	VO	pre	pre	NGen	NGen	DemN	DemN	y	t	f	t	pre	n	\N	\N	\N	\N
101	101	VO	VO	pre	pre	NGen	NGen	DemN	DemN	y	t	f	t	pre	n	no 3	n	non-sg	\N
102	102	VO	VO	pre	pre	NGen	NGen	DemN	DemN	y	t	f	t	pre	n	no 3	n	all	\N
103	103	VO	\N	pre	\N	NGen	\N	DemN	\N	y	t	f	t	pre	n	no 3	n	all	\N
104	104	VO	\N	pre	\N	NGen	\N	DemN	\N	y	t	f	t	pre	n	no 3	n	all	\N
105	105	VO	VO	pre	pre	NGen	NGen	DemN	DemN	n	f	f	t	pre	n	no 3	n	non-sg	\N
106	106	VO	VO	pre	pre	NoDom	NoDom	DemN	DemN	y (suffix)	t	f	t	pre	n	no 3	n	non-sg	\N
107	107	VO	VO	pre	pre	NoDom	NoDom	DemN	DemN	y (suffix, deictic distinctions)	t	\N	\N	\N	n	\N	\N	\N	\N
108	108	VO	\N	pre	\N	NoDom	\N	DemN	\N	y (suffix, deictic distinctions)	t	f	t	pre	n	\N	\N	\N	y
109	109	VO	VO	pre	pre	NoDom	NoDom	DemN	DemN	n	f	\N	t	pre	n	\N	\N	\N	\N
110	110	VO	VO	pre	pre	NoDom	NoDom	DemN	DemN	(n)	f	\N	t	pre	n	\N	\N	non-sg	\N
111	111	VO	VO	pre	pre	NGen	NGen	DemN	DemN	n	f	f	t	pre	n	no 3	n	non-sg	\N
112	112	OV	OV	post	post	GenN	GenN	NDem	NDem	y (suffix)	t	t	t	\N	post	no 3	n	all	n
113	113	OV	OV	post	post	GenN	GenN	DemN	DemN	y	t	f	t	\N	post	all	y	all	y
114	114	OV	OV	post	post	GenN	GenN	DemN	DemN	y	t	t	t	\N	post	all	y	all	y
115	115	VO	VO	\N	\N	NGen	NGen	\N	\N	n	f	f	t	\N	pre	no 3	n	non-sg?	\N
116	116	VO	VO	pre	pre	NGen	\N	DemN	DemN	n	f	\N	t	pre	n	\N	\N	all	\N
117	117	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	pre	n	\N	\N	all	\N
118	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	pre	n	\N	\N	all	\N
119	119	VO	\N	pre	pre	NGen	NGen	NDem	NDem	\N	\N	\N	t	pre	n	\N	\N	all	\N
120	120	VO	VO	pre	pre	NGen	NGen	NDem	NDem	n (but def marking by initial vowel on modifiers)	f	f	t	pre	n	unclear	unclear	all	\N
121	121	VO	\N	pre	\N	NGen	\N	NDem	\N	n	f	f	t	pre	n	\N	\N	\N	\N
122	122	VO	VO	pre	pre	NGen	NGen	NDem	NDem	n	f	f	t	pre	n	\N	\N	all	\N
123	123	VO	VO	pre	pre	NGen	\N	NDem	NDem	n	f	f	t	pre	n	all	y	all	\N
124	124	VO	VO	NoDom	NoDom	GenN	GenN	NDem	NDem	y (general article in beginning of NP, 2 (short =def, long more like dem) def marker at end requires presence of initial article)	t	f	t	pre	n	all	y	all	y
125	125	OV	OV	post	post	GenN	GenN	DemN	DemN	y (def gender suffixes)	t	t	t	pre	n	all	y	no-sg?	n
126	126	OV	OV	post	post	GenN	GenN	DemN	DemN	n	f	t	t	pre	n	all?	y	unclear	n
127	127	OV	OV	post	post	GenN	GenN	DemN	DemN	y	t	f	t	pre	n	all	y	all	\N
128	128	VO	\N	pre	\N	NGen	\N	DemN	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
129	129	OV	\N	post	\N	GenN	\N	DemN	\N	n	f	f	t	post	n	all	y	unclear (+pl)	\N
130	130	VO	VO	NoDom	NoDom	GenN	GenN	DemN	DemN	n	f	f	t	pre	n	all	y	non-sg	y
131	131	VO	\N	pre	\N	GenN	\N	NDem	\N	n	f	f	t	pre	n	\N	?	\N	\N
132	132	VO	VO	post	post	GenN	GenN	DemN	DemN	y	t	f	t	pre	n	no 3	n	non-sg	\N
133	133	VO	VO	post	post	GenN	GenN	DemN	DemN	n (but sm case marking effects)	f	f	t	pre	n	all	y	non-sg	\N
134	134	NC	\N	NoAdpos	\N	unclear	\N	mixed	\N	n	f	\N	t	\N	pre	all	y	all	\N
\.


--
-- Data for Name: datasources; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.datasources (language_id, ref_short, ref_pages) FROM stdin;
1	Hinds 1988	254, 261
1	Noguchi 1997	780
1	Furuya 2008	sec. 3.2
1	Inokuma 2009	\N
1	(Coulmas 1982)	\N
2	Sohn 1994	284, 292
2	Choi 2014	151-154
3	Nedjalkov 1997	197, 199
4	Kornfilt 1997	288, 297f.
5	Merlan 1989 [1982]	103, 203
6	Austin 1981	97f.
7	Reece 1970	70
7	Hale 1973	316f.
7	(Simpson 1991)	\N
8	Dixon 1977	\N
9	Meakins & Nordlinger 2014	\N
10	Bowe 1990	49-51
11	Haviland 1979	104, 156f.
12	Patz 2002	120f, 202f.
13	Evans 1995	239, 241
13	Round 2013	141
14	Visser 2022	136f., 194f., 317f.
15	Wells 1979	46
16	Whitehead 2006	40, 46, 56f.
16	Whitehead 2013	9f., 18f.
17	Honeyman2017	169f.
18	Seiler 1985	44, 61f.
19	Obata 2003	47-49, 76, 79, 84f., 87-89, 92f.
20	Terrill 2003	171-173
21	Gravelle 2010	344
22	Reesink 2002	269f., 274
23	Reesink 1999	195
24	Dol 2007	141, 158, 172,  (281)
25	Hemmilä & Luoma 1987	123, 125
26	Foley 1991	\N
27	Wegener 2012	147, 155-159
28	Aikhenvald 2008	197f., 508-513
29	Feldman 1986	120-124
30	Bruce 1984	90-92, 96f.
31	Scott 1978	79f., 100f.
32	Haiman 1980	226-232, 239f.
33	Renck 1975	17f., 166, 181
34	Roberts 1987	162, 201, 209f.
35	Davies 1989	107f., 157
36	Reesink 1987	53f., 190f., 353
37	Robinson & Haan 2014	261
38	Klamer 2014	129
39	Schapper 2014	313f.
40	Kratchovíl 2014	391
41	Schapper & Hendery 2014	472
42	Holton 2014	53f.
43	Klamer 2010	\N
44	Doehler2016	552
45	Newman 2000	63, 155, 370f.
45	Jaggar 2001	330f.
46	Frajzyngier 1993	172
47	Harvey 2018	163
48	Treis 2008	335
49	Gary & Gamal-Eldin 1982	78, 80
50	Holes 1990	162, 165
51	Borg & Azzopardi-Alexander 1997	187f., 202
52	Pacifique et al. 1990	188
53	Costello 1969	28
54	Sohn 1973	245f.
55	Garvey 1964	\N
55	Paul 2009	\N
55	Paul & Travis 2019	\N
56	Sneddon 1996	170
56	(Ewing 2005)	\N
57	Kluge 2017	ch. 6.2
58	Davies 2010	\N
59	Palmer 2017, Schütz 2014	\N
60	Hamel 1994	sec. 4.2.1 (p. 90)
61	Gasser 2014	144
61	(Cowan 1955)	\N
62	Bauer 1993	368, 373
62	Bauer 1997	262f.
62	(Harlow 2007)	\N
63	Besnier 2000	392f.
64	Keesing 1985	104
65	D’Jernes 2002	255
66	Boswell 2018	165
67	Davis 2003	47, Palmer 2017
68	Palmer 2008	68, 95, (115), 116, 119, 123, 131, 137, 163, 242, 300, 305, 327, 399, 414
69	Du Feu 1996	\N
70	Næss & Hovdhaugen 2011	\N
71	Derbyshire 1979	131
72	Everett & Kern 1997	303, 310
73	Swadesh 1967	333
74	Huttar & Huttar 1994	224, 460, 466f.
75	Faraclas 1996	178, 181
76	Baxter 1988	86
77	Sridhar 1990	208f.
78	Asher & Kumari 1997	262f.
79	Asher 1985	142, 146
80	Fortescue 1984	110, 253, 256f.
81	\N	\N
82	(Johannessen 2008)	\N
83	(Johannessen 2008)	\N
84	(Johannessen 2008)	\N
85	(Johannessen 2008)	\N
86	\N	\N
87	\N	\N
88	Postal 1969	\N
88	Delorme & Dougherty 1972	\N
88	Sommerstein 1972	\N
88	Pesetsky 1978	\N
88	Keizer 2016 	\N
89	Lawrenz 1993	ch. 6
89	Rauh 2003, 2004	\N
89	Roehrs 2005	\N
90	Höhn, Silvestri & Squillaci 2017	274
91	Choi 2014	chs. 1+2
91	Höhn 2016	sec. 5
92	Wali & Koul 1997	200
93	Pandharipande 1997	386
94	Bhatia 1993	228
95	Mahootian 1997	209, 212
96	Höhn 2016	546, 560
97	Mallinson 1986	255, 258
97	Cornilescu & Nicolae 2014	20f.
98	Hualde 1992	287, 290
98	Höhn 2016	560
99	Alvarez et al. 1986	152, 301
99	Höhn 2016	560
100	Höhn 2016	555, 560
101	De Bruyne 1995	145
101	Choi 2014	210f.
101	Höhn 2016	560
102	Cardinaletti 1994	202f.
102	Höhn 2016	559
103	Höhn, Silvestri & Squillaci 2016	142
104	Höhn, Silvestri & Squillaci 2016	142
105	Pesetsky 1978	352
106	Höhn 2016	560
107	Friedman 2002, Tomić 2012	\N
108	Papadimitriou 2008	144
109	\N	\N
110	\N	\N
111	Rutkowski 2002	161
112	Saltarelli 1988	210
112	Trask 2003	122
112	De Rijk 2008	482, 501f.
112	Areta 2009	67
112	Artiagoitia 2012	\N
113	Böhm 1985	133-145
113	Haacke 1976,1977, 2013	\N
113	Maho 1998	140
114	Kilian-Hatz2008	ch. 3.1.2
115	Heath 1980	95
116	van der Wal 2022	68f.
117	\N	\N
118	van der Wal 2022	68
119	\N	\N
120	Taylor 1985	131
120	(Tayebwa 2014)	\N
121	Crane et al. 2011	210, 279
122	Mpiranya 2014	\N
123	Schaub 1985	197f.
124	Rennison 1997	242, 250f.
125	Carlson 1994	207f.
126	Haspelmath 1993	259
127	Hewitt 1989	157, 159
128	Galloway 1977	434f., Suttles 2004
129	Honkasalo 2019	438, 400, 480, 507, 646, 388
130	Boskovic & Hsieh 2013	sec. 7.3
131	Fan 2019	137
132	Kenesei,Vago & Fenyvesi 1998	269
132	Höhn 2016	559
133	Sulkala & Karjalainen 1992	277
134	Andrews 1975	192-194
134	Andrews 2003	ch. 17.3
\.


--
-- Data for Name: languages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.languages (language_id, lang_name, glottocode, walscode, iso639_3, lat, lon, coord_notes, area_wals, area_glottolog, sort_affiliation, genus_wals, family_genus) FROM stdin;
1	Japanese	nucl1643	jpn	jpn	35	135	\N	Eurasia	Eurasia	(Altaic?) Isolate	Japanese	Japonic
2	Korean	kore1280	kor	kor	37.5	128	\N	Eurasia	Eurasia	(Altaic?) Isolate	Korean	Koreanic
3	Evenki	even1259	eve	evn	61.972	94.689	\N	Eurasia	Eurasia	(Altaic?) Tungusic	Tungusic	Tungusic
4	Turkish	nucl1301	tur	tur	39.8667	32.8667	\N	Eurasia	Eurasia	(Altaic?) Turkic	Turkic	Turkic
5	Mangarrayi	mang1381	myi	mpc	-14.8	133.5	glottolog 4.1 longitude shifted, use glottolog 4.0 coords	Australia	Australia	(Australian) Mangarrayi-Maran, Mangarrayi	Mangarrayi	Mangarrayi-Maran, Mangarrayi
6	Diyari	dier1241	diy	dif	-28.1667	138	\N	Australia	Australia	(Australian) Pama-Nyungan, Karna	Central Pama-Nyungan	Pama-Nyungan, Karna
7	Warlpiri	warl1254	wrl	wbp	-20.1008	131.05	\N	Australia	Australia	(Australian) Pama-Nyungan, Ngarrkic	Western Pama-Nyungan	Pama-Nyungan, Desert Nyungic
8	Yidiny	yidi1250	yid	yii	-17.1332	145.876	\N	Australia	\N	(Australian) Pama-Nyungan, Ngumbin	Northern Pama-Nyungan	Pama-Nyungan, Desert Nyungic
9	Bilinarra	bili1250	bnr	nbj	-16.868771	130.533991	\N	Australia	Australia	(Australian) Pama-Nyungan, Ngumpin-Yapa	Western Pama-Nyungan	Pama-Nyungan, Desert Nyungic
10	Pitjantjatjara	pitj1243	pit	pjt	-26.9704	131.357	\N	Australia	Australia	(Australian) Pama-Nyungan, Wati, Western Desert	Western Pama-Nyungan	Pama-Nyungan, Desert Nyungic
11	Guugu Yimidhirr	gugu1255	guu	kky	-14.9424	144.831	\N	Australia	Australia	(Australian) Pama-Nyungan, Yimidhirr-Yalanji-Yidinic, Guugu-Yimidhirr	Northern Pama-Nyungan	Pama-Nyungan, Yimidhirr-Yalanji-Yidinic
12	Kuku-Yalanji	kuku1273	kya	gvn	-16.0036	145.188	\N	Australia	Australia	(Australian) Pama-Nyungan, Yimidhirr-Yalanji-Yidinic, Yalandyic	Northern Pama-Nyungan	Pama-Nyungan, Yimidhirr-Yalanji-Yidinic
13	Kayardild	kaya1319	kay	gyd	-17.0695	139.489	\N	Australia	Australia	(Australian) Macro-Pama-Nyungan, Tangkic	Tangkic	Tangkic
14	Kalamang	kara1499	\N	kgv	\N	\N	\N	\N	\N	(Papuan) 	\N	\N
15	Siroi	siri1273	ssd	ssd	\N	\N	\N	\N	\N	(Papuan) 	\N	\N
16	Menya	meny1245	mey	mcr	-7.17425	146.071	\N	Papunesia	Papunesia	(Papuan) Angan, Nucelar Angan, Kapau-Menya	Nuclear Angan	Angan
17	Momu	fass1245	fqs	fqs	-3.10868	141.64	\N	Papunesia	Papunesia	(Papuan) Baibai-Fas, Momu-Fas	Baibai-Fas	Baibai-Fas, Momu-Fas
18	Imonda	imon1245	imo	imn	-3.31228	141.171	\N	Papunesia	Papunesia	(Papuan) Border, Waris	Border	Border, Waris
19	Bilua	bilu1245	bil	blb	-7.92388	156.663	\N	Papunesia	Papunesia	(Papuan) Central Solomons	Bilua	Bliua
20	Lavukaleve	lavu1241	lav	lvk	-9.05569	159.119	\N	Papunesia	Papunesia	(Papuan) Central Solomons	Lavukaleve	Lavukaleve
21	Moskona	mosk1236	\N	mtj	-1.62201	133.145	\N	Papunesia	Papunesia	(Papuan) East Bird’s Head, Meax	East Bird's Head	East Bird’s Head, Meax
22	Sougb	mani1235	sgb	mnx	-1.49611	133.95	\N	Papunesia	Papunesia	(Papuan) East Bird’s Head, Sougb	East Bird's Head	Sougb
23	Hatam	hata1243	hat	had	-1.13531	134.037	\N	Papunesia	Papunesia	(Papuan) Hatam-Mansin, Hatam	Hatim-Mansim	Hatam-Mansin, Hatam
24	Maybrat	maib1239	may	ayz	-1.3679	132.591	\N	Papunesia	Papunesia	(Papuan) Maybrat-Karon	Maybrat	Maybrat-Karon
25	Urim	urim1252	uri	uri	-3.58018	142.653	\N	Papunesia	Papunesia	(Papuan) Nuclear Torricelli, Urim	Urim	Torricelli
26	Yimas	yima1243	yim	yee	-4.71731	143.572	\N	Papunesia	\N	(Papuan) Ramu-Lower Sepik, Karawari	Lower Sepik	Ramu-Lower Sepik
27	Savosavo	savo1255	svs	svs	-9.12853	159.814	\N	Papunesia	Papunesia	(Papuan) Savosavo	Savosavo	Savosavo
28	Manambu	mana1298	mbu	mle	-4.19082	142.862	\N	Papunesia	Papunesia	(Papuan) Sepik, Ndu	Ndu	Sepik, Ndu
29	Awtuw	awtu1239	awt	kmn	-3.53129	141.928	\N	Papunesia	Papunesia	(Papuan) Sepik, Ram	Ram	Sepik, Ram
30	Alamblak	alam1246	ala	amp	-4.66307	143.316	\N	Papunesia	Papunesia	(Papuan) Sepik, Sepik Hill	Sepik Hill	Sepik, Sepik Hill
31	Fore	fore1270	for	for	-6.64473	145.5065	\N	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Kainantu-Goroka, Gorokan, Fore 	Fore-Gimi	TNG, Kainantu-Goroka
32	Hua	huaa1250	hua	\N	-6.353409	145.339379	\N	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Kainantu-Goroka, Gorokan	Siane-Yagaria	TNG, Kainantu-Goroka
33	Yagaria	yaga1260	ygr	ygr	-6.32432	145.388	\N	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Kainantu-Goroka, Gorokan, Kamano-Yagaria	Siane-Yagaria	TNG, Kainantu-Goroka
34	Amele	amel1241	ame	aey	-5.29126	145.687	\N	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Madang, Gum	Mabuso	TNG, Madang
35	Kobon	kobo1249	kob	kpw	-5.16446	144.46	\N	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Madang, Kalam	Kalam-Kobon	TNG, Madang
36	Usan	usan1239	usa	wnu	-4.84265	145.362	\N	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Madang, Croisilles, Pihom, Numugenan	North Adelbert	TNG, Madang
37	Adang	adan1251	adg	adn	-8.18958	124.448	\N	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Timor-Alor-Pantar, Alor-Pantar, Alor	Alor-Pantar	TNG, TAP
38	Kaera	kaer1234	\N	jka	-8.3287	124.0177	added since 4.1	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Timor-Alor-Pantar, Alor-Pantar, Pantar	Alor-Pantar	TNG, TAP
39	Kamang	kama1365	woi	woi	-8.26897	124.792	\N	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Timor-Alor-Pantar, Alor-Pantar, Alor	Alor-Pantar	TNG, TAP
40	Sawila	sawi1256	\N	swt	-8.29105	125.078	\N	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Timor-Alor-Pantar, Alor-Pantar, Alor, East, Tanglapui	Alor-Pantar	TNG, TAP
41	Wersing	wers1238	kln	kvw	-8.33936	124.932	\N	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Timor-Alor-Pantar, Alor-Pantar, Alor	Alor-Pantar	TNG, TAP
42	Western Pantar	lamm1241	\N	lev	-8.52787	124.057	Lamma	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Timor-Alor-Pantar, Alor-Pantar, Pantar	Alor-Pantar	TNG, TAP
43	Teiwa	teiw1235	\N	twe	-8.37662	124.174	\N	Papunesia	Papunesia	(Papuan) Trans-New Guinea, Timor-Alor-Pantar, Alor-Pantar, Pantar	Alor-Pantar	TNG, TAP
44	Komnzo	wara1294	\N	tci	-8.64917	141.52	\N	Papunesia	Papunesia	(Papuan) Yam, Morehead-Maro, Tonda, Eastern Tonda	Morehead-Maro	Yam, Morehead-Maro
45	Hausa	haus1257	hau	hau	11.1513	8.7804	\N	Africa	Africa	Afroasiatic, Chadic	West Chadic	Afroasiatic, Chadic
46	Mupun	mwag1236	mup	sur	9.47205	8.96522	Mvaghavul	Africa	Africa	Afroasiatic, Chadic	West Chadic	Afroasiatic, Chadic
47	Gorwaa	goro1270	gor	gow	-4.23575	35.7996	\N	Africa	Africa	Afroasiatic, Cushitic, South Cushitic	Southern Cushitic	Afroasiatic, Cushitic
48	Kambaata	kamb1316	\N	ktb	7.37582	37.9088	\N	Africa	Africa	Afroasiatic, Cushitic	East Cushitic	Afroasiatic, Cushitic
49	Cairene Egyptian Colloquial Arabic	egyp1253	aeg	arz	31	31	\N	Africa	Africa	Afroasiatic, Semitic	Semitic	Afroasiatic, Semitic
50	Gulf Arabic	gulf1241	arg	afb	30.17	47.5	\N	Eurasia	Eurasia	Afroasiatic, Semitic	Semitic	Afroasiatic, Semitic
51	Maltese	malt1254	mlt	mlt	35.8884	14.4508	\N	Eurasia	Eurasia	Afroasiatic, Semitic	Semitic	Afroasiatic, Semitic
52	Mi’kmaq	mikm1235	mic	mic	45.9941	-65.5766	\N	North America	North America	Algic, Algonquian, Eastern Algonquian, Mi’kmaq	Algonquian	Algic, Algonquian
53	Katu	nucl1297	ktu	ktv, kuf	15.8553	107.644	coord for east1236	Eurasia	Eurasia	Austroasiatic, Katuic, Katu	Katuic	Austroasiatic, Katuic
54	Ulithian	ulit1238	uli	uli	\N	\N	\N	Papunesia	\N	Austronesian	\N	\N
55	Malagasy	mala1537	mal	mlg	-19.59	47.12	coord for Plateau Malagasy	Africa	Africa	Austronesian, Malayo-Polynesian, Basap-Greater Barito, Greater Barito linkage, Southeast Barito	Barito	Austronesian, Basap-Greater Barito
56	Indonesian	stin1234	ind	ind	\N	\N	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Chamic, Malayic, Malay	Malayo-Sumbawan	Austronesian, Malayic
57	Papuan Malay	papu1250	iir	pmy	-2.53482	139.651	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Malayic	Malayo-Sumbawan	Austronesian, Malayic
58	Madurese	nucl1460	mdr	mad	-7	113	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Malayo-Sumbawan, Madurese	Malayo-Sumbawan	Austronesian, Malayo-Sumbawan
59	Standard Fijian	fiji1243	fij	fij	-18	178.33	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Central-Eastern Malayo-Polynesian, Eastern Malayo-Polynesian, Oceanic, Oceanic, Central Pacific linkage, Tokelau-Fijian	Oceanic	\N
60	Loniu	loni1238	lon	los	-2.06124	147.35	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Central-Eastern Malayo-Polynesian, Eastern Malayo-Polynesian, Oceanic, Admiralty Islands, Eastern Admiralty Islands	Oceanic	Austronesian, Admiralty Islands
61	Windesi Wamesa (Wandamen)	wame1241	\N	wad	-2.25622	133.996	coordinates for wand1267	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Central-Eastern Malayo-Polynesian, Eastern Malayo-Polynesian, Oceanic, Greater South Halmahera-West New Guinea	Oceanic	Austronesian, Oceanic, Greater South Halmahera-West New Guinea
62	Maori	maor1246	mao	mri	-38.2881	176.541	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Oceanic, Polynesian, East, Tahitic	Oceanic	Austronesian, Polynesian
63	Tuvaluan	tuva1244	tvl	tvl	-8.520813	179.198088	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Oceanic, Polynesian, Samoic Outlier, Ellicean	Oceanic	Austronesian, Polynesian
64	Kwaio	kwai1243	kwa	kwd	-8.93744	160.965	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Oceanic, Central-Eastern Oceanic, Southeast Solomonic	Oceanic	Austronesian, Southeast Solomonic
65	Arop-Lokep	arop1243	alk	apr	-5.31671	147.103	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Central-Eastern Malayo-Polynesian, Eastern Malayo-Polynesian, Oceanic, Western Oceanic linkage, North New guinea linkage, Ngero-Vitiaz linkage, Vitiaz linkage, Korap linkage	Oceanic	Austronesian, Western Oceanic linkage
66	Cheke Holo	chek1238	ckh	mrn	-8.27055	159.625	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Central-Eastern Malayo-Polynesian, Eastern Malayo-Polynesian, Oceanic, Western Oceanic linkage, Northwest Solomonic	Oceanic	Austronesian, Western Oceanic linkage
67	Hoava	hoav1238	hoa	hoa	-8.19679	157.595	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Central-Eastern Malayo-Polynesian, Eastern Malayo-Polynesian, Oceanic, Oceanic, Western Oceanic linkage, Meso Melanseian linkage	Oceanic	Austronesian, Western Oceanic linkage
68	Kokota	koko1269	kkt	kkk	-8.16481	159.191	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Central-Eastern Malyao-Polynesian, Eastern Malayo-Polynesian, Oceanic, Western Oceanic linkage, Meso Melanesian linkage	Oceanic	Austronesian, Western Oceanic linkage
69	Rapanui	rapa1244	rap	rap	-27.113	-109.342	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Oceanic, Polynesian, East	Oceanic	Austronesian, Polynesian
70	Vaeakau-Taumako	pile1238	pil	piv	-10.173335	166.247188	\N	Papunesia	Papunesia	Austronesian, Malayo-Polynesian, Oceanic, Polynesian, Samoic Outlier, Futunic	Oceanic	Austronesian, Polynesian
71	Hixkaryana	hixk1239	hix	hix	-0.16265	-58.80153	\N	South America	South America	Carib	Cariban	Carib
72	Wari'	wari1268	war	pav	-10.69948	-64.56152	\N	South America	South America	Chapakuran	Chapacura-Wanham	Chapakuran
73	Chitimacha	chit1248	ctm	ctm	30.3386	-90.9123	\N	North America	North America	Chitimacha	Chitimacha	Chitimacha
74	Ndyuka	ndyu1242	ndy	djk	4.3126	-54.6419	\N	South America	South America	Creole, English-based	Creoles and Pidgins	Creole, English-based
75	Nigerian Pidgin	nige1257	npi	pcm	9.65873	4.21068	\N	Africa	Africa	Creole, English-based	Creoles and Pidgins	Creole, English-based
76	Kristang	mala1533	mlc	mcm	2.188087	102.262059	\N	Eurasia	Papunesia	Creole, Portuguese	Creoles and Pidgins	Creole, Portuguese-based
77	Kannada	nucl1305	knd	kan	13.5878	76.1198	\N	Eurasia	Eurasia	Dravidian, Southern	Dravidian	Dravidian
78	Malayalam	mala1464	mym	mal	9.59208	76.7651	\N	Eurasia	Eurasia	Dravidian, Southern	Dravidian	Dravidian
79	Tamil	tami1289	tml	tam	10.520219	78.825989	\N	Eurasia	Eurasia	Dravidian	Dravidian	Dravidian
80	West Greenlandic (Kalaallisut)	kala1399	grw	kal	69.3761	-52.864	\N	Eurasia	North America	Eskimo-Aleut, Eskimo, Inuit-Inupiaq	Eskimo	Eskimo-Aleut
81	Welsh	wels1247	wel	cym	52	-4	\N	Eurasia	Eurasia	IE, Celtic, Brittonic	Celtic	IE, Celtic
82	Danish	dani1285	dsh	dan	54.8655	9.36284	\N	Eurasia	Eurasia	IE, Germanic, North	Germanic	IE, Germanic
83	Icelandic	icel1247	ice	isl	63.4837	-19.0212	\N	Eurasia	Eurasia	IE, Germanic, North	Germanic	IE, Germanic
84	Norwegian	norw1258	nor	nor (nob/nno)	61	8	from WALS	Eurasia	Eurasia	IE, Germanic, North	Germanic	IE, Germanic
85	Swedish	swed1254	swe	swe	59.800634	17.389526	\N	Eurasia	Eurasia	IE, Germanic, North	Germanic	IE, Germanic
86	Afrikaans	afri1274	afr	afr	-22	30	\N	Africa	Africa	IE, Germanic, West	Germanic	IE, Germanic
87	Dutch	dutc1256	dut	nld	52	5	\N	Eurasia	Eurasia	IE, Germanic, West	Germanic	IE, Germanic
88	English	stan1293	eng	eng	53	-1	\N	Eurasia	Eurasia	IE, Germanic, West	Germanic	IE, Germanic
89	German	stan1295	ger	deu	52	10	use WALS coord	Eurasia	Eurasia	IE, Germanic, West	Germanic	IE, Germanic
90	Calabrian Greek	aspr1238	\N	\N	38.0166	15.88621	\N	Eurasia	Eurasia	IE, Hellenic	Greek	IE, Hellenic
91	Greek	mode1248	grk	ell	38.36	23.13	(prev. use WALS coord, glottolog since 4.1)	Eurasia	Eurasia	IE, Hellenic	Greek	IE, Hellenic
92	Kashmiri	kash1277	kas	kas	34.166825	74.330455	\N	Eurasia	Eurasia	IE, Indo-Aryan	Indic	IE, Indo-Aryan
93	Marathi	mara1378	mhi	mar	17.9344	76.6665	\N	Eurasia	Eurasia	IE, Indo-Aryan	Indic	IE, Indo-Aryan
94	Punjabi	panj1256	pan	pan/pnb	30.0368	75.6702	\N	Eurasia	Eurasia	IE, Indo-Aryan	Indic	IE, Indo-Aryan
95	Persian	west2369	prs	pes	32.9	53.3	\N	Eurasia	Eurasia	IE, Indo-Iranian	Iranian	IE, Indo-Iranian
96	Aromanian	arom1237	\N	rup	40.616	21.2	\N	Eurasia	Eurasia	IE, Romance, East	Romance	IE, Romance
97	Romanian	roma1327	rom	ron	46.3913	24.2256	\N	Eurasia	Eurasia	IE, Romance, East	Romance	IE, Romance
98	Catalan	stan1289	ctl	cat	41.453	1.569	\N	Eurasia	Eurasia	IE, Romance, Iberian	Romance	IE, Romance
99	Galician	gali1258	glc	glg	42.2446	-7.5343	\N	Eurasia	Eurasia	IE, Romance, Iberian	Romance	IE, Romance
100	Portuguese	port1283	por	por	39.91	-8.1	\N	Eurasia	Eurasia	IE, Romance, Iberian	Romance	IE, Romance
101	Spanish	stan1288	spa	spa	40.4414	-1.11788	\N	Eurasia	Eurasia	IE, Romance, Iberian	Romance	IE, Romance
102	Italian	ital1282	ita	ita	43.0464	12.6489	\N	Eurasia	Eurasia	IE, Romance, Italo	Romance	IE, Romance
103	Northern Calabrian	nort2612	\N	nap?	39.45	15.55	coord Verbicaro	Eurasia	Eurasia	IE, Romance, Italo, south	Romance	IE, Romance
104	Southern Calabrian	sout2616	\N	scn?	37.56	15.55	coord Bova Marina	Eurasia	Eurasia	IE, Romance, Italo, extreme south	Romance	IE, Romance
105	Russian	russ1263	rus	rus	59	50	\N	Eurasia	Eurasia	IE, Slavic, East	Slavic	IE, Slavic
106	Bulgarian	bulg1262	bul	bul	43.3646	25.047	\N	Eurasia	Eurasia	IE, Slavic, South	Slavic	IE, Slavic
107	Macedonian	mace1250	mcd	mkd	41.5957	21.7932	\N	Eurasia	Eurasia	IE, Slavic, South	Slavic	IE, Slavic
108	Pomak	poma1238	\N	\N	41.8	25.43	coord based on Xanthi	Eurasia	Eurasia	IE, Slavic, South	Slavic	IE, Slavic
109	Serbocroatian	sout1528	scr	hbs	42	19	Serbian now separate from Croatian in glottolog, using Serbian-Croatian coordinates from WALS	Eurasia	Eurasia	IE, Slavic, South	Slavic	IE, Slavic
110	Slovenian	slov1268	slo	slv	46.2543	14.7766	\N	Eurasia	Eurasia	IE, Slavic, South	Slavic	IE, Slavic
111	Polish	poli1260	pol	pol	51.8439	18.6255	\N	Eurasia	Eurasia	IE, Slavic, West	Slavic	IE, Slavic
112	Basque	basq1248	bsq	eus	43.2787	-1.31622	\N	Eurasia	Eurasia	isolate	Basque	isolate-Bas
113	Khoekhoe (Nama)	nama1264	kho	naq	-25.0747	17.9767	\N	Africa	Africa	Khoe-Kwadi, Khoekhoe	Khoe-Kwadi	Khoe-Kwadi, Khoekhoe
114	Khwe/Kxoe	kxoe1243	kxo	xuu	-16.59051	22.599835	\N	Africa	Africa	Khoe-Kwadi, West-Kxoe	Khoe-Kwadi	Khoe-Khwadi, West-Kxoe
115	Warndarang	wand1263	wrn	wnd	-14.2996	135.705	\N	Australia	Australia	(Australian) Mangarrayi-Maran, Maran	Mara	Mangarrayi-Maran, Maran
116	Kinyarwanda	kiny1244	kin	kin	-1.56771	29.6441	\N	Africa	Africa	Niger-Congo, Atlantic-Congo, Volta-Congo, Benue-Congo, Bantoid, Southern, Narrow Bantu, Central, J, Ruanda-Rundi (D.61) 	Bantu	Niger-Congo, Bantu
117	Kirundi	rund1242	rnd	run	-2.94	29.97	\N	Africa	Africa	Niger-Congo, Atlantic-Congo, Volta-Congo, Benue-Congo, Bantoid, Southern, Narrow Bantu, Central, J, Ruanda-Rundi (D.62) 	Bantu	Niger-Congo, Bantu
118	Lubukusu	buku1249	buk	bxk	0.68043	34.7719	\N	Africa	Africa	Niger-Congo, Atlantic-Congo, Volta-Congo, Benue-Congo, Bantoid, Southern, Narrow Bantu, Central, J, Masaba-Luhya (E.31) 	Bantu	Niger-Congo, Bantu
119	Luganda	gand1255	lda	lug	0.66884	32.15153	\N	Africa	Africa	Niger-Congo, Atlantic-Congo, Volta-Congo, Benue-Congo, Bantoid, Southern, Narrow Bantu, Central, J, Nyoro-Ganda (E.15) 	Bantu	Niger-Congo, Bantu
120	Nkore-Kiga	nkor1241	nko	nyn/cgg	-1.04	29.91	location for Chiga	Africa	Africa	Niger-Congo, Atlantic-Congo, Volta-Congo, Benue-Congo, Bantoid, Southern, Narrow Bantu, Central, J	Bantu	Niger-Congo, Bantu
121	Nzadi	nzad1234	\N	nzd	-4.102208	20.194462	\N	Africa	Africa	Atlantic-Congo, Volta-Congo, Benue-Congo, Bantoid, Southern, Narrow, Central-Western, Yanzi (B.80)	Bantu	Niger-Congo, Bantu
122	Swahili	swah1253	swa	swh	-8.25605	37.624	\N	Africa	Africa	Niger-Congo, Atlantic-Congo, Volta-Congo, Benue-Congo, Bantoid, Southern, Narrow Bantu	Bantu	Niger-Congo, Bantu
123	Babungo	veng1238	bab	bav	6.11403	10.4137	Vengo	Africa	Africa	Niger-Congo, Atlantic-Congo, Volta-Congo, Benue-Congo, Bantoid, Southern, Wide Grassfields, Narrow Grassfields, Ring, South	Wide Grassfields	Niger-Congo, Grassfields Bantu
124	Koromfe	koro1298	kfe	kfz	14.046	-1.96187	\N	Africa	Africa	Niger-Congo, Gur	Koromfe	Niger-Congo, Gur
125	Supyire	supy1237	sup	spp	11.632	-5.87709	\N	Africa	Africa	Niger-Congo, Senufo	Senufo	Niger-Congo, Senufo
126	Lezgian	lezg1247	lez	lez	41.5157	47.8951	\N	Eurasia	Eurasia	North East Caucasian	Lezgic	North East Caucasian
127	Abkhaz	abkh1244	abk	abk	43.056218	41.159115	\N	Eurasia	Eurasia	North West Caucasian	Northwest Caucasian	North West Caucasian
128	Chilliwack Halkomelem	chil1281	\N	hur	49.1169072	-122.7078057	coord for halk1245	North America	North America	Salishan, Central Salish, Halkomelem	Central Salish	Salishan, Central Salish
129	East Geshiza	gesh1238	\N	(ero)	31.1026	101.72	coord for horp1239	Eurasia	Eurasia	Sino-Tibetan, Burmo-Qiangic, Na-Qiangic, Qiangic, Gyalrongic, Horpa-Khroskyabs, Horpa	Burmo-Qiangic	Sino-Tibetan, Burmo-Qiangic
130	Mandarin	mand1415	mnd	cmn	40.0209	116.228	\N	Eurasia	Eurasia	Sino-Tibetan, Sinitic	Chinese	Sino-Tibetan, Sinitic
131	Lakkia	lakk1238	lkk	lbc	24.1169	110.106	\N	Eurasia	Eurasia	Tai-Kadai, Kam-Tai, Lakkia-Biao	Kadai	Tai-Kadai, Kam-Tai
132	Hungarian	hung1274	hun	hun	46.9068585714	19.6555271429	\N	Eurasia	Eurasia	Uralic, Ugric	Ugric	Uralic, Ugric
133	Finnish	finn1318	fin	fin	64.7628	25.5577	\N	Eurasia	Eurasia	Uralic, Finnic	Finnic	Uralic, Finnic
134	Classical Nahuatl	clas1250	\N	nci	19.72	-96.97	\N	North America	North America	Uto-Aztecan, Aztecan, Nahuatl, Central Nahuatl, Nuclear Nahuatl	Aztecan	Uto-Aztecan, Aztecan
\.


--
-- Name: core_properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.core_properties_id_seq', 134, true);


--
-- Name: languages_language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.languages_language_id_seq', 269, true);


--
-- Name: languages languages_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pk PRIMARY KEY (language_id);


--
-- Name: languages languages_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_unique UNIQUE (glottocode);


--
-- Name: core_properties syntactic_properties_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_properties
    ADD CONSTRAINT syntactic_properties_pk PRIMARY KEY (id);


--
-- Name: article_properties article_properties_languages_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.article_properties
    ADD CONSTRAINT article_properties_languages_fk FOREIGN KEY (language_id) REFERENCES public.languages(language_id) ON DELETE CASCADE;


--
-- Name: datasources datasources_languages_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.datasources
    ADD CONSTRAINT datasources_languages_fk FOREIGN KEY (language_id) REFERENCES public.languages(language_id) ON DELETE CASCADE;


--
-- Name: core_properties syntactic_properties_languages_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.core_properties
    ADD CONSTRAINT syntactic_properties_languages_fk FOREIGN KEY (language_id) REFERENCES public.languages(language_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

