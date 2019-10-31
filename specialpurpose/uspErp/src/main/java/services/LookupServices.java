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

import org.apache.ofbiz.base.util.*;
import org.apache.ofbiz.base.util.string.FlexibleStringExpander;
import org.apache.ofbiz.entity.Delegator;
import org.apache.ofbiz.entity.GenericEntityException;
import org.apache.ofbiz.entity.GenericValue;
import org.apache.ofbiz.entity.condition.EntityCondition;
import org.apache.ofbiz.entity.condition.EntityOperator;
import org.apache.ofbiz.entity.util.EntityQuery;
import org.apache.ofbiz.entity.util.EntityUtilProperties;
import org.apache.ofbiz.service.DispatchContext;
import org.apache.ofbiz.service.LocalDispatcher;
import org.apache.ofbiz.service.ServiceUtil;
import org.jdom.JDOMException;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.math.BigDecimal;
import java.nio.ByteBuffer;
import java.sql.Timestamp;
import java.util.*;

public class LookupServices {

    public static final String module = LookupServices.class.getName();
    public static final String resourceError = "UspErpUiLabels";
    public static final String resource = "UspErpUiLabels";
    private static int pdfCount = 0;
    private static String pdfPath;

    public static Map<String, Object> schSupplier(DispatchContext dctx, Map<String, ?> context) {
        Delegator delegator = dctx.getDelegator();
        Map<String, Object> result = ServiceUtil.returnSuccess();

        String supplierId = context.get("supplierId") == null ? "" : (String) context.get("supplierId");
        String supplierNm = context.get("supplierNm") == null ? "" : (String) context.get("supplierNm");

        try {
            // Check if the country is a country group and get recursively the
            // states
            List<EntityCondition> supplierConditionList = new LinkedList<EntityCondition>();

            if(!"".equals(supplierId)) {
                supplierConditionList.add(EntityCondition.makeCondition("vendorId", EntityOperator.LIKE, "%" + supplierId + "%"));
            }

            if(!"".equals(supplierNm)) {
                supplierConditionList.add(EntityCondition.makeCondition("vendorNm", EntityOperator.LIKE, "%" + supplierNm + "%"));
            }

            EntityCondition supplierListCondition = EntityCondition.makeCondition(supplierConditionList, EntityOperator.AND);
            Map<String, Object> supplierInfo = new HashMap<String, Object>();
            supplierInfo = EntityQuery.use(delegator)
                    .from("Vendor")
                    .where(supplierListCondition)
                    .queryOne();

            if(supplierInfo == null) {
                supplierInfo = new HashMap<String, Object>();
                result.put("returnDataInfo", supplierInfo);
                result.put("resultState", "fail");
            } else {
                result.put("returnDataInfo", supplierInfo);
                result.put("resultState", "success");
            }

        } catch (GenericEntityException e){
            Debug.logError(e, "Cannot lookup Supplier ", module);
        }

        return result;
    }

    public static Map<String, Object> schCustomer(DispatchContext dctx, Map<String, ?> context) {
        Delegator delegator = dctx.getDelegator();
        Map<String, Object> result = ServiceUtil.returnSuccess();

        String customerId = context.get("customerId") == null ? "" : (String) context.get("customerId");
        String customerName = context.get("customerName") == null ? "" : (String) context.get("customerName");

        try {
            // Check if the country is a country group and get recursively the
            // states

            List<EntityCondition> customerConditionList = new LinkedList<EntityCondition>();

            if(!"".equals(customerId)) {
                customerConditionList.add(EntityCondition.makeCondition("customerId", EntityOperator.LIKE, "%" + customerId + "%"));
            }

            if(!"".equals(customerName)) {
                customerConditionList.add(EntityCondition.makeCondition("customerName", EntityOperator.LIKE, "%" + customerName + "%"));
            }

            EntityCondition customerListCondition = EntityCondition.makeCondition(customerConditionList, EntityOperator.AND);

            Map<String, Object> customerInfo = new HashMap<String, Object>();
            customerInfo = EntityQuery.use(delegator)
                    .from("Customer")
                    .where(customerListCondition)
                    .queryOne();
            if(customerInfo == null) {
                customerInfo = new HashMap<String, Object>();
                result.put("returnDataInfo", customerInfo);
                result.put("resultState", "fail");
            } else {
                result.put("returnDataInfo", customerInfo);
                result.put("resultState", "success");
            }

        } catch (GenericEntityException e){
            Debug.logError(e, "Cannot lookup Customer ", module);
        }

        return result;
    }

    public static Map<String, Object> schPaint(DispatchContext dctx, Map<String, ?> context) {
        Delegator delegator = dctx.getDelegator();
        Map<String, Object> result = ServiceUtil.returnSuccess();

        try {
            // Check if the country is a country group and get recursively the
            // states
            Map<String, Object> paintInfo = new HashMap<String, Object>();
            paintInfo = EntityQuery.use(delegator)
                    .from("PaintCode")
                    .where("paintCode", context.get("paintCode"))
                    .queryOne();
            if(paintInfo == null) {
                paintInfo = new HashMap<String, Object>();
                result.put("returnDataInfo", paintInfo);
                result.put("resultState", "fail");
            } else {
                result.put("returnDataInfo", paintInfo);
                result.put("resultState", "success");
            }

        } catch (GenericEntityException e){
            Debug.logError(e, "Cannot lookup PaintCode ", module);
        }

        return result;
    }

    public static Map<String, Object> schPo(DispatchContext dctx, Map<String, ?> context) {
        Delegator delegator = dctx.getDelegator();
        Map<String, Object> result = ServiceUtil.returnSuccess();

        try {
            // Check if the country is a country group and get recursively the
            // states
            List<GenericValue> poMasterList = EntityQuery.use(delegator)
                    .from("Reference")
                    .where("poNo", context.get("poNo"), "lotNo", context.get("lotNo"))
                    .queryList();
            if(poMasterList == null) {
                poMasterList.clear();
                result.put("returnDataInfo", poMasterList);
                result.put("resultState", "fail");
            } else {
                result.put("returnDataInfo", poMasterList);
                result.put("resultState", "success");
            }

        } catch (GenericEntityException e){
            Debug.logError(e, "Cannot lookup PoMaste ", module);
        }

        return result;
    }

    public static Map<String, Object> multipleUploadShippingDoc(DispatchContext dctx, Map<String, ? extends Object> context)
            throws IOException, JDOMException {

        Map<String, Object> result = new HashMap<String, Object>();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        Delegator delegator = dctx.getDelegator();
        GenericValue userLogin = (GenericValue) context.get("userLogin");
        String poNo = (String) context.get("poNo");
        poNo = poNo.trim();
        String lotNo = (String) context.get("lotNo");
        lotNo = lotNo.trim();
        ByteBuffer pdfData = (ByteBuffer) context.get("uploadedFile");
        String uploadFileName = (String) context.get("_uploadedFile_fileName");
//        String imageResize = (String) context.get("imageResize");
        Locale locale = (Locale) context.get("locale");

        String pdfFilenameFormat = "";
        String pdfServerPath = "";
        String pdfServerUrl = "";
        String rootTargetDirectory = "";
        String pdfName = "";
        String pdfUrl = "";
        if (UtilValidate.isNotEmpty(uploadFileName)) {
            pdfFilenameFormat = EntityUtilProperties.getPropertyValue("purchase", "pdf.filename.format", delegator);
            pdfServerPath = FlexibleStringExpander.expandString(EntityUtilProperties.getPropertyValue("purchase", "pdf.server.path", delegator), context);
            pdfServerUrl = FlexibleStringExpander.expandString(EntityUtilProperties.getPropertyValue("purchase", "pdf.url.prefix", delegator), context);
            rootTargetDirectory = pdfServerPath;
            File rootTargetDir = new File(rootTargetDirectory);
            if (!rootTargetDir.exists()) {
                boolean created = rootTargetDir.mkdirs();
                if (!created) {
                    String errMsg = UtilProperties.getMessage(resourceError, "ProductCannotCreateTheTargetDirectory", locale);
                    Debug.logFatal(errMsg, module);
                    return ServiceUtil.returnError(errMsg);
                }
            }

            // Create folder product id.
            String targetDirectory = pdfServerPath + "/" + poNo + "/" + lotNo;
            File targetDir = new File(targetDirectory);
            if (!targetDir.exists()) {
                boolean created = targetDir.mkdirs();
                if (!created) {
                    String errMsg = "Cannot create the target directory";
                    Debug.logFatal(errMsg, module);
                    return ServiceUtil.returnError(errMsg);
                }
            }

            File file = new File(pdfServerPath + "/" + poNo + "/" + lotNo + "/" + uploadFileName);
            pdfPath = pdfServerPath + "/" + poNo + "/" + lotNo + "/" + uploadFileName;
            file = checkExistsPdf(file);
            if (UtilValidate.isNotEmpty(file)) {
                pdfName = file.getPath();
                pdfName = pdfName.substring(pdfName.lastIndexOf(File.separator) + 1);
            }

            // Create image file original to folder product id.
            try {
                RandomAccessFile out = new RandomAccessFile(file, "rw");
                out.write(pdfData.array());
                out.close();
            } catch (FileNotFoundException e) {
                Debug.logError(e, module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resourceError,
                        "PurchasePDFViewUnableWriteFile", UtilMisc.toMap("fileName", file.getAbsolutePath()), locale));
            } catch (IOException e) {
                Debug.logError(e, module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resourceError,
                        "PurchasePDFViewUnableWriteBinaryData", UtilMisc.toMap("fileName", file.getAbsolutePath()), locale));
            }

            pdfUrl = pdfServerUrl + "/" + poNo + "/" + lotNo + "/" + pdfName;
        }

        try {
            List<GenericValue> referenceInfoList = EntityQuery.use(delegator)
                    .from("Reference")
                    .where(
                            "poNo", poNo,
                            "lotNo", lotNo
                    ).queryList();

            if(referenceInfoList.size() > 0) {
                for(GenericValue referenceInfo : referenceInfoList) {
                    referenceInfo.put("lastUpdateUserId", userLogin.get("userLoginId"));
                    referenceInfo.put("lastUpdatedStamp", UtilDateTime.nowTimestamp());
                    referenceInfo.put("lastUpdatedTxStamp", UtilDateTime.nowTimestamp());

                    String docClass = (String) context.get("docClass");
                    docClass = docClass.trim();
                    if("BL".equals(docClass)) {
                        String blDocFileYN = (String)context.get("blDocFileYN") == null ? "" : (String)context.get("blDocFileYN");
                        String vessel = (String)context.get("vessel") == null ? "" : (String)context.get("vessel");
                        String blNo = (String)context.get("blNo") == null ? "" : (String)context.get("blNo");
                        String portOfLoading = (String)context.get("portOfLoading") == null ? "" : (String)context.get("portOfLoading");
                        String shippingCarrier = (String)context.get("shippingCarrier") == null ? "" : (String)context.get("shippingCarrier");

                        referenceInfo.put("blDocFileYN", context.get("blDocFileYN"));
                        referenceInfo.put("blDocFilePath", pdfUrl);
                        referenceInfo.put("vessel", context.get("vessel"));
                        referenceInfo.put("blNo", context.get("blNo"));
                        if(context.get("blDate") != null) {
                            referenceInfo.put("blDate", context.get("blDate"));
                        }
                        referenceInfo.put("portOfLoading", portOfLoading);
                        referenceInfo.put("shippingCarrier", shippingCarrier);
                    } else if("CI".equals(docClass)) {
                        String ciDocFileYN = (String)context.get("ciDocFileYN") == null ? "" : (String)context.get("ciDocFileYN");
                        String contractNo = (String)context.get("contractNo") == null ? "" : (String)context.get("contractNo");
                        String unitCost = (String)context.get("unitCost") == null ? "" : (String)context.get("unitCost");
                        String civAmount = (String)context.get("civAmount") == null ? "" : (String)context.get("civAmount");

                        referenceInfo.put("ciDocFileYN", ciDocFileYN);
                        referenceInfo.put("ciDocFilePath", pdfUrl);
                        referenceInfo.put("contractNo", context.get("contractNo"));
                        referenceInfo.put("unitCost", context.get("unitCost"));
                        referenceInfo.put("civAmount", context.get("civAmount"));
                    } else if("PL".equals(docClass)) {


                        referenceInfo.put("plDocFileYN", context.get("plDocFileYN"));
                        referenceInfo.put("plDocFilePath", pdfUrl);
                        referenceInfo.put("loadedQty", context.get("loadedQty"));
                        referenceInfo.put("weight", context.get("weight"));
                        referenceInfo.put("linealFeet", context.get("linealFeet"));
                        referenceInfo.put("coilQty", context.get("coilQty"));
                        referenceInfo.put("yield", context.get("yield"));
                    } else if("WL".equals(docClass)) {


                        referenceInfo.put("wlDocFileYN", context.get("wlDocFileYN"));
                        referenceInfo.put("wlDocFilePath", pdfUrl);
                    } else if("MTC".equals(docClass)) {


                        referenceInfo.put("mtcDocFileYN", context.get("mtcDocFileYN"));
                        referenceInfo.put("mtcDocFilePath", pdfUrl);
                        referenceInfo.put("mtcVerified", context.get("mtcVerified"));
                    } else if("SA".equals(docClass)) {


                        referenceInfo.put("shipmentAdviceDocFileYN", context.get("shipmentAdviceDocFileYN"));
                        referenceInfo.put("shipmentAdviceDocFilePath", pdfUrl);
                        referenceInfo.put("shippingAgent", context.get("shippingAgent"));
                        referenceInfo.put("email", context.get("email"));
                    }
                    Debug.logInfo("############################## = " + referenceInfo.toString(), null);
                    referenceInfo = delegator.createOrStore(referenceInfo);
                }
            }
        } catch (GenericEntityException e){
            Debug.logError(e, "Cannot createNupdateShippingDoc ", module);
        }

        result.put("poNo", poNo);
        result.put("lotNo", lotNo);

        return result;
    }

    public static File checkExistsPdf(File file) {
        if (!file.exists()) {
            pdfCount = 0;
            pdfPath = null;
            return file;
        }
        pdfCount++;
        String filePath = pdfPath.substring(0, pdfPath.lastIndexOf("."));
        String type = pdfPath.substring(pdfPath.lastIndexOf(".") + 1);
        file = new File(filePath + "(" + pdfCount + ")." + type);
        return checkExistsPdf(file);
    }
}