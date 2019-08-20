package util;

import org.apache.ofbiz.base.util.UtilGenerics;
import org.apache.ofbiz.base.util.UtilValidate;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.entity.GenericValue;

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

    public static boolean isSubString(String subString, String s) {
        return (s.indexOf(subString) != -1);
    }

    public static boolean checkPassedJobDate(String date) {
        long starterTime = (new Date()).getTime();
        boolean boolTF = false;
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
                boolTF = false;
            } else {
                boolTF = true;
            }
        }
        return boolTF;
    }

    public static List getDuplicateList(List<String> values) {
        List duplicates = new ArrayList<>();
        HashSet uniques = new HashSet<>();
        for (String value : values) {
            if (uniques.contains(value)) {
                duplicates.add(value);
            } else {
                uniques.add(value);
            }
        }
        deleteDuplicateItem(duplicates);
        return duplicates;
    }

    public static void deleteDuplicateItem(List list) {
        HashSet set = new HashSet(list);
        list.clear();
        list.addAll(set);
    }
}
