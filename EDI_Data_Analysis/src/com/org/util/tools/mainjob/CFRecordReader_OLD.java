package com.org.util.tools.mainjob;

import java.io.IOException;

import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.InputSplit;
import org.apache.hadoop.mapreduce.RecordReader;
import org.apache.hadoop.mapreduce.TaskAttemptContext;
import org.apache.hadoop.mapreduce.lib.input.CombineFileSplit;
import org.apache.hadoop.util.LineReader;

public class CFRecordReader_OLD extends RecordReader<Text, Text> {
	// private static final Log LOG = LogFactory.getLog(CFRecordReader.class);
	private long startOffset;
	private long end;
	private long pos;
	private FileSystem fs;
	private Path path;
	//private LongWritable key;
	private Text key;
	private Text value;
	// private Text fileEndValue;
	private StringBuffer sb = new StringBuffer();
	private FSDataInputStream fileIn;
	private LineReader reader;
	private String strValue;
	private String isaHeader;
	private String isaTailer;
	private String gsHeader;
	private String gsTailer;
	private Integer geCount = 0;
	private Integer stCount = 0;
	
	//Constants
	

	public CFRecordReader_OLD(CombineFileSplit split, TaskAttemptContext context,
			Integer index) throws IOException {
		this.path = split.getPath(index);
		fs = this.path.getFileSystem(context.getConfiguration());
		this.startOffset = split.getOffset(index);
		this.end = startOffset + split.getLength(index);
		fileIn = fs.open(path);
		reader = new LineReader(fileIn);
		this.pos = startOffset;
	}

	@Override
	public void initialize(InputSplit arg0, TaskAttemptContext arg1)
			throws IOException, InterruptedException {
		// Won't be called, use custom Constructor

		// `CFRecordReader(CombineFileSplit split, TaskAttemptContext context,

		// Integer index)`

		// instead

	}

	@Override
	public void close() throws IOException {

	}

	@Override
	public float getProgress() throws IOException {
		if (startOffset == end) {
			return 0;
		}
		return Math
				.min(1.0f, (pos - startOffset) / (float) (end - startOffset));
	}

	@Override
	public Text getCurrentKey() throws IOException,
			InterruptedException {
		return key;
	}

	@Override
	public Text getCurrentValue() throws IOException, InterruptedException {
		return value;
	}

	@Override
	public boolean nextKeyValue() throws IOException {
		if (key == null) {
			key = new Text();
			// key.fileName = path.getName();
		}

		//key.set(pos);
		if (value == null) {
			value = new Text();
		}

		int newSize = 0;
		int ediRecSize = 0;

		// ================================================ Modified
		sb.setLength(0);
		value.set("");
		while ((pos < end) && !value.toString().contains("SE*")) {
			newSize = reader.readLine(value);
			pos += newSize;
			ediRecSize += newSize;
			strValue = value.toString();

			if (strValue.contains("ISA*")) {// ----> Getting ISA Header
				isaHeader = strValue;
				isaTailer = strValue.split("\\*")[13] + "~";
				key.set(isaTailer);
				isaTailer = "IEA*1*" + isaTailer;
				geCount = 0;
			} else if (strValue.contains("GS*")) { // ----> Getting GS Header
				gsHeader = strValue;
				gsTailer = strValue.split("\\*")[6];
				key.set(key.toString() + gsTailer);
				gsTailer = "GE*1*" + gsTailer + "~";
				geCount += 1;
				stCount = 0;
			} else if (strValue.contains("GE*")) {// ----> Validating ST count
													// in each GS
				if (Integer.parseInt((strValue.split("\\*")[1])) != stCount) {
					sb.append("*#Incorrect Transaction Count. Details: File Name - " + path.getName()  + ", " + isaHeader  + ", " + gsHeader);
				}
			} else if (strValue.contains("IEA*")) {// ----> Validating ST count
													// in each IEA
				if (Integer.parseInt((strValue.split("\\*")[1])) != geCount) {
					sb.append("*#Incorrect Group Count. Details: File Name - " + path.getName() + ", " + isaHeader);
				}
			} else {
				sb.append(strValue);
			}
		}

		if (sb.toString().contains("*#Incorrect")) {
			value.set(sb.toString());
		} else if (sb.length() > 0) {
			value.set(isaHeader + gsHeader + sb.toString() + gsTailer
					+ isaTailer);
		} else {
			value.set("");
		}
		stCount += 1;
		// ================================================ End Modified

		if (ediRecSize == 0) {
			key = null;
			value = null;
			return false;
		} else {
			return true;
		}
	}
}
