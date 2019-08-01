/*******************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *******************************************************************************/
package services;

import org.apache.commons.collections.FastArrayList;
import org.apache.commons.collections.FastHashMap;
import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.base.util.UtilDateTime;
import org.apache.ofbiz.base.util.UtilMisc;
import org.apache.ofbiz.base.util.UtilValidate;
import org.apache.ofbiz.entity.Delegator;
import org.apache.ofbiz.entity.GenericEntityException;
import org.apache.ofbiz.entity.GenericValue;
import org.apache.ofbiz.entity.condition.EntityCondition;
import org.apache.ofbiz.entity.condition.EntityFunction;
import org.apache.ofbiz.entity.condition.EntityOperator;
import org.apache.ofbiz.entity.util.EntityUtil;
import org.apache.ofbiz.product.category.CategoryWorker;
import org.apache.ofbiz.service.DispatchContext;
import org.apache.ofbiz.service.ServiceUtil;

import java.sql.Timestamp;
import java.util.*;

public class AdminServices {

    public static final String module = AdminServices.class.getName();
    public static final String resourceError = "UspErpUiLabels";
    public static final String resource = "UspErpUiLabels";
    private static int pdfCount = 0;
    private static String pdfPath;

	public static List<Map<String, Object>> getRelatedCategories(Delegator delegator, String parentId, List<String> categoryTrail, boolean limitView, boolean excludeEmpty, boolean recursive)
	{
		List<Map<String, Object>> categories = new FastArrayList();
		if (categoryTrail == null) {
			categoryTrail = new FastArrayList();
		}
		categoryTrail.add(parentId);
		if (Debug.verboseOn()) {
			Debug.logVerbose("getRelatedCategories for: " + parentId, module);
		}

		List<GenericValue> rollups = null;
		try {
			rollups = delegator.findByAnd("ProductCategoryRollup", UtilMisc.toMap("parentProductCategoryId", parentId), UtilMisc.toList("sequenceNum"), false);
			if (limitView) {
				rollups = EntityUtil.filterByDate(rollups, true);
			}
		} catch (GenericEntityException e) {
			Debug.logWarning(e.getMessage(), module);
		}

		if (rollups != null) {
			for (GenericValue parent : rollups) {
				GenericValue cv = null;
				Map<String, Object> cvMap = new FastHashMap();

				try {
					cv = parent.getRelatedOne("CurrentProductCategory");
				} catch (GenericEntityException e) {
					Debug.logWarning(e.getMessage(), module);
				}
				if (cv != null) {
					if (excludeEmpty) {
						if (!CategoryWorker.isCategoryEmpty(cv)) {
							cvMap.put("ProductCategory", cv);
							cvMap.put("ProductCategoryRollup", parent);
							categories.add(cvMap);
							if (recursive) {
								categories.addAll(getRelatedCategories(delegator, cv.getString("productCategoryId"), categoryTrail, limitView, excludeEmpty, recursive));
							}
							List<String> popList = new FastArrayList();
							popList.addAll(categoryTrail);
							cvMap.put("categoryTrail", popList);
							categoryTrail.remove(categoryTrail.size() - 1);
						}
					} else {
						cvMap.put("ProductCategory", cv);
						cvMap.put("ProductCategoryRollup", parent);
						cvMap.put("parentProductCategoryId", parent.getString("parentProductCategoryId"));
						categories.add(cvMap);
						if (recursive) {
							categories.addAll(getRelatedCategories(delegator, cv.getString("productCategoryId"), categoryTrail, limitView, excludeEmpty, recursive));
						}
						List<String> popList = new FastArrayList();
						popList.addAll(categoryTrail);
						cvMap.put("categoryTrail", popList);
						categoryTrail.remove(categoryTrail.size() - 1);
					}
				}
			}
		}
		return categories;
	}

    public static Map<String, Object> searchEmployee(DispatchContext dctx, Map<String, ?> context) {
    	Delegator delegator = dctx.getDelegator();
    	Locale locale = (Locale) context.get("locale");
        Map<String, Object> result = ServiceUtil.returnSuccess();
        GenericValue userLogin = (GenericValue) context.get("userLogin");

		List<Map<String, Object>> resultList = new LinkedList<Map<String,Object>>();

		result.put("data", resultList);
		result.put("recordsTotal", resultList.size());
		result.put("recordsFiltered", resultList.size());
        return result;
    }

}