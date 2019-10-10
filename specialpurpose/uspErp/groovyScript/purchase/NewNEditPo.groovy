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

poCommonInfo = [:]
lotList = []

poNo = parameters.poNo
crudMode = "INIT"
nowTs = UtilDateTime.nowTimestamp()
poCommonInfo.put("orderDate", nowTs)

poStatus = from("PoStatusCode").orderBy("sortSeq").queryList()
purchaseClass = from("PurchaseClassCode").orderBy("sortSeq").queryList()

priceTerm = from("TermType").where("parentTypeId", "INCO_TERM").queryList()
paymentTerm = from("TermType").where("parentTypeId", "PAYMENT").queryList()
paymentMethodType = from("PaymentMethodType").queryList()

productTmp = from("ProductTmp").orderBy("sortSeq").queryList()
fobPointTmp = from("FobPointTmp").orderBy("sortSeq").queryList()
destinationTmp = from("DestinationTmp").orderBy("sortSeq").queryList()

steelType = from("SteelTypeCode").orderBy("sortSeq").queryList()
grade = from("GradeCode").orderBy("sortSeq").queryList()
coatingWeight = from("CoatingWeightCode").orderBy("sortSeq").queryList()
surfaceType = from("SurfaceTypeCode").orderBy("sortSeq").queryList()
thickness = from("ThicknessCode").orderBy("sortSeq").queryList()

exw = from("ExwCode").orderBy("sortSeq").queryList()
purchaseAgent = from("PurchaseAgentCode").orderBy("sortSeq").queryList()
coilMaxWeight = from("CoilMaxWeightCode").orderBy("sortSeq").queryList()
packaging = from("PackagingCode").orderBy("sortSeq").queryList()

context.poCommonInfo = poCommonInfo
context.crudMode =  crudMode
context.lotList =  lotList
context.poStatus =  poStatus
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