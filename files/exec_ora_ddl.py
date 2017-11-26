#!/usr/bin/env python

#from cx_Oracle import connect, DatabaseError, InterfaceError, LOB, STRING, SYSDBA, SYSOPER
#from cx_Oracle import PRELIM_AUTH, DBSHUTDOWN_ABORT, DBSHUTDOWN_IMMEDIATE, DBSHUTDOWN_TRANSACTIONAL, DBSHUTDOWN_FINAL
from pysqlexception import PysqlException, PysqlActionDenied, PysqlNotImplemented
import cx_Oracle
import sys


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

  def getConnector(self):
    self.initConnection()
    self.__dsn = cx_Oracle.makedsn(self.hostname, self.port, self.db)
    self.__dsn = utf8encode(self.__dsn)
    self.user = utf8encode(self.user)
    self.password = utf8encode(self.password)

    try:
        self.connector = cx_Oracle.connect(dsn=self.__dsn, user=self.user, password=self.password, mode=cx_Oracle.SYSDBA)
        logger.info("successfully connected as SYSDBA")
    except (cx_Oracle.OperationalError, cx_Oracle.DatabaseError, cx_Oracle.InterfaceError):
        try:
            self.connector = cx_Oracle.connect(dsn=self.__dsn, user=self.user, password=self.password)
        except (cx_Oracle.OperationalError, cx_Oracle.DatabaseError, cx_Oracle.InterfaceError), msg:
            raise SqlmapConnectionException(msg)

    self.initCursor()
    #self.printConnected()
    return self.connector

  def getCursor(self):
    return self.cursor


  def execsql(self, sql_stmt):
    self.cursor.execute(sql_stmt)


  def close(self):
    self.cursor.close()
    
db = OraDb(hostname = hstnm, port = prt, db = sid, user = usr,
                password = pwd)

cnxtr = db.getConnector()
cursor = db.getCursor()

db.execsql(sql_stmt)
db.close()

cursor = connection.cursor()
cursor.execute("CREATE TABLE x(a DATE)")
cursor.close()

