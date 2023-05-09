package com.kpms.common.excel4j.write;

import java.io.File;

import org.apache.poi.xssf.streaming.SXSSFSheet;

import com.kpms.common.excel4j.option.WriteOption;
import com.kpms.common.excel4j.util.write.AutoSizingColumns;
import com.kpms.common.excel4j.util.write.MakeContents;
import com.kpms.common.excel4j.util.write.MakeTitle;
import com.kpms.common.excel4j.util.write.MakeWorkBook;
import com.kpms.common.excel4j.util.write.WriteFileSystem;
import com.kpms.common.excel4j.util.write.share.WriteShare;

/**
 * 엑셀 파일을 서버의 디스크에 작성한다.
 * 
 * @see io.github.seccoding.excel.ExcelWriteTest
 * @author Minchang Jang (mcjang1116@gmail.com)
 */
public class ExcelWrite {

	/**
	 * 엑셀 파일이 쓰여질 경로. WriteOption 에서 가져온다.
	 */
	private static String downloadPath = null;


	/**
	 * 엑셀 파일을 작성한다.
	 * 
	 * @param WriteOption
	 * @return Excel 파일의 File 객체
	 */
	public static File write(WriteOption<?> writeOption) {
		WriteShare.writeOption = writeOption;
		MakeWorkBook.makeWorkBookAndSheet();
		
		MakeTitle.make();
		MakeContents.make();
		
		AutoSizingColumns.resize();
		
		downloadPath = WriteFileSystem.write();
		WriteShare.resetRowIndex();
		
		return getFile(WriteShare.writeOption.getFileName());
	}
	
	private static File getFile(String fileName) {
		return new File(downloadPath + fileName);
	}

}
