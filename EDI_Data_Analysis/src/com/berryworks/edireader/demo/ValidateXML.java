package com.berryworks.edireader.demo;

import java.io.File;
import java.io.IOException;
import java.io.StringReader;

import javax.xml.XMLConstants;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.xml.sax.SAXException;

public class ValidateXML {

	public static void main(String[] args) {

		/*System.out
				.println("EmployeeRequest.xml validates against Employee.xsd? "
						+ validateXMLSchema("Employee.xsd",
								"EmployeeRequest.xml"));
		System.out
				.println("EmployeeResponse.xml validates against Employee.xsd? "
						+ validateXMLSchema("Employee.xsd",
								"EmployeeResponse.xml"));
		System.out.println("employee.xml validates against Employee.xsd? "
				+ validateXMLSchema("Employee.xsd", "employee.xml"));*/

	}

	public static boolean validateXMLSchema(String xsdPath, String xmlInput) {

		try {
			SchemaFactory factory = SchemaFactory
					.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
			Schema schema = factory.newSchema(new File(xsdPath));
			Validator validator = schema.newValidator();
			validator.validate(new StreamSource(new StringReader(xmlInput)));
			System.out.println("Success");
		} catch (IOException | SAXException e) {
			System.out.println("Exception: " + e.getMessage());
			return false;
		}
		return true;
	}
}