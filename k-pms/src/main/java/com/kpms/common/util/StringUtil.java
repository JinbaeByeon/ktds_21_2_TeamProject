package com.kpms.common.util;

public abstract class StringUtil {
	private StringUtil() {}
	
	public static boolean isEmpty(String str) {
		return str == null || str.trim().length() == 0;
	}

	public static boolean isExceedLength(String str, int len) {
		if(!isNull(str)) {
			return str.trim().length() > len;
		}
		return false;
	}
	public static boolean isNull(String str) {
		return str == null;
	}
	
	public static boolean isMatchTo(String lhs, String rhs) {
		return lhs.equals(rhs);
	}

	public static int dateToInt(String dt) {
		return Integer.parseInt(dt.replace("-", ""));
	}
}
