package com.fileValidator.tcr.scalaFunctions

import com.fileValidator.tcr.scalaUtils.SparkUtils2
import com.fileValidator.tcr.scalaUtils._;
import java.lang._;
import org.apache.log4j._
import com.fileValidator.tcr.exceptions._




object Trigger {
  
 
  
  def main(args : Array[String]) : Unit = {    
  
  
   val logger = Logger.getLogger(getClass.getName);  
   
   logger.info("Started the main method ...")
   
  val params = new AppUtils().getArgs(args) 
 // val class_name = params("classname")
  
  logger.info("Passed Params : "+params)
  
  logger.info("Calling function class and method ...")  
 try{
  

   
   new CountValOnTables().execute(params)
  
  
 }
 
  catch {      
      case ex : DataCountMismatchException => throw new DataCountMismatchException
    
      case ex : ParamMismatchException => throw new ParamMismatchException
      
      case ex : Exception => ex.printStackTrace();throw new Exception
         
    }
  

    
  }
  
}