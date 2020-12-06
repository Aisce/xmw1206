/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: BwTFEcRvTpTWiE7TEMdXAG0oJESBFWyM
 */
package net.shopxx.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * Utils - 生成表格工具类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public final class Text {
	
	public static void upload(String path1) {
		String path = "D:/sys/";
		File file = new File(path);
		
		if (!file.exists()) {
			// 创建文件夹
			file.mkdirs();
		} 
		//上传文件
		byte[] buf = new byte[1024];
		try {
			InputStream fis = new FileInputStream(path1);
			OutputStream fos = new FileOutputStream(file);
			int readLen = -1;
			while ((readLen = fis.read(buf)) != -1) {
				fos.write(buf, 0, readLen);
			}
			fis.close();
			fos.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	//上传文件
	public static void main(String[] args) {
		upload("C:/Users/Administrator/Desktop/lqkj.zip");
	}
}