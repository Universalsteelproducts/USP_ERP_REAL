<#--
	total / orderquantity control 다시
	function 들 공통화 작업
-->
<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<script type="text/javascript">
	jQuery(document).ready(function(){
		$("#submitBtn").on("click", function() {
			$("#docInfo").submit();
		});

// 		$("input[name=poNo]").on("change lookup:changed", function() {
// 		    var poNo = $(this).val();

// 		    if(poNo != null && poNo != "") {
// 			    jQuery.ajax({
// 			    	url: '<@ofbizUrl>/searchPo</@ofbizUrl>',
// 			    	type: 'POST',
// 			    	data: {"vendorId" : vendorId},
// 			    	error: function(msg) {
// 			    		showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
// 			    	},
// 			    	success: function(data) {
// 			    		if(data.resultState == "success") {
// 				    		if(data.vendorInfo != null) {
// 						    	$.each(data.vendorInfo, function(index, value) {
// 							    	if(index == "remark") {
// 							    		$("#vendorNPoInfo #remark").val(value);
// 							    	} else {
// 							    		$("input[name=" + index + "]").val("");
// 								    	$("input[name=" + index + "]").val(value);
// 								    	$("input[name=" + index + "]").effect("highlight", {}, 3000);
// 							    	}
// 						    	});

// 						    	$('#vendorTel').change();
// 						    	$('#vendorFax').change();

// 						    	var nowDate = new Date();
// 						    	var year = nowDate.getFullYear().toString().substr(-2);;
// 						    	var month = (1 + nowDate.getMonth());
// 						    	month = month >= 10 ? month : '0' + month;
// 						    	var day = nowDate.getDate();
// 						    	day = day >= 10 ? day : '0' + day;

// 						    	var poNo = year + month + day + $("#vendorInitials").val();
// 						    	$("#vendorNPoInfo #poNo").val(poNo);
// 				    		} else {
// 				    			$("#vendorInitials").val("");
// 						    	$("#vendorAddr").val("");
// 						    	$("#priceTerm").val("");
// 						    	$("#vendorEmail").val("");
// 						    	$("#freightTerm").val("");
// 						    	$("#vendorTel").val("");
// 						    	$("#paymentTerm").val("");
// 						    	$("#vendorFax").val("");
// 						    	$("#downPayment").val("");
// 						    	$("#remark").val("");
// 				    		}
// 			    		}
// 			    	}
// 		    	});
// 		    } else {
// 		    	$("#lotNo").val();
// 		    }
// 		});
	});
</script>

<form name="docInfo" id="docInfo" method="post" enctype="multipart/form-data" action="<@ofbizUrl>createNupdateShippingDoc</@ofbizUrl>">
	<input type="hidden" name="docClass" id="docClass" />

	<!-- PO Info -->
	<div class="screenlet">
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.poInfo}</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="12%" style="min-width: 134px;" align="right" >
						${uiLabelMap.poNo}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="19%" style="min-width: 332px;">
						<@htmlTemplate.lookupField value="${poInfo.poNo!}" formName="docInfo" name="poNo" id="poNo" fieldFormName="LookupPo" position="center" />
					</td>
					<td class="label" width="12%" style="min-width: 93px;" align="right">
						${uiLabelMap.lotNo}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="lotNo" id="lotNo" value="${poInfo.lotNo!}" />
					</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
				</tr>
			</table>
		</div>
	<div>
	<!-- BL Document -->
	<div class="screenlet">
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.blDoc}</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="12%" style="min-width: 134px;" align="right">
						${uiLabelMap.blDocFile}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%" style="min-width: 332px;">
						<input type="file" name="blDocFile" id="blDocFile" value="${poInfo.blDocFile!}" />
						<input type="checkbox" id="blDocFileYN" name="blDocFileYN" value="N"/>
						<span class="button-text">N/A</span>
					</td>
					<td class="label"align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
					<td class="label" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.vessel}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="vessel" id="vessel" value="${poInfo.vessel!}" />
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.blNo}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="blNo" id="blNo" value="${poInfo.blNo!}" />
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.blDate}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<@htmlTemplate.renderDateTimeField name="blDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" value="${poInfo.blDate!}" size="25" maxlength="50" id="orderDate" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.portOfLoading}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="portOfLoading" id="portOfLoading" value="${poInfo.portOfLoading!}" />
					</td>
					<td class="label" width="12%" style="min-width: 93px;" align="right">
						${uiLabelMap.shippingCarrier}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="shippingCarrier" id="shippingCarrier" value="${poInfo.shippingCarrier!}" />
					</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- Commercial Invoice Document -->
	<div class="screenlet">
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.commercialInvoiceDoc}</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="12%" style="min-width: 134px;" align="right">
						${uiLabelMap.commercialInvoiceFile}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%" style="min-width: 332px;">
						<input type="file" name="ciDocFile" id="ciDocFile" value="${poInfo.ciDocFile!}" />
						<input type="checkbox" id="ciDocFileYN" name="ciDocFileYN" value="N"/>
						<span class="button-text">N/A</span>
					</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.contractNo}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="contractNo" id="contractNo" value="${poInfo.contractNo!}" />
					</td>
					<td class="label" width="12%" style="min-width: 93px;" align="right">
						${uiLabelMap.unitCost}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="unitCost" id="unitCost" value="${poInfo.unitCost!}" />
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.civAmount}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="civAmount" id="civAmount" value="${poInfo.civAmount!}" />
					</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- Packing List Document -->
	<div class="screenlet">
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.packingListDoc}</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="12%" style="min-width: 134px;" align="right">
						${uiLabelMap.plDocFile}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%" style="min-width: 332px;">
						<input type="file" name="plDocFile" id="plDocFile" value="${poInfo.plDocFile!}" />
						<input type="checkbox" id="plDocFileYN" name="ciDocFileYN" value="N"/>
						<span class="button-text">N/A</span>
					</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.loadedQty}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="loadedQty" id="loadedQty" value="${poInfo.loadedQty!}" />
					</td>
					<td class="label" width="12%" style="min-width: 93px;" align="right">
						${uiLabelMap.weight}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="weight" id="weight" value="${poInfo.weight!}" />
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.linealFeet}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="linealFeet" id="linealFeet" value="${poInfo.linealFeet!}" />
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.coilQuantity}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="coilQuantity" id="coilQuantity" value="${poInfo.coilQuantity!}" />
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.yield}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="yield" id="yield" value="${poInfo.yield!}" />
					</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- weightListDoc -->
	<div class="screenlet">
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.weightListDoc}</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="12%" style="min-width: 134px;" align="right">
						${uiLabelMap.wlDocFile}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%" style="min-width: 332px;">
						<input type="file" name="wlDocFile" id="wlDocFile" value="${poInfo.wlDocFile!}" />
						<input type="checkbox" id="wlDocFileYN" name="wlDocFileYN" value="N"/>
						<span class="button-text">N/A</span>
					</td>
					<td class="label" width="12%" style="min-width: 93px;" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- MTC Document -->
	<div class="screenlet">
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.mtcDoc}</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="12%" style="min-width: 134px;" align="right">
						${uiLabelMap.mtcDocFile}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%" style="min-width: 332px;">
						<input type="file" name="mtcDocFile" id="mtcDocFile" value="${poInfo.mtcDocFile!}" />
						<input type="checkbox" id="mtcDocFileYN" name="mtcDocFileYN" value="N"/>
						<span class="button-text">N/A</span>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" align="right">
						${uiLabelMap.mtcVerificationStatus}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<select name="mtcVerified" id="mtcVerified">
							<option value=""></option>
						<#if codeList??>
							<#list codeList as codeInfo>
								<#if codeInfo.codeGroup == "MTC_VERIFIED">
							<option value="${codeInfo.code!}" <#if codeInfo.code == poInfo.mtcVerified! >selected="selected"</#if>>${codeInfo.codeName!}</option>
								</#if>
							</#list>
						</#if>
						</select>
					</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- Shipment Advice Document -->
	<div class="screenlet">
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.shipmentAdviceDoc}</li>
			</ul>
			<br class="clear"/>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" width="12%" style="min-width: 134px;" align="right">
						${uiLabelMap.shipmentAdviceDocFile}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%" style="min-width: 300px;">
						<input type="file" name="shipmentAdviceDocFile" id="shipmentAdviceDocFile" value="${poInfo.shipmentAdviceDocFile!}" />
						<input type="checkbox" id="shipmentAdviceDocFileYN" name="shipmentAdviceDocFileYN" value="N"/>
						<span class="button-text">N/A</span>
					</td>
				</tr>
				<tr>
					<td class="label" width="12%" style="min-width: 134px;" align="right">
						${uiLabelMap.shippingAgent}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%"  style="min-width: 332px;">
						<input type="text" name="shippingAgent" id="shippingAgent" value="${poInfo.shippingAgent!}" />
					</td>
					<td class="label" width="12%" align="right">
						${uiLabelMap.email}
					</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">
						<input type="text" name="email" id="email" value="${poInfo.email!}" />
					</td>
					<td class="label" width="12%" align="right">&nbsp;</td>
					<td width="1%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
	<div>
		<ul>
			<input id="submitBtn" type="button" value="${uiLabelMap.submit}" class="buttontext"/>
		</ul>
	</div>
</form>