package com.berryworks.edireader.demo;

import java.io.InputStream;
import java.io.OutputStream;

public class IOString {
    private StringBuffer buf;

    /** Creates a new instance of IOString */
    public IOString() {
           buf = new StringBuffer();
    }

    public IOString(String text) {
           buf = new StringBuffer(text);
    }

    public InputStream getInputStream() {
           return new IOString.IOStringInputStream();
    }

    public OutputStream getOutputStream() {
           return new IOString.IOStringOutputStream();
    }

    public String getString() {
           return buf.toString();
    }

    class IOStringInputStream extends java.io.InputStream {
           private int position = 0;

           public int read() throws java.io.IOException {
                  if (position < buf.length()) {
                        return buf.charAt(position++);
                  } else {
                        return -1;
                  }
           }
    }

    class IOStringOutputStream extends java.io.OutputStream {
           public void write(int character) throws java.io.IOException {
                  buf.append((char) character);
           }

    }

}
