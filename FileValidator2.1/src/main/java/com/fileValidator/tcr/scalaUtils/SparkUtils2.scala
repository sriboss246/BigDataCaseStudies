package com.fileValidator.tcr.scalaUtils

import org.apache.log4j.Logger
import org.apache.spark.sql.SQLContext
import org.apache.spark.sql.SparkSession

class SparkUtils2 {

  var session: SparkSession = null
  var sqlContext: SQLContext = null

  val logger = Logger.getLogger(getClass.getName);

  def init(params: scala.collection.Map[String, Any]) {

    session = SparkSession.builder().appName("TCRGenericFunctions").master("yarn").
      getOrCreate();
    sqlContext = session.sqlContext

  }

  /**
   * rename respect to parquet/parameterize
   */
  def getDFCountByPath(path: String, fileFormat: String): Long = {

    session.read.format(fileFormat).load(path).count()

    // sqlContext.read.format(fileFormat).load(path).count()

  }

  def closeSession() {
    session.close()
  }
}