#!/bin/bash
su -c "psql gitlab -c 'select true from users where id=1' | sed -n 3p" postgres
