#!/bin/sh

json_file=$PWD/composer.json

echo '{
    "autoload": {
        "classmap": [' > $json_file

du | awk '
BEGIN                     { ORS = "" }
/\/tests\//               { next }
/\/(controllers|classes)/ { printf"%s\t\t\t\"%s\"",separator,$2,separator=",\n" }
END                       { }
' | \
    sed 's/\t/    /g' >> $json_file

echo '
        ],
        "files": [' >> $json_file
## any files that end with "inc.php" to address funcions
## phpactor cares about sequence - defines must be first if any function uses constants
du -a | awk '
BEGIN         { ORS = "" }
/\.inc\.php$/ { printf "%s\t\t\t\"%s\"", separator, $2, separator = ",\n" }
END           { }' | \
    sed 's/\t/    /g' >> $json_file

echo '
        ]
    },
    "config": {
        "optimize-autoloader": true,
        "classmap-authoritative": true,
        "apcu-autoloader": true
    }
}' >> $json_file

# Today we need to clear out file loader, because inc includes more inc
# and php errors during autoload, because functions become "redeclared" again.
# Composer does not use php runetime - the require_once does not wok this way in autoload.
# diff_to_remove=$(du -a \
#     | awk '{print $2}' \
#     | grep -e 'inc\.php$' \
#     | xargs ag --nofilename require_once \
#     | grep -e 'inc\.php\'' \
#     | xargs -d\' \
#     | awk '{ print "./include" $3 }' \
#     | grep 'include/')

# echo $diff_to_remove

composer du
