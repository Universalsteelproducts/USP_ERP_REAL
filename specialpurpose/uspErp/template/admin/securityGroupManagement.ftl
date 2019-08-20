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
		var securityGroupListTable = $("#securityGroupList").DataTable({
            dom : "lfrtip",
            processing : true,
            scrollY : true,
            scrollX : true,
            ajax : {
                "type"		: "POST",
                "url"		: '<@ofbizUrl>searchSecurityGroupList</@ofbizUrl>',
                "data"		: function(d) {
                    d.draw = "0";
                    d.groupId = $("input[name=groupId]").val();
                }
            },
            columns : [
                {
                    "data" : "groupId",
                    "render": function ( data, type, row ) {
                        return "<a href='<@ofbizUrl>updateSecurityGroupForm?groupId=" + data + "</@ofbizUrl>' class='buttontext'>" + data + "</a>";
                    }
                },
                {
                    "data" : "description",
                },
                {
                    "render": function ( data, type, row ) {
                        return "<a href='<@ofbizUrl>employeeManagement?searchGroupId=" + row.groupId + "</@ofbizUrl>' class='buttontext'>${uiLabelMap.employeeList}</a>";
                    }
                },
                {
                    "render": function ( data, type, row ) {
                        return "<a href='<@ofbizUrl>securityGroupPermissionList?groupId=" + row.groupId + "</@ofbizUrl>' class='buttontext'>${uiLabelMap.permissionList}</a>";
                    }
                }
            ]
        });

		/***************************************************************************
		 ******************			Table change Event			********************
		 ***************************************************************************/
        $('#securityGroupList tbody').on( 'click', 'tr', function () {
            if ( $(this).hasClass('selected') ) {
                $(this).removeClass('selected');
            }
            else {
                securityGroupListTable.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            }
        } );

		/***************************************************************************
		 ******************			SelectBox Control			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************				Button Control			********************
		 ***************************************************************************/
		$("#searchBtn").on("click", function() {
		    securityGroupListTable.ajax.reload();
		});

		$("#addGroupBtn").on("click", function() {
		    var selectRow = securityGroupListTable.rows(".selected").data();
		    var selectRowCnt = selectRow.length;
		    if(selectRowCnt > 0) {
                parent.addSecurityGroupRow(selectRow);

                var option = {
                    formId : "lookupForm"
                };
                openDialog.close(option);
		    } else {
                alert("No data selected");
		    }
        });
	});
</script>

<div class="page-title">
	<span>
		${uiLabelMap.securityGroup}
	</span>
</div>

<div class="button-bar">
	<a class="buttontext create" href="/uspErp/control/createSecurityGroupForm">
		${uiLabelMap.securityGroupCreate}
	</a>
</div>

<!-- Search Condition -->
<div class="screenlet">
    <div class="screenlet-title-bar">
        <ul>
            <li class="h3">${uiLabelMap.securityGroup}</li>
        </ul>
    </div>
    <div class="screenlet-body">
        <div id="search-options">
            <form name="searchForm" id="searchForm" method="post">
            <table class="basic-table" cellspacing="0">
                <tr>
                    <td class="label" align="right" >
                        ${uiLabelMap.groupId}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="text" name="groupId" id="groupId" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" align="right">
                        &nbsp;
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="button" id="searchBtn" value="${uiLabelMap.CommonFind}" class="buttontext" />
                    </td>
                </tr>
            </table>
            </form>
        </div>
    </div>
</div>

<!-- Search Result -->
<div class="screenlet">
    <table id="securityGroupList" class="hover cell-border stripe" style="width:100%">
        <thead>
            <tr>
                <th style="vertical-align: middle;">${uiLabelMap.groupId}</th>
                <th style="vertical-align: middle;">${uiLabelMap.description}</th>
                <th style="vertical-align: middle;">${uiLabelMap.employeeList}</th>
                <th style="vertical-align: middle;">${uiLabelMap.permissionList}</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
            <tr>
                <th style="vertical-align: middle;">${uiLabelMap.groupId}</th>
                <th style="vertical-align: middle;">${uiLabelMap.description}</th>
                <th style="vertical-align: middle;">${uiLabelMap.employeeList}</th>
                <th style="vertical-align: middle;">${uiLabelMap.permissionList}</th>
            </tr>
        </tfoot>
    </table>
</div>