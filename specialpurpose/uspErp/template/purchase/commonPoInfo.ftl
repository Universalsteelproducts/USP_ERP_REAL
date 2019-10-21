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
	var initCrudMode = "${crudMode}";
	$(".asmSelect").remove();
	$(".asmList").remove();
	jQuery(document).ready(function() {
		/***************************************************************************
	     ******************			Common Control				********************
	     ***************************************************************************/

	    /***************************************************************************
	     ******************			InputBox Control			********************
	     ***************************************************************************/
	    $("#poNo").on("change", function() {
            jQuery.ajax({
                url: '<@ofbizUrl>CRUPoList</@ofbizUrl>',
                type: 'POST',
                data: {
                    "crudMode" : "DP",
                    "poNo" : $("#poNo").val()
                },
                error: function(msg) {
                    showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
                },
                success: function(data, status) {
                    if(data.data[0] != null) {
                        alert("Existed PO Number");
                        $("#poNo").val("");
                    }
                }
            });
        });

	    /***************************************************************************
	     ******************			SelectBox Control			********************
	     ***************************************************************************/
        /*$("select[multiple]").asmSelect({
            addItemTarget: 'bottom',
            hideWhenAdded: true,
            animate: true,
            highlight: true,
            sortable: true
        }).after($("<a href='#'>Select All</a>").click(function() {
            $("#purchaseClass").children().attr("selected", "selected").end().change();
            return false;
        }));*/

	    /***************************************************************************
	     ******************				Button Control			********************
	     ***************************************************************************/

	});
</script>

<form name="poInfoForm" id="poInfoForm" method="post">
    <input type="hidden" name="crudMode" id="crudMode" value="${crudMode}"/>

	<!-- Purchase Order Info -->
	<div>
		<ul align="right">
		<#if pageAction == "edit">
			<label class="label">
				Issue Date : ${poCommonInfo.createdStamp!?string("yyyy-MM-dd")},
				Last Updated Date : ${poCommonInfo.lastUpdatedStamp!?string("yyyy-MM-dd")}
			</label>
		</#if>
		</ul>
	</div>
	<br />
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
				    <td class="label" width="12%" align="right">
                        ${uiLabelMap.poNo}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%">
                        <input type="text" name="poNo" id="poNo" size="25" maxlength="255" value="${poNo!}" />
                    </td>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.priceTerm}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%">
                        <select name="priceTerm" id="priceTerm" style="min-width:60px">
                            <option value="">--Select</option>
                        <#if priceTerm??>
                            <#list priceTerm as priceTermInfo>
                            <option value="${priceTermInfo.termTypeId!}">${priceTermInfo.description!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
					<td class="label" width="13%" align="right" >
						${uiLabelMap.supplier}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="20%">
					<#if pageAction == "edit">
						${poCommonInfo.supplierId!}
					<#else>
						<!-- set_multivalues -->
						<@htmlTemplate.lookupField value="${poCommonInfo.supplierId!}" formName="poInfoForm" name="supplierId" id="supplierId" fieldFormName="LookupSupplier" position="center" />
					</#if>
						<input type="hidden" name="supplierInitials" id="supplierInitials" value="" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
				    <td class="label" width="13%" align="right">
                        ${uiLabelMap.orderDate}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="20%">
                    <#if pageAction == "edit">
                        ${poCommonInfo.orderDate!}
                    <#else>
                        <!-- set_multivalues -->
                        <@htmlTemplate.renderDateTimeField name="orderDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" value="${poCommonInfo.orderDate!}" size="25" maxlength="50" id="orderDate" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
                    </#if>
                    </td>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.freightTerm}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="20%">
                        <select name="freightTerm" id="freightTerm" style="min-width:60px">
                            <option value="">--Select</option>
                        <#if paymentMethodType??>
                            <#list paymentMethodType as paymentMethodTypeInfo>
                            <option value="${paymentMethodTypeInfo.paymentMethodTypeId!}">${paymentMethodTypeInfo.description!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                    <td class="label" width="13%" align="right" >
                        ${uiLabelMap.purchaseAgent}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="20%">
                        <select name="agentId" id="agentId" style="min-width:60px">
                            <option value="">--Select</option>
                        <#if purchaseAgent??>
                            <#list purchaseAgent as purchaseAgentInfo>
                            <option value="${purchaseAgentInfo.purchaseAgentId!}">${purchaseAgentInfo.purchaseAgentNm!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.poStatus}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="20%">
					<#if pageAction == "new">
					    PO Entered
                        <input type="hidden" name="poStatus" id="poStatus" value="PE" />
                    <#else>
                        <#if poStatus??>
                            <#list poStatus as poStatusInfo>
                                <#if poStatusInfo.poStatusId == poCommonInfo.poStatus>
                                ${poStatusInfo.poStatusNm}
                                </#if>
                            </#list>
                        </#if>
                    </#if>
					</td>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.paymentTerm}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="20%">
                        <select name="paymentTerm" id="paymentTerm" style="min-width:60px">
                            <option value="">--Select</option>
                        <#if paymentMethodType??>
                            <#list paymentMethodType as paymentMethodTypeInfo>
                            <option value="${paymentMethodTypeInfo.paymentMethodTypeId!}">${paymentMethodTypeInfo.description!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.totalQuantity}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%">
                        <input type="text" name="totalOrderQty" id="totalOrderQty" value="${totalQuantity!}" size="18" style="text-align:right;background-color:#EEEEEE;" readonly="readonly" />
                        <select name="totalQtyUnit" id="totalQtyUnit" disabled="disabled" style="width:45px;">
                            <option value=""></option>
                            <option value="MT">MT</option>
                            <option value="LB">LB</option>
                        </select>
                    </td>
				</tr>
				<tr>
				    <td class="label" width="13%" align="right">
                        ${uiLabelMap.shipmentMonth}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="20%">
                        <input type="text" name="shipmentMonth" id="shipmentMonth" size="25" value='' />
                    </td>
                    <td class="label" width="13%" align="right">
						${uiLabelMap.downPayment}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="20%">
					<#if pageAction == "edit">
						${poCommonInfo.downPayment?default(0)?string(',##0.00')}
					<#else>
						$ <input type="text" name="downPayment" id="downPayment" value='' size="17" maxlength="255" style="text-align:right;" />
					</#if>
					</td>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.totalPoAmount}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%">
                        <input type="text" name="totalOrderAmount" id="totalOrderAmount" value="${totalPrice!}" size="18" style="text-align:right;background-color:#EEEEEE;" readonly="readonly" />
                        <select name="totalOrderAmountUnit" id="totalOrderAmountUnit" disabled="disabled" style="width:45px;">
                            <option value=""></option>
                            <option value="MT">$/MT</option>
                            <option value="LB">$/LB</option>
                        </select>
                    </td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.orderRemark}
					</td>
					<td width="2%">&nbsp;</td>
					<td colspan="7">
						<textarea name="orderRemark" id="orderRemark" rows="3">${poCommonInfo.orderRemark!}</textarea>
					</td>
				</tr>
				<tr>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.internalNote}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td colspan="7">
                        <textarea name="internalNote" id="internalNote" rows="3">${poCommonInfo.internalNote!}</textarea>
                    </td>
                </tr>
                <#if pageAction == "edit">
                <tr>
                    <td align="center">
                        <input type="button" id="voidBtn" value="${uiLabelMap.voidBtn}" class="buttontext" />
                    </td>
                    <td colspan="8" align="right">
                        <input type="button" id="cancelBtn" value="${uiLabelMap.cancelBtn}" class="buttontext" />
                        <input type="button" id="confirmBtn" value="${uiLabelMap.confirmBtn}" class="buttontext" />
                    </td>
                </tr>
                </#if>
			</table>
		</div>
	</div>
</form>