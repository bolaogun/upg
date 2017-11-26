#!/usr/bin/env python

import cx_Oracle
import sys
import argparse


class OraDb():
  def __init__(self, **kwargs):
    self.hostname = hostname
    self. port = port
    self.db = db
    self.user = user
    self.password = password
    self.connector = None
    self.cursor = None

  def initConnection(self):
    self.connector = None
     
  def initCursor(self):
    self.cursor = self.connector.cursor

  def printConnected(self):
    printf("Connected\n")
    
  def getConnector(self):
    self.initConnection()
    self.__dsn = cx_Oracle.makedsn(self.hostname, self.port, self.db)
    self.__dsn = utf8encode(self.__dsn)
    self.user = utf8encode(self.user)
    self.password = utf8encode(self.password)

    try:
        self.connector = cx_Oracle.connect(dsn=self.__dsn, user=self.user, password=self.password, mode=cx_Oracle.SYSDBA)
        printf("successfully connected as SYSDBA")
    except (cx_Oracle.OperationalError, cx_Oracle.DatabaseError, cx_Oracle.InterfaceError):
        try:
            self.connector = cx_Oracle.connect(dsn=self.__dsn, user=self.user, password=self.password)
        #except (cx_Oracle.OperationalError, cx_Oracle.DatabaseError, cx_Oracle.InterfaceError), msg:
        except (cx_Oracle.OperationalError, cx_Oracle.DatabaseError, cx_Oracle.InterfaceError):
            self.printException (exception)
            #raise SqlmapConnectionException(msg)

    self.initCursor()
    self.printConnected()
    return self.connector

  def getCursor(self):
    return self.cursor

  def printException (exception):
    error, = exception.args
    printf ("Error code = %s\n",error.code);
    printf ("Error message = %s\n",error.message);
  
  def execsql(self, sql_stmt):
    try:
      self.cursor.execute(sql_stmt)
    #except cx_Oracle.DatabaseError, exception:
    except cx_Oracle.DatabaseError:
      printf ('Failed to Execute Statement\n')
      self.printException (exception)
      exit (1)

  def close(self):
    self.cursor.close()

def main():

  parser = argparse.ArgumentParser()
#  parser.add_argument("-hst", "--hostname", type=str, metavar='', required=True, help="The Oracle Db Host")
#  parser.add_argument("-pn", "--portnum", type=str, metavar='', required=True, help="The Db Listener Port Number")
#  parser.add_argument("-s", "--sid", type=str, metavar='', required=True, help="The Oracle Db SID to connect to")
#  parser.add_argument("-u", "--username", type=str, metavar='', required=True, help="The Username to connect as")
#  parser.add_argument("-pw", "--password", type=str, metavar='', required=True, help="The Password for the User")
#  parser.add_argument("-sql", "--sql_statement", type=str, metavar='', required=True, help="The SQL Statement to Execute")

  parser.add_argument("-hst", "--hostname", type=str, required=True, help="The Oracle Db Host")
  parser.add_argument("-pn", "--portnum", type=str, required=True, help="The Db Listener Port Number")
  parser.add_argument("-s", "--sid", type=str, required=True, help="The Oracle Db SID to connect to")
  parser.add_argument("-u", "--username", type=str, required=True, help="The Username to connect as")
  parser.add_argument("-pw", "--password", type=str, required=True, help="The Password for the User")
  parser.add_argument("-sql", "--sql_statement", type=str, required=True, help="The SQL Statement to Execute")
  args = parser.parse_args()
  
#  db = OraDb(hostname = hstnm, port = prt, db = sid, user = usr,
#                password = pwd)
#
#  db.getConnector()
#  db.getCursor()
#  db.execsql(sql_stmt)
#  db.close()

#cursor = connection.cursor()
#cursor.execute("CREATE TABLE x(a DATE)")
#cursor.close()

if __name__ == '__main__':
  main()
