package com.nielsen.tcr.exceptions

class CountMismatchException {
  
}

case class DataCountMismatchException(private val message:String="",private val cause:Throwable=None.orNull)
extends Exception(message,cause)

case class ParamMismatchException(private val message:String="",private val cause:Throwable=None.orNull)
extends Exception(message,cause)

case class ZeroFileExistException(private val message:String="",private val cause:Throwable=None.orNull)
extends Exception(message,cause)