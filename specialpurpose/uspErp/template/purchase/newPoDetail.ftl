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

		/***************************************************************************
	     ******************				Init Table				********************
	     ***************************************************************************/
	    var poListTable = $("#lotColoList").DataTable({
			//dom: "Bfrtip",
			//dom : "frtip",
			dom : "lfrtip",
			processing : true,
			scrollY : true,
			scrollX : true,
			fixedHeader : true,
			ajax : {
				"type"	: "POST",
				"url"	: '<@ofbizUrl>CRUPoList</@ofbizUrl>',
				"data"	: function(d) {
					d.crudMode = $("#crudMode").val();
					d.poNo = $("#poNo").val();
				}
			},
			columns : [
	            {
					"data" : "lotNo",
					"render" : function ( data, type, row ) {
						return "LOT" + checkNull(data);
	  				},
	  				"width": "45px",
	  				"className" : "align-middle"
	            },
	            {
					"data" : "itemId",
	  				"width" : "100px",
	  				"className" : "align-middle"
	            },
	            {
					"data" : "productId",
					"render": function ( data, type, row ) {
                        data = checkNull(data);
                        var $select = $("<select></select>", {
                            "id" : "productId",
                            "value" : data
                        });
                        var $option = "<option value=''></option>";
                    <#if productTmp??>
                        <#list productTmp as productTmpInfo>
                        $option += "<option value='${productTmpInfo.productId!}'>${productTmpInfo.productNm!}</option>";
                        </#list>
                    </#if>

                        $select.append($option);
                        $select.find("[value='" + data + "']").attr("selected", "selected");
                        $select.attr("class", "productId");
                        return $select.prop("outerHTML");
                    },
	  				"width" : "200px",
	  				"className" : "align-middle"
	            },
                {
	            	"data" : "paintCode",
	  				"width" : "100px"
	            },
	            {
	            	"data" : "orderThickness",
	                "render": function ( data, type, row ) {
	                	return "<input type='text' name='orderThickness' id='orderThickness' value='" + data + "' />";
					},
	  				"width" : "150px"
	            },
	            {
	            	"data" : "orderWidth",
	            	"render": function ( data, type, row ) {
		            	return "<input type='text' name='orderWidth' id='orderWidth' value='" + data + "' />";
	            	},
	  				"width" : "50px"
	            },
	            {
	            	"data" : "fobPoint",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "fobPoint",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if fobPointTmp??>
		            	<#list fobPointTmp as fobPointTmpInfo>
		            	$option += "<option value='${fobPointTmpInfo.fobPointId!}'>${fobPointTmpInfo.fobPointNm!}</option>";
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "fobPoint");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "60px"
	            },
	            {
                    "data" : "orderQty",
                    "width" : "60px"
                },
                {
                    "data" : "qtyUnit",
                    "width" : "60px"
                },
	            {
                    "data" : "unitPrice",
                    "render": function ( data, type, row ) {
                        if(data != null && data != "") {
                            data =  checkNull(data).format(2);
                        } else {
                            data =  "";
                        }
                        return "<input type='text' id='unitPrice' style='text-align:right;' name='unitPrice' value='" + data + "'/>";
                    },
                    "width" : "60px"
                },
                {
                    "data" : "priceUnitText",
                    "width" : "60px"
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
                    "data" : "destination",
                    "width" : "120px"
                },
                {
                    "data" : "purchaseClass",
                    "width" : "100px"
                },
                {
                    "data" : "soNo",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        return "<input type='text' id='soNo' name='soNo' value='" + data + "'/>";
                    },
                    "width": "90px",
                    "className" : "align-middle"
                },
                {
                    "data" : "referenceNo",
                    "visible": false
                },
	            {
					"data" : "referenceSeq",
					"visible": false
	            },
                {
                    "data" : "barge",
                    "visible": false
                },
                {
                    "data" : "coatingWeight",
                    "visible": false
                },
                {
                    "data" : "maxWeight",
                    "visible": false
                },
                {
                    "data" : "exw",
                    "visible": false
                },
                {
                    "data" : "fobPointEta",
                    "visible": false
                },
                {
                    "data" : "gaugeControlYield",
                    "visible": false
                },
                {
                    "data" : "grade",
                    "visible": false
                },
                {
                    "data" : "innerDiameter",
                    "visible": false
                },
                {
                    "data" : "note",
                    "visible": false
                },
                {
                    "data" : "packaging",
                    "visible": false
                },
                {
                    "data" : "paintBrand",
                    "visible": false
                },
                {
                    "data" : "paintName",
                    "visible": false
                },
                {
                    "data" : "paintType",
                    "visible": false
                },
                {
                    "data" : "poStatus",
                    "visible": false
                },
                {
                    "data" : "orderQty",
                    "visible": false
                },
                {
                    "data" : "steelType",
                    "visible": false
                },
                {
                    "data" : "surfaceType",
                    "visible": false
                },
                {
                    "data" : "priceUnit",
                    "visible": false
                },
                {
                    "data" : "amountUnit",
                    "visible": false
                },
                {
                    "data" : "orderQtyLB",
                    "visible": false
                }
			],
			rowCallback : function( row, data, displayNum, displayIndex, dataIndex ) {

			},
			drawCallback : function(settings) {
				totalPriceNQuantity(this.api(), "totalOrderQty", "totalOrderAmount");
			},
			footerCallback : function ( row, data, start, end, display ) {
                var api = this.api(), data;

                // Total over all pages
                var weightTotal = api
                    .column( 7 )
                    .data()
                    .reduce( function (a, b) {
                        return intVal(a) + intVal(b);
                    }, 0 );

                // Total over all pages
                var amountTotal = api
                    .column( 11 )
                    .data()
                    .reduce( function (a, b) {
                        return intVal(a) + intVal(b);
                    }, 0 );


                // Total over this page
                var pageWeightTotal = api
                    .column( 7, { page: 'current'} )
                    .data()
                    .reduce( function (a, b) {
                        return intVal(a) + intVal(b);
                    }, 0 );

                var pageAmountTotal = api
                    .column( 11, { page: 'current'} )
                    .data()
                    .reduce( function (a, b) {
                        return intVal(a) + intVal(b);
                    }, 0 );

                // Update footer
                var qtyUnit = $("#qtyUnit").val();
                var priceUnitText = $("#priceUnitText").val();
                $( api.column( 7 ).footer() ).html(
                    'Weight Total : '+pageWeightTotal + ' ' + qtyUnit + '('+ weightTotal + ' ' + qtyUnit + ' total)'
                );
                $( api.column( 11 ).footer() ).html(
                    'Amount Total : '+pageAmountTotal +' ' + priceUnitText + '( '+ amountTotal + ' ' + priceUnitText + ' total)'
                );
            }
	    });

		// 그리드 Row 클릭 이벤트
		$('#lotColoList tbody').on( 'dblclick', 'tr', function () {
	        $(this).toggleClass('selected');
	    } );

		// 그리드 Column 클릭 이벤트
		$("#lotColoList tbody").on( 'click', 'td', function () {
		    var idx = poListTable.cell( this ).index().column;
		    var title = poListTable.column( idx ).header();
		});

		// column value update
		$("#lotColoList").on("change", ":input,textarea,select", function() {
			var val;
			var valType = typeof $(this).val();
			var type = typeof poListTable.cell( $(this).parent() ).data();
			if(type == "number") {
				if(valType == "string") {
					val = Number($(this).val().replace(/\,/g, ""));
				} else {
					val = Number($(this).val());
				}
			} else {
				val = $(this).val();
			}

			poListTable.cell( $(this).parent() ).data(val).draw();
		});

		// column value update
		$("#lotColoList").on("keyup", ":input", function() {
			var id = $(this).attr("id");
			if(id == "unitQuantity") {
				$(this).objectFormat({format : "int"});
				var colIdx = poListTable.cell( $(this).parent() ).index().column;
			}
		});

	    /***************************************************************************
	     ******************			InputBox Control			********************
	     ***************************************************************************/
	    $("input[name=paintCode]").on("change lookup:changed", function() {
    	    var paintColArry = new Array();
            paintColArry.push("paintBrand");
            paintColArry.push("paintName");
            paintColArry.push("paintType");
            var schPaint = "<@ofbizUrl>/schPaint</@ofbizUrl>";
	        setLookupVal("paintCode", $(this).val(), schPaint, paintColArry);
	    });

	    $("#unitPrice,#orderQty").on("change, keyup", function(event) {
	        $(this).objectFormat({format : "float"});
	        var elementId = $(this).prop("id");
            if(elementId == "unitPrice") {
                var qty = Number($("#orderQty").val()) >= 0 ? Number($("#orderQty").val()) : 0;
                var curVal = parseFloat($(this).val());
                var amount = qty * curVal;

                $("#amount").val(amount);
            } else if(elementId == "orderQty") {
                var unitPrice = parseFloat($("#unitPrice").val()) >= 0 ? parseFloat($("#unitPrice").val()) : 0;
                var curVal = parseFloat($(this).val());
                var amount = unitPrice * curVal;

                $("#amount").val(amount);
            }
	    });

	    /***************************************************************************
	     ******************			SelectBox Control			********************
	     ***************************************************************************/
        $("#qtyUnit").on("change", function() {
            $("#totalQtyUnit").val($(this).val());
            $("#totalOrderAmountUnit").val($(this).val());
            $("#priceUnit").val($(this).val());
            $("#priceUnitText").val($("#priceUnit option:selected").text());
            $("#amountUnit").val($(this).val());
            $("#commissionPriceUnit").val($(this).val());
        });

        $("#productId").on("change", function() {
            var curNm = $("#productId option:selected").text();
            $("#productNm").val(curNm);
        });

	    /***************************************************************************
	     ******************				Button Control			********************
	     ***************************************************************************/
        $("#createLot").on("click", function() {
            var lotIdx = $("#lotNo option").size();
            lotIdx = lotIdx >= 10 ? lotIdx : '0' + lotIdx;
            $("#lotCommonInfo #lotNo").append("<option value='" + lotIdx + "'>LOT" + lotIdx + "</option>");

            inputInit("lotDetail");
            inputInit("productDetail1");
            inputInit("productDetail2");

            $("#lotCommonInfo #lotNo option:eq(" + lotIdx + ")").attr("selected", true);
        });

        $("#deleteLot").on("click", function() {
            var curValue = $("#lotNo option:selected").val();
            var curIndex = $("#lotNo option:selected").index() - 1;

            if(curValue != "") {
                $("#lotNo option:selected").remove();
                $("#lotNo option:eq(" + curIndex + ")").prop('selected', true);
            }
        });

        $("#clearBtn").on("click", function() {
            inputInit("lotDetail");
            inputInit("productDetail1");
            inputInit("productDetail2");
            //$("#lotColoList tbody").children().remove();
        });

        $("#addToOrderBtn").on("click", function() {
            if($("input[name=supplierId]").val() == null || $("input[name=supplierId]").val() == "") {
                alert("Select Supplier");
                return false;
            }

            if($("#poNo").val() == null || $("#poNo").val() == "") {
                alert("Select Supplier");
                return false;
            }

            if($("#lotNo").val() == "") {
                alert("Select LOT");
                return false;
            }

            var rowMap = new Object();
            rowMap = addToOrder("lotCommonInfo", rowMap);
            rowMap = addToOrder("productSpec", rowMap);
            rowMap = addToOrder("productAttr", rowMap);
            rowMap = addToOrder("itemInfo", rowMap);

            rowMap["referenceNo"] = $("#poNo").val() + $("#lotNo").val() + "00";
            if($("#paintCode").val() == "") {
                rowMap["paintCode"] = "";
            }
            if($("#paintName").val() == "") {
                rowMap["paintName"] = "";
            }

            var orderQtyLB = 0;
            if($("#qtyUnit").val() == "MT") {
                orderQtyLB = Number(rowMap["orderQty"]) * 2204.62;
            } else if($("#qtyUnit").val() == "LB") {
                orderQtyLB = Number(rowMap["orderQty"]);
            }
            rowMap["orderQtyLB"] = orderQtyLB;

            poListTable.row.add(rowMap).columns.adjust().draw();
        });

        $("#submitBtn").on("click", function() {
            var reqData = poListTable.rows().data();
            var reqArray = makeArrayData(reqData);
            $("#crudMode").val("C");

            jQuery.ajax({
                url: '<@ofbizUrl>CRUPoList</@ofbizUrl>',
                type: 'POST',
                data: $("#poInfoForm").serialize() + "&reqData=" + JSON.stringify(reqArray),
                error: function(msg) {
                    showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
                },
                success: function(data, status) {
                    if(data.successStr == "success") {
                        alert("PO Create Completed");

                        $("#pageMoveForm").attr("action", "<@ofbizUrl>editPo?poNo=" + $("#poNo").val() + "&pageAction=edit&poStatus=PE</@ofbizUrl>");
                        $("#pageMoveForm").submit();
                    } else {
                        alert("PO Create Fail");
                    }
                }
            });
        });

        $("#moveListBtn").on("click", function() {
            $.confirm({
                title: 'Move To List',
                boxWidth: '500px',
                useBootstrap: false,
                content: '<font style="font-size: 16px;">Are you sure you want to move to before saving?</font>',
                buttons: {
                    confirm: function () {
                        $("#pageMoveForm").attr("action", "<@ofbizUrl>schPoList</@ofbizUrl>");
                        $("#pageMoveForm").submit();
                    },
                    cancel: function () {
                    }
                }
            });
        });
	});
</script>
<#if pageAction == "new">
<!-- LOT Info -->
<div class="screenlet">
	<div class="screenlet-title-bar">
		<ul>
			<li class="h3">
				${uiLabelMap.lotInfo}
			</li>
		</ul>
		<br class="clear"/>
	</div>
	<div class="screenlet-body">
		<table class="basic-table" cellspacing="0" id="lotCommonInfo">
			<tr>
				<td class="label" width="12%" align="right">
					${uiLabelMap.lot}
				</td>
				<td width="1%"></td>
				<td width="20%">
					<select name="lotNo" id="lotNo" style="min-width:60px">
						<option value="">--Select</option>
						<option value="01">LOT01</option>
					</select>
					<input type="button" id="createLot" value="${uiLabelMap.createLotBtn}" class="buttontext" />
					<input type="button" id="deleteLot" value="${uiLabelMap.deleteBtn}" class="buttontext" />
				</td>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.exwEtd}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <input type="text" name="exwEtd" id="exwEtd" value="" size="25" maxlength="255"/>
                </td>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.fobPointEta}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <input type="text" name="fobPointEta" id="fobPointEta" value="" size="25" maxlength="255"/>
                </td>
			</tr>
			<tr>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.destination}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <select name="destination" id="destination" style="min-width:60px">
                        <option value="">--Select</option>
                    <#if destinationTmp??>
                        <#list destinationTmp as destinationTmpInfo>
                        <option value="${destinationTmpInfo.destinationId!}">${destinationTmpInfo.destinationNm!}</option>
                        </#list>
                    </#if>
                    </select>
                </td>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.exw}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <select name="exw" id="exw" style="min-width:60px">
                        <option value="">--Select</option>
                    <#if exw??>
                        <#list exw as exwInfo>
                        <option value="${exwInfo.exwId!}">${exwInfo.exwNm!}</option>
                        </#list>
                    </#if>
                    </select>
                </td>
				<td class="label" width="12%" align="right">
                    ${uiLabelMap.fobPoint}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <select name="fobPoint" id="fobPoint" style="min-width:60px">
                        <option value="">--Select</option>
                    <#if fobPointTmp??>
                        <#list fobPointTmp as fobPointTmpInfo>
                        <option value="${fobPointTmpInfo.fobPointId!}">${fobPointTmpInfo.fobPointNm!}</option>
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
                <td width="20%">
                    <select name="purchaseClass" id="purchaseClass" title="" style="min-width:60px">
                        <option value="">--Select</option>
                    <#if purchaseClass??>
                        <#list purchaseClass as purchaseClassInfo>
                        <option value="${purchaseClassInfo.purchaseClassId!}">${purchaseClassInfo.purchaseClassNm!}</option>
                        </#list>
                    </#if>
                    </select>
                </td>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.customer}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <form name="customerForm" id="customerForm" method="post">
                        <@htmlTemplate.lookupField value="" formName="customerForm" name="customerId" id="customerId" fieldFormName="LookupCustomer" position="center" />
                    </form>
                    <input type="hidden" id="customerNm" name="customerNm" value="">
                </td>
                <td class="label" width="13%" align="right" >
                    ${uiLabelMap.importSO}
                </td>
                <td width="2%">&nbsp;</td>
                <td width="20%">
                    <!-- set_multivalues -->
                    <form name="salesOrderForm" id="salesOrderForm" method="post">
                        <@htmlTemplate.lookupField value="" formName="salesOrderForm" name="soNo" id="soNo" fieldFormName="LookupSalesOrder" position="center" />
                    </form>
                </td>
            </tr>
            <tr>
				<td class="label" width="12%" align="right">
                    ${uiLabelMap.product}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <select name="productId" id="productId" style="min-width:60px">
                        <option value="">--Select</option>
                    <#if productTmp??>
                        <#list productTmp as productTmpInfo>
                        <option value="${productTmpInfo.productId!}">${productTmpInfo.productNm!}</option>
                        </#list>
                    </#if>
                    </select>
                    <input type="hidden" id="productNm" name="productNm" value="">
                </td>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.barge}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <input type="checkbox" id="barge" name="barge" value="Y">
                </td>
            </tr>
            <tr>
                <td class="label" width="13%" align="right">
                    ${uiLabelMap.note}
                </td>
                <td width="2%">&nbsp;</td>
                <td colspan="7">
                    <textarea name="note" id="note" rows="3">${poCommonInfo.note!}</textarea>
                </td>
            </tr>
		</table>
    </div>
</div>

<div class="screenlet" id="lotDetail">
    <div class="screenlet-title-bar">
        <ul>
            <li class="h3">
                ${uiLabelMap.productSpecification}
            </li>
        </ul>
        <br class="clear">
    </div>
    <div class="screenlet-body no-padding">
        <table class="basic-table" cellspacing="0" id="productSpec">
            <tr>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.steelType}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="35%">
                    <select name=steelType id="steelType" style="min-width:60px">
                        <option value="">--Select</option>
                    <#if steelType??>
                        <#list steelType as steelTypeInfo>
                        <option value="${steelTypeInfo.steelTypeId!}" >${steelTypeInfo.steelTypeNm!}</option>
                        </#list>
                    </#if>
                    </select>
                </td>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.thickness}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="35%">
                    <input type="text" name="orderThickness" id="orderThickness" value="" size="25" maxlength="255"/>
                </td>
            </tr>
            <tr>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.surfaceCoilType}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="35%">
                    <select name="surfaceType" id="surfaceType" style="min-width:60px">
                        <option value="">--Select</option>
                    <#if surfaceType??>
                        <#list surfaceType as surfaceTypeInfo>
                        <option value="${surfaceTypeInfo.surfaceTypeId!}">${surfaceTypeInfo.surfaceTypeNm!}</option>
                        </#list>
                    </#if>
                    </select>
                </td>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.width}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="35%">
                    <input type="text" name="orderWidth" id="orderWidth" value="" size="25" maxlength="255"/>
                </td>
            </tr>
            <tr>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.grade}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="35%">
                    <select name="grade" id="grade" style="min-width:60px">
                        <option value="">--Select</option>
                    <#if grade??>
                        <#list grade as gradeInfo>
                        <option value="${gradeInfo.gradeId!}">${gradeInfo.gradeNm!}</option>
                        </#list>
                    </#if>
                    </select>
                </td>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.coilMaxWeight}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="35%">
                    <input type="text" name="maxWeight" id="maxWeight" value="" size="25" maxlength="255"/>
                </td>
            </tr>
            <tr>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.coatingWeight}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="35%">
                    <select name="coatingWeight" id="coatingWeight" style="min-width:60px">
                        <option value="">--Select</option>
                    <#if coatingWeight??>
                        <#list coatingWeight as coatingWeightInfo>
                        <option value="${coatingWeightInfo.coatingWeightId!}">${coatingWeightInfo.coatingWeightNm!}</option>
                        </#list>
                    </#if>
                    </select>
                </td>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.packaging}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="35%">
                    <select name="packaging" id="packaging" style="min-width:60px">
                        <option value="">--Select</option>
                    <#if packaging??>
                        <#list packaging as packagingInfo>
                        <option value="${packagingInfo.packagingId!}">${packagingInfo.packagingNm!}</option>
                        </#list>
                    </#if>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.coilId}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="35%">
                    <input type="text" name="innerDiameter" id="innerDiameter" value="" size="25" maxlength="255"/>
                </td>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.gaugeControlYield}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="35%">
                    <input type="text" name="gaugeControlYield" id="gaugeControlYield" size="25" value="" maxlength="255"/>
                </td>
            </tr>
        </table>
    </div>
</div>

<div class="lefthalf" id="productDetail1">
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">
                    ${uiLabelMap.productAttribute}
                </li>
            </ul>
            <br class="clear">
        </div>
        <div class="screenlet-body no-padding">
            <table class="basic-table" cellspacing="0" id="productAttr">
                <tr>
                    <td class="label" width="15%" align="right">
                        ${uiLabelMap.paintCode}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="34%" >
                        <form name="paintCodeForm" id="paintCodeForm" method="post">
                            <@htmlTemplate.lookupField value="" formName="paintCodeForm" name="paintCode" id="paintCode" fieldFormName="LookupPaint" position="center" />
                        </form>
                    </td>
                    <td class="label" width="15%" align="right">
                        ${uiLabelMap.paintName}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="34%" >
                        <input type="text" name="paintName" id="paintName" disabled="disabled" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right">
                        ${uiLabelMap.paintBrand}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="34%" >
                        <input type="text" name="paintBrand" id="paintBrand" disabled="disabled" maxlength="255"/>
                    </td>
                    <td class="label" width="15%">
                        ${uiLabelMap.paintType}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="34%" >
                        <input type="text" name="paintType" id="paintType" disabled="disabled" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right">
                        ${uiLabelMap.itemId}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="34%" colspan="4">
                        <input type="text" name="itemId" id="itemId"  maxlength="255"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<div class="righthalf" id="productDetail2">
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">
                    ${uiLabelMap.order}
                </li>
            </ul>
            <br class="clear">
        </div>
        <div class="screenlet-body no-padding">
            <table class="basic-table" cellspacing="0" id="itemInfo">
                <tr>
                    <td class="label" width="15%" align="right">
                        ${uiLabelMap.qty}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="34%" >
                        <input type="text" name="orderQty" id="orderQty" size="16" maxlength="255" style="text-align:right;" />
                        <select name="qtyUnit" id="qtyUnit" style="width:45px;">
                            <option value=""></option>
                            <option value="MT">MT</option>
                            <option value="LB">LB</option>
                        </select>
                    </td>
                    <td class="label" width="15%" align="right">
                        ${uiLabelMap.commissionPrice}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="34%" >
                        <input type="text" name="commissionPrice" id="commissionPrice" size="16" maxlength="255"/>
                        <select name="commissionPriceUnit" id="commissionPriceUnit" disabled="disabled" style="width:45px;">
                            <option value=""></option>
                            <option value="MT">$/MT</option>
                            <option value="LB">$/LB</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right">
                        ${uiLabelMap.unitPrice}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="34%" >
                        <input type="text" name="unitPrice" id="unitPrice" size="16" maxlength="255" style="text-align:right;" />
                        <select name="priceUnit" id="priceUnit" disabled="disabled" style="width:45px;">
                            <option value=""></option>
                            <option value="MT">$/MT</option>
                            <option value="LB">$/LB</option>
                        </select>
                        <input type="hidden" id="priceUnitText" name="priceUnitText" />
                    </td>
                    <td class="label" width="15%" align="right">
                        ${uiLabelMap.amount}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="34%" >
                        <input type="text" name="amount" id="amount" size="16" disabled="disabled" maxlength="255" style="text-align:right;" />
                        <select name="amountUnit" id="amountUnit" disabled="disabled" style="width:45px;">
                            <option value=""></option>
                            <option value="MT">$/MT</option>
                            <option value="LB">$/LB</option>
                        </select>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <br />
    <ul align="right">
        <input id="clearBtn" type="button" value="${uiLabelMap.clearBtn}" class="buttontext"/>
        <input id="addToOrderBtn" type="button" value="${uiLabelMap.addToOrderBtn}" class="buttontext"/>
    </ul>
</div>
<div class="clear">
</div>
</#if>
<div class="screenlet">
	<form name="lotInfo" id="lotInfo" method="post">
		<table class="display cell-border stripe" id="lotColoList" name="lotColoList">
			<thead>
				<tr>
					<th style="vertical-align: middle;">${uiLabelMap.lot}</th>
					<th style="vertical-align: middle;">${uiLabelMap.itemId}</th>
					<th style="vertical-align: middle;">${uiLabelMap.productId}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintCode}</th>
					<th style="vertical-align: middle;">${uiLabelMap.thickness}</th>
					<th style="vertical-align: middle;">${uiLabelMap.width}</th>
					<th style="vertical-align: middle;">${uiLabelMap.fobPoint}</th>
					<th style="vertical-align: middle;">${uiLabelMap.weight}</th>
					<th style="vertical-align: middle;">${uiLabelMap.weightUnit}</th>
					<th style="vertical-align: middle;">${uiLabelMap.unitCost}</th>
					<th style="vertical-align: middle;">${uiLabelMap.costUnit}</th>
					<th style="vertical-align: middle;">${uiLabelMap.amount}</th>
					<th style="vertical-align: middle;">${uiLabelMap.destination}</th>
					<th style="vertical-align: middle;">${uiLabelMap.purchaseClass}</th>
					<th style="vertical-align: middle;">${uiLabelMap.soNo}</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			<tfoot>
				<tr>
                    <th colspan="8" style="text-align:right"></th>
					<th colspan="4" style="text-align:right"></th>
                    <th colspan="3"></th>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<div>
	<ul>
	    <input id="moveListBtn" type="button" value="${uiLabelMap.list}" class="buttontext"/>
	<#if pageAction == "new">
		<input id="submitBtn" type="button" value="${uiLabelMap.savePo}" class="buttontext"/>
	</#if>
	</ul>
</div>

<form name="pageMoveForm" id="pageMoveForm" method="post">