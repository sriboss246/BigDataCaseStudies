package com.berryworks.edireader;

import java.util.ArrayList;

public class LoopStack {

	public static LoopStack ls = null;
	private ArrayList<String> lsLis = new ArrayList<String>();

	private LoopStack() {

	}

	public static LoopStack getLoopStack() {
		if (ls == null) {
			ls = new LoopStack();
			ls.push("root");
		}
		return ls;
	}

	public void push(String str) {
		lsLis.add(str);
	}

	public String pop() {
		String res = lsLis.get(lsLis.size()-1);
		lsLis.remove(lsLis.size()-1);
		return res;
	}

	public String getLoop(int index) {
		return lsLis.get(index);
	}

	public ArrayList<String> getLoop() {
		return lsLis;
	}
}
