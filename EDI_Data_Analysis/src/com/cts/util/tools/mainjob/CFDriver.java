package com.cts.util.tools.mainjob;

import java.io.File;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;
import java.util.Scanner;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.JobConf;
import org.apache.hadoop.mapreduce.Counters;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.LazyOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;
import org.apache.avro.Schema;
import org.apache.avro.file.*;
import org.apache.avro.mapred.AvroOutputFormat;
import org.apache.avro.mapreduce.AvroKeyOutputFormat;
import org.apache.avro.mapreduce.AvroKeyValueOutputFormat;
import org.apache.avro.mapreduce.AvroMultipleOutputs;

import com.cts.util.tools.mainjob.CFMapper.ediCounters;

public class CFDriver implements Tool {
	
	 public int run(String[] args) throws Exception {
		 Configuration conf = new Configuration();
		 conf.set("resourceFiles", args[2]);
		 conf.set("InputFiles",args[3]);
		 List filenames =new ArrayList<String>();
		 Schema schema=null;
		 
		 File schemafile=new File(conf.get("resourceFiles")+"/ANSI_837_05010.avsc");
		 schema = new Schema.Parser().parse(schemafile);
		  
		    conf.set("mapred.max.split.size", "536870912"); // for 512 mb
			conf.set("InputType",args[0]);
			
			//getting list of file names from a txt file
			 
			File resFile=new File(conf.get("resourceFiles")+"/resource.txt");
			Scanner sc=new Scanner(resFile);
			
			while(sc.hasNextLine()){
				
			  filenames.add(sc.nextLine());
				
			}
			
			
			Job job = new Job(conf, "EDI Processer");
			 
			job.setJarByClass(CFDriver.class);
			job.setMapperClass(CFMapper.class);
			job.setNumReduceTasks(0);// To Be removed
			job.setMapOutputKeyClass(Text.class);
			job.setMapOutputValueClass(Text.class);
			
			job.setInputFormatClass(CFInputFormat.class);
			
			 
			FileInputFormat.addInputPath(job, new Path(args[0]));
			FileOutputFormat.setOutputPath(job, new Path(args[1]));
			
			MultipleOutputs.addNamedOutput(job, "XMLConvFailed", TextOutputFormat.class, Text.class, Text.class);
			MultipleOutputs.addNamedOutput(job, "XMLTransformationFailed", TextOutputFormat.class, Text.class, Text.class);
			MultipleOutputs.addNamedOutput(job, "XMLValidationFailed", TextOutputFormat.class, Text.class, Text.class);
			MultipleOutputs.addNamedOutput(job, "XMLAvroConvFailed", TextOutputFormat.class, Text.class, Text.class);
			MultipleOutputs.addNamedOutput(job, "XMLInvalid", TextOutputFormat.class, Text.class, Text.class);
			MultipleOutputs.addNamedOutput(job, "EDISummary", TextOutputFormat.class, NullWritable.class, Text.class);
						
			String fname=filenames.iterator().next().toString().replace("_","");
			AvroMultipleOutputs.addNamedOutput(job,"AvroData",AvroKeyOutputFormat.class,schema);
			
			LazyOutputFormat.setOutputFormatClass(job, TextOutputFormat.class);
			Integer returnVal = job.waitForCompletion(true) ? 0 : 1;
			Counters counters =job.getCounters();
			System.out.println("    => ST Count Failed: " + counters.findCounter(ediCounters.stCountFailed).getValue());
			System.out.println("    => GS Count Failed: " + counters.findCounter(ediCounters.gsCountFailed).getValue());
			System.out.println("    => EDI To XML Failed: " + counters.findCounter(ediCounters.ediToXMLFailed).getValue());
			System.out.println("    => XML To Avro Failed: " + counters.findCounter(ediCounters.xmlToAvroFailed).getValue());
			
			return returnVal;
	 }
	
	public static void main(String[] args) throws Exception {
		int res = ToolRunner.run(new Configuration(), new CFDriver(), args);
	    System.exit(res);
	}

	public Configuration getConf() {
		// TODO Auto-generated method stub
		return null;
	}

	public void setConf(Configuration arg0) {
		// TODO Auto-generated method stub
	}
}
