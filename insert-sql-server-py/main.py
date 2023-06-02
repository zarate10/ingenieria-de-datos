import pyodbc 

db = 'prueba'
tabla_insert = 'prueba_tabla'
dataset = 'insert'
sep = ';'

try:
    conn = pyodbc.connect('DRIVER={SQL Server};' + f'SERVER=DESKTOP-0KGJ7P5;DATABASE={db};Trusted_Connection=yes;')
    pass
except Exception as e: 
    print(e)
else: 
    cursor = conn.cursor()

    try: 
        with open('./datasets/' + dataset + '.csv', 'rt', encoding='utf-8') as file: 

            for linea in file: 
                linea = linea.rstrip().split(sep)

                cursor.execute('INSERT INTO ' + tabla_insert + ' VALUES ({})'.format(','.join(['?' for c in linea])), [dato for dato in linea])
                cursor.commit()
                
    except Exception as e: 
        print(e)

    print('Consultas ejecutadas exitosamente.')
    cursor.close()