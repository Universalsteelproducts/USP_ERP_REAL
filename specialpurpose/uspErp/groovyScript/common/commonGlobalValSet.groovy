/*
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
 */
import org.apache.commons.lang.StringUtils
import org.apache.ofbiz.base.util.UtilValidate
import org.apache.ofbiz.entity.condition.EntityCondition
import org.apache.ofbiz.entity.condition.EntityOperator
import org.apache.ofbiz.entity.util.EntityUtil
import org.apache.ofbiz.entity.condition.EntityFunction
import org.apache.ofbiz.base.util.UtilMisc
import services.AdminServices
import org.apache.commons.collections.FastArrayList
import org.apache.ofbiz.product.store.ProductStoreWorker

globalContext.stores = delegator.findList("ProductStore",EntityCondition.makeCondition([isDemoStore : "N"]), null, null, null, false)
productStore = ""
productStoreId = ""
selectedProductStoreId = "10000"//parameters.selectedProductStoreId
boolean retrieveProductStoreData = false

if (UtilValidate.isNotEmpty(selectedProductStoreId)) {
    //clear all variables when product store is selected
    //shopCart.clear();
    //shopCart.setProductStoreId(selectedProductStoreId);
    session.removeAttribute("ADMIN_CONTEXT")

    //set productStore info
    store = delegator.findOne("ProductStore",["productStoreId":selectedProductStoreId], false)
    if (UtilValidate.isNotEmpty(store)) {
        productStore = store
        productStoreId = store.getString("productStoreId")
        globalContext.selectedStore = store
        globalContext.selectedStoreId = productStoreId
        globalContext.productStore = store
        globalContext.productStoreName = store.storeName
        globalContext.productStoreId = store.productStoreId
        session.setAttribute("selectedStore",store)
        retrieveProductStoreData = true
    }
}

selectedStore = session.getAttribute("selectedStore")
if (UtilValidate.isEmpty(selectedStore)) {
    store = ProductStoreWorker.getProductStore(request)
    if (UtilValidate.isNotEmpty(store)) {
        productStore = store
        productStoreId= store.getString("productStoreId")
        globalContext.selectedStore = store
        globalContext.selectedStoreId = productStoreId
        globalContext.productStore = store
        globalContext.productStoreName = store.storeName
        globalContext.productStoreId = store.productStoreId
        session.setAttribute("selectedStore",store)
        retrieveProductStoreData = true
    }
}

if (retrieveProductStoreData && UtilValidate.isNotEmpty(productStore)) {
    webSites =delegator.findByAnd("WebSite", UtilMisc.toMap("productStoreId", productStore.getString("productStoreId")), null, false)
    webSite = EntityUtil.getFirst(webSites)
    if (UtilValidate.isNotEmpty(webSite)) {
        globalContext.webSite = webSite
        globalContext.webSiteId = webSite.webSiteId
        session.setAttribute("selectedWebsite",webSite)
    }

    //PRODUCT STORE CATALOG
    storeCatalogs = delegator.findByAnd("ProductStoreCatalog", UtilMisc.toMap("productStoreId", productStore.productStoreId), UtilMisc.toList("sequenceNum", "prodCatalogId"), false)
    storeCatalogs = EntityUtil.filterByDate(storeCatalogs, true)
    currentCatalog= EntityUtil.getFirst(storeCatalogs)
    if (UtilValidate.isNotEmpty(currentCatalog)) {
        globalContext.prodCatalogId = currentCatalog.prodCatalogId
        prodCatalog = currentCatalog.getRelatedOne("ProdCatalog")
        globalContext.prodCatalogName = prodCatalog.catalogName
        session.setAttribute("selectedProdCatalog",prodCatalog)

        prodCatalogCategories = delegator.findByAnd("ProdCatalogCategory",UtilMisc.toMap("prodCatalogId", currentCatalog.prodCatalogId,"prodCatalogCategoryTypeId","PCCT_BROWSE_ROOT"),UtilMisc.toList("sequenceNum", "productCategoryId"), false)
        prodCatalogCategories = EntityUtil.filterByDate(prodCatalogCategories, true)
        if (UtilValidate.isNotEmpty(prodCatalogCategories)) {
            prodCatalogCategory = EntityUtil.getFirst(prodCatalogCategories)
            session.setAttribute("selectedProdCatalogCategory",prodCatalogCategory)
            globalContext.rootProductCategoryId = prodCatalogCategory.productCategoryId

            currentCategories = new FastArrayList()
            allUnexpiredCategories = AdminServices.getRelatedCategories(delegator, prodCatalogCategory.productCategoryId, null, true, false, true)
            for (Map<String, Object> workingCategoryMap : allUnexpiredCategories) {
                workingCategory = (Map<String, Object>) workingCategoryMap.get("ProductCategory")
                currentCategories.add(workingCategory)
            }
            globalContext.currentCategories = currentCategories
            session.setAttribute("selectedCategories",currentCategories)
        }
    }
} else {
    selectedStore = session.getAttribute("selectedStore")
    if (UtilValidate.isNotEmpty(selectedStore)) {
        globalContext.selectedStore = selectedStore
        globalContext.selectedStoreId = selectedStore.productStoreId
        globalContext.productStore = selectedStore
        globalContext.productStoreName = selectedStore.storeName
        globalContext.productStoreId = selectedStore.productStoreId
    }

    selectedWebsite = session.getAttribute("selectedWebsite")
    if (UtilValidate.isNotEmpty(selectedWebsite)) {
        globalContext.webSite = selectedWebsite
        globalContext.webSiteId = selectedWebsite.webSiteId
    }

    selectedProdCatalog = session.getAttribute("selectedProdCatalog")
    if (UtilValidate.isNotEmpty(selectedProdCatalog)) {
        globalContext.prodCatalogId = selectedProdCatalog.prodCatalogId
        globalContext.prodCatalogName = selectedProdCatalog.catalogName
    }

    selectedCategories = session.getAttribute("selectedCategories")
    if (UtilValidate.isNotEmpty(selectedCategories)) {
        globalContext.currentCategories = selectedCategories
    }

    selectedProdCatalogCategory = session.getAttribute("selectedProdCatalogCategory")
    if (UtilValidate.isNotEmpty(selectedProdCatalogCategory)) {
        globalContext.rootProductCategoryId=selectedProdCatalogCategory.productCategoryId
    }
}

context.productStore = productStore
context.productStoreId = productStoreId