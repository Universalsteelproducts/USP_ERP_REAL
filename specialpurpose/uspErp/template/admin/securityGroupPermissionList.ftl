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
        var securityGroupPermissionListTable = $("#securityGroupPermissionList").DataTable({
            dom : "lfrtip",
            processing : true,
            scrollY : true,
            scrollX : true,
            ajax : {
                "type"		: "POST",
                "url"		: '<@ofbizUrl>searchSecurityGroupPermission</@ofbizUrl>',
                "data"		: function(d) {
                    d.draw = "0";
                    d.groupId = "${groupId}";
                }
            },
            columns : [
                {
                    "data" : "permissionId"
                }
            ]
        });

        // 그리드 Row 클릭 이벤트
        $('#securityGroupPermissionList tbody').on( 'click', 'tr', function () {
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
        $("#addPermissionBtn").on("click", function () {
            var option = {
                url : "/uspErp/control/lookupSecurityGroupPermission",
                width : 600,
                height : 630,
                title : "${uiLabelMap.permissionList}",
                formId : "lookupForm",
                data : {
                    "groupId": "${groupId}",
                    "presentation": "layer"
                }
            };
            openDialog.open(option);
        });

        $("#savePermissionBtn").on("click", function () {
            var targetForm = $("#savePermissionForm");
            var reqData = securityGroupPermissionListTable.rows().data();
           	for(var i=0 ; reqData.length > i ; i++) {
                var reqMap = new Object();
                var val = reqData[i]["permissionId"];
                var inputStr = "<input type='hidden' name='permissionIdMap_" + i + "' value='" + val + "' />";
                targetForm.append(inputStr);
            }

            targetForm.attr("method", "post");
            targetForm.attr("action", "<@ofbizUrl>updateSecurityGroupPermission</@ofbizUrl>");
            targetForm.submit();
        });

        $("#deletePermissionBtn").on("click", function() {
            $.confirm({
                title: '${uiLabelMap.delete} ${uiLabelMap.permissionId}',
                boxWidth: '500px',
                useBootstrap: false,
                content: '<font style="font-size: 16px;">Are you sure you want to delete Permission?</font>',
                buttons: {
                    confirm: function () {
                        var selectRow = securityGroupPermissionListTable.rows( '.selected' ).indexes();
                        if(selectRow.length > 0) {
                            securityGroupPermissionListTable.rows(selectRow).remove().draw();
                        }
                    },
                    cancel: function () {
                    }
                }
            });
        });
	});

    function addPermissionRow(data) {
        for(var i=0 ; data.length > i ; i++) {
            var dataMap = new Object();
            dataMap["permissionId"] = data[i].permissionId;
            $("#securityGroupPermissionList").DataTable().row.add(dataMap).columns.adjust().draw();
        }
    }
</script>

<div class="page-title">
	<span>
		${uiLabelMap.securityGroupPermission}
	</span>
</div>

<div class="screenlet">
    <div class="screenlet-title-bar">
        <ul>
            <li class="h3">${uiLabelMap.permissionList}( ${uiLabelMap.groupId} : <font color="red">${groupId}</font> )</li>
        </ul>
        <br class="clear"/>
    </div>
    <br />
    <div>
        <ul style="text-align:right;">
            <input id="addPermissionBtn" type="button" value="${uiLabelMap.addPermissionBtn}" class="buttontext"/>
            <input id="deletePermissionBtn" type="button" value="${uiLabelMap.deletePermissionBtn}" class="buttontext"/>
            <input id="savePermissionBtn" type="button" value="${uiLabelMap.CommonSave}" class="buttontext"/>
        </ul>
    </div>
    <br />

<form name="savePermissionForm" id="savePermissionForm" method="post">
    <input type="hidden" id="groupId" name="groupId" value="${groupId}" />

    <table id="securityGroupPermissionList" class="hover cell-border stripe" style="width:100%">
        <thead>
            <tr>
                <th style="vertical-align: middle;">${uiLabelMap.permissionId}</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
            <tr>
                <th style="vertical-align: middle;">${uiLabelMap.permissionId}</th>
            </tr>
        </tfoot>
    </table>
</form>
</div>
<form name="lookupForm" id="lookupForm" method="post"></form>