/*
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
*/
Date.CultureInfo.formatPatterns.shortDate = "yyyy-MM-dd";

var openDialog = (function($, undefined){
    var default_option = {
        httpType : "POST",
        url : "",
        width : 200,
        height : 300,
        autoOpen : false,
        modal : true,
        closeOnEscape : true,
        title : "",
        formId : "",
        data : {}
    };

    function _open(opt) {
        // 옵션 세팅
        var option = $.extend(true, default_option, option, opt ? opt : {});
        var reqData = $.extend(true, {}, reqData, option.data ? option.data : {});
        if(option.formId != "" && option.url != "") {
            $("#" + option.formId).dialog({
                autoOpen: option.autoOpen,
                title: option.title,
                height: option.height,
                width: option.width,
                modal: option.modal,
                closeOnEscape: option.closeOnEscape,
                open: function() {
                    jQuery.ajax({
                        url: option.url,
                        type: option.httpType,
                        data: reqData,
                        success: function(data) {
                            $("#" + option.formId).html(data);
                        }
                    });
                }
            });

            $("#" + option.formId).dialog("open");
        } else {
            return false;
        }
    }

    function _close(opt) {
        var option = $.extend(true, default_option, option, opt ? opt : {});
        $("#" + option.formId).dialog("close");
    }

    return {
        open : function(option){
            return _open(option);
        },
        close : function(option){
            return _close(option);
        }
    };
})(jQuery);

var makeArrayData = function(reqData) {
	var reqArray = new Array();
	for(var i=0 ; reqData.length > i ; i++) {
		var reqMap = new Object();
		var map = reqData[i];
		for(var key in map) {
			if(key != "undefined") {
			    if(typeof reqData[key] == "string") {
                    reqMap[key] = $.trim(map[key]);
                } else {
                    reqMap[key] = map[key];
                }
			}
		}
		reqArray.push(reqMap);
	}

	return reqArray;
};

var makeMapData = function(reqData) {
    var reqMap = new Object();
    for(var key in reqData) {
        if(key != "undefined") {
            if(typeof reqData[key] == "string") {
                reqMap[key] = $.trim(reqData[key]);
            } else {
                reqMap[key] = reqData[key];
            }
        }
    }

    return reqMap;
};

var makeStringArrayData = function(reqData, colName) {
	var reqArray = new Array();
	for(var i=0 ; reqData.length > i ; i++) {
		var reqMap = new Object();
		var val = reqData[i][colName];
		reqArray.push(val);
	}

	return reqArray;
};

var inputInit = function(id) {
	$("#" + id + " :input").each(function() {
		if($(this).prop("type") == "select-one") {
			$(this).find("option:eq(0)").attr("selected", true);
		} else if($(this).prop("type") == "checkbox") {
			$(this).prop("checked", false);
		} else {
			if($(this).prop("type") != "button") {
				$(this).val("");
			}
		}
	});
};

var setLookupVal = function(elementNm, curVal, schUrl, setColNmArry) {
    var map = new Object();
    map[elementNm] = curVal;
    if(curVal != null && curVal != "") {
        jQuery.ajax({
            url: schUrl,
            type: 'POST',
            data: map,
            error: function(msg) {
                showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
            },
            success: function(data) {
                if(data.resultState == "success") {
                    if(data.returnDataInfo != null) {
                        $.each(data.returnDataInfo, function(index, value) {
                            for(var i=0 ; setColNmArry.length > i ; i++) {
                                var colNm = setColNmArry[i];
                                if(index == colNm) {
                                    $("input[name=" + index + "]").val("");
                                    $("input[name=" + index + "]").val(value);
                                    $("input[name=" + index + "]").effect("highlight", {}, 3000);
                                }
                            }
                        });
                    } else {
                        for(var i=0 ; setColNmArry.length > i ; i++) {
                            var colNm = setColNmArry[i];
                            $("input[name=" + colNm + "]").val("");
                        }
                    }
                }
            }
        });
    } else {
        for(var i=0 ; setColNmArry.length > i ; i++) {
            var colNm = setColNmArry[i];
            $("input[name=" + colNm + "]").val("");
        }
    }
};

function set_values(poNo, lotNo) {
	if (GLOBAL_LOOKUP_REF.getReference(ACTIVATED_LOOKUP)) {
        obj_caller.target = GLOBAL_LOOKUP_REF.getReference(ACTIVATED_LOOKUP).target;
    } else {
        obj_caller.target = jQuery(obj_caller.targetW);
    }

    var target = obj_caller.target;
    write_value(poNo, target);
    write_value(lotNo, $("#lotNo"));

    closeLookup();
}

function set_customer(customerId, customerNm) {
	if (GLOBAL_LOOKUP_REF.getReference(ACTIVATED_LOOKUP)) {
        obj_caller.target = GLOBAL_LOOKUP_REF.getReference(ACTIVATED_LOOKUP).target;
    } else {
        obj_caller.target = jQuery(obj_caller.targetW);
    }

    var target = obj_caller.target;
    write_value(customerId, target);
    write_value(customerNm, $("#customerNm"));
    write_value(customerNm, $("#schCustomerNm"));

    closeLookup();
}

function set_supplier(supplierId, supplierNm) {
	if (GLOBAL_LOOKUP_REF.getReference(ACTIVATED_LOOKUP)) {
        obj_caller.target = GLOBAL_LOOKUP_REF.getReference(ACTIVATED_LOOKUP).target;
    } else {
        obj_caller.target = jQuery(obj_caller.targetW);
    }

    var target = obj_caller.target;
    write_value(supplierNm, target);
    write_value(supplierId, $("#supplierId"));
    write_value(supplierId, $("#schSupplierId"));

    closeLookup();
}

/**
 * emailFormat
 * 정규식 사용하여 이메일 check
 * @param options
 */
$.fn.emailFormat = function (options) {
	var filter = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	if(filter.test($(this).val())) {
		return true;
	} else {
		return false;
	}
}

/**
 * objectFormat
 * 정규식 사용하여 입력한 포멧만 허용
 * @param options -> format : Object type
 */
$.fn.objectFormat = function (options) {
	var params = $.extend({
        format: 'int',
        fixLeng : 0
    }, options);

	var filter, rep, reg;
	if(params.format == "int") {
		filter = /^-?\d*$/;
		reg = /^(-?)([0-9]*)([^0-9]*)([0-9]*)([^0-9]*)/;
		rep = "$1$2$4";
	} else if(params.format == "float") {
		filter = /^-?\d*[.,]?\d*$/;
		reg = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/;
		rep = "$1$2$3$5";
	} else if(params.format == "en") {
		filter = /^[a-zA-Z\s]+$/;
		reg = /[^a-zA-Z\s]+$/;
		rep = "";
	} else if(params.format == "sd") {
		filter = /^[a-zA-Z0-9\s]+$/;
		reg = /[^a-zA-Z0-9\s]+$/;
		rep = "";
	}

	if(filter != null && filter != "") {
		if(filter.test($(this).val().replace(/\,/g, ""))) {
			return true;
		} else {
			alert("Invalid Format");
			$(this).val($(this).val().replace(reg, rep));
			$(this).focus();
			return false;
		}
	}
}

/**
 * Number.prototype.format(n, x)
 *
 * @param integer n: length of decimal
 * @param integer x: length of sections
 */
Number.prototype.format = function(n, x) {
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
    return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
};

String.prototype.format = function(n, x) {
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
    return Number(this.replace(/\,/g, "")).toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
};

var checkNull = function(str) {
	if(str == null || str == undefined || str == "undefined" || str == "") {
		return "";
	} else {
		return str;
	}
};

var inputInit = function(elementId) {
	$("#" + elementId + " :input").each(function() {
        if($(this).prop("type") == "select-one") {
            $(this).find("option:eq(0)").attr("selected", true);
            if($(this).attr("name") == "steelType") {
                $(this).trigger("change");
            }
        } else if($(this).prop("type") == "checkbox") {
            $(this).prop("checked", false);
        } else {
            if($(this).prop("type") != "button") {
                $(this).val("");

//                if($(this).attr("name") == "orderQuantity" || $(this).attr("name") == "unitPrice"
//                    || $(this).attr("name") == "commissionUnitPrice" || $(this).attr("name") == "unitQuantity") {
//                    $(this).val("0");
//                } else if($(this).attr("name") != "customerId") {
//                    $(this).val("");
//                }
            }
        }
	});
};

var addToOrder = function(id, rowMap) {
	var tagTmp = "";
	$("#" + id + " :input").each(function() {
	    if($(this).prop("type") != "button") {
            if($(this).prop("type") == "checkbox") {
                if($(this).is(":checked")) {
                    rowMap[$(this).attr("name")] = "Y";
                } else {
                    rowMap[$(this).attr("name")] = "N";
                }
            } else {
                rowMap[$(this).attr("name")] = $(this).val();
            }
        }
	});

	rowMap["referenceSeq"] = "";
	var referenceNo = $("#poNo").val() + $("#lotNo").val() + "00";
	rowMap["referenceNo"] = referenceNo;
	rowMap["poStatus"] = "PE";

	return rowMap;
};

function openTab(evt, tabName) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the button that opened the tab
    document.getElementById(tabName).style.display = "block";
    evt.target.className += " active";
}

// csv파일 import 시 동기화 위하여 promise사용
const readFileAsCsv = (inputFile) => {
  const temporaryFileReader = new FileReader();

  return new Promise((resolve, reject) => {
    temporaryFileReader.onerror = () => {
      temporaryFileReader.abort();
      reject(new DOMException("Parsing Error"));
    };

    temporaryFileReader.onload = () => {
      resolve(temporaryFileReader.result);
    };
    temporaryFileReader.readAsText(inputFile);
  });
};

// csv파일 import 시 동기화 위하여 promise사용
var covertFileToData = async (event) => {
    //var f = $("#" + fileElementId).get(0).files[0];
    var f = event.target.files[0];

    if (f) {
        var data = await readFileAsCsv(f);
        var csvData = $.csv.toObjects(data);
        if (csvData && csvData.length > 0) {
            return csvData;
        } else {
            return null;
        }
    } else {
        return null;
    }
};

var totalPriceNQuantity = function(tableObj, totalQuantityId, totalPriceId) {
    var tableSize = tableObj.rows().data().length;
    var totalQuantity = 0;
    var totalPrice = 0;
    var groupUnitQuantity = 0;

    var totalQuantityUnit = "";
    var totalPriceUnit = "";

    if(tableSize > 0) {
        for(var i=0 ; tableSize > i ; i++) {
            var gridUnitQuantity = Number(tableObj.rows(i).data().pluck("orderQty")[0] != "" ? tableObj.rows(i).data().pluck("orderQty")[0] : 0);
            var gridUnitPrice = parseFloat(tableObj.rows(i).data().pluck("unitPrice")[0] != "" ? tableObj.rows(i).data().pluck("unitPrice")[0] : 0);

            totalQuantity += gridUnitQuantity;
            totalPrice += (gridUnitQuantity*gridUnitPrice);
        }
    }

    $("#" + totalQuantityId).val(totalQuantity.format());
    $("#" + totalPriceId).val(totalPrice.format(2));
};

$.fn.dataTable.Api.register( 'selectedColSum()', function (colName) {
    var data = this.rows(".selected").data();
    var returnTotal = 0;
    data.each( function ( value, index ) {
        var x = parseFloat( value[colName] ) || 0;
        returnTotal += x;
    });
    return returnTotal;
});

// Remove the formatting to get integer data for summation
var intVal = function ( i ) {
    return typeof i === 'string' ?
        i.replace(/[\$,]/g, '')*1 :
        typeof i === 'number' ?
            i : 0;
};

var selectedColTotal = function(tableObj, setColNUnitNIdxArry) {
    if(setColNUnitNIdxArry.length > 0) {
        for(var i=0 ; setColNUnitNIdxArry.length > i ; i++) {
            // Total over all pages
            var setColNUnitNIdx = setColNUnitNIdxArry[i] + "";
            var splitStr = setColNUnitNIdx.split(",");

            var selectTotal = tableObj.selectedColSum(splitStr[0]);
            var total = tableObj.column( splitStr[0]+":name" ).data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                });
            if(total == null || total == "") {
                total = 0;
            }

            $( tableObj.column( splitStr[2] ).footer() ).html(
                $.fn.dataTable.render.number( ',', '.', 2, '').display(selectTotal ) +
                ' ' + splitStr[1] + '( ' + $.fn.dataTable.render.number( ',', '.', 2, '').display(total ) +
                ' ' + splitStr[1] + ')'
            );
        }
    }
}

var timeTodateFormat = function(inputDate) {
    var date = new Date(inputDate);
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
    var h = date.getHours();
    if(h < 10) {
        h = "0" + h;
    }
    var M = date.getMinutes();
    if(M < 10) {
        M = "0" + M;
    }
    var s = date.getSeconds();
    if(s < 10) {
        s = "0" + s;
    }

    return y + "-" + m + "-" + d  + " " + h + ":" + M + ":" + s;
}

jQuery(document).ready(function() {
    $("select").on("change", function() {
        if($(this).val() == "QUICK_ADD") {
            var entityNm = $(this).find("option:selected").attr("entity-name");
            var codeId = $(this).find("option:selected").attr("code-id");
            var codeNm = $(this).find("option:selected").attr("code-nm");
            var elementId = $(this).attr("id");
            var option = {
                url : "/uspErp/control/LookupAddCode",
                width : 600,
                height : 630,
                title : "${uiLabelMap.addCodeLookup}",
                formId : "lookupForm",
                data : {
                    "entityNm": entityNm,
                    "codeId": codeId,
                    "codeNm": codeNm,
                    "elementId" : elementId
                }
            };
            openDialog.open(option);
        }
    });
});

var redrawDropdown = function(reqData, paramMap) {
    if(reqData.length > 0) {
        var entityNm = paramMap["entityNm"];
        var codeId = paramMap["codeId"];
        var codeNm = paramMap["codeNm"];
        var elementId = paramMap["elementId"];

        reqData.sort(function(a, b){
            var a1= a.sortSeq, b1= b.sortSeq;
            if(a1== b1) return 0;
            return a1> b1? 1: -1;
        });

        $("#" + elementId + " option").remove();
        var $option = "<option value=''>--Select</option>";
        for(var i=0 ; reqData.length > i ; i++) {
            var data = reqData[i];
            var codeVal = data[codeId];
            var nameVal = data[codeNm];
            if(codeVal == "QUICK_ADD") {
                $option += "<option value='" + codeVal + "' entity-name='" + entityNm + "' code-id='" + codeId + "' code-nm='" + codeNm + "'>" + nameVal + "</option>";
            } else {
                $option += "<option value='" + codeVal + "'>" + nameVal + "</option>";
            }
        }
        $("#" + elementId).append($option);
    }
    var option = {
        formId : "lookupForm"
    };
    openDialog.close(option);
}