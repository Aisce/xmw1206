/*
 * Copyright 2008-2019 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 * FileId: BwTFEcRvTpTWiE7TEMdXAG0oJESBFWyM
 */
package net.shopxx.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.NumberToTextConverter;

/**
 * Utils - Bean
 * 
 * @author SHOP++ Team
 * @version 6.1
 */
public final class TransformCellUtils {
	
	public final static String DATE_OUTPUT_PATTERNS = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";  
	public final static SimpleDateFormat simpleDateFormat = new SimpleDateFormat(  
	        DATE_OUTPUT_PATTERNS);  
	
	public static String getCellValue(Cell cell) {  
	    String ret = "";  
	    if (cell == null) return ret;  
	    CellType type = cell.getCellTypeEnum();  
	    switch (type) {  
	    case BLANK:  
	        ret = "";  
	        break;  
	    case BOOLEAN:  
	        ret = String.valueOf(cell.getBooleanCellValue());  
	        break;  
	    case ERROR:  
	        ret = null;  
	        break;  
	    case FORMULA:  
	        Workbook wb = cell.getSheet().getWorkbook();  
	        CreationHelper crateHelper = wb.getCreationHelper();  
	        FormulaEvaluator evaluator = crateHelper.createFormulaEvaluator();  
	        ret = getCellValue(evaluator.evaluateInCell(cell));  
	        break;  
	    case NUMERIC:  
	        if (DateUtil.isCellDateFormatted(cell)) {  
	            Date theDate = cell.getDateCellValue();  
	            ret = simpleDateFormat.format(theDate);  
	        } else {  
	            ret = NumberToTextConverter.toText(cell.getNumericCellValue());  
	        }  
	        break;  
	    case STRING:  
	        ret = cell.getRichStringCellValue().getString();  
	        break;  
	    default:  
	        ret = "";  
	    }  
	  
	    return ret; 
	}  
}