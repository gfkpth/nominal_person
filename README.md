# Introduction

This repository contains a database with syntactic data on >100 languages with a focus on properties relating to the phenomenon of *nominal person*. Cross-linguistially common expression of *nominal person* are personal pronouns used in syntactic construction as in English 1).

1) we linguists

More detailed information on the range of variation can be found in [Höhn (2020)](https://doi.org/10.5334/gjgl.1121) and [Höhn (2024)](https://doi.org/10.1515/lingty-2023-0080) as well as [my dissertation](https://ling.auf.net/lingbuzz/003618).


# Content

- root level:
  - requirements.txt *for python scripts*
- [db-creation-notes](db-creation-notes): documents the process of creating the database from the original master .ods file
- [2020-Glossa](2020-Glossa): csv file and R script from a [2020 Glossa article](https://doi.org/10.5334/gjgl.1121) on person restrictions in nominal person, based on a subset of the data in the main database
- [2024-LT](2024-LT): csv file and R script from a [2024 Linguistic Typology article](https://doi.org/10.1515/lingty-2023-0080) on word order correlations in nominal person, based on a (larger) subset of the data represented in the main database


# Background

The original data has so far been stored in an ods table and subsets have been published as csv files in the supplementary materials for articles in Glossa [(Höhn 2020)](https://doi.org/10.5334/gjgl.1121) and Linguistic Typology [(Höhn 2024)](https://doi.org/10.1515/lingty-2023-0080), see the [2020-Glossa](2020-Glossa) and [2024-LT](2024-LT) folders.

While a plain CSV/ODS table has been a sufficient -- and probably the most practical -- solution for my analytical purposes so far given the comparatively moderate size of the dataset (113 languages), I have two reasons for the endeavour of creating a database.

1. Making available my complete dataset on the phenomena. The datasets used in my *Glossa* and *Linguistic Typolog* papers address different aspects of nominal person, so they do not provide a full overview. Moreover, my master ODS file is not very tidy (containing extraneous notes, unused columns, extra columns for lookups of from other lists etc.). I have been thinking about an effective way of making a more comprehensive and tidier dataset publicly available, while also allowing scope for possible future extensions (or additional uses).

2. It provides an opportunity for me to practice database design with SQL and data manipulation with python using a familiar dataset.


# Format

For now, I plan to provide the database as a dump for postgresql and sqlite3, mainly because I wanted to try my hand at both. In case the database sees more extensive/dynamic use in the future, I may then decide to only maintain one version based on practical considerations.


# Data analysis



# Deploying the database

## postgresql


## sqlite3


# Using the database


## DB scheme

Tables:

- 


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
