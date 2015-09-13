package com.org.edi.util.tools;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Stack;

public class XsdGen {
	private Stack<String> loops;
	private String input;
	private String output;
	private InputStream inputStream;
	private OutputStream outputStream;
	StringBuilder sb = new StringBuilder();

	@SuppressWarnings("unused")
	private XsdGen() {

	}

	public XsdGen(String input, String output) {
		this.setInput(input);
		this.setOutput(output);
		loops = new Stack<String>();
	}

	public String getInput() {
		return input;
	}

	public void setInput(String input) {
		this.input = input;
	}

	public String getOutput() {
		return output;
	}

	public void setOutput(String output) {
		this.output = output;
	}

	public void schemaGen() throws Exception {
		InputStream inputFile = null;
		OutputStream outputFile = null;
		try {
			inputFile = new FileInputStream(input);
			outputFile = new FileOutputStream(output);

			schemaGen(inputFile, outputFile);
		} finally {
			if (inputFile != null)
				inputFile.close();
			if (outputFile != null)
				outputFile.close();
		}
	}

	private String readLine() {
		String str = "";
		int i;
		char c;

		try {
			do {
				i = inputStream.read();
				c = (char) i;
				if (i != -1)
					str = str + c;
			} while (i != -1 && c != '\r');
		} catch (IOException e) {
			e.printStackTrace();
		}
		return str;
	}

	private void schemaGen(InputStream inputStream, OutputStream outputStream) throws IOException {
		this.inputStream = inputStream;
		this.outputStream = outputStream;
		String str;
		EdiMetaInfo ediMeta = null;
		EdiMetaInfo prevEdiMeta = null;

		schemaHeader();
		str = this.readLine();
		while (!str.isEmpty()) {
			ediMeta = new EdiMetaInfo(str);
			if (!ediMeta.isNull()) {

				if (ediMeta.getCategory().toLowerCase().equals("loop")) {
					if (prevEdiMeta != null && prevEdiMeta.getCategory().equalsIgnoreCase("element")) {
						endSegment();
					}
					if (prevEdiMeta != null && prevEdiMeta.getCategory().equalsIgnoreCase("sub-element")) {
						endElement(true);
						endSegment();
					}
					if (ediMeta.getIsStart().equalsIgnoreCase("start")) {
						startLoop(ediMeta.getLseName(), ediMeta);
					} else if (ediMeta.getIsStart().equalsIgnoreCase("end")) {
						endLoop(ediMeta.getLseName());
					}
				}

				if (ediMeta.getCategory().toLowerCase().equals("segment")) {
					if (prevEdiMeta != null && prevEdiMeta.getCategory().equalsIgnoreCase("element")) {
						endSegment();
					}
					if (prevEdiMeta != null && prevEdiMeta.getCategory().equalsIgnoreCase("sub-element")) {
						endElement(true);
						endSegment();
					}
					startSegment(ediMeta.getLseDesc(), ediMeta);
				}

				if (ediMeta.getCategory().toLowerCase().equals("element")) {
					if (prevEdiMeta != null && prevEdiMeta.getCategory().equalsIgnoreCase("sub-element")) {
						endElement(true);
					}

					if (!ediMeta.getDataType().equalsIgnoreCase("comp")) {
						startElement(/* ediMeta.getLseName() + "_" + */ediMeta.getLseDesc(), ediMeta);
						endElement();
					} else if (ediMeta.getDataType().equalsIgnoreCase("comp")) {
						startElement(/* ediMeta.getLseName() + "_" + */ediMeta.getLseDesc(), true, ediMeta);
					}

				}

				if (ediMeta.getCategory().toLowerCase().equals("sub-element")) {
					startElement(ediMeta.getLseName() + "_" + ediMeta.getLseDesc(), ediMeta);
					endElement();
				}

				prevEdiMeta = ediMeta;
			}
			str = this.readLine();
		}
		schemaFooter();
	}

	private void startLoop(String loopName, EdiMetaInfo ediMeta) throws IOException {
		startElement(loopName, true, ediMeta);
	}

	private void startSegment(String segName, EdiMetaInfo ediMeta) throws IOException {
		startElement(segName, true, ediMeta);
	}

	private void startElement(String elementName, EdiMetaInfo ediMeta) throws IOException {
		startElement(elementName, false, ediMeta);
	}

	private void startElement(String elementName, boolean isComplex, EdiMetaInfo ediMeta) throws IOException {
		sb.setLength(0);
		sb.append("<xs:element name=\"").append(schemaElementClean(elementName)).append("\"");
		if (!ediMeta.getLseName().equalsIgnoreCase("ediroot")) {
			sb.append(" minOccurs=\"").append(ediMeta.getMinOccurence()).append("\"");
			sb.append(" maxOccurs=\"").append(ediMeta.getMaxOccurence()).append("\"");
		}
		sb.append(">");
		sb.append("<xs:annotation> <xs:documentation>");
		sb.append(ediMeta.getCategory()).append(" - ").append(ediMeta.getLseName()).append(" - ");
		sb.append(ediMeta.getLseDesc());
		sb.append("</xs:documentation> </xs:annotation>");
		if (isComplex)
			sb.append("<xs:complexType> <xs:sequence>");
		if ((ediMeta.getCategory().equalsIgnoreCase("element") && !ediMeta.getDataType().equalsIgnoreCase("comp"))
				|| ediMeta.getCategory().equalsIgnoreCase("sub-element")) {
			if (ediMeta.getDataType().equalsIgnoreCase("ID") || ediMeta.getDataType().equalsIgnoreCase("AN")
					|| ediMeta.getDataType().equalsIgnoreCase("B") || ediMeta.getDataType().equalsIgnoreCase("DT")
					|| ediMeta.getDataType().equalsIgnoreCase("TM")) {
				sb.append("<xs:simpleType>");
				sb.append("<xs:restriction base=\"").append(ediMeta.getSchemaDataType()).append("\">");
				if (ediMeta.getValidVals().trim().isEmpty() && ediMeta.getPattern().trim().isEmpty()) {
					sb.append("<xs:minLength value=\"").append(ediMeta.getMinLength()).append("\" />");
					sb.append("<xs:maxLength value=\"").append(ediMeta.getMaxLength()).append("\" />");
				} else if (!ediMeta.getValidVals().trim().isEmpty()) {
					String[] validVals = ediMeta.getValidVals().split(",");
					for (int i = 0; i < validVals.length; i++)
						sb.append("<xs:enumeration value=\"").append(validVals[i].trim()).append("\" />");
				} else if (!ediMeta.getPattern().trim().isEmpty()) {
					String[] pattrenVals = ediMeta.getPattern().split(",");
					for (int i = 0; i < pattrenVals.length; i++)
						sb.append("<xs:pattern value=\"").append(pattrenVals[i].trim()).append("\" />");
				}
				sb.append("</xs:restriction> </xs:simpleType>");
			}
			if (ediMeta.getDataType().equalsIgnoreCase("N") || ediMeta.getDataType().equalsIgnoreCase("R")) {
				sb.append("<xs:simpleType>");
				sb.append("<xs:restriction base=\"").append(ediMeta.getSchemaDataType()).append("\">");
				sb.append("<xs:totalDigits value=\"").append(ediMeta.getMaxLength()).append("\" />");
				sb.append("</xs:restriction> </xs:simpleType>");
			}
		}
		outputStream.write(sb.toString().getBytes());
	}

	private void endLoop(String loopName) throws IOException {
		endElement(true);
	}

	private void endSegment() throws IOException {
		endElement(true);
	}

	private void endElement() throws IOException {
		endElement(false);
	}

	private void endElement(boolean isComplex) throws IOException {
		sb.setLength(0);
		if (isComplex)
			sb.append("</xs:sequence> </xs:complexType>");
		sb.append("</xs:element>");
		outputStream.write(sb.toString().getBytes());
	}

	private void schemaHeader() throws IOException {
		sb.setLength(0);
		sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		sb.append("<xs:schema version=\"1.0\" xmlns:xs=\"http://www.w3.org/2001/XMLSchema\">");
		outputStream.write(sb.toString().getBytes());
	}

	private void schemaFooter() throws IOException {
		sb.setLength(0);
		sb.append("</xs:schema>");
		outputStream.write(sb.toString().getBytes());
	}

	private String schemaElementClean(String elementName) {
		return elementName.replace("  ", " ").trim().replace(" ", "_");
	}
}
