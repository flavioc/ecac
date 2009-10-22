#!/usr/bin/python

import MySQLdb
import sys

FILE = "adult.data"

user = sys.argv[1]
password = sys.argv[2]

if len(sys.argv) != 3:
  print "import.py <user> <password>"
  sys.exit(1)

def create_conn(db_user, db_password):
  return MySQLdb.connect(host = "localhost", user = db_user, passwd = db_password, db="adult", use_unicode = True, charset = 'utf8', unix_socket = "/tmp/mysql.sock")

db = create_conn(user, password)

def cleanup_database():
  cursor = db.cursor()
  sql = "DELETE FROM adult"
  cursor.execute(sql)
  db.commit()
  return True

def add_new_adult(age, workclass, fnlwgt, education, education_num,
    marital_status, occupation, relationship, race, sex, capital_gain,
    capital_loss, hours_per_week, native_country, plus_50):
  cursor = db.cursor()
  sql = "INSERT INTO adult(age, workclass, fnlwgt, education, education_num, marital_status, occupation, relationship, race, sex, capital_gain, capital_loss, hours_per_week, native_country, plus_50) VALUES (%s, '%s', %s, '%s', %s, '%s', '%s', '%s', '%s', '%s', %s, %s, %s, '%s', %s)" \
                % (age, workclass, fnlwgt, education, education_num,
                    marital_status, occupation, relationship, race, sex, capital_gain,
                    capital_loss, hours_per_week, native_country, plus_50)
  cursor.execute(sql)
  id = int(db.insert_id())
  db.commit()
  return id

def normalize_field(field):
  return field.lower().replace('-', '_')

def import_record(line):
  vec = line.split(', ')
  if len(vec) < 14:
    return
  age = vec[0]
  workclass = normalize_field(vec[1])
  fnlwgt = vec[2]
  education = normalize_field(vec[3])
  education_num = vec[4]
  marital_status = normalize_field(vec[5])
  occupation = normalize_field(vec[6])
  relationship = normalize_field(vec[7])
  race = normalize_field(vec[8])
  sex = normalize_field(vec[9])
  capital_gain = vec[10]
  capital_loss = vec[11]
  hours_per_week = vec[12]
  native_country = normalize_field(vec[13])
  plus_50 = vec[14]
  if plus_50 == '>50K\n':
    plus_50 = 'TRUE'
  else:
    plus_50 = 'FALSE'
  if native_country == 'trinadad&tobago':
    native_country = 'trinadad_tobago'
  if native_country == 'outlying_us(guam_usvi_etc)':
    native_country = 'outlying_us'
  if native_country == '?':
    native_country = 'unknown'
  if workclass == '?':
    workclass = 'unknown'
  if occupation == '?':
    occupation = 'unknown'
  add_new_adult(age, workclass, fnlwgt, education, education_num, marital_status, occupation, relationship, race, sex, capital_gain, capital_loss, hours_per_week, native_country, plus_50)

def import_file(file):
  f = open(file, 'r')
  for line in f:
    import_record(line)
  f.close()

cleanup_database()
import_file(FILE)

db.close()
