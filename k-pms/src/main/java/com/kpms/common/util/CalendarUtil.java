package com.kpms.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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
	public static String getDate(String date, int field ,int amount) {
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		try {
			cal.setTime(sdf.parse(date));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		cal.add(field, amount);
		return getDate(cal);
	}
}
