package util;

import org.apache.ofbiz.base.util.UtilValidate;

import java.sql.Timestamp;
import java.util.Date;

public class UspErpCommonUtil {

    public static boolean isValidId(String id) {
        if (UtilValidate.isEmpty(id)) {
            return false;
        }

        char[] chars = id.toCharArray();
        for (char c: chars) {
            if ((!Character.isLetterOrDigit(c)) && (c!='-') && (c!='_')) {
                return false;
            }
        }
        return true;
    }

    public static boolean isNumber(String number) {
        if (UtilValidate.isEmpty(number)) {
            return false;
        }

        return UtilValidate.isInteger(number);
    }

    /** Returns true if single String subString is contained within string s. */
    public static boolean isSubString(String subString, String s) {
        return (s.indexOf(subString) != -1);
    }

    public static boolean checkPassedJobDate(String date) {
        long starterTime = (new Date()).getTime();
        //check start datetime
        if (UtilValidate.isNotEmpty(date)) {
            try {
                Timestamp ts1 = Timestamp.valueOf(date);
                starterTime = ts1.getTime();
            } catch (IllegalArgumentException e) {
                try {
                    starterTime = Long.parseLong(date);
                } catch (NumberFormatException nfe) {
                    return false;
                }
            }

            if (starterTime < (new Date()).getTime()) {
                return false;
            }
        }
        return true;
    }
}
