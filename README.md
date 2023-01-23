# Assembly QC Report Generator

## Table of Contents

- [Assembly QC Report Generator](#assembly-qc-report-generator)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Installation](#installation)
  - [Getting sample data](#getting-sample-data)
  - [Running the Pipeline](#running-the-pipeline)
  - [Final notes](#final-notes)

## Introduction

Welcome to the Assembly QC report generator. This software is a Nextflow pipeline that can be used to perform BUSCO searches on fasta data and will generate an easy-to-read html report. More capabilities will be added in the future.

## Installation

1. Copy the Github repository URL and run the following in your target folder:

```bash
$ git clone https://github.com/PlantandFoodResearch/assembly_qc.git
```

2. Navigate into the project

```bash
$ cd assembly_qc/
```

## Getting sample data

In order to retrieve dummy data to test the pipeline with, run the following:

```bash
$ ml seqkit
$ mkdir input_data
$ cp /output/genomic/fairGenomes/Fungus/Neonectria/ditissima/sex_na/1x/assembly_rs324p/v1/Nd324_canupilon_all.sorted.renamed.fasta \
./input_data/test_data.fasta
$ seqkit sample -p 0.9 ./input_data/test_data.fasta > ./input_data/test_data2.fasta
```

Two sets of data will now be in the input_data folder. They will be named test_data.fasta and test_data2.fasta

## Running the Pipeline

1. Load the required modules:

```bash
$ ml singularity
$ ml conda
$ ml nextflow
```

2. Run the pipeline:

```bash
$ nextflow main.nf
```

The test data will take around 15 minutes to run. When the pipeline has finished running you will see the output of "Complete!" in the terminal along with the standard BUSCO output.

You will now see a results folder which will contain a file named 'report.html' and can be viewed on the [powerPlant storage server](https://storage.powerplant.pfr.co.nz).

An example report.html file can be found in the [example_report](./example_report/) folder.

---

:memo: Note: If you are using your own data, please place it into the input_data folder. You will need to update the "input_files" value in the nextflow.config file to match the paths to your data. To include multiple input files, simply add ["NAME", "YOUR_INPUT_FILE"] to the input_files parameter, separated by commas. The "NAME" portion will be how BUSCO identifies your input file.

The nextflow.config file also contains the parameters for the BUSCO search which can be changed to suit the user. For example, if you wish to include multiple lineage datasets against which to test your data, simply add "YOUR_LINEAGE_DATASET" to the lineage_datasets parameter, separated by commas.

---

After running the pipeline, if you wish to clean up the logs and work folder, you can run the following:

```bash
$ ./cleanNXF.sh
```

## Final notes

This tool is designed to make your life easier. If you have any suggestions for improvements please feel free to contact me to discuss!
