--- Create database scheme in postgreSQL

CREATE DATABASE persn;

--- Create tables

--- Table of languages in the DB
CREATE TABLE public.languages (
	language_id serial2 NOT NULL,
	lang_name varchar NOT NULL,
	glottocode varchar NULL,
	walscode varchar NULL,
	iso639_3 varchar NULL,
	lat double precision NULL,
	lon double precision NULL,
	coord_notes text NULL,
	area_wals varchar NULL,
	area_glottolog varchar NULL,
	sort_affiliation varchar NULL,
    genus_wals varchar NULL,
    family_genus varchar NULL,
	CONSTRAINT languages_pk PRIMARY KEY (language_id),
	CONSTRAINT languages_unique UNIQUE (glottocode)
);


--- Table of nominal person-related source references
CREATE TABLE public.datasources (
	language_ID smallint not NULL,
	ref_short text,
	ref_bibtex text,
	ref_pages text,
	notes text,
	CONSTRAINT datasources_languages_FK FOREIGN KEY (language_ID) REFERENCES languages(language_ID) ON DELETE CASCADE
);

--- core syntactic properties related to language_id as foreign key (allows easier remodelling of languages_dim to encode genetic relationships in more elaborate way if need arises)
CREATE TABLE public.core_properties (
	id serial2 NOT NULL,
	language_id smallint NOT NULL,
	constituent_order varchar NULL,
	constituent_order_wals varchar NULL,
	adposition_order varchar NULL,
	adposition_order_wals varchar NULL,
	genitive_order varchar NULL,
	genitive_order_wals varchar NULL,
	demonstrative_order varchar NULL,
	demonstrative_order_wals varchar NULL,
	definite_article varchar NULL,
	article_distinct_third bool NULL,
	demonstrative_as_third bool NULL,
	nominal_person bool NULL,
	apc_direction varchar NULL,
	bound_person_direction varchar NULL,
	person_allowed varchar NULL,
	person_third_available varchar NULL,
	number_allowed varchar NULL,
	ppdc varchar NULL,
	CONSTRAINT syntactic_properties_pk PRIMARY KEY (id),
	CONSTRAINT syntactic_properties_languages_fk FOREIGN KEY (language_id) REFERENCES public.languages(language_id) ON DELETE CASCADE
);

--- syntactic properties of articles
CREATE TABLE public.article_properties (
	language_id smallint NOT NULL,
	article_order varchar NULL,
	demonstrative_w_article varchar NULL,
	nominal_person_w_article varchar NULL,
	CONSTRAINT article_properties_languages_fk FOREIGN KEY (language_id) REFERENCES public.languages(language_id) ON DELETE CASCADE
);