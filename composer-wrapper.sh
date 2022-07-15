#!/bin/sh

php /usr/local/lib/php-code-quality/composer $@
STATUS=$?
return $STATUS