package com.org.edi.util.tools;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Stack;

public class XslGen {
	private Stack<EdiMetaInfo> loops;
	private String input;
	private String output;
	private InputStream inputStream;
	private OutputStream outputStream;
	private StringBuilder sb = new StringBuilder();
	private EdiMetaInfo prevEdiMeta = null;
	private HashMap<String, LinkedHashMap<String, EdiNode>> xslTemplates;
	private String xPathVar = "<xsl:variable name=\"xPath\"> <xsl:call-template name=\"getXPath\" /> </xsl:variable>";

	private String absPath;
	private String cond;
	private EdiMetaInfo prevCompEdi;

	@SuppressWarnings("unused")
	private XslGen() {

	}

	public XslGen(String input, String output) {
		this.setInput(input);
		this.setOutput(output);
		loops = new Stack<EdiMetaInfo>();
		xslTemplates = new HashMap<String, LinkedHashMap<String, EdiNode>>();
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

	public void styleGen() throws Exception {
		InputStream inputFile = null;
		OutputStream outputFile = null;
		try {
			inputFile = new FileInputStream(input);
			outputFile = new FileOutputStream(output);
			styleGen(inputFile, outputFile);
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

	private void processNode(EdiMetaInfo ediMeta) throws IOException {
		if (!ediMeta.isNull()) {
			if (ediMeta.getCategory().toLowerCase().equals("loop")) {
				if (prevEdiMeta != null && prevEdiMeta.getCategory().equalsIgnoreCase("element")) {
					endSegment();
				}
				if (prevEdiMeta != null && prevEdiMeta.getCategory().equalsIgnoreCase("sub-element")) {
					endElement();
					endSegment();
				}
				if (ediMeta.getIsStart().equalsIgnoreCase("start")) {
					startLoop(ediMeta);
				} else if (ediMeta.getIsStart().equalsIgnoreCase("end")) {
					endLoop(ediMeta.getLseName());
				}
			}

			if (ediMeta.getCategory().toLowerCase().equals("segment")) {
				if (prevEdiMeta != null && prevEdiMeta.getCategory().equalsIgnoreCase("element")) {
					endSegment();
				}
				if (prevEdiMeta != null && prevEdiMeta.getCategory().equalsIgnoreCase("sub-element")) {
					endElement();
					endSegment();
				}
				startSegment(ediMeta);
			}

			if (ediMeta.getCategory().toLowerCase().equals("element")) {
				if (prevEdiMeta != null && prevEdiMeta.getCategory().equalsIgnoreCase("sub-element")) {
					endElement();
				}

				if (!ediMeta.getDataType().equalsIgnoreCase("comp")) {
					startElement(ediMeta);
					endElement();
				} else if (ediMeta.getDataType().equalsIgnoreCase("comp")) {
					startElement(ediMeta);
					prevCompEdi = ediMeta;
				}
			}

			if (ediMeta.getCategory().toLowerCase().equals("sub-element")) {
				startSubElement(ediMeta);
				endSubElement();
			}
			prevEdiMeta = ediMeta;
		}
	}

	private void styleGen(InputStream inputStream, OutputStream outputStream) throws IOException {
		this.inputStream = inputStream;
		this.outputStream = outputStream;
		String str;
		EdiMetaInfo ediMeta = null;

		styleHeader();
		str = this.readLine();
		while (!str.isEmpty()) {
			ediMeta = new EdiMetaInfo(str);
			if (!ediMeta.isNull()) {
				processNode(ediMeta);
			}
			str = this.readLine();
		}
		emitContent();
		styleFooter();
		outputStream.flush();
	}

	private void emitContent() throws IOException {
		sb.setLength(0);
		for (Map.Entry<String, LinkedHashMap<String, EdiNode>> entry : xslTemplates.entrySet()) {
			sb.append("<xsl:template match=\"").append(entry.getKey()).append("\">");
			sb.append(xPathVar).append("<xsl:choose>");
			for (Map.Entry<String, EdiNode> subEntry : entry.getValue().entrySet())
				sb.append(subEntry.getValue().toString());
			sb.append("<xsl:otherwise> ");
			sb.append("<xsl:copy> <xsl:apply-templates select=\"node()|@*\" /></xsl:copy> ");
			sb.append("</xsl:otherwise>");
			sb.append("</xsl:choose></xsl:template>");
		}
		outputStream.write(sb.toString().getBytes());
	}

	private void startLoop(EdiMetaInfo ediMeta) throws IOException {
		LinkedHashMap<String, EdiNode> entry;
		String key = null;
		loops.push(ediMeta);
		if (!ediMeta.getLseName().equalsIgnoreCase("ediroot")) {
			absPath = getXPath();
			cond = ediMeta.getConditions();
			sb.append("<").append(ediMeta.getLseName()).append(">");
			sb.append("<xsl:apply-templates select=\"node()|@*\" />");
			sb.append("</").append(ediMeta.getLseName()).append(">");

			EdiNode ein = new EdiNode(absPath, cond, sb.toString());
			if (xslTemplates.containsKey(ediMeta.getElementName()))
				entry = xslTemplates.get(ediMeta.getElementName());
			else
				entry = new LinkedHashMap<String, EdiNode>();
			key = absPath + (cond.isEmpty() ? "" : "$" + cond);
			entry.put(key, ein);
			xslTemplates.put(ediMeta.getElementName(), entry);
		}
	}

	private String getLoopCondition() {
		EdiMetaInfo emi = loops.peek();
		return emi.getLoopConditions();
	}

	private void startSegment(EdiMetaInfo ediMeta) throws IOException {
		sb.setLength(0);
		String loopCond = getLoopCondition();
		loops.push(ediMeta);
		absPath = getXPath();
		cond = ediMeta.getConditions();
		if (!loopCond.trim().isEmpty()) {
			if (!cond.isEmpty())
				cond = cond + " and " + loopCond;
			else
				cond = loopCond;
		}
		sb.append("<" + styleElementClean(ediMeta.getLseDesc().trim()) + ">");
	}

	private void startElement(EdiMetaInfo ediMeta) throws IOException {
		loops.push(ediMeta);
		sb.append("<xsl:if test=\"").append(ediMeta.getLseName().trim()).append("\">");
		if (ediMeta.getDataType().trim().equalsIgnoreCase("comp")) {
			sb.append("<" + styleElementClean(ediMeta.getLseDesc().trim()) + ">");
		} else {
			sb.append("<" + styleElementClean(ediMeta.getLseDesc().trim()) + ">");
			sb.append("<xsl:value-of select=\"").append(ediMeta.getLseName()).append("\"/>");
		}
	}

	private void startSubElement(EdiMetaInfo ediMeta) throws IOException {
		loops.push(ediMeta);
		sb.append("<xsl:if test=\"");
		sb.append(prevCompEdi.getLseName()).append("/").append(ediMeta.getLseName().trim());
		sb.append("\">");
		sb.append("<" + styleElementClean(ediMeta.getLseDesc().trim()) + ">");
		sb.append("<xsl:value-of select=\"");
		sb.append(prevCompEdi.getLseName()).append("/").append(ediMeta.getLseName());
		sb.append("\"/>");
	}

	private void endLoop(String loopName) throws IOException {
		EdiMetaInfo ediMeta = (EdiMetaInfo) loops.pop();
	}

	private void endSegment() throws IOException {
		LinkedHashMap<String, EdiNode> entry;
		String key = null;
		EdiMetaInfo ediMeta = (EdiMetaInfo) loops.pop();

		sb.append("</" + styleElementClean(ediMeta.getLseDesc().trim()) + ">");
		EdiNode ein = new EdiNode(absPath, cond, sb.toString());
		if (xslTemplates.containsKey(ediMeta.getElementName()))
			entry = xslTemplates.get(ediMeta.getElementName());
		else
			entry = new LinkedHashMap<String, EdiNode>();
		key = absPath + (cond.isEmpty() ? "" : "$" + cond);
		entry.put(key, ein);
		xslTemplates.put(ediMeta.getElementName(), entry);

		absPath = "";
		cond = "";
		sb.setLength(0);
	}

	private void endElement() throws IOException {
		EdiMetaInfo ediMeta = (EdiMetaInfo) loops.pop();
		sb.append("</" + styleElementClean(ediMeta.getLseDesc().trim()) + ">");
		sb.append("</xsl:if>");
	}

	private void endSubElement() throws IOException {
		EdiMetaInfo ediMeta = (EdiMetaInfo) loops.pop();
		sb.append("</" + styleElementClean(ediMeta.getLseDesc().trim()) + ">");
		sb.append("</xsl:if>");
	}

	private void styleHeader() throws IOException {
		sb.setLength(0);
		sb.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		sb.append("<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">");
		sb.append("<xsl:output method=\"xml\" indent=\"yes\" />");
		sb.append("<xsl:template name=\"getXPath\">");
		sb.append("<xsl:for-each select=\"parent::*\">");
		sb.append("<xsl:call-template name=\"getXPath\" />");
		sb.append("</xsl:for-each>");
		sb.append("<xsl:value-of select=\"concat('/',name())\" />");
		sb.append("</xsl:template>");
		sb.append("<xsl:template match=\"node()|@*\">");
		sb.append("<xsl:copy>").append("<xsl:apply-templates select=\"node()|@*\" />").append("</xsl:copy>");
		sb.append("</xsl:template>");
		outputStream.write(sb.toString().getBytes());
	}

	private void styleFooter() throws IOException {
		sb.setLength(0);
		sb.append("</xsl:stylesheet>");
		outputStream.write(sb.toString().getBytes());
	}

	private String styleElementClean(String elementName) {
		return elementName.replace("  ", " ").trim().replace(" ", "_");
	}

	private String getXPath() {
		EdiMetaInfo stEntry;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < loops.size(); i++) {
			stEntry = (EdiMetaInfo) loops.get(i);
			sb.append("/").append(styleElementClean(stEntry.getElementName()));
		}
		return sb.toString();
	}

}
