#!/bin/bash

cp /usr/local/bin/php /usr/local/bin/s_php

cp -r $PHP_SRC_PATH/ext/phar -r $POLYSCRIPT_PATH/util/resetPhp/
cp $PHP_SRC_PATH/Zend/zend_language_scanner.l $POLYSCRIPT_PATH/util/resetPhp/
cp $PHP_SRC_PATH/Zend/zend_language_parser.y $POLYSCRIPT_PATH/util/resetPhp/
