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

package com.berryworks.edireader;

import com.berryworks.edireader.error.RecoverableSyntaxException;
import com.berryworks.edireader.tokenizer.Token;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import java.io.IOException;

/**
 * Common parent class to several EDIReader subclasses that provide for the
 * parsing of specific EDI standards. This common parent provides an opportunity
 * to factor and share common concepts and logic.
 */
public abstract class StandardReader extends EDIReader {

	/**
	 * Interchange Control Number
	 */
	private String interchangeControlNumber;

	/**
	 * Group-level control number
	 */
	private String groupControlNumber;

	private int groupCount;

	private int documentCount;

	private ReplyGenerator ackGenerator;

	private RecoverableSyntaxException syntaxException;

	protected abstract Token recognizeBeginning() throws IOException,
			SAXException;

	protected abstract Token parseInterchange(Token t) throws SAXException,
			IOException;

	@Override
	public void parse(InputSource source) throws SAXException, IOException {
		if (source == null)
			throw new IOException("parse called with null InputSource");
		if (getContentHandler() == null)
			throw new IOException("parse called with null ContentHandler");

		if (!isExternalXmlDocumentStart())
			startXMLDocument();

		parseSetup(source);

		getTokenizer().setDelimiter(getDelimiter());
		getTokenizer().setSubDelimiter(getSubDelimiter());
		getTokenizer().setRelease(getRelease());
		getTokenizer().setRepetitionSeparator(getRepetitionSeparator());
		getTokenizer().setTerminator(getTerminator());

		try {
			parseInterchange(recognizeBeginning());
		} catch (EDISyntaxException e) {
			if (ackGenerator != null)
				ackGenerator.generateNegativeACK();
			throw e;
		}

		if (!isExternalXmlDocumentStart())
			endXMLDocument();

	}

	/**
	 * Issue SAX calls on behalf of an EDI element. The token passed as an
	 * argument is first token of a field.
	 *
	 * @param t
	 *            the parsed token
	 * @throws SAXException
	 *             for problem emitting SAX events
	 */
	protected void parseSegmentElement(Token t) throws SAXException {
		String elementId = t.getElementId();
		getDocumentAttributes().clear();

		if (t.getType() == Token.TokenType.SIMPLE) {

			String value = t.getValue().trim();
			if (value.length() == 0)
				return;

			/**
			 * Srini - Modification on element creation Commenting Starting of
			 * element and creating a element in different way <element
			 * id="XXX"> to <XXX>
			 */
			// getDocumentAttributes().addCDATA(getXMLTags().getIdAttribute(),
			// elementId);
			// startElement(getXMLTags().getElementTag(),
			// getDocumentAttributes());
			getDocumentAttributes().clear();
			startElement(elementId, getDocumentAttributes());

			char[] cv = t.getValueChars();
			getContentHandler().characters(cv, 0, cv.length);

			/**
			 * Srini - Modification on element ending Commenting ending of
			 * element and ending a element in different way </element> to
			 * </XXX>
			 */
			// endElement(getXMLTags().getElementTag());
			endElement(elementId);

			// if (debug) trace("... SIMPLE element " + elementId);
		} else if ((t.getType() == Token.TokenType.SUB_ELEMENT)
				|| (t.getType() == Token.TokenType.SUB_EMPTY)) {
			if (t.isFirst()) {
				/**
				 * Srini - Modification on element creation Commenting Starting
				 * of element and creating a element in different way <element
				 * id="XXX"> to <XXX>
				 */
				// getDocumentAttributes().addCDATA(getXMLTags().getIdAttribute(),
				// elementId);
				// getDocumentAttributes().addCDATA(getXMLTags().getCompositeIndicator(),
				// "yes");
				// startElement(getXMLTags().getElementTag(),
				// getDocumentAttributes());
				getDocumentAttributes().clear();
				startElement(elementId, getDocumentAttributes());

				// if (debug) trace("... first subelement of a composite");
			}
			if (t.getType() == Token.TokenType.SUB_ELEMENT) {
				getDocumentAttributes().clear();
				// getDocumentAttributes().addAttribute("", getXMLTags()
				// .getSubElementSequence(), getXMLTags()
				// .getSubElementSequence(), "CDATA", String.valueOf(1 + t
				// .getSubIndex()));

				startElement(elementId + String.valueOf(1 + t.getSubIndex()),
						getDocumentAttributes());

				char[] cv = t.getValueChars();
				getContentHandler().characters(cv, 0, cv.length);

				// endElement(getXMLTags().getSubElementTag());
				endElement(elementId + String.valueOf(1 + t.getSubIndex()));
				// if (debug) trace("... subelement");
			}
			if (t.isLast()) {
				// endElement(getXMLTags().getElementTag());
				endElement(elementId);
				// if (debug) trace("... last subelement of a composite");
			}
		}
	}

	/**
	 * Set an override value to be used whenever generating a control date and
	 * time. This method is used for automated testing.
	 *
	 * @param overrideValue
	 *            to be used in lieu of current date and time
	 */
	public void setControlDateAndTime(String overrideValue) {
		getAckGenerator().setControlDateAndTime(overrideValue);
	}

	protected boolean recover(RecoverableSyntaxException e) {
		return getSyntaxExceptionHandler() != null
				&& getSyntaxExceptionHandler().process(e);
	}

	public int getGroupCount() {
		return groupCount;
	}

	public void setGroupCount(int groupCount) {
		this.groupCount = groupCount;
	}

	public String getInterchangeControlNumber() {
		return interchangeControlNumber;
	}

	public void setInterchangeControlNumber(String interchangeControlNumber) {
		this.interchangeControlNumber = interchangeControlNumber;
	}

	public String getGroupControlNumber() {
		return groupControlNumber;
	}

	public void setGroupControlNumber(String groupControlNumber) {
		this.groupControlNumber = groupControlNumber;
	}

	public int getDocumentCount() {
		return documentCount;
	}

	public void setDocumentCount(int documentCount) {
		this.documentCount = documentCount;
	}

	public RecoverableSyntaxException getSyntaxException() {
		return syntaxException;
	}

	public void setSyntaxException(RecoverableSyntaxException syntaxException) {
		this.syntaxException = syntaxException;
	}

	public ReplyGenerator getAckGenerator() {
		return ackGenerator;
	}

	public void setAckGenerator(ReplyGenerator ackGenerator) {
		this.ackGenerator = ackGenerator;
	}

	protected void parseSegment(PluginController pluginController,
			String segmentType) throws SAXException, IOException {
		LoopStack ls = LoopStack.getLoopStack();
		if (pluginController.transition(segmentType)) {
			// First close off any loops that were closed as the result of
			// the transition
			int toClose = pluginController.closedCount();
			if (debug)
				trace("closing " + toClose + " loops");
			for (; toClose > 0; toClose--) {
				/**
				 * Srini - Modification on Loop creation Commenting Starting of
				 * Loop and creating a loop in different way </loop> to </l-XXX>
				 */
				// endElement(getXMLTags().getLoopTag());
				endElement(getXMLTags().getLoopPrefixTag() + ls.pop());
			}

			String s = pluginController.getLoopEntered();
			if (pluginController.isResumed()) {
				// We are resuming some outer loop, so we do not
				// start a new instance of the loop.
			} else {
				/**
				 * Srini - Modification on Loop creation Commenting Starting of
				 * Loop and creating a loop in different way <loop id="XXX"> to
				 * <l-XXX>
				 */
				getDocumentAttributes().clear();
				// getDocumentAttributes().addCDATA(getXMLTags().getIdAttribute(),
				// s);
				// startElement(getXMLTags().getLoopTag(),
				// getDocumentAttributes());
				startElement(getXMLTags().getLoopPrefixTag() + s,
						getDocumentAttributes());
				ls.push(s);
				/**
				 * Make an entry into stack.
				 */

			}
		}

		/**
		 * Srini - Modification on Segment creation Commenting Starting of
		 * Segment and creating a segment in different way <segment id="XXX"> to
		 * <XXX>
		 */
		getDocumentAttributes().clear();
		// getDocumentAttributes().addCDATA(getXMLTags().getIdAttribute(),
		// segmentType);
		// startElement(getXMLTags().getSegTag(), getDocumentAttributes());
		startElement(getXMLTags().getSegPrefixTag() + segmentType,
				getDocumentAttributes());

		Token t;
		while ((t = getTokenizer().nextToken()).getType() != Token.TokenType.SEGMENT_END) {

			switch (t.getType()) {
			case SIMPLE:
			case EMPTY:
			case SUB_ELEMENT:
			case SUB_EMPTY:
				break;

			case END_OF_DATA:
				throw new EDISyntaxException(UNEXPECTED_EOF, getTokenizer());

			default:
				throw new EDISyntaxException(MALFORMED_EDI_SEGMENT,
						getTokenizer());

			}

			parseSegmentElement(t);
		}

		/**
		 * Srini - Modification on Segment ending Commenting ending of Segment
		 * and creating a Segment in different way </segment> to </XXX>
		 */
		// endElement(getXMLTags().getSegTag());
		endElement(getXMLTags().getSegPrefixTag() + segmentType);
	}
}
