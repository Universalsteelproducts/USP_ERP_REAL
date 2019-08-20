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
				reqMap[key] = $.trim(map[key]);
			}
		}
		reqArray.push(reqMap);
	}

	return reqArray;
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

jQuery(document).ready(function(){
    $(window).keydown(function(event){
        if(event.keyCode == 13) {
          event.preventDefault();
          return false;
        }
    });
});