#!/bin/bash
## make server, agent and db schema
## creates database
[[ $1 == -h ]] && zbx.-h "$0" && exit
while [[ "$#" > 0 ]]; do case $1 in
    #- recreate dev database (assuming build has happened, else use with --srv flag).
    -D |--db)__db=1;;
    #- recreate Postgres dev database (assuming build has happened, else use with --srv flag).
    -Dp|--postgresql)__psgsql=1;;
    #- create test database for selenium tests (db affix: test_selenium).
    -Ds|--db-selenium)__db_selenium=1;;
    #- create test database for API tests (db affix: test_api).
    -Da|--db-api)__db_api=1;;
    #- Sets up phpunit and it's config, to be used with zbx,test -h
    -P |--phpunit)__phpunit=1;;
    #- clean build/rebuild server, schema, agent
    -S |--srv)__srv=1;;
    #- clean build/rebuild server, schema, agent, use postgresql
    -Sp|--srv)__srv=1;__srv_pgsql=1;;
    #- Open editot to update this stcipt.
    -ED) $EDITOR $0; exit 0;;
    *) echo "Unknown parameter passed: $1"; exit 1;;
esac; shift; done

# TODO write db settings - enable debug, increase refresh rates
# TODO create loop process that reloads config all the time

working_dir="$(zbx.resolve --working-dir)"
build_dir="$(zbx.resolve --build-prefix)"
branch_name="$(zbx.resolve --branch)"

cd $working_dir;

srv() {

    rm -rf $build_dir
    mkdir -p $build_dir

    make --directory=$working_dir distclean

    $working_dir/bootstrap.sh

    if [[ ! -z $__srv_pgsql ]]; then
        $working_dir/configure -q \
            --enable-server \
            --enable-agent \
            --with-libcurl \
            --enable-proxy \
            --with-postgresql \
            --prefix="$build_dir"
    else
        $working_dir/configure -q \
            --enable-server \
            --enable-agent \
            --with-libcurl \
            --enable-proxy \
            --with-mysql \
            --prefix="$build_dir"
    fi

    make --directory=$working_dir --jobs=9 --quiet dbschema
    make --directory=$working_dir --jobs=9 --quiet install

};[ ! -z $__srv ] && srv

db_p() {
    dbname=$1

    if [ ! -e $working_dir/database/postgresql/schema.sql ];then
        echo "No dbschema found, have you run $(
            tput bold)$(basename $0) --srv$(tput sgr 0)?";
        exit 2;
    fi

    cp -rf $working_dir/database $build_dir

    echo "drop database if exists \"${dbname}\";" | psql -h127.0.0.1 -Upostgres

    echo "DB: user > '${dbname}'."
    echo "create database \"${dbname}\";" | psql -h127.0.0.1 -Upostgres

    echo "DB: schema > '${dbname}'."
    psql -h127.0.0.1 -Upostgres $dbname < $build_dir/database/postgresql/schema.sql
    echo "DB: images > '${dbname}'."
    psql -h127.0.0.1 -Upostgres $dbname < $build_dir/database/postgresql/images.sql
    echo "DB: data > '${dbname}'."
    psql -h127.0.0.1 -Upostgres $dbname < $build_dir/database/postgresql/data.sql

};[ ! -z $__psgsql ] && db_p $branch_name

db() {
    dbname=$1

    if [ ! -e $working_dir/database/mysql/schema.sql ];then
        echo "No dbschema found, have you run $(
            tput bold)$(basename $0) --srv$(tput sgr 0)?";
        exit 2;
    fi

    cp -rf $working_dir/database $build_dir

    echo "DB: schema files copied into ${build_dir} from $working_dir/database"
    if [[ ! -z $(mysql -h127.0.0.1 -uroot -e "show databases" | grep "${dbname}") ]]; then
        echo "DB: dropped previous database '${dbname}'."
        mysql -h127.0.0.1 -uroot -e "drop database \`${dbname}\`;"
    fi
    echo "DB: user > '${dbname}'."
    mysql -h127.0.0.1 -uroot -e "create database \`${dbname}\` character set utf8 collate utf8_bin;"
    mysql -h127.0.0.1 -uroot -e "grant all privileges on \`${dbname}\`.* to zabbix@localhost identified by 'zabbix';"

    echo "DB: schema > '${dbname}'."
    mysql -h127.0.0.1 -uroot -D $dbname < $build_dir/database/mysql/schema.sql
    echo "DB: images > '${dbname}'."
    mysql -h127.0.0.1 -uroot -D $dbname < $build_dir/database/mysql/images.sql
    echo "DB: data > '${dbname}'. ::$build_dir/database/mysql/data.sql"
    mysql -h127.0.0.1 -uroot -D $dbname < $build_dir/database/mysql/data.sql

};[ ! -z $__db ] && db $branch_name

db_selenium() {
    dbname=$1_test_selenium
    db $dbname

    echo "DB: selenium test data > '${dbname}'."
    mysql -h127.0.0.1 -uroot -D $dbname < $working_dir/frontends/php/tests/selenium/data/data_test.sql
};[ ! -z $__db_selenium ] && db_selenium $branch_name

db_api() {
    dbname=$1_test_api
    db $dbname

    echo "DB: api json test data > '${dbname}'."
    mysql -h127.0.0.1 -uroot -D $dbname < $working_dir/frontends/php/tests/api_json/data/data_test.sql
};[ ! -z $__db_api ] && db_api $branch_name

phpunit() {
    echo '{"require":{"phpunit/phpunit":"5.7.27"}}' > \
        $working_dir/frontends/php/tests/composer.json
    composer i -d $working_dir/frontends/php/tests/
};[ ! -z $__phpunit ] && phpunit
