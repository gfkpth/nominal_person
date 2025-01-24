# Introduction

This repository contains a database with syntactic data on >100 languages with a focus on properties relating to the phenomenon of *(ad)nominal person*. One common form of *nominal person* are personal pronouns forming co-constituents of a co-referring nominal expression as in English *we linguists*.

More detailed information on relevant phenomena and the range of cross-linguistic variation can be found in [Höhn (2020)](https://doi.org/10.5334/gjgl.1121) and [Höhn (2024)](https://doi.org/10.1515/lingty-2023-0080) as well as [my dissertation](https://ling.auf.net/lingbuzz/003618). If you use this data, I'd appreciate it if you'd let me know. It's not a strict requirement, but I'm curious. If you are a linguist interested in (ad)nominal person and struggle with using this database, feel free to get in touch.


# Content

- root level:
  - persn_db.sqlite
  - persn_postgresql_dump.sql
  - requirements.txt *for python scripts*
- [db-creation-notes/](db-creation-notes): folder documenting the process of creating the database from the original master .ods file
- [2020-Glossa/](2020-Glossa): folder containing a csv file and R script from a [2020 Glossa article](https://doi.org/10.5334/gjgl.1121) on person restrictions in nominal person, based on a subset of the data in the main database
- [2024-LT/](2024-LT): folder containing a csv file and R script from a [2024 Linguistic Typology article](https://doi.org/10.1515/lingty-2023-0080) on word order correlations in nominal person, based on a (larger) subset of the data represented in the main database


# Background

The original data has so far been stored in an ods table and subsets have been published as csv files in the supplementary materials for articles in Glossa [(Höhn 2020)](https://doi.org/10.5334/gjgl.1121) and Linguistic Typology [(Höhn 2024)](https://doi.org/10.1515/lingty-2023-0080), see the [2020-Glossa](2020-Glossa) and [2024-LT](2024-LT) folders.

While a plain CSV/ODS table has been a sufficient -- and probably the most practical -- solution for my analytical purposes so far given the comparatively moderate size of the dataset (113 languages), I have two reasons for the endeavour of creating a database.

1. Making available my complete dataset on the phenomena. The datasets used in my *Glossa* and *Linguistic Typolog* papers address different aspects of nominal person, so they do not provide a full overview. Moreover, my master ODS file is not very tidy (containing extraneous notes, unused columns, extra columns for lookups of from other lists etc.). I have been thinking about an effective way of making a more comprehensive and tidier dataset publicly available, while also allowing scope for possible future extensions (or additional uses).

2. It provides an opportunity for me to practice database design with SQL and data manipulation with python using a familiar dataset.


# Format

For now, I plan to provide the database as an sqlite3 file and as a dump for postgresql, mainly because I wanted to try my hand at both. In case the database sees more extensive/dynamic use in the future, I may then decide to only maintain one version based on practical considerations.


# Data analysis

As of now, the most recent linguistic analyses of data from this dataset are [my dissertation](https://ling.auf.net/lingbuzz/003618), [Höhn (2020)](https://doi.org/10.5334/gjgl.1121) and [Höhn (2024)](https://doi.org/10.1515/lingty-2023-0080).


# Deploying the database

## postgresql

I am dumping the database for sharing on github using the following command:

```sh
pg_dump --table=table_name --no-owner --no-privileges -U your_username -d your_database -f table_dump.sql
```

In order to import the database, make sure postgresql is installed on your system and then use psql as follows (replace *username* by a user that has access to the database):

```sh
psql -U username -d persn -f persn_postgresql_dump.sql
```

You should then be able to access the database, e.g. using

```sh
psql -U username -d persn
```

Inside psql you can run the following code to check if the tables are intact (of course you can use another table than *languages* to test):

```SQL
SELECT * FROM languages;
```


## sqlite3

The database is in *persn_db.sqlite*. You can directly open it from the commandline as below (assuming you have sqlite3 installed on your system).

```sh 
sqlite3 persn_db.sqlite
```


# Using the database


## DB scheme

![Database diagram](assets/persn-diagram.png "An illustration of the database relations")

Tables:

**languages**

language\_id *private key* 
: unique internal identifier

lang\_name
: English name of the language (extension to native and other names is possible, but probably not necessary at this point)


glottocode
: identifier for languoid in [Glottolog](glottolog.org) if available

walscode
: identifier for languoid in [WALS](wals.info) if available

iso639\_3
: language code according to ISO 639-3 if available

lat
: latitude of salient map point for language (mostly based on glottolog where available, in some cases WALS and manual)

lon
: longitude of salient map point for language (see lat)

coord\_notes
: notes regarding the choice or source of coordinates (lat/lon)

area\_wals
: macro area of the language following WALS classification

area\_glottolog
: macro area of the language following Glottolog classification

sort\_affiliation
: manual coding of phylogenetic information mostly for more accessible sorting of data presentation


genus\_WALS
: phylogenetic genus based on WALS where available (manually supplied otherwise)

family\_genus
: phylogenetic information including top-level family (mostly based on Glottolog) and, where applicable, genus information based on WALS




# Major changes

This section notes any significant changes to the content or organisation of the database.


# License

Note that the datasets and scripts in the [2020-Glossa](2020-Glossa) and [2024-LT](2024-LT) folders were published as part of the supplementary material to the respective articles (see above)

Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
