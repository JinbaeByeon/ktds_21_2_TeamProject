package com.kpms.common.util;

import java.util.Calendar;

public class CalendarUtil {
	public static String getDate(Calendar cal) {
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DATE);
		String strMonth = month < 10 ? "0" + month : "" + month;
		String strDay = day < 10 ? "0" + day : "" + day;
		
		return year + "-" + strMonth + "-" + strDay;
	}
	
}
