/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: BwTFEcRvTpTWiE7TEMdXAG0oJESBFWyM
 */
package net.shopxx.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
/**
 * Utils - 生成表格工具类
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public final class ExcelUtils {
	
	/**
	 *  创建excel表格
	 * @param map
	 * @param strArray
	 */
    public static void createExcel(Map<String, String> map, String[] strArray) {
        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("sheet1");
        sheet.setDefaultColumnWidth(20);// 默认列宽
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        // 创建一个居中格式
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

        // 添加excel title
        HSSFCell cell = null;
        for (int i = 0; i < strArray.length; i++) {
            cell = row.createCell((short) i);
            cell.setCellValue(strArray[i]);
            cell.setCellStyle(style);
        }

        // 第五步，写入实体数据 实际应用中这些数据从数据库得到,list中字符串的顺序必须和数组strArray中的顺序一致
        int i = 0;
        for (String str : map.keySet()) {
            row = sheet.createRow((int) i + 1);
            String string = map.get(str);

            // 第四步，创建单元格，并设置值
            for (int j = 0; j < strArray.length; j++) {
                row.createCell((short) j).setCellValue(string);
            }

            // 第六步，将文件存到指定位置
            try {
                FileOutputStream fout = new FileOutputStream("E:/template/Members.xls");
                wb.write(fout);
                fout.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            i++;
        }
    }
    
    public static void exportExcel(String sheetname, String[] headers,List<Map<String, Object>> list,HttpServletResponse response) {
		// 声明一个工作薄
		HSSFWorkbook workbook = new HSSFWorkbook();
		// 生成一个表格
		HSSFSheet sheet = workbook.createSheet(sheetname);
		// 设置表格默认列宽度为15个字节
		sheet.setDefaultColumnWidth(20);
		// 产生表格标题行
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell=row.createCell(0);
		// 1.生成字体对象  
        HSSFFont font = workbook.createFont();  
        font.setFontHeightInPoints((short) 12);  
        font.setFontName("新宋体");  
        
        // 2.生成样式对象，这里的设置居中样式和版本有关，我用的poi用HSSFCellStyle.ALIGN_CENTER会报错，所以用下面的
        HSSFCellStyle style = workbook.createCellStyle();
//      style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//设置居中样式
        style.setFont(font); // 调用字体样式对象  
        style.setWrapText(true);
        style.setAlignment(HorizontalAlignment.CENTER);//设置居中样式
        
        // 3.单元格应用样式  
        cell.setCellStyle(style); 
        
        //设置单元格内容
        cell.setCellValue(sheetname);
        //合并单元格CellRangeAddress构造参数依次表示起始行，截至行，起始列， 截至列
        sheet.addMergedRegion(new CellRangeAddress(0,0,0,9));
        
        HSSFCell createCell = null;
		
			HSSFRow row1=sheet.createRow(1);
			
			createCell = row1.createCell(0);
			HSSFRichTextString text0 = new HSSFRichTextString(headers[0]);
			createCell.setCellValue(text0);
			
			createCell = row1.createCell(1);
			HSSFRichTextString text1 = new HSSFRichTextString(headers[1]);
			createCell.setCellValue(text1);
			
			createCell = row1.createCell(2);
			HSSFRichTextString text2 = new HSSFRichTextString(headers[2]);
			createCell.setCellValue(text2);
			
			createCell = row1.createCell(3);
			HSSFRichTextString text3 = new HSSFRichTextString(headers[3]);
			createCell.setCellValue(text3);
			
			createCell = row1.createCell(4);
			HSSFRichTextString text4 = new HSSFRichTextString(headers[4]);
			createCell.setCellValue(text4);
		for(int i=0;i<list.size();i++) {
			HSSFRow rowx=sheet.createRow(i+2);
        	Map<String,Object> map = list.get(i);

        	String orderSn = (String) map.get("orderSn");
        	HSSFCell cell00=rowx.createCell(0);
        	cell00.setCellStyle(style);
        	cell00.setCellValue(orderSn);
        	
        	String product = (String) map.get("product");
        	HSSFCell cell01=rowx.createCell(1);
        	cell01.setCellStyle(style);
        	cell01.setCellValue(product);
        	
        	String storename = (String) map.get("storename");
        	HSSFCell cell02=rowx.createCell(2);
        	cell02.setCellStyle(style);
        	cell02.setCellValue(storename);
        	
        	String creattime = (String) map.get("creattime");
        	HSSFCell cell03=rowx.createCell(3);
        	cell03.setCellStyle(style);
        	cell03.setCellValue(creattime);
        	
        	String neirong = (String) map.get("neirong");
        	HSSFCell cell04=rowx.createCell(4);
        	cell04.setCellStyle(style);
        	cell04.setCellValue(neirong);
		}
		try {
			OutputStream output=response.getOutputStream();
	        response.reset();
	        response.setHeader("Content-disposition", "attachment; filename=report.xls");//文件名这里可以改
	        response.setContentType("application/msexcel");
	        workbook.write(output);
	        output.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}