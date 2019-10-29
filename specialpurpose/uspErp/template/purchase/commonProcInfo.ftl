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
	jQuery(document).ready(function() {
		/***************************************************************************
	     ******************			Common Control				********************
	     ***************************************************************************/
        $("select[multiple]").asmSelect({
            addItemTarget: 'bottom',
            hideWhenAdded: true,
            animate: true,
            highlight: true,
            sortable: true
        }).after($("<a href='#'>Select All</a>").click(function() {
            $("#purchaseClass").children().attr("selected", "selected").end().change();
            return false;
        }));

		/***************************************************************************
	     ******************				Init Table				********************
	     ***************************************************************************/

	    /***************************************************************************
	     ******************			InputBox Control			********************
	     ***************************************************************************/

	    /***************************************************************************
	     ******************			SelectBox Control			********************
	     ***************************************************************************/

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
		<#if crudMode == "UR">
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
                        <select name="priceTerm" id="priceTerm">
                            <option value=""></option>
                        <#if priceTermList??>
                            <#list priceTermList as priceTermInfo>
                                <#if priceTermInfo.codeGroup == "QUANTITY_UNIT">
                            <option value="${priceTermInfo.code!}" <#if priceTermInfo.code == totalQuantityUnit! >selected="selected"</#if>>${priceTermInfo.codeName!}</option>
                                <#else>
                            <option value="${priceTermInfo.code!}">${priceTermInfo.codeName!}</option>
                                </#if>
                            </#list>
                        </#if>
                        </select>
                    </td>
					<td class="label" width="13%" align="right" >
						${uiLabelMap.supplier}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="20%">
					<#if crudMode == "UR">
						${poCommonInfo.vendorId!}
					<#else>
						<!-- set_multivalues -->
						<@htmlTemplate.lookupField value="${poCommonInfo.supplierId!}" formName="poInfoForm" name="supplier" id="supplier" fieldFormName="LookupSupplier" position="center" />
					</#if>
						<input type="hidden" name="supplierInitials" id="supplierInitials" value="${poCommonInfo.supplierInitials!}" size="25" maxlength="255"/>
					</td>
				</tr>
				<tr>
				    <td class="label" width="13%" align="right">
                        ${uiLabelMap.orderDate}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="20%">
                    <#if crudMode == "UR">
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
                        <select name="freightTerm" id="freightTerm">
                            <option value=""></option>
                        <#if freightTermList??>
                            <#list freightTermList as freightTermInfo>
                                <#if freightTermInfo.codeGroup == "QUANTITY_UNIT">
                            <option value="${freightTermInfo.code!}" <#if freightTermInfo.code == totalQuantityUnit! >selected="selected"</#if>>${freightTermInfo.codeName!}</option>
                                <#else>
                            <option value="${freightTermInfo.code!}">${freightTermInfo.codeName!}</option>
                                </#if>
                            </#list>
                        </#if>
                        </select>
                    </td>
                    <td class="label" width="13%" align="right" >
                        ${uiLabelMap.purchaseAgent}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="20%">
                    <#if crudMode == "UR">
                        ${poCommonInfo.purchaseAgentId!}
                    <#else>
                        <!-- set_multivalues -->
                        <@htmlTemplate.lookupField value="${poCommonInfo.purchaseAgentId!}" formName="poInfoForm" name="purchaseAgent" id="purchaseAgent" fieldFormName="LookupPurchaseAgent" position="center" />
                    </#if>
                        <input type="hidden" name="purchaseAgentInitials" id="purchaseAgentInitials" value="${poCommonInfo.purchaseAgentInitials!}" size="25" maxlength="255"/>
                    </td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.poStatus}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
					<#if crudMode == "R" || crudMode == "CR" || crudMode == "CL">
					    Open
                        <input type="hidden" name="poStatus" id="poStatus" value="PE" />
                    <#else>
                        <input type="hidden" name="poStatus" id="poStatus" value="${poCommonInfo.poStatus!}"/>
                    </#if>
					</td>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.paymentTerm}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="20%">
                        <select name="paymentTerm" id="paymentTerm">
                            <option value=""></option>
                        <#if paymentTermList??>
                            <#list paymentTermList as paymentTermInfo>
                                <#if paymentTermInfo.codeGroup == "QUANTITY_UNIT">
                            <option value="${paymentTermInfo.code!}" <#if paymentTermInfo.code == totalQuantityUnit! >selected="selected"</#if>>${paymentTermInfo.codeName!}</option>
                                <#else>
                            <option value="${paymentTermInfo.code!}">${paymentTermInfo.codeName!}</option>
                                </#if>
                            </#list>
                        </#if>
                        </select>
                    </td>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.totalQuantity}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%">
                        <input type="text" name="totalQuantity" id="totalQuantity" value="${totalQuantity!}" style="text-align:right;background-color:#EEEEEE;" readonly="readonly" />
                        <select name="quantityUnit" id="quantityUnit" disabled="disabled">
                            <option value=""></option>
                        <#if codeList??>
                            <#list codeList as codeInfo>
                                <#if codeInfo.codeGroup == "QUANTITY_UNIT">
                            <option value="${codeInfo.code!}" <#if codeInfo.code == totalQuantityUnit! >selected="selected"</#if>>${codeInfo.codeName!}</option>
                                </#if>
                            </#list>
                        </#if>
                        </select>
                    </td>
				</tr>
				<tr>
				    <td class="label" width="13%" align="right">
                        ${uiLabelMap.shipmentMonth}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="20%">
                    <#if crudMode == "UR">
                        ${poCommonInfo.shipmentMonth!}
                    <#else>
                        <!-- set_multivalues -->
                        <@htmlTemplate.renderDateTimeField name="shipmentMonth" event="" action="" className="" alert="" title="Format: yy-MM" value="${poCommonInfo.shipmentMonth!}" size="5" maxlength="5" id="shipmentMonth" dateType="date" shortDateInput=true timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
                    </#if>
                    </td>
                    <td class="label" width="13%" align="right">
						${uiLabelMap.downPayment}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="20%">
					<#if crudMode == "UR">
						${poCommonInfo.downPayment?default(0)?string(',##0.00')}
					<#else>
						$ <input type="text" name="downPayment" id="downPayment" value='' size="23" maxlength="255" style="text-align:right;" />
					</#if>
					</td>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.totalPoAmount}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%">
                        <input type="text" name="totalPoAmount" id="totalPoAmount" value="${totalPrice!}" style="text-align:right;background-color:#EEEEEE;" readonly="readonly" />
                        <select name="priceUnit" id="priceUnit" disabled="disabled">
                            <option value=""></option>
                        <#if codeList??>
                            <#list codeList as codeInfo>
                                <#if codeInfo.codeGroup == "PRICE_UNIT">
                            <option value="${codeInfo.code!}" <#if codeInfo.code == totalPriceUnit! >selected="selected"</#if>>${codeInfo.codeName!}</option>
                                </#if>
                            </#list>
                        </#if>
                        </select>
                    </td>
				</tr>
				<tr>
					<td class="label" width="13%" align="right">
						${uiLabelMap.purchaseClass}
					</td>
					<td width="2%">&nbsp;</td>
					<td colspan="7">
                        <select name="purchaseClass" multiple="multiple" id="purchaseClass">
                            <option value=""></option>
                            <option value="1">1</option>
                            <option value="2">13</option>
                            <option value="3">2</option>
                            <option value=""></option>
                                                        <option value="1">1</option>
                                                        <option value="2">13</option>
                                                        <option value="3">2</option>
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
                <tr>
                    <td align="center">
                        <input type="button" id="voidBtn" value="${uiLabelMap.voidBtn}" class="buttontext" />
                    </td>
                    <td colspan="8" align="right">
                        <input type="button" id="cancelBtn" value="${uiLabelMap.cancelBtn}" class="buttontext" />
                        <input type="button" id="confirmBtn" value="${uiLabelMap.confirmBtn}" class="buttontext" />
                    </td>
                </tr>
			</table>
		</div>
	</div>
</form>