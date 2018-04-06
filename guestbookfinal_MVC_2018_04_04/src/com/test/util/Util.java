package com.test.util;

import java.util.*;

public class Util {
	
	public static String randFileName() {
		
		StringBuilder sb = new StringBuilder();
	    Random r = new Random();
	    
	    String[] srand = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", 
	    		"m", "n", "o", "p", "q", "r", "s", "t", "u", "y", "z", "x","!", 
	    		"1","2","3","4","5","6","7","8","9","0" };
	    int len = srand.length;
	    for(int i = 0; i < 20; ++i){
	    	sb.append(srand[r.nextInt(len)]);
	    }
	    return sb.toString(); 
	}
	
}
