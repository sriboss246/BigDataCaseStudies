package com.org.edi.util.tools;

import java.util.LinkedList;

public class EdiMetaQueue<E> {
	private LinkedList<E> list;

	public EdiMetaQueue() {
		list = new LinkedList<E>();
	}

	public void enqueue(E item) {
		list.addLast(item);
	}

	public boolean hasItems() {
		return !list.isEmpty();
	}
	
	public E dequeue() {
		return list.poll();
	}

	public int size() {
		return list.size();
	}

	public void addItems(EdiMetaQueue<? extends E> q) {
		while (q.hasItems())
			list.addLast(q.dequeue());
	}
}