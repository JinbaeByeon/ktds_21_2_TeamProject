package com.kpms.common.excel4j.util.write;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.poi.openxml4j.util.ZipSecureFile;

import com.kpms.common.excel4j.util.write.share.WriteShare;

public class WriteFileSystem {

	public static String write() {
		FileOutputStream fos = null;
		String downloadPath = null;
		
		try {
			
			downloadPath = WriteShare.writeOption.getFilePath();
			if ( downloadPath == null ) {
				throw new RuntimeException("Excel 파일이 만들어질 경로가 누락되었습니다. WriteOption 의 filePath를 셋팅하세요. 예 > D:\\uploadFiles\\");
			}
			
			ZipSecureFile.setMinInflateRatio(0);
			File f = getFile(downloadPath, WriteShare.writeOption.getFileName());
			WriteShare.writeOption.setFileName(f.getName());
			fos = new FileOutputStream(f);
			WriteShare.wb.write(fos);
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
		finally {
			if(fos != null) {
				try {
					fos.flush();
					fos.close();
				} catch (IOException e) {}
			}
		}
		
		return downloadPath;
	}
	
	private static File getFile(String downloadPath, String fileName) {
		
		File f = new File(downloadPath + fileName); 
		
		String name = fileName.substring(0, fileName.lastIndexOf("."));
		String ext = fileName.substring(fileName.lastIndexOf(".")+1);
		String newName = "";
		int index = 1;
		while (f.exists()) {
			newName = name + " (" + (++index) + ")";
			f = new File(downloadPath + newName + "." + ext); 
		}
		
		return f;
	}
	
}
