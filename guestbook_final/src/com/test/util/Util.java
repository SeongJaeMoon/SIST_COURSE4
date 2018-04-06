package com.test.util;

import java.util.*;

public class Util {
	/* 사용자 정의 메소드 */
	public static String randomFileName() {
		String[] arr = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
	    Random r = new Random();
	    StringBuilder rndStr = new StringBuilder();
	    for(int i = 0; i < 20; ++i){
	    	rndStr.append(arr[r.nextInt(arr.length)]);
	    }
	    return rndStr.toString();
	}
}
