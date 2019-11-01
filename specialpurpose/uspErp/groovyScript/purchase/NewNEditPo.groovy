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
import org.apache.ofbiz.base.util.UtilDateTime
import org.apache.ofbiz.entity.GenericValue
import java.text.SimpleDateFormat
import org.apache.ofbiz.entity.model.DynamicViewEntity

poCommonInfo = [:]
lotList = []
poSubtotal = []

crudMode = "INIT"
nowTs = UtilDateTime.nowTimestamp()
poCommonInfo.put("orderDate", nowTs)

poStatus = from("PoStatusCode").orderBy("sortSeq ASC").queryList()
purchaseClass = from("PurchaseClassCode").orderBy("sortSeq ASC").queryList()

//priceTerm = from("TermType").where("parentTypeId", "INCO_TERM").queryList()
priceTerm = from("PriceTermCode").orderBy("sortSeq ASC").queryList()
//paymentTerm = from("TermType").where("parentTypeId", "PAYMENT").queryList()
paymentTerm = from("PaymentTermCode").orderBy("sortSeq ASC").queryList()
paymentMethodType = from("PaymentMethodType").queryList()

productTmp = from("ProductTmp").orderBy("sortSeq ASC").queryList()
fobPointTmp = from("FobPointTmp").orderBy("sortSeq ASC").queryList()
destinationTmp = from("DestinationTmp").orderBy("sortSeq ASC").queryList()

steelType = from("SteelTypeCode").orderBy("sortSeq ASC").queryList()
grade = from("GradeCode").orderBy("sortSeq ASC").queryList()
coatingWeight = from("CoatingWeightCode").orderBy("sortSeq ASC").queryList()
surfaceType = from("SurfaceTypeCode").orderBy("sortSeq ASC").queryList()
thickness = [] //from("ThicknessCode").orderBy("sortSeq ASC").queryList()

exw = from("ExwCode").orderBy("sortSeq ASC").queryList()
purchaseAgent = from("PurchaseAgentCode").orderBy("sortSeq ASC").queryList()
coilMaxWeight = from("CoilMaxWeightCode").orderBy("sortSeq ASC").queryList()
packaging = from("PackagingCode").orderBy("sortSeq ASC").queryList()

poNo = parameters.poNo
pageAction = "new"
if(poNo != null && poNo != "") {
    shippingLine = from("ShippingLineTmp").orderBy("sortSeq ASC").queryList()
    shippingAgent = from("ShippingAgentTmp").orderBy("sortSeq ASC").queryList()
    context.shippingLine = shippingLine
    context.shippingAgent = shippingAgent

    pageAction = "edit"
    crudMode = "R"
    poCommonInfo = from("PoMaster").where("poNo", poNo).queryOne()
    context.poStatus = parameters.poStatus

    lotList = select("lotNo").from("PoReference").where("poNo", poNo).orderBy("lotNo ASC").distinct().queryList()
}

context.pageAction = pageAction
context.poCommonInfo = poCommonInfo
context.crudMode =  crudMode
context.lotList =  lotList
context.poStatusList =  poStatus
context.purchaseClass =  purchaseClass

context.priceTerm =  priceTerm
context.paymentTerm =  paymentTerm
context.paymentMethodType =  paymentMethodType

context.productTmp =  productTmp
context.fobPointTmp =  fobPointTmp
context.destinationTmp =  destinationTmp

context.steelType =  steelType
context.grade =  grade
context.coatingWeight =  coatingWeight
context.surfaceType =  surfaceType
context.thickness =  thickness

context.exw =  exw
context.purchaseAgent =  purchaseAgent
context.coilMaxWeight =  coilMaxWeight
context.packaging =  packaging