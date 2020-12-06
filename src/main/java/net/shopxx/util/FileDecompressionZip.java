/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: BwTFEcRvTpTWiE7TEMdXAG0oJESBFWyM
 */
package net.shopxx.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.model.FileHeader;

/**
 * Utils - 解压工具类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public class FileDecompressionZip{
	/**
	 * 解压zip文件
	 * 
	 * @author 诛仙
	 * @param sourceFile,待解压的zip文件; toFolder,解压后的存放路径
	 * @return 
	 * @throws Exception
	 **/
	public String zipToFile(String sourceFile, String toFolder) throws Exception {

		System.out.println("--sourceFile--"+sourceFile);
		String toDisk = toFolder;// 接收解压后的存放路径
		ZipFile zfile = new ZipFile(sourceFile);// 连接待解压文件 "utf-8"会乱码
		zfile.setFileNameCharset("gbk");
		if (zfile.isEncrypted()) {
			zfile.setPassword("lq!@#$qwer4321");
		}
		List fileHeaders = zfile.getFileHeaders();
		String fileName = "";
		byte[] buf = new byte[1024];
		for (Object obj : fileHeaders) {
			FileHeader fileHeader = (FileHeader) obj;
			String name = fileHeader.getFileName();
			String suffix = name.substring(name.lastIndexOf(".") + 1);
			if (suffix.equals("xls") || suffix.equals("xlsx")) {
				fileName = name;
			}
			String destFile = toDisk + name;
			InputStream inputStream = null;
			OutputStream fileOutputStream = null;
			try {
				inputStream = zfile.getInputStream(fileHeader);
				fileOutputStream = new FileOutputStream(destFile);
				int readLen = -1;
				while ((readLen = inputStream.read(buf)) != -1) {
					fileOutputStream.write(buf, 0, readLen);
				}
			}catch (Exception e) {
				// TODO: handle exception
				// log.info("解压失败："+e.toString());
				throw new IOException("解压失败：" + e.toString());
			}finally {
				if (inputStream != null) {
					try {
						inputStream.close();
					} catch (IOException ex) {
						ex.printStackTrace();
					}
				}
				if (fileOutputStream != null) {
					try {
						fileOutputStream.close();
					} catch (IOException ex) {
						ex.printStackTrace();
					}
				}
				inputStream = null;
				fileOutputStream = null;
			}
		}
		return fileName;
	}
}