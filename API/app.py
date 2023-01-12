import os
import psycopg2
from flask import Flask, render_template, request, url_for, redirect
from flask import jsonify

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(host='localhost',
        	database="space",
        # user=os.environ['DB_USERNAME'],
		user="postgres",
		# password=os.environ['DB_PASSWORD']
        password="2NxnBj6J")
    return conn


@app.route('/')
def index():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT * FROM planeta;')
    planetas = cur.fetchall()
    cur.execute('SELECT * FROM estrella;')
    estrellas = cur.fetchall()
    cur.execute('SELECT * FROM constelacion;')
    constelaciones = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('index.html', planetas=planetas, estrellas=estrellas, constelaciones=constelaciones)

@app.route('/create')
def create():
    
    return render_template('create.html')


@app.route('/c_constelacion', methods=('GET', 'POST'))
def c_constelacion():
    try:
        if request.method == 'POST':
            n_cons = request.form['n_cons']
            n_estrellas = int(request.form['n_estrellas'])


            conn = get_db_connection()
            cur = conn.cursor()
            if (n_cons != "" and n_estrellas != ""):
                cur.execute('INSERT INTO constelacion (nombre_constelacion, cantidad_estrellas)'
                            'VALUES (%s, %s)',
                            (n_cons, n_estrellas))
            conn.commit()
            cur.close()
            conn.close()

        return render_template('c_constelacion.html')
    except psycopg2.Error as e:
        print(e)
        return jsonify({"error": e})

@app.route('/c_estrella', methods=('GET', 'POST'))
def c_estrella():
    try:
        if request.method == 'POST':

            n_es = request.form['n_es']
            n_constelacion = request.form['n_constelacion']
            radio_es = int(request.form['radio_es'])
            edad = int(request.form['edad'])

            conn = get_db_connection()
            cur = conn.cursor()
            
            if (n_es != "" and n_constelacion != "" and radio_es != "" and edad != ""):
                cur.execute('INSERT INTO estrella (nombre_estrella, nombre_constelacion, tamaño, edad)'
                            'VALUES (%s, %s, %s, %s)',
                            (n_es, n_constelacion, radio_es, edad))
            conn.commit()
            cur.close()
            conn.close()
            

        return render_template('c_estrella.html')
    except psycopg2.Error as e:
        print(e)
        return jsonify({"error": e})

@app.route('/c_planeta', methods=('GET', 'POST'))
def c_planeta():
    try:
        if request.method == 'POST':

            n_planeta = request.form['n_planeta']
            n_estrella = request.form['n_estrella']
            n_sistema = request.form['n_sistema']
            radio_pl = int(request.form['radio_pl'])
            tipo_orbita = request.form['tipo_orbita']

            conn = get_db_connection()
            cur = conn.cursor()

            if (n_planeta != "" and n_estrella != "" and radio_pl != "" and tipo_orbita != "" and n_sistema != ""):
                cur.execute('INSERT INTO planeta (nombre_planeta, nombre_estrella, nombre_sistema,tamaño, orbita)'
                            'VALUES (%s, %s, %s,%s, %s)',
                            (n_planeta, n_estrella, n_sistema,radio_pl, tipo_orbita))
            conn.commit()
            cur.close()
            conn.close()
            

        return render_template('c_planeta.html')
    except psycopg2.Error as e:
        print(e)
        return jsonify({"error": e})


@app.route('/d_constelacion/', methods=(['GET', 'POST']))
def d_constelacion():
    try:
        if request.method == 'POST':
            n_constelacion = request.form['n_constelacion']

            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('DELETE FROM constelacion WHERE nombre_constelacion = %s;', (n_constelacion,))
            conn.commit()
            cur.close()
            conn.close()

        return render_template('d_constelacion.html')
    except psycopg2.Error as e:
        print(e)
        return jsonify({"error": e})

@app.route('/d_estrella/', methods=(['GET', 'POST']))
def d_estrella():
    try:
        if request.method == 'POST':
            n_estrella = request.form['n_estrella']

            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('DELETE FROM estrella WHERE nombre_estrella = %s;', (n_estrella,))
            conn.commit()
            cur.close()
            conn.close()

        return render_template('d_estrella.html')
    except psycopg2.Error as e:
        print(e)
        return jsonify({"error": e})

@app.route('/d_planeta/', methods=(['GET', 'POST']))
def d_planeta():
    try:
        if request.method == 'POST':
            n_planeta = request.form['n_planeta']

            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('DELETE FROM planeta WHERE nombre_planeta = %s;', (n_planeta,))
            conn.commit()
            cur.close()
            conn.close()

        return render_template('d_planeta.html')
    except psycopg2.Error as e:
        print(e)
        return jsonify({"error": e})

@app.route('/u_estrella/', methods=(['GET', 'POST']))
def u_estrella():
    try:
        if request.method == 'POST':
            nombre = request.form['nombre']
            edad = int(request.form['edad'])

            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('UPDATE estrella SET edad = %s WHERE nombre_estrella = %s;',
                            (edad, nombre))
            conn.commit()
            cur.close()
            conn.close()

        return render_template('u_estrella.html')
    except psycopg2.Error as e:
        print(e)
        return jsonify({"error": e})

@app.route('/u_planeta/', methods=(['GET', 'POST']))
def u_planeta():
    try:
        if request.method == 'POST':
            nombre = request.form['nombre']
            orbita = request.form['orbita']

            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute('UPDATE planeta SET orbita = %s WHERE nombre_planeta = %s;',
                            (orbita, nombre))
            conn.commit()
            cur.close()
            conn.close()

        return render_template('u_planeta.html')
    except psycopg2.Error as e:
        print(e)
        return jsonify({"error": e})

@app.route('/about/')
def about():

    return render_template('about.html')