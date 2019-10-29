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
					"data" : "destination",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						var $select = $("<select></select>", {
							"id" : "destination",
							"value" : data
						});
						var $option = "<option value=''></option>";
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "DESTINATION">
						$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
							</#if>
						</#list>
					</#if>

						$select.append($option);
						$select.find("[value='" + data + "']").attr("selected", "selected");
						$select.attr("class", "destination");
						return $select.prop("outerHTML");
					},
	  				"width" : "150px"
	            },
	            {
					"data" : "steelType",//"coilDescription",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						var $select = $("<select></select>", {
							"id" : "steelType",
							"value" : data
						});
						var $option = "<option value=''></option>";
					<#if codeList??>
						<#list codeList as codeInfo>
							<#if codeInfo.codeGroup == "STEEL_TYPE">
						$option += "<option value='${codeInfo.code!}' data-desc='${codeInfo.attribute1!}'>${codeInfo.codeName!}</option>";
							</#if>
						</#list>
					</#if>

						$select.append($option);
						$select.find("[value='" + data + "']").attr("selected", "selected");
						$select.attr("class", "steelType");
						return $select.prop("outerHTML");
					},
	  				"width" : "70px"
	            },
	            {
	            	"data" : "grade",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "grade",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "GRADE">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
	            	</#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "grade");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "50px"
	            },
	            {
					"data" : "gradeDesc",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='gradeDesc' name='gradeDesc' value='" + data + "'/>";
					},
	  				"width" : "150px"
	            },
	            {
	            	"data" : "coatingWeight",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "coatingWeight",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
	            	<#if codeList??>
		            	<#list codeList as codeInfo>
			            	<#if codeInfo.codeGroup == "COATING_WEIGHT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
			            	</#if>
		            	</#list>
	            	</#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "coatingWeight");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "90px"
	            },
	            {
					"data" : "coatingWeightDesc",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='coatingWeightDesc' name='coatingWeightDesc' value='" + data + "'/>";
					},
	  				"width" : "160px"
	            },
	            {
	            	"data" : "surfaceCoilType",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "surfaceCoilType",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "SURFACE_COIL_TYPE">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "surfaceCoilType");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "110px"
	            },
	            {
					"data" : "surfaceCoilTypeDesc",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='surfaceCoilTypeDesc' name='surfaceCoilTypeDesc' value='" + data + "'/>";
					},
	  				"width" : "160px"
	            },
	            {
	            	"data" : "gauge",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "gauge",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "GAUGE">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		           	 		</#if>
		            	</#list>
		           	</#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "gauge");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "50px"
	            },
	            {
	            	"data" : "gaugeUnit",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "gaugeUnit",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "GAUGE_UNIT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "gaugeUnit");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "70px"
	            },
	            {
					"data" : "gaugeDesc",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='gaugeDesc' name='gaugeDesc' value='" + data + "'/>";
					},
	  				"width" : "150px"
	            },
	            {
	            	"data" : "width",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "width",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "WIDTH">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "width");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "50px"
	            },
	            {
					"data" : "widthDesc",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='widthDesc' name='widthDesc' value='" + data + "'/>";
					},
	  				"width" : "150px"
	            },
	            {
	            	"data" : "coilMaxWeight",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "coilMaxWeight",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "COIL_MAX_WEIGHT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "coilMaxWeight");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
					"data" : "innerDiameter",
					"render": function ( data, type, row ) {
						data = checkNull(data);
						return "<input type='text' id='innerDiameter' name='innerDiameter' value='" + data + "'/>";
					},
	  				"width" : "100px"
	            },
	            {
					"data" : "gaugeControlYield",
					"render": function ( data, type, row ) {
						data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "gaugeControlYield",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "GUAGE_CONTROL_YIELD">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "gaugeControlYield");
		            	return $select.prop("outerHTML");
					},
	  				"width" : "130px"
	            },
	            {
	            	"data" : "packaging",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "packaging",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PACKAGING">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "packaging");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "70px"
	            },
	            {
	            	"data" : "packagingDesc",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
	                	return "<input type='text' id='packagingDesc' name='packagingDesc' value='" + data + "'/>";
	                },
	  				"width" : "150px"
	            },
	            {
	            	"data" : "businessClass",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "businessClass",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "BUSINESS_CLASS">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "businessClass");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "90px"
	            },
	            {
					"data" : "customerName",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
	  				"width" : "250px"
	            },
	            {
	            	"data" : "otherDetail",
	                "render": function ( data, type, row ) {
	                	data = checkNull(data);
						return "<textarea name='otherDetail' id='otherDetail'>" + data + "</textarea>";
					},
	  				"width" : "170px"
	            },
	            {
	            	"data" : "barge",
	            	"className" : "dt-body-center",
	                "render": function ( data, type, row ) {
	                	data = checkNull(data);
						return "<input type='checkbox' name='barge' id='barge' value='" + data + "' />";
					},
	  				"width" : "50px"
	            },
// 	            {
// 	            	"data" : "orderQuantity",
// 	                "render": function ( data, type, row ) {
// 	                	if(data != null && data != "") {
// 	                		data =  checkNull(data).format();
// 	                	} else {
// 	                		data =  "";
// 	                	}
// 						return "<input type='text' id='orderQuantity' style='text-align:right;' name='orderQuantity' value='" + data + "'/>";
// 					},
// 	  				"width" : "100px"
// 	            },
// 	            {
// 	            	"data" : "orderQuantityUnit",
// 	            	"render": function ( data, type, row ) {
// 	            		data = checkNull(data);
// 		            	var $select = $("<select></select>", {
// 			            	"id" : "orderQuantityUnit",
// 			            	"value" : data
// 		            	});
// 		            	var $option = "<option value=''></option>";
// 		            <#if codeList??>
// 		            	<#list codeList as codeInfo>
// 		            		<#if codeInfo.codeGroup == "QUANTITY_UNIT">
// 		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
// 		            		</#if>
// 		            	</#list>
// 		            </#if>

// 		            	var unit = "";
// 		            	if(row.orderQuantityUnit == null || row.orderQuantityUnit == "") {
// 		            		unit = row.quantityUnit;
// 		            		row.orderQuantityUnit = row.quantityUnit;
// 		            	} else {
// 		            		unit = row.orderQuantityUnit;
// 		            	}

// 		            	$select.append($option);
// 		            	$select.find("[value='" + unit + "']").attr("selected", "selected");
// 		            	$select.attr("class", "orderQuantityUnit");
// 		            	return $select.prop("outerHTML");
// 	            	},
// 	  				"width" : "100px"
// 	            },
	            {
	            	"data" : "unitQuantity",
	                "render": function ( data, type, row ) {
	                	if(data != null && data != "") {
	                		data =  checkNull(data).format();
	                	} else {
	                		data =  "";
	                	}
						return "<input type='text' id='unitQuantity' style='text-align:right;' name='unitQuantity' value='" + data + "'/>";
					},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "quantityUnit",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "quantityUnit",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "QUANTITY_UNIT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + row.quantityUnit + "']").attr("selected", "selected");
		            	$select.attr("class", "quantityUnit");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
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
	  				"width" : "100px"
	            },
	            {
	            	"data" : "priceUnit",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "priceUnit",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PRICE_UNIT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + row.priceUnit + "']").attr("selected", "selected");
		            	$select.attr("class", "priceUnit");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "totalPrice",
	                "render": function ( data, type, row ) {
						return "$ " + (row.unitPrice*row.unitQuantity);
					},
					"className" : "dt-body-right",
	  				"width" : "100px"
	            },
	            {
	            	"data" : "commissionUnitPrice",
	                "render": function ( data, type, row ) {
	                	if(data != null && data != "") {
	                		data =  checkNull(data).format(2);
	                	} else {
	                		data =  "";
	                	}
						return "<input type='text' id='commissionUnitPrice' style='text-align:right;' name='commissionUnitPrice' value='" + data + "'/>";
					},
	  				"width" : "130px"
	            },
	            {
	            	"data" : "commissionUnitPriceUnit",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "commissionUnitPriceUnit",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PRICE_UNIT">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	row.commissionUnitPriceUnit = row.priceUnit;
		            	$select.append($option);
		            	$select.find("[value='" + row.priceUnit + "']").attr("selected", "selected");
		            	$select.attr("class", "commissionUnitPriceUnit");
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "160px"
	            },
	            {
	            	"data" : "paintBrand",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "paintBrand",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PAINT_BRAND">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "paintBrand");
// 		            	var steelType = row.steelType;
// 		            	if(steelType != "PPGI" && steelType != "PPGL") {
// 		            		$select.attr("disabled", "disabled");
// 		            	}
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "paintCode",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "paintCode",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PAINT_CODE">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "paintCode");
// 		            	var steelType = row.steelType;
// 		            	if(steelType != "PPGI" && steelType != "PPGL") {
// 		            		$select.attr("disabled", "disabled");
// 		            	}
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "paintColor",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "paintColor",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PAINT_COLOR">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "paintColor");
// 		            	var steelType = row.steelType;
// 		            	if(steelType != "PPGI" && steelType != "PPGL") {
// 		            		$select.attr("disabled", "disabled");
// 		            	}
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "paintType",
	            	"render": function ( data, type, row ) {
	            		data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "paintType",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PAINT_TYPE">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "paintType");
// 		            	var steelType = row.steelType;
// 		            	if(steelType != "PPGI" && steelType != "PPGL") {
// 		            		$select.attr("disabled", "disabled");
// 		            	}
		            	return $select.prop("outerHTML");
	            	},
	  				"width" : "100px"
	            },
	            {
	            	"data" : "paintCoatingThickness",
	                "render": function ( data, type, row ) {
	                	data = checkNull(data);
		            	var $select = $("<select></select>", {
			            	"id" : "paintCoatingThickness",
			            	"value" : data
		            	});
		            	var $option = "<option value=''></option>";
		            <#if codeList??>
		            	<#list codeList as codeInfo>
		            		<#if codeInfo.codeGroup == "PAINT_COATING_THICKNESS">
		            	$option += "<option value='${codeInfo.code!}'>${codeInfo.codeName!}</option>";
		            		</#if>
		            	</#list>
		            </#if>

		            	$select.append($option);
		            	$select.find("[value='" + data + "']").attr("selected", "selected");
		            	$select.attr("class", "paintCoatingThickness");
// 		            	var steelType = row.steelType;
// 		            	if(steelType != "PPGI" && steelType != "PPGL") {
// 		            		$select.attr("disabled", "disabled");
// 		            	}
		            	return $select.prop("outerHTML");
					},
	  				"width" : "150px"
	            },
	            {
					"data" : "referenceSeq",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
					"visible": false
	            },
	            {
					"data" : "referenceNo",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
					"visible": false
	            },
	            {
					"data" : "ppglNo",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
					"visible": false
	            },
	            {
					"data" : "partialYN",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
					"visible": false
	            },
	            {
					"data" : "partialNo",
					"render": function ( data, type, row ) {
						return checkNull(data);
					},
					"visible": false
	            },
	            {
	            	"data" : "customerId",
	            	"render": function ( data, type, row ) {
						return checkNull(data);
					},
	            	"visible": false
	            }
			],
			rowCallback : function( row, data, displayNum, displayIndex, dataIndex ) {
				if(initCrudMode == "CL") {
					var poNo = generatePoNo();
					var lotNo = data.lotNo;
					data.poNo = poNo + "11";
					data.referenceNo = poNo + "11" + lotNo + "00";
					data.referenceSeq = "";
					data.createUserId = "";
					data.createdStamp = "";
					data.createdTxStamp = "";
					data.lastUpdateUserId = "";
					data.lastUpdatedStamp = "";
					data.lastUpdatedTxStamp = "";
				}
				$('input#barge', row).prop( 'checked', data.barge == "Y" );
			},
			drawCallback : function(settings) {
				//totalPriceNQuantity(this.api(), "totalQuantity", "totalPoAmount");
			}
// 			buttons: [
// 				{
// 					text: 'Delete',
// 					fn: function() {
// 					},
// 					className: 'btn btn-primary'
// 			    }
// 			]
	    });

		// 그리드 Row 클릭 이벤트
		$('#lotColoList tbody').on( 'dblclick', 'tr', function () {
	        $(this).toggleClass('selected');
	    } );

		// 그리드 Column 클릭 이벤트
		$("#lotColoList tbody").on( 'click', 'td', function () {
		    var idx = poListTable.cell( this ).index().column;
		    var title = poListTable.column( idx ).header();
			if(idx == 22) {
				var checkYN = $(this).find(":input").prop("checked");
				if(checkYN) {
					poListTable.cell( this ).data("Y").draw();
				} else {
					poListTable.cell( this ).data("N").draw();
				}
		    }
		} );

		// column value update
		$("#lotColoList").on("change", ":input,textarea,select,check", function() {
// 			var colIdx = poListTable.cell( $(this).parent() ).index().column;
// 			var rowIdx = poListTable.cell( $(this).parent() ).index().row;

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

		if(initCrudMode == "CL") {
	    	var poNo = generatePoNo();
	    	$("#vendorNPoInfo #poNo").val(poNo+"11");
		}

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
				<#if crudMode != "CR">
					<select name="lotNo" id="lotNo" size="1">
						<option value="">--Select</option>
					<#if lotList??>
						<#list lotList as codeInfo>
		   				<option value="${codeInfo.lotNo!}">LOT${codeInfo.lotNo!}</option>
		       			</#list>
		       		</#if>
					</select>
				<#else>
					<select name="lotNo" id="lotNo" size="1">
						<option value="">--Select</option>
						<option value="01">LOT01</option>
					</select>
				</#if>
					<input type="button" id="createLot" value="${uiLabelMap.createLotBtn}" class="buttontext" />
					<input type="button" id="deleteLot" value="${uiLabelMap.deleteBtn}" class="buttontext" />
				</td>
				<td class="label" width="12%" align="right">
                    ${uiLabelMap.fobPoint}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <select name="fobPoint" id="fobPoint">
                        <option value="">--Select</option>
                    <#if fobPointList??>
                        <#list fobPointList as fobPointInfo>
                            <#if fobPointInfo.codeGroup == "DESTINATION">
                        <option value="${fobPointInfo.code!}">${fobPointInfo.codeName!}</option>
                            </#if>
                        </#list>
                    </#if>
                    </select>
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
					<select name="destination" id="destination">
						<option value="">--Select</option>
					<#if codeList??>
						<#list codeList as codeInfo>
						<option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
						</#list>
					</#if>
					</select>
				</td>
				<td class="label" width="12%" align="right">
                    ${uiLabelMap.product}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <select name="product" id="product">
                        <option value="">--Select</option>
                    <#if productList??>
                        <#list productList as productInfo>
                        <option value="${productInfo.code!}">${productInfo.codeName!}</option>
                        </#list>
                    </#if>
                    </select>
                </td>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.exw}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <select name="exw" id="exw">
                        <option value="">--Select</option>
                    <#if exwList??>
                        <#list exwList as exwInfo>
                        <option value="${exwInfo.code!}">${exwInfo.codeName!}</option>
                        </#list>
                    </#if>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="label" width="12%" align="right">
                    ${uiLabelMap.exwEtd}
                </td>
                <td width="1%">&nbsp;</td>
                <td width="20%">
                    <input type="text" name="fobPointEta" id="fobPointEta" value="" size="25" maxlength="255"/>
                </td>
                <td class="label" width="13%" align="right" >
                    ${uiLabelMap.importSO}
                </td>
                <td width="2%">&nbsp;</td>
                <td width="20%">
                    <!-- set_multivalues -->
                    <@htmlTemplate.lookupField value="${poCommonInfo.salesOrderNum!}" formName="lookupForm" name="salesOrderNum" id="salesOrderNum" fieldFormName="LookupSalesOrder" position="center" />
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

<div class="left7">
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">
                    ${uiLabelMap.productSpecification}
                </li>
            </ul>
            <br class="clear">
        </div>
        <div class="screenlet-body no-padding">
            <table class="basic-table" cellspacing="0" id="lotCommonInfo">
                <tr>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.steelType}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="35%">
                        <select name=steelType id="steelType" style="width:19%;">
                            <option value="">--Select</option>
                        <#if steelTypeList??>
                            <#list steelTypeList as steelTypeInfo>
                            <option value="${steelTypeInfo.code!}" data-desc="${steelTypeInfo.attribute1!}">${codeInfo.codeName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.coilMaxWeight}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="35%">
                        <select name="coilMaxWeight" id="coilMaxWeight">
                            <option value="">--Selecet</option>
                        <#if coilMaxWeightList??>
                            <#list coilMaxWeightList as coilMaxWeightInfo>
                            <option value="${coilMaxWeightInfo.code!}">${coilMaxWeightInfo.codeName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.surfaceCoilType}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="35%">
                        <select name="surfaceCoilType" id="surfaceCoilType" style="width:20%;">
                            <option value="">--SURFACE TYPE</option>
                        <#if surfaceCoilTypeList??>
                            <#list surfaceCoilTypeList as surfaceCoilTypeInfo>
                            <option value="${surfaceCoilTypeInfo.code!}">${surfaceCoilTypeInfo.codeName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.packaging}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="35%">
                        <select name="packaging" id="packaging" style="width:30%;">
                            <option value="">--Select</option>
                        <#if packagingList??>
                            <#list packagingList as packagingInfo>
                            <option value="${packagingInfo.code!}">${packagingInfo.codeName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.grade}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="35%">
                        <select name="grade" id="grade">
                            <option value="">--GRADE</option>
                        <#if gradeList??>
                            <#list gradeList as gradeInfo>
                            <option value="${gradeInfo.code!}">${gradeInfo.codeName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.coilId}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="35%">
                        <input type="text" name="innerDiameter" id="innerDiameter" value="" size="25" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.coatingWeight}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="35%">
                        <select name="coatingWeight" id="coatingWeight" style="width:20%;">
                            <option value="">--COATING WEIGHT</option>
                        <#if coatingWeightList??>
                            <#list coatingWeightList as coatingWeightInfo>
                            <option value="${coatingWeightInfo.code!}">${coatingWeightInfo.codeName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.gaugeControlYield}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="35%">
                        <select name="gaugeControlYield" id="gaugeControlYield" disabled="disabled">
                            <option value="">--Selecet</option>
                        <#if gaugeControlYieldList??>
                            <#list gaugeControlYieldList as gaugeControlYieldInfo>
                            <option value="${gaugeControlYieldInfo.code!}">${gaugeControlYieldInfo.codeName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.gauge}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td colspan="4">
                        <select name="gaugeUnit" id="gaugeUnit" style="width:5%;">
                            <option value="">--GAUGE</option>
                        <#if codeList??>
                            <#list gaugeUnitList as gaugeUnitInfo>
                            <option value="${gaugeUnitInfo.code!}">${gaugeUnitInfo.codeName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="12%" align="right">
                        ${uiLabelMap.width}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td colspan="4">
                        <select name="width" id="width" style="width:18%;">
                            <option value="">--WIDTH</option>
                        <#if widthList??>
                            <#list widthList as widthInfo>
                            <option value="${widthInfo.code!}">${widthInfo.codeName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<div class="right3">
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
            <table class="basic-table" cellspacing="0" id="lotCommonInfo">
                <tr>
                    <td class="label" width="40%" align="right">
                        ${uiLabelMap.paintCode}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="59%" >
                        <select name="paintCode">
                            <option value="">--Select</option>
                        <#if codeList??>
                            <#list codeList as codeInfo>
                                <#if codeInfo.codeGroup == "PAINT_CODE">
                            <option value="${codeInfo.code!}">${codeInfo.codeName!}</option>
                                </#if>
                            </#list>
                        </#if>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="40%" align="right">
                        ${uiLabelMap.paintBrand}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="59%" >
                        <select name="paintBrand">
                            <option value="">--Select</option>
                        <#if paintBrandist??>
                            <#list paintBrandList as paintBrandInfo>
                            <option value="${paintBrandInfo.code!}">${paintBrandInfo.codeName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="40%">
                        ${uiLabelMap.paintType}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="59%" >
                        <select name="paintType">
                            <option value="">--Select</option>
                        <#if paintTypeList??>
                            <#list paintTypeList as paintTypeInfo>
                            <option value="${paintTypeInfo.code!}">${paintTypeInfo.codeName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="40%" align="right">
                        ${uiLabelMap.paintName}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="59%" >
                        <input type="text" name="paintName" id="paintName"  maxlength="255"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">
                    ${uiLabelMap.item}
                </li>
            </ul>
            <br class="clear">
        </div>
        <div class="screenlet-body no-padding">
            <table class="basic-table" cellspacing="0" id="lotCommonInfo">
                <tr>
                    <td class="label" width="40%" align="right">
                        ${uiLabelMap.itemId}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="59%" >
                        <input type="text" name="itemId" id="itemId"  maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="40%" align="right">
                        ${uiLabelMap.qty}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="59%" >
                        <input type="text" name="qty" id="qty"  maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="40%" align="right">
                        ${uiLabelMap.unitPrice}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="59%" >
                        <input type="text" name="unitPrice" id="unitPrice"  maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="40%" align="right">
                        ${uiLabelMap.amount}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="59%" >
                        <input type="text" name="amount" id="amount"  maxlength="255"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<div class="clear">
</div>
<div align="right">
    <ul>
        <input id="clearBtn" type="button" value="${uiLabelMap.clearBtn}" class="buttontext"/>
        <input id="addToOrderBtn" type="button" value="${uiLabelMap.addToOrderBtn}" class="buttontext"/>
    </ul>
</div>
<br />
<div class="screenlet">
	<form name="lotInfo" id="lotInfo" method="post">
		<table class="display cell-border stripe" id="lotColoList" name="lotColoList">
			<thead>
				<tr>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.lotNo?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.destination?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.steelType?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.grade?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.coatingWeight?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.surfaceCoilType?trim}</th>
					<th colspan="3" style="vertical-align: middle;">${uiLabelMap.gauge?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.width?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.coilMaxWeight?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.innerDiameter?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.gaugeControlYield?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.packaging?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.businessClass?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.customerName?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.otherDetails?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.barge?trim}</th>
<!-- 					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim}</th> -->
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.unitQuantity?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.unitPrice?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.totalPrice?trim}</th>
					<th colspan="2" style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintBrand?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintCode?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintColor?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintType?trim}</th>
					<th rowspan="2" style="vertical-align: middle;">${uiLabelMap.paintCoatingThickness?trim}</th>
				</tr>
				<tr>
					<th style="vertical-align: middle;">${uiLabelMap.grade?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gradeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.coatingWeight?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.coatingWeightDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.surfaceCoilType?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.surfaceCoilTypeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gauge?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gaugeUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gaugeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.width?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.widthDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.packaging?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.packagingDesc?trim}</th>
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim}</th> -->
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim} Unit</th> -->
					<th style="vertical-align: middle;">${uiLabelMap.unitQuantity?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.quantityUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.unitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.priceUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim} Unit</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
			<tfoot>
				<tr>
					<th style="vertical-align: middle;">${uiLabelMap.lotNo?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.destination?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.steelType?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.grade?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gradeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.coatingWeight?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.coatingWeightDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.surfaceCoilType?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.surfaceCoilTypeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gauge?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gaugeUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gaugeDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.width?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.widthDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.coilMaxWeight?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.innerDiameter?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.gaugeControlYield?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.packaging?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.packagingDesc?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.businessClass?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.customerName?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.otherDetails?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.barge?trim}</th>
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim}</th> -->
<!-- 					<th style="vertical-align: middle;">${uiLabelMap.orderQuantity?trim} Unit</th> -->
					<th style="vertical-align: middle;">${uiLabelMap.unitQuantity?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.quantityUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.unitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.priceUnit?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.totalPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.commissionUnitPrice?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintBrand?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintCode?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintColor?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintType?trim}</th>
					<th style="vertical-align: middle;">${uiLabelMap.paintCoatingThickness?trim}</th>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<div>
	<ul>
	<#if crudMode == "CR" || crudMode == "CL">
		<input id="submitBtn" type="button" value="${uiLabelMap.submit}" class="buttontext"/>
	<#else>
		<input id="submitBtn" type="button" value="${uiLabelMap.update}" class="buttontext"/>
		<input id="duplicate" type="button" value="${uiLabelMap.duplicate}" class="buttontext"/>
		<input id="cancelBtn" type="button" value="${uiLabelMap.cancel}" class="buttontext"/>
    </#if>
	</ul>
</div>
<form id="referenceForm" name="referenceForm" method="post"></form>
<form id="duplicateForm" name="duplicateForm" method="post"></form>

<form id="lookupForm" name="lookupForm" method="post"></form>