#!/bin/bash

#download taxonomy from NCBI
kraken2-build --download-taxonomy --db Kraken2_database
#download library "Bacteria"
kraken2-build --download-library bacteria
#