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
		/***************************************************************************
		 ******************			Common Control				********************
		 ***************************************************************************/
		var poListTable = $("#poList").DataTable({
			dom : "lfrtip",
			processing : true,
			scrollY : true,
	        scrollX : true,
	        ajax : {
	        	"type"		: "POST",
	            "url"		: '<@ofbizUrl>RUPoList</@ofbizUrl>',
	            "data"		: function(d) {
	            	d.draw = "0";
	            	d.crudMode = $("#crudMode").val();
	            	d.schPoStatus = $("#schPoStatus").val();
	            	d.schSupplierId = $("input[name=schSupplierId]").val();
	            	d.schPoNo = $("#schPoNo").val();

	            	d.schProductId = $("#schProductId").val();
	            	d.schCustomerId = $("input[name=schCustomerId]").val();
	            	d.schOrderFromDate = $("#schOrderFromDate").val();
	            	d.schOrderToDate = $("#schOrderToDate").val() + " 23:59:59";
	            }
	        },
	        columns : [
	        	{
	        		"data" : "poStatus",
        			"render": function ( data, type, row ) {
        				var $select = $("<select></select>", {
        	                "id" : "poStatus",
        	                "value" : data
        	            });
        				var $option = $("#poStatusTemp").html();
       	                $select.append($option);
       	             	$select.find("[value='" + data + "']").attr("selected", "selected");
       	             	$select.attr("class", "poStatus");
            			return $select.prop("outerHTML");
	                },
                    "width" : "60px"
	        	},
	        	{
	        		"data" : "poNo",
	        		"render": function ( data, type, row ) {
	        			return "<a href='<@ofbizUrl>editPo?poNo=" + data + "</@ofbizUrl>' class='buttontext'>" + data + "</a>";
	                },
                    "width" : "60px"
	        	},
	        	{
	        		"data" : "lotNo",
	        		"render": function ( data, type, row ) {
	                    return "<b>LOT" + data + "</b>";
	                },
	                "width" : "60px"
	        	},
	        	{
                    "data" : "shipmentMonth",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "120px"
                },
	        	{
                    "data" : "fobPoint",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "80px"
                },
                {
                    "data" : "destination",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "60px"
                },
                {
                    "data" : "soNo",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "90px"
                },
                {
                    "data" : "customerNm",
                    "render": function ( data, type, row ) {
                        return data;
                    }
                },
	        	{
                    "data" : "productNm",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "200px",
                    "className" : "dt-body-center"
                },
	        	{
                    "data" : "paintCode",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "80px"
                },
	        	{
                    "data" : "paintName",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "70px"
                },
	        	{
                    "data" : "qty",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "60px",
                    "className" : "dt-body-right"
                },
	        	{
                    "data" : "unitPrice",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "60px",
                    "className" : "dt-body-right"
                },
	        	{
                    "data" : "amount",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "60px",
                    "className" : "dt-body-right"
                },
	        	{
                    "data" : "produced",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "60px",
                    "className" : "dt-body-center"
                },
	        	{
                    "data" : "invoiceRev",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "80px",
                    "className" : "dt-body-center"
                },
	        	{
                    "data" : "shipmentCreated",
                    "render": function ( data, type, row ) {
                        return data;
                    },
                    "width" : "120px",
                    "className" : "dt-body-center"
                },
	        	{
	        		"data" : "referenceNo",
	        		"visible": false
	        	},
	        	{
                    "data" : "referenceSeq",
                    "visible": false,
                },
	        	/*{
	        		"data" : "lastUpdateUserId",
	  				"visible": false
	        	},*/
	        	{
                    "data" : "productId",
                    "visible": false
                },
	        	{
	        		"data" : "lastUpdatedStamp",
	        		"render" : function ( data, type, row ) {
	        			var date = new Date(data);
	        			var d = date.getDate();
	        			if(d < 10) {
	        				d = "0" + d;
	        			}
	        			var m = date.getMonth();
        				m += 1;
	        			if(m < 10) {
	        				m = "0" + m;
	        			}
	        			var y = date.getFullYear();

						return y + "-" + m + "-" + d;
	        		},
	        		"visible": false
	        	}
	        ]
		});

		/***************************************************************************
		 ******************			Table change Event			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************			SelectBox Control			********************
		 ***************************************************************************/
		$("#poList").on("change", "select.poStatus",function() {
			var reqData = poListTable.rows($(this).parent().parent()).data();
			var reqArray = new Array();
			reqData[0]["poStatus"] = $(this).val();
            reqArray.push(reqData[0]);

			jQuery.ajax({
				url: '<@ofbizUrl>RUPoList</@ofbizUrl>',
				type: 'POST',
				data: {
					"crudMode" : "U",
					"reqData" : JSON.stringify(reqArray)
				},
				error: function(msg) {
		            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
		        },
				success: function(data) {
					if(data.data.length > 0) {
						alert("PO Status Update Complete.");
						$("#searchBtn").click();
					} else {
						alert("PO Status Update Fail.");
					}
				}
			});
		});

		/***************************************************************************
		 ******************				Button Control			********************
		 ***************************************************************************/
		$("#searchBtn").on("click", function() {
			$("#crudMode").val("R");
			poListTable.ajax.reload();
		});
	});
</script>

<div style="display:none;" id="poStatusTemp">
	<#if poStatus??>
        <#list poStatus as poStatusInfo>
    <option value="${poStatusInfo.poStatusId!}">${poStatusInfo.poStatusNm!}</option>
        </#list>
    </#if>
</div>

<div class="page-title">
	<span>
		${uiLabelMap.PurchaseOrder}
	</span>
</div>
<div class="button-bar">
	<a class="buttontext create" href="/uspErp/control/newPo?pageAction=new">
		${uiLabelMap.newPo}
	</a>
</div>

<form name="searchForm" id="searchForm" method="post">
	<input type="hidden" name="noConditionFind" value="Y"/>
	<input type="hidden" name="crudMode" id="crudMode" value="R"/>
	<input type="hidden" name="data" id="data" value=""/>

	<!-- Search Condition -->
	<div class="screenlet">
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.schCon}</li>
			</ul>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
				    <td class="label" align="right" >
                        ${uiLabelMap.poStatus}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="20%">
                        <select name="schPoStatus" id="schPoStatus">
                        <#if poStatus??>
                            <option value="">--Select</option>
                            <#list poStatus as poStatusInfo>
                            <option value="${poStatusInfo.poStatusId!}">${poStatusInfo.poStatusNm!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                    <td class="label" align="right" >
                        ${uiLabelMap.supplier}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="20%">
                        <!-- set_multivalues -->
                        <@htmlTemplate.lookupField value="" formName="searchForm" name="schSupplierId" id="schSupplierId" fieldFormName="LookupSupplier" position="center" />
                    </td>
					<td class="label" align="right" >
						${uiLabelMap.poNo}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="20%">
						<!-- set_multivalues -->
						<input type="text" name="schPoNo" id="schPoNo" maxlength="255"/>
					</td>
				</tr>
				<tr>
					<td class="label" align="right" >
						${uiLabelMap.product}
					</td>
					<td width="2%">&nbsp;</td>
					<td>
					    <select name="schProductId" id="schProductId">
						<#if productList??>
                            <#list productList as productInfo>
                            <option value="${productInfo.code!}">${productInfo.codeName!}</option>
                            </#list>
                        </#if>
                            <option value="">--Select</option>
                            <option value="G5AAG2">GRADE 50 AZ50 ACRYLIC GALVALUME 29GA x 41.56</option>
                            <option value="G5ABG2">GRADE 50 AZ50 BTP GALVALUME 29GA x 41.56</option>
                        </select>
					</td>
					<td class="label" align="right" >
						${uiLabelMap.customerId}
					</td>
					<td width="2%">&nbsp;</td>
					<td>
						<!-- set_multivalues -->
						<@htmlTemplate.lookupField value="" formName="searchForm" name="schCustomerId" id="schCustomerId" fieldFormName="LookupCustomer" position="center" />
					</td>
					<td class="label" align="right" >
						${uiLabelMap.orderDate}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<@htmlTemplate.renderDateTimeField name="schOrderFromDate" id="schOrderFromDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd" value="${orderFromDate?string('yyyy-MM-dd')}" size="10" maxlength="10" dateType="date" shortDateInput=true timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
						&nbsp;~&nbsp;
						<@htmlTemplate.renderDateTimeField name="schOrderToDate" id="schOrderToDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd" value="${orderToDate?string('yyyy-MM-dd')}" size="10" maxlength="10" dateType="date" shortDateInput=true timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
					</td>
				</tr>
				<tr>
					<td class="label" align="right">
						&nbsp;
					</td>
					<td width="2%">&nbsp;</td>
					<td colspan="7">
						<input type="button" id="searchBtn" value="${uiLabelMap.CommonFind}" class="buttontext" />
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>

<!-- Search Result -->
<div class="screenlet">
	<table id="poList" class="hover cell-border stripe">
		<thead>
			<tr>
				<th style="vertical-align: middle;">${uiLabelMap.poStatus}</th>
				<th style="vertical-align: middle;">${uiLabelMap.poNo}</th>
				<th style="vertical-align: middle;">${uiLabelMap.lotNo}</th>
				<th style="vertical-align: middle;">${uiLabelMap.shipmentMonth}</th>
				<th style="vertical-align: middle;">${uiLabelMap.fobPoint}</th>
				<th style="vertical-align: middle;">${uiLabelMap.destination}</th>
				<th style="vertical-align: middle;">${uiLabelMap.soNo}</th>
				<th style="vertical-align: middle;">${uiLabelMap.customer}</th>
				<th style="vertical-align: middle;">${uiLabelMap.productId}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintCode}</th>
				<th style="vertical-align: middle;">${uiLabelMap.paintName}</th>
				<th style="vertical-align: middle;">${uiLabelMap.orderQty}</th>
				<th style="vertical-align: middle;">${uiLabelMap.unitPrice}</th>
				<th style="vertical-align: middle;">${uiLabelMap.amount}</th>
				<th style="vertical-align: middle;">${uiLabelMap.produced}</th>
				<th style="vertical-align: middle;">${uiLabelMap.invoicedRev}</th>
				<th style="vertical-align: middle;">${uiLabelMap.shipmentCreated}</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<th style="vertical-align: middle;">${uiLabelMap.poStatus}</th>
                <th style="vertical-align: middle;">${uiLabelMap.poNo}</th>
                <th style="vertical-align: middle;">${uiLabelMap.lotNo}</th>
                <th style="vertical-align: middle;">${uiLabelMap.shipmentMonth}</th>
                <th style="vertical-align: middle;">${uiLabelMap.fobPoint}</th>
                <th style="vertical-align: middle;">${uiLabelMap.destination}</th>
                <th style="vertical-align: middle;">${uiLabelMap.soNo}</th>
                <th style="vertical-align: middle;">${uiLabelMap.customer}</th>
                <th style="vertical-align: middle;">${uiLabelMap.productId}</th>
                <th style="vertical-align: middle;">${uiLabelMap.paintCode}</th>
                <th style="vertical-align: middle;">${uiLabelMap.paintName}</th>
                <th style="vertical-align: middle;">${uiLabelMap.orderQty}</th>
                <th style="vertical-align: middle;">${uiLabelMap.unitPrice}</th>
                <th style="vertical-align: middle;">${uiLabelMap.amount}</th>
                <th style="vertical-align: middle;">${uiLabelMap.produced}</th>
                <th style="vertical-align: middle;">${uiLabelMap.invoicedRev}</th>
                <th style="vertical-align: middle;">${uiLabelMap.shipmentCreated}</th>
			</tr>
		</tfoot>
	</table>
</div>