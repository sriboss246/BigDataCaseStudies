package com.fileValidator.tcr.scalaFunctions

import com.fileValidator.tcr.scalaUtils._
import com.fileValidator.tcr.exceptions._
import org.apache.log4j.Logger
import org.apache.spark.SparkException
import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
import org.apache.hadoop.fs._

class CountValOnTables   extends FExecutor {
  
  def execute(params : scala.collection.Map[String,String]) {
    
    val logger = Logger.getLogger(getClass.getName); 
    val sparkutil  = new SparkUtils2()
    logger.info("execute method invoked ...")    
  
    
    try {
    
   // Thread.sleep(12000)
    sparkutil.init(params)  
    
    val country_id=params("country_id")
    val run_id=params("run_id")
    
    val partitions=getpartitions(params)
    
    logger.info("Partitons = "+partitions)
    
    val ipaths=params("input_paths")
    val opaths=params("output_paths")
    
    val ipathArr = ipaths.split(':')
    val opathArr = opaths.split(':')
    
    
    val fs: FileSystem = FileSystem.get(sparkutil.session.sparkContext.hadoopConfiguration)
   
    logger.info("Initialized hdfs FS instance")
    
    if(ipathArr.length != opathArr.length){
      
      logger.error("Input and output tables params count are not matching .. please give same No.of table details in both params")
      throw new ParamMismatchException("Input Params are not matching")
    }
    
   for( index <- 0 to ipathArr.length-1){ 
   
   var inPath = ipathArr(index).split(',')(0)+partitions
   var inFormat = ipathArr(index).split(',')(1)
   var outPath = opathArr(index).split(',')(0)+partitions  
   var outFormat = opathArr(index).split(',')(1)
   
   logger.info("Prepared I/O paths for the Validation Job")
   logger.info("Input path :"+ inPath+" Output path:"+outPath)
   
   if(inPath == null || outPath == null)
   {
     logger.info("ERROR -- Input and output tables paths cannot be null .. please give valid paths")
      throw new ParamMismatchException("Input Params cannot be null")
     
     }
   
   
   
    val ippath = new Path(inPath)
    val oppath = new Path(outPath)
    
    val iDirExist = fs.exists(ippath) && fs.getFileStatus(ippath).isDirectory()
    val ifile_count = fs.listStatus(ippath).size
    
    val oDirExist = fs.exists(oppath) && fs.getFileStatus(oppath).isDirectory()
    val ofile_count = fs.listStatus(oppath).size
    
    if(iDirExist == false || ifile_count==0 ){
      
    logger.error("ERROR -- Input path does not have any data files or directories - zero file exists : "+ inPath)
      throw new ZeroFileExistException("Input not have any data")  
   
    }
    
    
    if(oDirExist == false || ofile_count==0 ){
      
    logger.error("ERROR -- Output path does not have any data files or directories - zero file exists : "+ outPath)
      throw new ZeroFileExistException("Output not have any data")  
   
    }
    
   inFormat = if (inFormat == null) "Text"  else inFormat 
   outFormat = if (outFormat == null) "Text"  else outFormat 
   
    logger.info("Performing count check for inpath:"+inPath+" & outpath:"+outPath)
    logger.info("Format of Input:"+inFormat+" & Output:"+outFormat)
    
  /* var input_count = sparkutil.getDFByPath(inPath,inFormat).count()
   var output_count = sparkutil.getDFByPath(outPath,outFormat).count()*/
    
   var input_count = sparkutil.getDFCountByPath(inPath, inFormat)
   var output_count = sparkutil.getDFCountByPath(outPath,outFormat)
  
    
   
   if(input_count != output_count){
     
     logger.error("Row counts are not matching between Input and output Tables, input:"+input_count+" output:"+output_count)
     throw new DataCountMismatchException("Table counts are not matching")
     
   }
    
   else {
     
     logger.info("----Counts are matching between the tables, input:"+input_count+" & output:"+output_count)
    
   
   } 
  }
 }
  
    catch {
      
      case ex : DataCountMismatchException =>  throw new DataCountMismatchException
      case ex : ParamMismatchException =>  throw new ParamMismatchException
      case ex : ZeroFileExistException => throw new ZeroFileExistException
      case ex : Exception => throw new Exception
    }
    
    
    finally{
      
      sparkutil.closeSession()
    }
    
  }
  

def getpartitions(params : scala.collection.Map[String,String]) : String = {
  val partitionList = params("partitions").split(',')
  var partition = ""
  for(element <- partitionList){
    
    element match{
      case "country_id" => partition+="/country_id="+params("country_id")
      case "run_id" => partition+="/run_id="+params("run_id")
      case "period_id" => partition+="/period_id="+params("period_id")
      case "" => partition+=""
      case null => 
    }
    
  }
  
  
  partition
}

}

