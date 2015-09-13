package com.cts.util.tools.mainjob;

public final class Constants {
	private Constants() {
		// restrict instantiation
	}
	
	//CFRecordReader Related Contants
	public static final String ISA_START = "ISA*";
	public static final String ISA_END = "IEA*";
	public static final String ISA_VAL_DELIM = "\\*";
	public static final Integer ISA_NUM_INDEX = 13;
	public static final String ISA_TAILER_PREFIX = "IEA*1*";
	
	public static final String GS_START = "GS*";
	public static final String GS_END = "GE*";
	public static final String GS_VAL_DELIM = "\\*";
	public static final Integer GS_NUM_INDEX = 6;
	public static final String GS_TAILER_PREFIX = "GE*1*";
	
	public static final String INCORRECT_TC_CNT_MSG = "*#Incorrect Transaction Count. Details: File Name - ";
	public static final String INCORRECT_GS_CNT_MSG = "*#Incorrect Group Count. Details: File Name - ";
	public static final String CHECK_TEXT = "*#Incorrect";
	
	public static final String FAILED_TEXT = "Failed";
}
