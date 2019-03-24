package com.fileValidator.tcr.scalaUtils

import org.apache.log4j.Logger;
import scala.util.control._
 

class AppUtils {
  
   val logger = Logger.getLogger(getClass.getName);
   
   def getArgs(args : Array[String]) : Map[String,String] = 
    {
    
     var params : Map[String,String] = Map.empty;
     val argLen : Int = args.length;
     
    if(argLen==0){
      
      logger.info("Passed zero arguments to this app");
      throw new Exception("Zero arguments provided exception - provide arguments as --class_name ABC...")
     }
    
    else {
      val loop = new Breaks;
      
      loop.breakable{
       
      for( i <- 0 to argLen if i%2==0){
        
        if(i >= argLen)
        { loop.break() }    
          
        params += (args(i) -> args(i+1))
        
      }
      
      }
    
     println("Params : "+params)
    }
    
    return params;
  }
}