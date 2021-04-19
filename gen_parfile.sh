#!/bin/sh
set -e
git clone https://github.com/Alatius/latin-macronizer.git
cd latin-macronizer
git clone https://github.com/Alatius/treebank_data.git
python extractlexicon.py
rft-train -l rftagger-lexicon.txt -c 7 -p 6.5 ldt-corpus.txt wordclass.txt latin.par
cd ../
mv latin.par old-latin.par
mv latin-macronizer/latin.par latin.par
echo "Latin parfile is in latin.par"
echo "Testing output"
diff -q <(rft-annotate latin.par latintok.txt) test-output.txt || echo "Test failed."
echo "All good!"
