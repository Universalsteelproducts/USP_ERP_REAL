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
        var codeListTable = $("#codeList").DataTable({
            dom : "lfrtip",
            processing : true,
            fixedHeader : true,
            scrollY : true,
            scrollX : true,
            ajax : {
                "type"		: "POST",
                "url"		: '<@ofbizUrl>schCommCodeList</@ofbizUrl>',
                "data"		: function(d) {
                    d.draw = "0";
                    d.entityNm = $("input[name=entityNm]").val();
                    d.codeId = $("input[name=codeId]").val();
                    d.codeNm = $("input[name=codeNm]").val();
                }
            },
            columns : [
                {
                    "data" : "${codeId}"
                },
                {
                    "data" : "${codeNm}",
                },
                {
                    "data" : "sortSeq",
                    "render" : function(data, type, row, meta) {
                        return data ? parseInt(data) : null;
                    }
                },
                {
                    "data" : "description"
                }
            ]
        });

        // 그리드 Row 클릭 이벤트
        $('#codeList tbody').on( 'click', 'tr', function () {
            $(this).toggleClass('selected');
        } );

		/***************************************************************************
		 ******************			Table change Event			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************			SelectBox Control			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************				Button Control			********************
		 ***************************************************************************/
		$("#addCodeBtn").on("click", function() {
		    var rowMap = new Object();
		    var schCodeId = checkNull($("#schCodeId").val());
		    var schCodeNm = checkNull($("#schCodeNm").val());
		    var description = checkNull($("#description").val());
		    var codeId = checkNull($("#codeId").val());
            var codeNm = checkNull($("#codeNm").val());
		    if(schCodeId == "") {
                alert("Input Code ID.");
                return false;
		    }

		    if(schCodeNm == "") {
                alert("Input Code Name.");
                return false;
            }

            var serArry = codeListTable.column(2).data();
            var nextSeqNum = Math.max.apply(Math, serArry);

		    var duplCnt = 0;
		    var qaRowIdx = -1;
		    codeListTable.rows().every( function ( rowIdx, tableLoop, rowLoop ) {
		        var data = this.data();
		        var codeVal = data[codeId];

		        if(codeVal == "QUICK_ADD") {
		            qaRowIdx = rowIdx;
		        }

		        if(codeVal == schCodeId) {
		            duplCnt++;
		        }
		    });

		    if(duplCnt > 0) {
		        alert("Duplicate Code Exists");
		        return false;
		    }

		    if(qaRowIdx > -1) {
		        var qaData = codeListTable.row(qaRowIdx).data();
		        qaData["sortSeq"] = nextSeqNum + 1;
		        codeListTable.row(qaRowIdx).data(qaData).draw();
		    }

            rowMap[codeId] = schCodeId;
            rowMap[codeNm] = schCodeNm;
            rowMap["sortSeq"] = nextSeqNum;
            rowMap["description"] = description;

		    codeListTable.row.add(rowMap).columns.adjust().draw();

            inputInit("inputTable");
        });
        
        $("#deleteRow").on("click", function() {
            var selectRowIdx = codeListTable.rows( '.selected' ).indexes();
            var reqArray = makeArrayData(codeListTable.rows( '.selected' ).data());

            if(selectRowIdx.length > 0) {
                codeListTable.rows(selectRowIdx).remove().draw();
                jQuery.ajax({
                    url: '<@ofbizUrl>CUCommCodeList</@ofbizUrl>',
                    type: 'POST',
                    data: $("#addForm").serialize() + "&crudMode=D&reqData=" + JSON.stringify(reqArray),
                    error: function(msg) {
                        showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
                    },
                    success: function(data, status) {
                        if(data.successStr == "success") {
                            alert("Code Delete Completed");
                            redrawDropdown(reqData, paramMap);
                        } else {
                            alert("Code Delete Fail");
                        }
                    }
                });
            }
        });

        $("#submitCodeBtn").on("click", function() {
            var reqData = codeListTable.rows().data();
            var entityNm = $("input[name=entityNm]").val();
            var codeId = checkNull($("#codeId").val());
            var codeNm = checkNull($("#codeNm").val());
            var elementId = $("input[name=elementId]").val();
            var paramMap = {
                "entityNm" : entityNm,
                "codeId" : codeId,
                "codeNm" : codeNm,
                "elementId" : elementId
            };
            if(reqData.length > 0) {
                var reqArray = makeArrayData(reqData);
                jQuery.ajax({
                    url: '<@ofbizUrl>CUCommCodeList</@ofbizUrl>',
                    type: 'POST',
                    data: $("#addForm").serialize() + "&crudMode=CU&reqData=" + JSON.stringify(reqArray),
                    error: function(msg) {
                        showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
                    },
                    success: function(data, status) {
                        if(data.successStr == "success") {
                            alert("Code Create Completed");
                            redrawDropdown(reqData, paramMap);
                        } else {
                            alert("Code Create Fail");
                        }
                    }
                });
            }
        });
	});
</script>

<!-- Search Condition -->
<div class="screenlet">
    <div class="screenlet-title-bar">
        <ul>
            <li class="h3">${uiLabelMap.addCodeLookup}( Entity : ${entityNm} )</li>
        </ul>
    </div>
    <div class="screenlet-body no-padding">
        <div id="search-options">
        <form name="addForm" id="addForm" method="post" class="basic-form">
            <input type="hidden" name="entityNm" id="entityNm" value="${entityNm}" />
            <input type="hidden" name="codeId" id="codeId" value="${codeId}" />
            <input type="hidden" name="codeNm" id="codeNm" value="${codeNm}" />
            <input type="hidden" name="elementId" id="elementId" value="${elementId}" />

            <table class="basic-table" cellspacing="0" id="inputTable" name="inputTable">
                <tbody>
                    <tr>
                        <td class="label" align="right" >
                            ${uiLabelMap.codeId}
                        </td>
                        <td width="2%">&nbsp;</td>
                        <td>
                            <input type="text" name="schCodeId" id="schCodeId" maxlength="255"/>
                        </td>
                        <td class="label" align="right" >
                            ${uiLabelMap.codeNm}
                        </td>
                        <td width="2%">&nbsp;</td>
                        <td>
                            <input type="text" name="schCodeNm" id="schCodeNm" maxlength="255"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label" align="right" >
                            ${uiLabelMap.description}
                        </td>
                        <td width="2%">&nbsp;</td>
                        <td colspan="4">
                            <textarea name="description" id="description" rows="3"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="label" align="right" >
                        </td>
                        <td width="2%">&nbsp;</td>
                        <td colspan="4">
                            <input type="button" id="addCodeBtn" value="${uiLabelMap.addCodeBtn}" class="buttontext" />
                            <input id="deleteRow" type="button" value="${uiLabelMap.deleteRow}" class="buttontext"/>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        </div>
    </div>
</div>

<!-- Search Result -->
<div class="screenlet">
    <table id="codeList" class="hover cell-border stripe" style="width:100%">
        <thead>
            <tr>
                <th style="vertical-align: middle;">${uiLabelMap.codeId}</th>
                <th style="vertical-align: middle;">${uiLabelMap.codeNm}</th>
                <th style="vertical-align: middle;">${uiLabelMap.sortSeq}</th>
                <th style="vertical-align: middle;">${uiLabelMap.description}</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
        </tfoot>
    </table>
</div>
<div>
	<ul>
		<input type="button" id="submitCodeBtn" value="${uiLabelMap.submit}" class="buttontext"/>
	</ul>
</div>