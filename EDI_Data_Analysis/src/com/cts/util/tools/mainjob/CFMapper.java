package com.cts.util.tools.mainjob;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;

import org.apache.avro.Schema;
import org.apache.avro.generic.GenericData;
import org.apache.avro.mapred.AvroKey;
import org.apache.avro.mapreduce.AvroMultipleOutputs;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;

import com.berryworks.edireader.demo.EDItoXML;
import com.berryworks.edireader.demo.IOString;
import com.berryworks.edireader.plugin.PluginControllerImpl;
import com.cts.util.tools.xmltoavro.Converter;
 

public class CFMapper extends Mapper<Text, Text, Text, Text>
   {
     String ediMsg;
	 MultipleOutputs<Text, Text> multipleOutputs;
	 Text OutputVal = new Text();
	 AvroMultipleOutputs avroOutput;
	 Schema schema;
	 Configuration conf;
	 FSDataInputStream fdis;
	 Path schemaPath, xsdPath, xslPath;
	 FileSystem fs;
	 String ediMsgStyled=null;
	 String xmlEdiData=null;
	 HashMap<String,String> cachedFiles;
	
	
	public enum ediCounters {
		gsCountFailed, stCountFailed, ediToXMLFailed, xslTransformationFailed, xmlValidationFailed, xmlToAvroFailed;
	};
	

	private String readSchemaOrTransformFile(Path uri) throws IOException {
		StringBuilder sb = new StringBuilder();
		  FileSystem fs = FileSystem.get(conf);
	        InputStream is = fs.open(uri);
		try {
			BufferedReader readBuffer1 = new BufferedReader(new InputStreamReader(is));
			String line;
			while ((line = readBuffer1.readLine()) != null) {
				sb.append(line);

			}
			readBuffer1.close();
		} catch (IOException e) {
			throw e;
		}
		return sb.toString();
	}

	@Override
	protected void setup(Mapper<Text, Text, Text, Text>.Context context)
			throws IOException, InterruptedException {
		multipleOutputs = new MultipleOutputs(context);
		avroOutput = new AvroMultipleOutputs(context);
		conf = context.getConfiguration();
		schemaPath = new Path(conf.get("InputFiles")+"/ANSI_837_05010.avsc");
		xsdPath = new Path(conf.get("InputFiles")+"/ANSI_837_05010.xsd");
		xslPath = new Path(conf.get("InputFiles")+"/ANSI_837_05010.xsl");
		
		fs = FileSystem.get(conf);
		 
		
		cachedFiles = new HashMap<String, String>();
		
		try {
			cachedFiles.put(xsdPath.toString() , readSchemaOrTransformFile(xsdPath));
			cachedFiles.put(xslPath.toString() , readSchemaOrTransformFile(xslPath));
			cachedFiles.put(schemaPath.toString() , readSchemaOrTransformFile(schemaPath));
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			throw e;
		}
	}

	public void map(Text key, Text value, Context context) throws IOException,
			InterruptedException {
		 
		ediMsg = null;
		 
		ediMsg = value.toString();
		OutputVal.set("");
        IOString xslStirng=new IOString(cachedFiles.get(xslPath.toString()));
        IOString xsdString=new IOString(cachedFiles.get(xsdPath.toString()));
		IOString xmlString=null;
		IOString avscString=new IOString(cachedFiles.get(schemaPath.toString()));
		
		if (ediMsg.contains(Constants.INCORRECT_TC_CNT_MSG)) { // If ST count in
																// GE is
																// incorrect
			OutputVal.set(Constants.FAILED_TEXT);
			multipleOutputs.write("EDISummary", key, OutputVal);
			context.getCounter(ediCounters.stCountFailed).increment(1);
		}

		if (ediMsg.contains(Constants.INCORRECT_GS_CNT_MSG)) {// If GE count in
																// ISA is
																// incorrect
			OutputVal.set(Constants.FAILED_TEXT);
			multipleOutputs.write("EDISummary", key, OutputVal);
			context.getCounter(ediCounters.gsCountFailed).increment(1);
		}

		if (!"".equals(ediMsg) && OutputVal.toString().equals("")) { // If EDI
																		// message
																		// is
																		// Valid
			try { // Convert EDI to XML
				xmlEdiData = EDItoXML.convertToXML(ediMsg);
               
                
				//context.write(key,new Text(ediMsg));
			} catch (Exception e) { // TODO Auto-generated catch block
				context.getCounter(ediCounters.ediToXMLFailed).increment(1);
				multipleOutputs
						.write("XMLConvFailed", key, new Text("Failed1"));
			}

			try {
				// Applying XSL
				 
				context.write(key,new Text(ediMsg));
				
				ediMsgStyled = Stylizer.applyXMLStyle(xslStirng.getInputStream(), xmlEdiData);
				
				 xmlString=new IOString(ediMsgStyled);
				 
				 
				 multipleOutputs.write("XMLTransformationFailed", key,new Text(ediMsgStyled));
				 

			} catch (Exception e) { // TODO Auto-generated catch block
				context.getCounter(ediCounters.xslTransformationFailed)
						.increment(1);
				multipleOutputs.write("XMLTransformationFailed", key,
						new Text(e.toString()));

			}

			try {
				 
				 

				XmlValidator.xmlValidate(xsdString.getInputStream(), xmlString.getInputStream());
				
			} catch (Exception e) {

				context.getCounter(ediCounters.xmlValidationFailed)
						.increment(1);
				multipleOutputs.write("XMLValidationFailed", key,
						new Text(e.toString()));
			}

			try {

				if (xsdString != null && xmlString != null) {
					 
					 
					 
					Schema schema1 = new Schema.Parser().parse(avscString.getString());
					 
					 

					Object datum = Converter.createDatum(schema1, xmlString.getString());

					 					 					
					context.getCounter(ediCounters.xmlToAvroFailed)
							.increment(1);
				 
					avroOutput.write("AvroData", new AvroKey(datum));
					
					context.getCounter(ediCounters.xmlToAvroFailed)
							.increment(1);
				}
			}

			catch (Exception e) {

				e.printStackTrace();
				context.getCounter(ediCounters.xmlToAvroFailed).increment(1);
				multipleOutputs.write("XMLAvroConvFailed", key,
						new Text(e.toString()+"  "+xmlString.getString().length()+" "+ediMsgStyled.length()+" "+ediMsg.length()+" "+xslStirng.getString().length()+" "+xsdString.getString().length()));
			}

			// DO XML Transformation

			// Do XML Validation Against XSD

			// Write To AVRO
		}
	}

	@Override
	protected void cleanup(Mapper<Text, Text, Text, Text>.Context context)
			throws IOException, InterruptedException {
		// TODO Auto-generated method stub
		multipleOutputs.close();
		avroOutput.close();

	}

}