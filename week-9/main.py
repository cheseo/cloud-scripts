#!/bin/python3
import psycopg2
import os
from flask import Flask, request, redirect
from markupsafe import escape

DBNAME="postgres"
USER="postgres"
PASSWORD=os.getenv("POSTGRES_PASSWORD")
PORT=os.getenv("POSTGRES_PORT")
HOST=os.getenv("POSTGRES_HOST")
conn = psycopg2.connect(f"host={HOST} dbname={DBNAME} user={USER} password={PASSWORD} port={PORT} sslmode=disable")
cur = conn.cursor()

cur.execute("CREATE TABLE IF NOT EXISTS users (id serial PRIMARY KEY, name text);")

app = Flask(__name__)

@app.route("/")
def get_users():
    str = '''
<!DOCTYPE html>
<html>
<head><title>Postgres!</title></head>
<body>
<form action="/new" method="GET">
<input type="text" name="name" placeholder="name" >
<input type="submit">
</form>
<h3>The available users are</h3>
<table border="1">
'''
    cur.execute("SELECT * FROM users;")
    for i, name in cur or []:
        str = str + f"<tr><td>{escape(i)}</td><td>{escape(name)}</tr>"
    str = str + '''
</table>
</body>
</html>
    '''
    return str

@app.route("/new")
def add_user():
    name = request.args.get("name") or "blabla"
    cur.execute("INSERT INTO users(name) values(%s);", [name])
    conn.commit()
    return redirect('/')

