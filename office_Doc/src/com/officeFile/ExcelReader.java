package com.officeFile;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javafx.scene.control.Cell;

import org.apache.poi.POIOLE2TextExtractor;
import org.apache.poi.POITextExtractor;
import org.apache.poi.hpsf.extractor.*;
import org.apache.poi.hssf.eventusermodel.HSSFEventFactory;
import org.apache.poi.hssf.eventusermodel.HSSFListener;
import org.apache.poi.hssf.eventusermodel.HSSFRequest;
import org.apache.poi.hssf.extractor.ExcelExtractor;
import org.apache.poi.hssf.record.BOFRecord;
import org.apache.poi.hssf.record.BoundSheetRecord;
import org.apache.poi.hssf.record.LabelSSTRecord;
import org.apache.poi.hssf.record.NumberRecord;
import org.apache.poi.hssf.record.Record;
import org.apache.poi.hssf.record.RowRecord;
import org.apache.poi.hssf.record.SSTRecord;
import org.apache.poi.hssf.record.crypto.Biff8EncryptionKey;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.crypt.Decryptor;
import org.apache.poi.poifs.crypt.EncryptionInfo;
import org.apache.poi.poifs.filesystem.NPOIFSFileSystem;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.eventusermodel.XSSFReader;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.POITextExtractor;
/**
 * This example shows how to use the event API for reading a file.
 */
public class ExcelReader
       
{
   
	
	 NPOIFSFileSystem np ;
	 FileInputStream fin1;
	 EncryptionInfo info;
	 Decryptor d;
	 String pwd;
	 XSSFWorkbook wb;
	 XSSFSheet xsheet;
	 
	 
	 
	 public ExcelReader(String pwdp) throws IOException
	 {
		 
		 fin1 = new FileInputStream("/F:/MyData/MY_FILES/My_Creds.xlsx");
		    np= new  NPOIFSFileSystem(fin1);
	         info = new EncryptionInfo(np);
	         d= Decryptor.getInstance(info);
	         pwd=pwdp;
	         wb=null;
	         xsheet=null;
	         System.out.println(pwd+"****");
		  }
	 
	 

    /**
     * This method returns entire row by taking key as argument
     */
        
    public String getRecord(String searchKey){
    	
    	String rowValue=searchKey+" "+getSheetMap().get(searchKey);
    	return rowValue;
    }
    
    
/**
 * This method displays contents of the sheet 
 * 
 * */    
    
    public void displaySheet(){
    	
      Map sheetMap = getSheetMap();
      
      Set keys=sheetMap.keySet();
      Iterator keyItr=keys.iterator();      
      String key;
      while(keyItr.hasNext())
      {
    	 key=(String)keyItr.next();
    	 System.out.println("=============================================");
    	System.out.println(key+"--------"+sheetMap.get(key));  
    	System.out.println("===============================================");
       }
      
}

/**
 * @author sridhr
 * getSheetMap() - This method returns Map of key of first col 
 * and value as other column contents from the sheet
 * */
    
    public Map getSheetMap()
     {
       	Map sheetValues = new HashMap();
    	XSSFCell cellContent=null;
    	Iterator rows = xsheet.iterator();
    	int index=0;
    	String content=null,key=null;
    	DataFormatter df=new DataFormatter();
    	while(rows.hasNext()){
    		
    		Row row = (Row)rows.next();
    		Iterator cells = row.cellIterator();
    		index=0;
    		while(cells.hasNext()){
    			cellContent = (XSSFCell)cells.next();
    			
    			if(index==0)
    			{
    				key = df.formatCellValue(cellContent);
    				
    			  }
    			else 
    			{
    				
    				content += df.formatCellValue(cellContent).replaceAll("null", "")+" ";
    			 }
    			index++;
    		}
    		sheetValues.put(key, content);
    		content="";
    	}
    	
    	return  sheetValues;
    }
    
    
    
    /**
     * This method authenticates or read excel file with given security key 
     */
    
    public boolean authenticate() throws IOException
     {
    	
    	 try {
			   if(d.verifyPassword(this.pwd))
			    {
				  wb=new XSSFWorkbook(d.getDataStream(np));
				  xsheet=wb.getSheetAt(0);
		        	return true;	 
				 }
			
			 else 
				 return false;
		} 
    	 catch (GeneralSecurityException e) 
    	   {
			// TODO Auto-generated catch block
			e.printStackTrace();
		    return false;	
		  }
   	
    }
    
    
    
    public static void main(String[] args) throws IOException, OpenXML4JException, GeneralSecurityException
    {
    	
    	BufferedReader br=new BufferedReader(new InputStreamReader(System.in));
    	String inputPwd = br.readLine();
    	
    	ExcelReader er = new ExcelReader(inputPwd);
    	er.authenticate();
    	//System.out.println(er.getRecord("HDFC personal Loan"));
    	//er.displaySheet();
       
    }
}