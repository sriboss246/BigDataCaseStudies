/*
 * Copyright 2005-2011 by BerryWorks Software, LLC. All rights reserved.
 *
 * This file is part of EDIReader. You may obtain a license for its use directly from
 * BerryWorks Software, and you may also choose to use this software under the terms of the
 * GPL version 3. Other products in the EDIReader software suite are available only by licensing
 * with BerryWorks. Only those files bearing the GPL statement below are available under the GPL.
 *
 * EDIReader is free software: you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version.
 *
 * EDIReader is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
 * even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with EDIReader.  If not,
 * see <http://www.gnu.org/licenses/>.
 */

package com.berryworks.edireader.demo;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.stream.StreamResult;

import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;

import com.berryworks.edireader.EDIReader;
import com.berryworks.edireader.EDIReaderFactory;
import com.berryworks.edireader.EDISyntaxException;
import com.berryworks.edireader.error.EDISyntaxExceptionHandler;
import com.berryworks.edireader.error.RecoverableSyntaxException;
import com.berryworks.edireader.util.CommandLine;

/**
 * Converts EDI input to XML output using the default XSLT transformer.
 * <p/>
 * <br>
 * <br>
 * Assuming your CLASSPATH contains edireader-n.n.n.jar, you may run this
 * program with the command line <br>
 * <br>
 * <code>
 * java com.berryworks.edireader.demo.EDItoXM [input-file] [-o output-file]
 * </code><br>
 * <br>
 * If an input-file is not specified, System.in is used; if an output-file is
 * not specified, System.out is used.
 */
public class EDItoXML {
	private final InputSource inputSource;
	private final Writer generatedOutput;
	private final Reader inputReader;
	private boolean namespaceEnabled;
	private boolean recover;

	public EDItoXML(Reader inputReader, Writer outputWriter) {
		this.inputReader = inputReader;
		inputSource = new InputSource(inputReader);
		generatedOutput = outputWriter;
	}

	/**
	 * Main processing method for the EDItoXML object
	 */
	public void run() {

		try {
			XMLReader ediReader = new EDIReader();

			// Tell the ediReader if an xmlns="http://..." is desired
			if (namespaceEnabled) {
				((EDIReader) ediReader).setNamespaceEnabled(namespaceEnabled);
			}

			// Tell the ediReader to handle EDI syntax errors instead of
			// aborting
			if (recover) {
				((EDIReader) ediReader)
						.setSyntaxExceptionHandler(new IgnoreSyntaxExceptions());
			}

			// Establish the SAXSource
			SAXSource source = new SAXSource(ediReader, inputSource);

			// Establish a Transformer
			Transformer transformer = TransformerFactory.newInstance()
					.newTransformer();

			// Use a StreamResult to capture the generated XML output
			StreamResult result = new StreamResult(generatedOutput);

			// Call the Transformer to generate XML output from the parsed input
			transformer.transform(source, result);
		} catch (TransformerConfigurationException e) {
			System.err.println("\nUnable to create Transformer: " + e);
		} catch (TransformerException e) {
			System.err.println("\nFailure to transform: " + e);
			System.err.println(e.getMessage());
		}

		try {
			inputReader.close();
		} catch (IOException ignored) {
		}
		try {
			generatedOutput.close();
		} catch (IOException ignored) {
		}
	}

	public void run_alternate1() {

		try {
			// Establish an EDIReader.
			EDIReader ediReader = EDIReaderFactory.createEDIReader(inputSource);

			// Tell the ediReader if an xmlns="http://..." is desired
			if (namespaceEnabled) {
				ediReader.setNamespaceEnabled(namespaceEnabled);
			}

			// Tell the ediReader to handle EDI syntax errors instead of
			// aborting
			if (recover) {
				ediReader
						.setSyntaxExceptionHandler(new IgnoreSyntaxExceptions());
			}

			// Establish the SAXSource
			SAXSource source = new SAXSource(ediReader, inputSource);

			// Establish a Transformer
			Transformer transformer = TransformerFactory.newInstance()
					.newTransformer();

			// Use a StreamResult to capture the generated XML output
			StreamResult result = new StreamResult(generatedOutput);

			// Call the Transformer to generate XML output from the parsed input
			transformer.transform(source, result);
		} catch (EDISyntaxException e) {
			System.err.println("\nSyntax error while parsing EDI: " + e);
		} catch (IOException e) {
			System.err.println("\nException attempting to read EDI data: " + e);
		} catch (TransformerConfigurationException e) {
			System.err.println("\nUnable to create Transformer: " + e);
		} catch (TransformerException e) {
			System.err.println("\nFailure to transform: " + e);
			System.err.println(e.getMessage());
		}
	}

	public void run_alternate2() {

		try {
			// Establish an XMLReader which is actually an EDIReader.
			System.setProperty("javax.xml.parsers.SAXParserFactory",
					"com.berryworks.edireader.EDIParserFactory");
			SAXParserFactory sFactory = SAXParserFactory.newInstance();
			SAXParser sParser = sFactory.newSAXParser();
			XMLReader ediReader = sParser.getXMLReader();

			// Tell the ediReader if an xmlns="http://..." is desired
			if (namespaceEnabled) {
				((EDIReader) ediReader).setNamespaceEnabled(namespaceEnabled);
			}

			// Tell the ediReader to handle EDI syntax errors instead of
			// aborting
			if (recover) {
				((EDIReader) ediReader)
						.setSyntaxExceptionHandler(new IgnoreSyntaxExceptions());
			}

			// Establish the SAXSource
			SAXSource source = new SAXSource(ediReader, inputSource);

			// Establish a Transformer
			Transformer transformer = TransformerFactory.newInstance()
					.newTransformer();

			// Use a StreamResult to capture the generated XML output
			StreamResult result = new StreamResult(generatedOutput);

			// Call the Transformer to generate XML output from the parsed input
			transformer.transform(source, result);
		} catch (SAXException e) {
			System.err.println("\nUnable to create EDIReader: " + e);
		} catch (ParserConfigurationException e) {
			System.err.println("\nUnable to create EDIReader: " + e);
		} catch (TransformerConfigurationException e) {
			System.err.println("\nUnable to create Transformer: " + e);
		} catch (TransformerException e) {
			System.err.println("\nFailure to transform: " + e);
			System.err.println(e.getMessage());
		}
	}

	public static String convertToXML(String ediMsg) throws Exception 
	{
		Reader inp = new InputStreamReader(
				(new IOString(ediMsg)).getInputStream());
		IOString res = new IOString();
		Writer out = new OutputStreamWriter(res.getOutputStream());

		EDItoXML theObject = new EDItoXML(inp, out);
		theObject.setNamespaceEnabled(true);
		theObject.setRecover(false);
		theObject.run();
		
		return res.getString();
					 
		/* Commented for Future Usage 
		 System.out.println("----------" + PluginControllerImpl.plugginKey);
		URL url = EDItoXML.class.getResource(PluginControllerImpl.plugginKey);
		//String test= "<?xml version=\"1.0\" encoding=\"UTF-8\"?><ediroot xmlns=\"http://www.berryworkssoftware.com/2008/edireader\"><interchange Standard=\"ANSI X.12\" Date=\"030603\" Time=\"1337\" StandardsId=\"U\" Version=\"00401\" Control=\"000000121\"><sender><address Id=\"D00111         \" Qual=\"ZZ\"/></sender><receiver><address Id=\"0055           \" Qual=\"ZZ\"/></receiver><group GroupType=\"HP\" ApplSender=\"D00111\" ApplReceiver=\"0055\" Date=\"20030603\" Time=\"1337\" Control=\"1210001\" StandardCode=\"X\" StandardVersion=\"004010X091A1\"><transaction DocType=\"835\" Name=\"Health Care Claim Payment/Advice\" Control=\"0001\"><BPR><BPR01>I</BPR01><BPR02>144.68</BPR02><BPR03>C</BPR03><BPR04>CHK</BPR04><BPR16>20030604</BPR16></BPR><TRN><TRN01>1</TRN01><TRN02>123456789</TRN02><TRN03>1386000134</TRN03></TRN><REF><REF01>EV</REF01><REF02>0055</REF02></REF><DTM><DTM01>405</DTM01><DTM02>20030604</DTM02></DTM><l-1000><N1><N101>PR</N101><N102>Department of Community Health</N102></N1><N3><N301>P.O. Box 30479</N301></N3><N4><N401>Lansing</N401><N402>MI</N402><N403>48909</N403></N4><PER><PER01>CX</PER01><PER03>EM</PER03><PER04>providersupport@michigan.gov</PER04><PER05>TE</PER05><PER06>8002922550</PER06></PER></l-1000><l-1000><N1><N101>PE</N101><N102>STEIN FRANK N MD</N102><N103>FI</N103><N104>111223333</N104></N1></l-1000><l-2000><LX><LX01>1</LX01></LX><TS3><TS301>109876543</TS301><TS302>11</TS302><TS303>20031231</TS303><TS304>4</TS304><TS305>453.33</TS305></TS3><l-2100><CLP><CLP01>111111</CLP01><CLP02>1</CLP02><CLP03>240</CLP03><CLP04>35.89</CLP04><CLP06>MC</CLP06><CLP07>0123456789</CLP07></CLP><NM1><NM101>QC</NM101><NM102>1</NM102><NM103>SMITH</NM103><NM104>JANE</NM104><NM108>MR</NM108><NM109>44444444</NM109></NM1><NM1><NM101>82</NM101><NM102>1</NM102><NM103>STEIN</NM103><NM104>FRANK</NM104><NM105>N</NM105><NM107>MD</NM107><NM108>MC</NM108><NM109>109876543</NM109></NM1><DTM><DTM01>232</DTM01><DTM02>20030315</DTM02></DTM><DTM><DTM01>233</DTM01><DTM02>20030315</DTM02></DTM><l-2110><SVC><SVC01><SVC01>HC</SVC01><SVC01>99431</SVC01></SVC01><SVC02>150</SVC02><SVC03>35.89</SVC03><SVC05>1</SVC05></SVC><DTM><DTM01>150</DTM01><DTM02>20030315</DTM02></DTM><DTM><DTM01>151</DTM01><DTM02>20030315</DTM02></DTM><CAS><CAS01>CO</CAS01><CAS02>A2</CAS02><CAS03>114.11</CAS03></CAS><REF><REF01>6R</REF01><REF02>123123001</REF02></REF><LQ><LQ01>HE</LQ01><LQ02>N14</LQ02></LQ></l-2110><l-2110><SVC><SVC01><SVC01>HC</SVC01><SVC01>99238</SVC01></SVC01><SVC02>90</SVC02><SVC03>0</SVC03><SVC05>1</SVC05></SVC><DTM><DTM01>472</DTM01><DTM02>20030315</DTM02></DTM><CAS><CAS01>CO</CAS01><CAS02>B18</CAS02><CAS03>90</CAS03></CAS><REF><REF01>6R</REF01><REF02>123123002</REF02></REF><LQ><LQ01>HE</LQ01><LQ02>MA66</LQ02></LQ></l-2110></l-2100><l-2100><CLP><CLP01>111111</CLP01><CLP02>1</CLP02><CLP03>60</CLP03><CLP04>31.18</CLP04><CLP06>MC</CLP06><CLP07>1234567890</CLP07></CLP><NM1><NM101>QC</NM101><NM102>1</NM102><NM103>SMITH</NM103><NM104>JANE</NM104><NM108>MR</NM108><NM109>44444444</NM109></NM1><NM1><NM101>82</NM101><NM102>1</NM102><NM103>STEIN</NM103><NM104>FRANK</NM104><NM105>N</NM105><NM107>MD</NM107><NM108>MC</NM108><NM109>109876543</NM109></NM1><DTM><DTM01>232</DTM01><DTM02>20030318</DTM02></DTM><DTM><DTM01>233</DTM01><DTM02>20030318</DTM02></DTM><l-2110><SVC><SVC01><SVC01>HC</SVC01><SVC01>99213</SVC01></SVC01><SVC02>60</SVC02><SVC03>31.18</SVC03><SVC05>1</SVC05></SVC><DTM><DTM01>150</DTM01><DTM02>20030318</DTM02></DTM><DTM><DTM01>151</DTM01><DTM02>20030318</DTM02></DTM><CAS><CAS01>CO</CAS01><CAS02>A2</CAS02><CAS03>28.82</CAS03></CAS><REF><REF01>6R</REF01><REF02>123124001</REF02></REF><LQ><LQ01>HE</LQ01><LQ02>N14</LQ02></LQ></l-2110></l-2100><l-2100><CLP><CLP01>111111</CLP01><CLP02>1</CLP02><CLP03>93.33</CLP03><CLP04>46.43</CLP04><CLP06>MC</CLP06><CLP07>2345678901</CLP07></CLP><NM1><NM101>QC</NM101><NM102>1</NM102><NM103>SMITH</NM103><NM104>JANE</NM104><NM108>MR</NM108><NM109>44444444</NM109></NM1><NM1><NM101>82</NM101><NM102>1</NM102><NM103>STEIN</NM103><NM104>FRANK</NM104><NM105>N</NM105><NM107>MD</NM107><NM108>MC</NM108><NM109>109876543</NM109></NM1><DTM><DTM01>232</DTM01><DTM02>20030401</DTM02></DTM><DTM><DTM01>233</DTM01><DTM02>20030401</DTM02></DTM><l-2110><SVC><SVC01><SVC01>HC</SVC01><SVC01>99391</SVC01></SVC01><SVC02>93.33</SVC02><SVC03>46.43</SVC03><SVC05>1</SVC05></SVC><DTM><DTM01>150</DTM01><DTM02>20030401</DTM02></DTM><DTM><DTM01>151</DTM01><DTM02>20030401</DTM02></DTM><CAS><CAS01>CO</CAS01><CAS02>42</CAS02><CAS03>46.90</CAS03></CAS><REF><REF01>6R</REF01><REF02>123125001</REF02></REF><LQ><LQ01>HE</LQ01><LQ02>N14</LQ02></LQ></l-2110></l-2100><l-2100><CLP><CLP01>111111</CLP01><CLP02>1</CLP02><CLP03>60</CLP03><CLP04>31.18</CLP04><CLP06>MC</CLP06><CLP07>3456789012</CLP07></CLP><NM1><NM101>QC</NM101><NM102>1</NM102><NM103>SMITH</NM103><NM104>JANE</NM104><NM108>MR</NM108><NM109>44444444</NM109></NM1><NM1><NM101>82</NM101><NM102>1</NM102><NM103>STEIN</NM103><NM104>FRANK</NM104><NM105>N</NM105><NM107>MD</NM107><NM108>MC</NM108><NM109>109876543</NM109></NM1><DTM><DTM01>232</DTM01><DTM02>20030415</DTM02></DTM><DTM><DTM01>233</DTM01><DTM02>20030415</DTM02></DTM><l-2110><SVC><SVC01><SVC01>HC</SVC01><SVC01>99213</SVC01></SVC01><SVC02>60</SVC02><SVC03>31.18</SVC03><SVC05>1</SVC05></SVC><DTM><DTM01>150</DTM01><DTM02>20030415</DTM02></DTM><DTM><DTM01>151</DTM01><DTM02>20030415</DTM02></DTM><CAS><CAS01>CO</CAS01><CAS02>A2</CAS02><CAS03>28.82</CAS03></CAS><REF><REF01>6R</REF01><REF02>123126001</REF02></REF><LQ><LQ01>HE</LQ01><LQ02>N14</LQ02></LQ></l-2110></l-2100></l-2000></transaction></group></interchange></ediroot>";
		Boolean isValidXML = ValidateXML.validateXMLSchema(url.getPath(), res.getString());
		//Boolean isValidXML = ValidateXML.validateXMLSchema(url.getPath(), test);
		
		
		if(isValidXML == true){
			return res.getString();
		}else{
			return "Failed";
		}*/	
	}
	
	public static String convertToXML(String ediMsg, boolean validate) throws Exception {
		Reader inp = new InputStreamReader(
				(new IOString(ediMsg)).getInputStream());
		IOString res = new IOString();
		Writer out = new OutputStreamWriter(res.getOutputStream());

		EDItoXML theObject = new EDItoXML(inp, out);
		theObject.setNamespaceEnabled(true);
		theObject.setRecover(false);
		theObject.run();
		return res.getString();
	}

	/**
	 * Main for EDItoXML.
	 * 
	 * @param args
	 *            command line arguments
	 */
	public static void main(String args[]) {
		CommandLine commandLine = new CommandLine(args) {
			@Override
			public String usage() {
				return "EDItoXML [inputfile] [-o outputfile] [-n true|false] [-r true|false] [-s ediMsgStr]";
			}
		};
		String inputFileName = commandLine.getPosition(0);
		String outputFileName = commandLine.getOption("o");
		boolean namespaceEnabled = "true".equals(commandLine.getOption("n"));
		boolean recover = "true".equals(commandLine.getOption("r"));

		// Establish input
		Reader inputReader;
		if (inputFileName == null) {
			inputReader = new InputStreamReader(System.in);
		} else {
			try {
				inputReader = new InputStreamReader(new FileInputStream(
						inputFileName), "ISO-8859-1");
			} catch (IOException e) {
				System.out.println(e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}

		// Establish output
		Writer generatedOutput;
		if (outputFileName == null) {
			generatedOutput = new OutputStreamWriter(System.out);
		} else {
			try {
				generatedOutput = new OutputStreamWriter(new FileOutputStream(
						outputFileName), "ISO-8859-1");
				System.out.println("Output file " + outputFileName + " opened");
			} catch (IOException e) {
				System.out.println(e.getMessage());
				throw new RuntimeException(e.getMessage());
			}
		}

		EDItoXML theObject = new EDItoXML(inputReader, generatedOutput);
		theObject.setNamespaceEnabled(namespaceEnabled);
		theObject.setRecover(recover);
		theObject.run();
		
		String s = System.getProperty("line.separator");
		System.out.print(s + "Transformation complete" + s);
	}

	public boolean isNamespaceEnabled() {
		return namespaceEnabled;
	}

	public void setNamespaceEnabled(boolean namespaceEnabled) {
		this.namespaceEnabled = namespaceEnabled;
	}

	public void setRecover(boolean recover) {
		this.recover = recover;
	}

	static class IgnoreSyntaxExceptions implements EDISyntaxExceptionHandler {

		public boolean process(RecoverableSyntaxException syntaxException) {
			System.out.println("Syntax Exception. class: "
					+ syntaxException.getClass().getName() + "  message:"
					+ syntaxException.getMessage());
			// Return true to indicate that you want parsing to continue.
			return true;
		}
	}

}
