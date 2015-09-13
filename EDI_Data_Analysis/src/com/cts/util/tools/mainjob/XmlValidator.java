package com.cts.util.tools.mainjob;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.xml.sax.SAXException;

public class XmlValidator {

	public static void xmlValidate(InputStreamReader xsdpath,
			InputStreamReader xmlMsg) throws SAXException, IOException {
		SchemaFactory schemaFactory = SchemaFactory
				.newInstance("http://www.w3.org/2001/XMLSchema");
		Schema sch = schemaFactory.newSchema(new StreamSource(xsdpath));
		Validator validator = sch.newValidator();
		validator.validate(new StreamSource(xmlMsg));
		System.out.println("Xml against xsd validated");
	}
	
	public static void xmlValidate(InputStream xsdpath,InputStream xmlMsg) throws SAXException, IOException {
		SchemaFactory schemaFactory = SchemaFactory
				.newInstance("http://www.w3.org/2001/XMLSchema");
		Schema sch = schemaFactory.newSchema(new StreamSource(xsdpath));
		Validator validator = sch.newValidator();
		validator.validate(new StreamSource(xmlMsg));
		System.out.println("Xml against xsd validated");
	}

	public static void main(String... arg) throws SAXException, IOException {
		InputStreamReader is = new InputStreamReader(
				new FileInputStream(arg[1]), "ISO-8859-1");
		InputStreamReader isxsd = new InputStreamReader(new FileInputStream(
				arg[0]), "ISO-8859-1");
		XmlValidator.xmlValidate(isxsd, is);
	}

}
