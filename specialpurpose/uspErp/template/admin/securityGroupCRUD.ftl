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

		/***************************************************************************
		 ******************			Table change Event			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************			Input Tag Control			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************				Button Control			********************
		 ***************************************************************************/
		$("#listBtn").on("click", function() {
            var targetForm = $("#detailForm");
            targetForm.attr("method", "post");
            targetForm.attr("action", "<@ofbizUrl>securityGroupManagement</@ofbizUrl>");
            targetForm.submit();
		});

		$("#updateBtn").on("click", function() {
            var targetForm = $("#detailForm");
            targetForm.attr("method", "post");
            targetForm.attr("action", "<@ofbizUrl>updateSecurityGroup</@ofbizUrl>");
            targetForm.submit();
        });

		$("#submitBtn").on("click", function() {
            var targetForm = $("#detailForm");
            targetForm.attr("method", "post");
            targetForm.attr("action", "<@ofbizUrl>createSecurityGroup</@ofbizUrl>");
            targetForm.submit();
        });
	});
</script>

<div class="page-title">
	<span>
	<#if curdType == "RU" >
		${uiLabelMap.securityGroupDetail}
	<#elseif curdType == "C" >
	    ${uiLabelMap.securityGroupCreate}
    </#if>
	</span>
</div>

<form name="detailForm" id="detailForm" method="post">
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">${uiLabelMap.securityGroup}</li>
            </ul>
            <br class="clear"/>
        </div>
        <div class="screenlet-body">
            <table class="basic-table" cellspacing="0">
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.groupId}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                    <#if curdType == "RU">
                        ${(securityGroupInfo.groupId)?default("")}
                        <input type="hidden" name="groupId" id="groupId" value="${(securityGroupInfo.groupId)?default("")}" />
                    <#elseif curdType == "C" >
                        <input type="text" name="groupId" id="groupId" size="60" maxlength="255"/>
                    </#if>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.description}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <textarea name="description" id="description" rows="3">${(securityGroupInfo.description)?default("")}</textarea>
                    </td>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</form>

<div>
	<ul>
	    <input id="listBtn" type="button" value="${uiLabelMap.list}" class="buttontext"/>
	<#if curdType == "RU">
		<input id="updateBtn" type="button" value="${uiLabelMap.update}" class="buttontext"/>
	<#else>
		<input id="submitBtn" type="button" value="${uiLabelMap.submit}" class="buttontext"/>
    </#if>
	</ul>
</div>
