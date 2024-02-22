#!/bin/bash

#install centrifuger

git clone https://github.com/mourisl/centrifuger.git

cd centrifuger
make
cd ..

chmod +x centrifuger-download

