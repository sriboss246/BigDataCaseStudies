/**
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.cts.util.tools.xmltoavro;

import org.apache.avro.Schema;
import org.apache.avro.file.DataFileWriter;
import org.apache.avro.hadoop.io.AvroSerializer;
import org.apache.avro.generic.GenericDatumWriter;
import org.apache.avro.io.BinaryEncoder;
import org.apache.avro.io.DatumWriter;
import org.apache.avro.io.Encoder;
import org.apache.avro.io.EncoderFactory;
import org.apache.avro.specific.SpecificDatumWriter;





import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class Converter  /*extends SpecificDatumWriter*/{
    public static Schema createSchema(String xsd) { return new SchemaBuilder().createSchema(xsd); }
    public static Schema createSchema(File file) throws ConverterException, IOException { return new SchemaBuilder().createSchema(file); }
    public static Schema createSchema(Reader reader) { return new SchemaBuilder().createSchema(reader); }
    public static Schema createSchema(InputStream stream) { return new SchemaBuilder().createSchema(stream); }

    public static <T> T createDatum(Schema schema, File file) throws IOException { return new DatumBuilder(schema).createDatum(file); }
    public static <T> T createDatum(Schema schema, String xml) { return new DatumBuilder(schema).createDatum(xml); }
    public static <T> T createDatum(Schema schema, Reader reader) { return new DatumBuilder(schema).createDatum(reader); }
    public static <T> T createDatum(Schema schema, InputStream stream) { return new DatumBuilder(schema).createDatum(stream); }

   /* private static class Options {
        static final String USAGE = "{-d|--debug} {-b|--baseDir <baseDir>} <xsdFile> <xmlFile> {<avscFile>} {<avroFile>}";
        public enum args_enum{d,debug,b,basedir};
        
        
        File xsdFile;
        File xmlFile;

        File avscFile;
        File avroFile;

        boolean debug;
        File baseDir;

        Options(String... args) {
            List<String> files = new ArrayList<String>();

            for (int i = 0; i < args.length; i++) {
                String arg = args[i];

                if (arg.startsWith("-"))
                 {  int caseval;
                     if(arg.charAt(1)=='d')
                    	 caseval=1;
                     else if(arg.charAt(1)=='b')
                    	 caseval=2;
                     else
                    	 caseval=3;
                    switch (caseval) {
                        //case "-d":
                        case 1:
                            debug = true;
                            break;
                       // case "-b":
                        case 2:
                            if (i == args.length - 1) throw new IllegalArgumentException("Base dir required");
                            i++;
                            baseDir = new File(args[i]);
                            break;
                        default:
                            throw new IllegalArgumentException("Unsupported option " + arg);
                    }
                 }
                else
                    files.add(arg);
            }

            if (files.size() < 2 || files.size() > 4)
                throw new IllegalArgumentException("Incorrect number of in/out files. Expected [2..4]");

            xsdFile = replaceBaseDir(files.get(0), baseDir);
            xmlFile = replaceBaseDir(files.get(1), baseDir);

            avscFile = files.size() > 2 ? replaceBaseDir(files.get(2), baseDir) : replaceExtension(xsdFile, "avsc");
            avroFile = files.size() > 3 ? replaceBaseDir(files.get(3), baseDir) : replaceExtension(xmlFile, "avro");
        }

        private static File replaceExtension(File file, String newExtension) {
            String fileName = file.getPath();

            int dotIdx = fileName.lastIndexOf('.');
            if (dotIdx != -1) fileName = fileName.substring(0, dotIdx);

            return new File(fileName + "." + newExtension);
        }

        private static File replaceBaseDir(String path, File baseDir) {
            File file = new File(path);
            if (baseDir == null || file.isAbsolute()) return file;
            return new File(baseDir, file.getPath());
        }
    }

    private static class BaseDirResolver implements SchemaBuilder.Resolver {
        private File baseDir;
        private BaseDirResolver(File baseDir) { this.baseDir = baseDir; }

        public InputStream getStream(String systemId) {
            File file = new File(baseDir, systemId);

            try { return new FileInputStream(file); }
            catch (FileNotFoundException e) { return null; }
        }
    }*/

     public void callMethod(Schema schema,Object object,OutputStream stream) throws IOException{
    	
    	 //GenericDatumWriter datumWriter = new GenericDatumWriter(schema);
          
     	// this.write(schema,object, EncoderFactory.get().directBinaryEncoder(stream, null));
    	
    } 
    
    public static Object main(String... args) throws IOException {
       // Options opts;
        Converter cn;
        try {
            //opts = new Options(args);
            cn=new Converter();
        } catch (IllegalArgumentException e) {
            System.out.println("XML Avro converter.\nError: " + e.getMessage() + "\n" + "Usage: " + "\n");
            System.exit(1);
            return "";
        }

       // System.out.println("Converting: \n" + opts.xsdFile + " -> " + opts.avscFile + "\n" + opts.xmlFile + " -> " + opts.avroFile);

        SchemaBuilder schemaBuilder = new SchemaBuilder();
       // schemaBuilder.setDebug(opts.debug);
       // if (opts.baseDir != null) schemaBuilder.setResolver(new BaseDirResolver(opts.baseDir));
        Schema schema = schemaBuilder.createSchema(args[0]);
      /*  Writer writer=null;
        try  {
        	  writer = new FileWriter(opts.avscFile);
            writer.write(schema.toString(true));
        }

        finally{
        	writer.close();
        	
        }*/
        
        DatumBuilder datumBuilder = new DatumBuilder(schema);
        Object datum = datumBuilder.createDatum(args[1]);
        return datum;
       // OutputStream stream=null;
        
       // try   {
        	   // stream = new FileOutputStream(opts.avroFile);
        	    
               
            // System.out.println(datum.toString());
          
        	  //  cn.callMethod(schema, datum, stream);
        	    
//        	    GenericDatumWriter datumWriter = new GenericDatumWriter(schema);
//                 
//        	    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
//
//        	    Encoder e = EncoderFactory.get().binaryEncoder(outputStream, null);
//
//        	    datumWriter.write(datum, e);
//        	    e.flush();
//
//        	    return outputStream.toString();
        	    
        	   /* DataFileWriter<Object> dataFileWriter = new DataFileWriter<Object>(datumWriter);
                File avroFile = opts.avroFile;
                dataFileWriter.create(schema, avroFile);
                dataFileWriter.append(datum);
                dataFileWriter.flush();
                dataFileWriter.close();*/
       	/*        datumWriter.write(schema,EncoderFactory.get().directBinaryEncoder(stream, null));
       	        datumWriter.write(schema,datum,EncoderFactory.get().directBinaryEncoder(stream, null));
*/       // }
        
       // finally{
        	
        //	stream.close();
       // }
    }
}