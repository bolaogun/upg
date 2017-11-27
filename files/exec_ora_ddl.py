#!/usr/bin/python

import sys
import cx_Oracle
import argparse

def printException (exception):
  error, = exception.args
  print ("Error code = {}\n".format(error.code))
  print ("Error message = {}\n".format(error.message))

parser = argparse.ArgumentParser()

parser.add_argument("-hst", "--hostname", type=str, required=True, help="The Oracle Db Host")
parser.add_argument("-pn", "--portnum", type=str, required=True, help="The Db Listener Port Number")
parser.add_argument("-s", "--sid", type=str, required=True, help="The Oracle Db SID to connect to")
parser.add_argument("-u", "--username", type=str, required=True, help="The Username to connect as")
parser.add_argument("-pw", "--password", type=str, required=True, help="The Password for the User")
parser.add_argument("-sql", "--sql_statement", type=str, required=True, help="The SQL Statement to Execute")
args = parser.parse_args()
print (args)

dsn = cx_Oracle.makedsn(args.hostname, args.portnum, args.sid )
try:
    connection = cx_Oracle.connect (dsn=dsn, user=args.username, password=args.password, mode=cx_Oracle.SYSDBA)
except cx_Oracle.DatabaseError, exception:
    try:
        connection = cx_Oracle.connect (dsn=dsn, user=args.username, password=args.password)
    except cx_Oracle.DatabaseError, exception:
        print ('Failed to connect to DB: {}\n',format(dsn))
        printException (exception)
        exit (1)

cursor = connection.cursor ()

try:
  cursor.execute (args.sql_statement)
except cx_Oracle.DatabaseError, exception:
  print ('Failed to Execute Statement: {}\n'.format(args.sql_statement))
  printException (exception)
  exit (1)

print ('Statement Executed')

cursor.close ()

connection.close ()

exit (0)

