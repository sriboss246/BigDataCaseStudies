package com.file_comparator.module;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import difflib.*;

class FileCompOpr{
	
	
	
	public FileCompOpr(){
		
		System.out.println("Application has initialized");
	}
	
	public void compareFileList(String sourceDir,String targetDir){
		
		File srcDir = new File(sourceDir);
		File trgDir = new File(targetDir);
		String srcDirname = srcDir.getName();
		String trgDirname = trgDir.getName();
		HashMap<String,String> srcFileMap = new HashMap();
		HashMap<String,String> trgFileMap = new HashMap();
		
	 if(srcDir.isDirectory() && trgDir.isDirectory())
	  {
		
			 
		System.out.println(srcDirname+" "+trgDirname);
		File[] srcFileList = srcDir.listFiles();
		File[] targetFileList = trgDir.listFiles();
		List<File> srcSet = new ArrayList(Arrays.asList(srcFileList));
		List<File> trgSet = new ArrayList(Arrays.asList(targetFileList));
		
		
		for(File sfile: srcSet){
			if(sfile.isFile())
			srcFileMap.put(sfile.getName(),sfile.getAbsolutePath());
		}
		
		
		for(File trgFile: trgSet){
			if(trgFile.isFile())
			trgFileMap.put(trgFile.getName(),trgFile.getAbsolutePath());
			
		}
		
	     Set<String> mset=srcFileMap.keySet();
	     
	     for(String fkey : mset)
	     {
	    	 
            if(fkey.contains(".jar"))
             {
	    		  continue;
	    	   }
            
	    	 if(!trgFileMap.containsKey(fkey))
	    	 {
	    		 System.out.println("$Target doesnot have the matching file ... exiting-- missing file : "+ fkey +" Src Location:"+srcFileMap.get(fkey));
	    	     System.exit(-1);
	    	   }
	    	 
	    	
	    	 
	    	 List<String> flist = fileToLines(srcFileMap.get(fkey));
	    	 
	    	List<String> tflist = fileToLines(trgFileMap.get(fkey));
	    	
	    	Patch patch = DiffUtils.diff(flist, tflist);

            for (Delta delta: patch.getDeltas()) {
                System.out.println(delta);
                System.out.println("#"+srcFileMap.get(fkey) + "Is mismatching...between source and target");
            }
	    	 
            if(patch.getDeltas().isEmpty()){
            	
            	System.out.println("*Content is matching between source:"+srcFileMap.get(fkey)+" and destination:"+trgFileMap.get(fkey) );
              }
	       }
	 	
	  }
	}
	
	
	private List<String> fileToLines(String filename) {
	    List<String> lines = new LinkedList<String>();
	    String line = "";
	    try {
	        BufferedReader in = new BufferedReader(new FileReader(filename));
	        while ((line = in.readLine()) != null) {
	            lines.add(line);
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    return lines;
	}
	
 public List<String> getDirList(String filePath) throws IOException{
		
		BufferedReader br= new BufferedReader(new FileReader(filePath));
		List<String> dirList = new ArrayList();
		String line = br.readLine();
		dirList.add(line);
		while(line != null){
			
			line=br.readLine();
			
			if(line==null)
				break;
			
			dirList.add(line);
		}
		
		return dirList;
		
	}
}

public class FilesComp {
	
	public static void main(String...args) throws IOException{
		
		String srcListPath = args[0];
		String trgListPath = args[1];
		String srcDir = args[2];
		String trgDir = args[3];
		
		FileCompOpr fo = new FileCompOpr();
		List<String> srcDirList = fo.getDirList(srcListPath);
		List<String> trgDirList = fo.getDirList(trgListPath);
		
		for(int i=0;i<srcDirList.size();i++)
		 {
			
			String srcPath = srcDir+"\\"+srcDirList.get(i);
			String trgPath = trgDir+"\\"+trgDirList.get(i);
		    fo.compareFileList(srcPath, trgPath);
		}		
		
		System.out.println("File comparator is completed...");
	}

}
