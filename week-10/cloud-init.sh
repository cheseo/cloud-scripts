#!/bin/bash
apt update
apt install -y sqlite3 git
git clone 'https://codeberg.org/boink/skilldb2'
cd skilldb2
curl 'https://ashwink.com.np/t/skilldb2' > skilldb2
curl 'https://ashwink.com.np/t/db.db' > db.db
chmod +x ./skilldb2
./skilldb2 &

