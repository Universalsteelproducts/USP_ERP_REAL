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
        var employeeSecurityGroupListTable = $("#employeeSecurityGroupList").DataTable({
            dom : "lfrtip",
            processing : true,
            scrollY : true,
            scrollX : true,
            ajax : {
                "type"		: "POST",
                "url"		: '<@ofbizUrl>searchEmployeeSecurityGroupList</@ofbizUrl>',
                "data"		: function(d) {
                    d.draw = "0";
                    d.employeeLoginId = "${employeeLoginId}";
                }
            },
            columns : [
                {
                    "data" : "groupId"
                },
                {
                    "data" : "fromDate",
                    "render" : function ( data, type, row ) {
                        if(data == null || data == "") {
                            return data;
                        } else {
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
                        }
                    }
                },
                {
                    "data" : "thruDate",
                    "render" : function ( data, type, row ) {
                        if(data == null || data == "") {
                            return data;
                        } else {
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
                        }
                    }
                }
            ]
        });

        // 그리드 Row 클릭 이벤트
        $('#employeeSecurityGroupList tbody').on( 'click', 'tr', function () {
            $(this).toggleClass('selected');
        } );

        /***************************************************************************
         ******************			    Popup Event 			********************
         ***************************************************************************/
        /*$( "#lookupForm" ).on( "dialogclose", function( event, ui ) {
            // popup 닫힐때 로직
        });*/

		/***************************************************************************
		 ******************			Table change Event			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************			SelectBox Control			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************				Button Control			********************
		 ***************************************************************************/
        $("#addSecurityGroupBtn").on("click", function () {
            var option = {
                url : "/uspErp/control/lookupEmployeeSecurityGroup",
                width : 600,
                height : 630,
                title : "${uiLabelMap.securityGroup}",
                formId : "lookupForm",
                data : {
                    "employeeLoginId": "${employeeLoginId}",
                    "presentation": "layer"
                }
            };
            openDialog.open(option);
        });

        $("#saveSecurityGroupBtn").on("click", function () {
            var targetForm = $("#saveSecurityGroupForm");
            var reqData = employeeSecurityGroupListTable.rows().data();
           	for(var i=0 ; reqData.length > i ; i++) {
                var reqMap = new Object();
                var val = reqData[i]["groupId"];
                var inputStr = "<input type='hidden' name='groupIdMap_" + i + "' value='" + val + "' />";
                targetForm.append(inputStr);
            }

            targetForm.attr("method", "post");
            targetForm.attr("action", "<@ofbizUrl>updateEmployeeSecurityGroup</@ofbizUrl>");
            targetForm.submit();
        });

        $("#deleteSecurityGroupBtn").on("click", function() {
            $.confirm({
                title: '${uiLabelMap.delete} ${uiLabelMap.groupId}',
                boxWidth: '500px',
                useBootstrap: false,
                content: '<font style="font-size: 16px;">Are you sure you want to delete Security Group?</font>',
                buttons: {
                    confirm: function () {
                        var selectRow = employeeSecurityGroupListTable.rows( '.selected' ).indexes();
                        if(selectRow.length > 0) {
                            employeeSecurityGroupListTable.rows(selectRow).remove().draw();
                        }
                    },
                    cancel: function () {
                    }
                }
            });
        });
	});

    function addSecurityGroupRow(data) {
        for(var i=0 ; data.length > i ; i++) {
            var dataMap = new Object();
            dataMap["groupId"] = data[i].groupId;
            dataMap["fromDate"] = "";
            dataMap["thruDate"] = "";
            $("#employeeSecurityGroupList").DataTable().row.add(dataMap).columns.adjust().draw();
        }
    }
</script>

<div class="page-title">
	<span>
		${uiLabelMap.employeeSecurityGroup}
	</span>
</div>

<div class="screenlet">
    <div class="screenlet-title-bar">
        <ul>
            <li class="h3">${uiLabelMap.employeeGroupId}( ${uiLabelMap.employeeLoginId} : <font color="red">${employeeLoginId}</font> )</li>
        </ul>
        <br class="clear"/>
    </div>
    <br />
    <div>
        <ul style="text-align:right;">
            <input id="addSecurityGroupBtn" type="button" value="${uiLabelMap.addSecurityGroupBtn}" class="buttontext"/>
            <input id="deleteSecurityGroupBtn" type="button" value="${uiLabelMap.deleteSecurityGroupBtn}" class="buttontext"/>
            <input id="saveSecurityGroupBtn" type="button" value="${uiLabelMap.CommonSave}" class="buttontext"/>
        </ul>
    </div>
    <br />

<form name="saveSecurityGroupForm" id="saveSecurityGroupForm" method="post">
    <input type="hidden" id="employeeLoginId" name="employeeLoginId" value="${employeeLoginId}" />

    <table id="employeeSecurityGroupList" class="hover cell-border stripe" style="width:100%">
        <thead>
            <tr>
                <th style="vertical-align: middle;">${uiLabelMap.groupId}</th>
                <th style="vertical-align: middle;">${uiLabelMap.fromDate}</th>
                <th style="vertical-align: middle;">${uiLabelMap.thruDate}</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
            <tr>
                <th style="vertical-align: middle;">${uiLabelMap.groupId}</th>
                <th style="vertical-align: middle;">${uiLabelMap.fromDate}</th>
                <th style="vertical-align: middle;">${uiLabelMap.thruDate}</th>
            </tr>
        </tfoot>
    </table>
</form>
</div>
<form name="lookupForm" id="lookupForm" method="post"></form>