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

		String productStoreId = context.get("productStoreId") == null ? "" : (String) context.get("productStoreId");
		String srchEmployeeId = context.get("srchEmployeeId") == null ? "" : (String) context.get("srchEmployeeId");
		String searchGroupId = context.get("searchGroupId") == null ? "" : (String) context.get("searchGroupId");

		List<Map<String, Object>> resultList = new LinkedList<Map<String,Object>>();
		if (userLogin != null) {
			String userLoginId = (String) userLogin.get("userLoginId");

			try {
				List<EntityCondition> employeeConditionList = new ArrayList<EntityCondition>();

				if(!"".equals(srchEmployeeId)) {
					employeeConditionList.add(EntityCondition.makeCondition(EntityFunction.UPPER_FIELD("userLoginId"), EntityOperator.LIKE, "%" + srchEmployeeId.toUpperCase() + "%"));
				}
				if(!"".equals(searchGroupId)) {
					List<EntityCondition> userLogSecGroupCond = new ArrayList<EntityCondition>();
					userLogSecGroupCond.add(EntityCondition.makeCondition("groupId", EntityOperator.EQUALS, searchGroupId));
					List<GenericValue> userLoginSecurityGroups = delegator.findList("UserLoginSecurityGroup", EntityCondition.makeCondition(UtilMisc.toMap("groupId", "searchGroupId")), null, null, null, false);
					List<String> contentIds = EntityUtil.getFieldListFromEntityList(userLoginSecurityGroups, "userLoginId", true);
					employeeConditionList.add(EntityCondition.makeCondition("userLoginId", EntityOperator.IN, contentIds));
				}

				List<GenericValue> contentUserList = delegator.findList("ProductStoreRole", EntityCondition.makeCondition(UtilMisc.toMap("roleTypeId", "CONTENT_USER", "productStoreId", productStoreId)), null, null, null, false);
				List<String> contentUserListIds = EntityUtil.getFieldListFromEntityList(contentUserList, "partyId", true);
				employeeConditionList.add(EntityCondition.makeCondition("partyId", EntityOperator.IN, contentUserListIds));

				List<GenericValue> employeeList = new  ArrayList<GenericValue>();
				if (UtilValidate.isNotEmpty(employeeConditionList)) {
					EntityCondition mainCond = EntityCondition.makeCondition(employeeConditionList, EntityOperator.AND);
					employeeList = delegator.findList("UserLogin",mainCond, null, UtilMisc.toList("userLoginId"), null, false);
				}

				if(employeeList.size() > 0) {
					for (GenericValue employeeInfo : employeeList) {
						Map<String, Object> resultMap = new HashMap<String, Object>();

						String groupIdString = "";
						boolean securityGroupExpired = false;
						boolean addMapTF = true;
						if (!"".equals(searchGroupId)) {
							List<GenericValue> userLoginSecurityGroups = delegator.findByAnd("UserLoginSecurityGroup", UtilMisc.toMap("userLoginId", employeeInfo.getString("userLoginId"), "groupId", searchGroupId), null, false);
							if (userLoginSecurityGroups.size() > 0) {
								for (GenericValue userLoginSecurityGroup : userLoginSecurityGroups) {
									Timestamp nowTimeStamp = UtilDateTime.nowTimestamp();
									if(userLoginSecurityGroup.getTimestamp("thruDate") != null) {
										if (nowTimeStamp.after(userLoginSecurityGroup.getTimestamp("thruDate"))) {
											securityGroupExpired = true;
										}
									}
								}
								addMapTF = true;
							} else {
								addMapTF = false;
							}
						}

						if (securityGroupExpired == false) {
							if(addMapTF == true) {
								resultMap.putAll(employeeInfo);

								List<GenericValue> userGroups = delegator.findByAnd("UserLoginSecurityGroup", UtilMisc.toMap("userLoginId", employeeInfo.getString("userLoginId")), null, false);
								List<String> groupIds = EntityUtil.getFieldListFromEntityList(userGroups, "groupId", true);
								int resultCnt = 0;
								if (groupIds.size() > 0) {
									for (String groupId : groupIds) {
										if (resultCnt == 0) {
											groupIdString += groupId;
										} else {
											groupIdString += ", " + groupId;
										}
										resultCnt++;
									}
									resultMap.put("groupId", groupIdString);
								} else {
									resultMap.put("groupId", "");
								}

								resultList.add(resultMap);
							}
						}
					}
				}
			} catch (GenericEntityException e){
				Debug.logError(e, "Cannot searchEmployee ", module);
			}
		}
		result.put("data", resultList);
		result.put("recordsTotal", resultList.size());
		result.put("recordsFiltered", resultList.size());

		return result;
	}

}