package com.cts.edi.util.tools;

public class SchemaGen {
	public static void main(String[] args) throws Exception {

		XsdGen xg = new XsdGen(args[0], args[1]+".xsd");
		xg.schemaGen(); 
	
		XslGen xs = new XslGen(args[0], args[1]+".xsl");
		xs.styleGen();
	
	}
}
