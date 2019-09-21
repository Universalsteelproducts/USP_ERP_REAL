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
        var employeeListTable = $("#employeeList").DataTable({
            dom : "lfrtip",
            processing : true,
            scrollY : true,
            scrollX : true,
            ajax : {
                "type"		: "POST",
                "url"		: '<@ofbizUrl>searchEmployee</@ofbizUrl>',
                "data"		: function(d) {
                    d.draw = "0";
                    d.productStoreId = "${productStoreId}";
                    d.srchEmployeeId = $("#srchEmployeeId").val();
                    d.searchGroupId = $("#searchGroupId").val();
                }
            },
            columns : [
                {
                    "data" : "userLoginId",
                    "render": function ( data, type, row ) {
                        return "<a href='<@ofbizUrl>updateEmployeeDetailForm?employeeLoginId=" + data + "</@ofbizUrl>' class='buttontext'>" + data + "</a>";
                    }
                },
                {
                    "data" : "isSystem"
                },
                {
                    "data" : "enabled"
                },
                {
                    "data" : "requirePasswordChange"
                },
                {
                    "data" : "disabledDateTime",
                    "render": function ( data, type, row ) {
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
                },
                {
                    "data" : "groupId",
                    "render": function ( data, type, row ) {
                        if(data == "") {
                            data = "None";
                        }

                        return "<a href='<@ofbizUrl>employeeSecurityGroupList?employeeLoginId=" + row.userLoginId + "</@ofbizUrl>' class='buttontext'>" + data + "</a>";
                    }
                }
            ]
        });
		/***************************************************************************
		 ******************			Table change Event			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************			SelectBox Control			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************				Button Control			********************
		 ***************************************************************************/
		$("#searchBtn").on("click", function() {
           employeeListTable.ajax.reload();
		});
	});
</script>

<div class="page-title">
	<span>
		${uiLabelMap.employeeManagement}
	</span>
</div>
<div class="button-bar">
    <a class="buttontext create" href="/uspErp/control/createEmployeeDetailForm">
        ${uiLabelMap.createEmployee}
    </a>
</div>

<form name="searchForm" id="searchForm" method="post">
	<!-- Search Condition -->
	<div class="screenlet">
		<div class="screenlet-title-bar">
			<ul>
				<li class="h3">${uiLabelMap.searchPoForm}</li>
			</ul>
		</div>
		<div class="screenlet-body">
			<table class="basic-table" cellspacing="0">
				<tr>
					<td class="label" align="right" >
						${uiLabelMap.employeeId}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
						<!-- set_multivalues -->
						<input type="text" name="srchEmployeeId" id="srchEmployeeId" maxlength="255"/>
					</td>
					<td class="label" align="right" >
						${uiLabelMap.securityGroup}
					</td>
					<td width="2%">&nbsp;</td>
					<td width="35%">
					<#if securityGroups??>
                        <select name="searchGroupId" id="searchGroupId">
                            <option value=""></option>
                        <#list securityGroups as securityGroup>
                            <option value="${securityGroup.groupId!}" <#if securityGroup.groupId == searchGroupId! >selected="selected"</#if>>${securityGroup.groupId!}</option>
                        </#list>
                        </select>
                    </#if>
					</td>
				</tr>
				<tr>
                    <td class="label" align="right">
                        &nbsp;
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td width="35%">
                        <input type="button" id="searchBtn" value="${uiLabelMap.CommonFind}" class="buttontext" />
                    </td>
                </tr>
			</table>
		</div>
	</div>
</form>

<!-- Search Result -->
<div class="screenlet">
	<table id="employeeList" class="hover cell-border stripe" style="width:100%">
		<thead>
			<tr>
				<th style="vertical-align: middle;">${uiLabelMap.employeeLoginId}</th>
				<th style="vertical-align: middle;">${uiLabelMap.system}</th>
				<th style="vertical-align: middle;">${uiLabelMap.enabled}</th>
				<th style="vertical-align: middle;">${uiLabelMap.reqPwdChange}</th>
				<th style="vertical-align: middle;">${uiLabelMap.disabledDate}</th>
				<th style="vertical-align: middle;">${uiLabelMap.securityGroup}</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<th style="vertical-align: middle;">${uiLabelMap.employeeLoginId}</th>
                <th style="vertical-align: middle;">${uiLabelMap.system}</th>
                <th style="vertical-align: middle;">${uiLabelMap.enabled}</th>
                <th style="vertical-align: middle;">${uiLabelMap.reqPwdChange}</th>
                <th style="vertical-align: middle;">${uiLabelMap.disabledDate}</th>
                <th style="vertical-align: middle;">${uiLabelMap.securityGroup}</th>
			</tr>
		</tfoot>
	</table>
</div>