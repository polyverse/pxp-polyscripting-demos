#!/bin/bash

cp $POLYSCRIPT_PATH/util/resetPhp/zend_language_parser.y $PHP_SRC_PATH/Zend/
cp $POLYSCRIPT_PATH/util/resetPhp/zend_language_scanner.l $PHP_SRC_PATH/Zend/
cp -r $POLYSCRIPT_PATH/util/resetPhp/phar $PHP_SRC_PATH/ext/
rm $POLYSCRIPT_PATH/scrambled.json

if [[ -f "./run-test" ]]; then 
	cp ./run-test $PHP_SRC_PATH/run-tests.php
fi

if [[ $1 == "-revert" ]]; then
	rm -rf $POLYSCRIPT_PATH/tests_ps
	
	cd $PHP_SRC_PATH
        make install
fi
