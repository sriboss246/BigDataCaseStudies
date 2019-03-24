package com.officeFile;

import java.awt.Event;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

import javax.swing.*;

public class OfficeSecureInterface implements ActionListener{
	
	
	    JFrame f,f1,f2;
	    JButton b;  
	    //JTextField tf ;
	    JPasswordField tf;
	    JLabel jl;
	    JLabel jl2;
	    ExcelReader er;
	    
	    public OfficeSecureInterface(){
			
	    	f=new JFrame("My***Secure");  
		    b=new JButton("Enter"); 
	    	jl=new JLabel("Key:");
	    
	    	 jl2= new JLabel();
			jl2.setBounds(100, 180,90, 50);
			f.add(jl2);
		    tf= new JPasswordField();
		    
		    jl.setBounds(30,90,100,30);
	    	tf.setBounds(90,90, 100, 30);
		    b.setBounds(100,140,70,20); 
		    
		    f.add(jl);
		    f.add(b);  
		    f.add(tf);
		    f.setSize(400,400);  
		    f.setLayout(null);  
		    f.setVisible(true);
		    b.addActionListener(this);
		
	}
	
	public static void main(String[] args) {  
	  
	    	new OfficeSecureInterface();
	}    	
	
	public void actionPerformed(ActionEvent e) {
	      
	
		
		String pwd = new String(tf.getPassword());
		System.out.println(pwd);
		//jl2.setText(pwd);
		try {
			er = new ExcelReader(pwd.trim());
			f.getContentPane().removeAll();
			f.getContentPane().repaint();
			f.add(jl2);
			if(er.authenticate()){
				
				System.out.println("auth");
				jl2.setText("password authentic");
			}
			else {
				
				System.out.println("not auth");
				jl2.setText("password not authentic");
			}
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
				
			}
	    
	  

}
