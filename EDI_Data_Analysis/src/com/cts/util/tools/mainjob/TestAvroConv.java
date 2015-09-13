package com.cts.util.tools.mainjob;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import org.apache.avro.Schema;
import org.apache.avro.file.DataFileWriter;
import org.apache.avro.generic.GenericDatumWriter;

public class TestAvroConv {
	
	Schema schema;
	Object datum;
	
	public TestAvroConv(Schema sch,Object dtm){
		
		schema=sch;
		datum=dtm;
		
	}
	  
	public byte[] createData() throws IOException{
		  
		 ByteArrayOutputStream baos = new ByteArrayOutputStream();
         GenericDatumWriter datumWriter = new GenericDatumWriter(schema);
         DataFileWriter<Object> dataFileWriter = new DataFileWriter<Object>(datumWriter);
         // File avroFile = new File("D:\\schema\\order1.avro");
         
          dataFileWriter.create(schema, baos);
          dataFileWriter.append(datum);
          dataFileWriter.flush();
          
           
          
          byte[] str= baos.toByteArray();    //.toString("UTF-8"); 
          
         // out.flush();
          dataFileWriter.close();
          baos.close();
          
          return str;
		  
	  }

}
