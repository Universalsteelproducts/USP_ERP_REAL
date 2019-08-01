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
            targetForm.attr("action", "<@ofbizUrl>employeeManagement</@ofbizUrl>");
            targetForm.submit();
		});

		$("#updateBtn").on("click", function() {

        });

		$("#submitBtn").on("click", function() {

        });
	});
</script>

<div class="page-title">
	<span>
	<#if curdType == "RU" >
		${uiLabelMap.employeeDetail}
	<#elseif curdType == "C" >
	    ${uiLabelMap.employeeCreate}
    </#if>
	</span>
</div>

<form name="detailForm" id="detailForm" method="post">
    <input type="hidden" name="productStoreId" id="productStoreId" value="${productStoreId!}" />
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">${uiLabelMap.employeeDetail}</li>
            </ul>
            <br class="clear"/>
        </div>
        <div class="screenlet-body">
            <table class="basic-table" cellspacing="0">
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.employeeLoginId}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                    <#if curdType == "RU">
                        ${(employeeInfo.userLoginId)?default("")}
                    <#elseif curdType == "C" >
                        <input type="text" name="employeeLoginId" id="employeeLoginId" size="60" maxlength="255"/>
                    </#if>
                    </td>
                </tr>
            <#if curdType == "RU">
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.currentPw}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="password" name="currentPw" id="currentPw" size="60" maxlength="255"/>
                    </td>
                </tr>
            </#if>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.passwd}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="password" name="passwd" id="passwd" size="60" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.confirmPw}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="password" name="confirmPw" id="confirmPw" size="60" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.pwHint}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <textarea name="pwHint" id="pwHint" rows="3">${(employeeInfo.passwordHint)?default("")}</textarea>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.system}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <select name="system" id="system" disabled="disabled">
                            <option value="Y" <#if (employeeInfo.isSystem)?default("") != "" && (employeeInfo.isSystem)?default("") == "Y">selected="selected"</#if>>YES</option>
                            <option value="N" <#if (employeeInfo.isSystem)?default("") == "" || (employeeInfo.isSystem)?default("") == "N">selected="selected"</#if>>NO</option>
                        </select>
                    </td>
                </tr>
            <#if curdType == "RU">
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.hasLoggedOut}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <select name="hasLogOut" id="hasLogOut" disabled="disabled">
                            <option value="Y" <#if (employeeInfo.hasLoggedOut)?default("") == "" || (employeeInfo.hasLoggedOut)?default("") == "Y">selected="selected"</#if>>YES</option>
                            <option value="N" <#if (employeeInfo.hasLoggedOut)?default("") != "" && (employeeInfo.hasLoggedOut)?default("") == "N">selected="selected"</#if>>NO</option>
                        </select>
                    </td>
                </tr>
            </#if>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.enabled}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <select name="enabledSel" id="enabledSel" <#if curdType == "C">disabled="disabled"</#if>>
                            <option value="Y" <#if (employeeInfo.enabled)?default("") == "" || (employeeInfo.enabled)?default("") == "Y">selected="selected"</#if>>YES</option>
                            <option value="N" <#if (employeeInfo.enabled)?default("") != "" && (employeeInfo.enabled)?default("") == "N">selected="selected"</#if>>NO</option>
                        </select>
                    </td>
                </tr>
                <tr id="extendTr" style="display:none;">
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.disabledDate}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                       <@htmlTemplate.renderDateTimeField name="disabledDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" value="" size="25" maxlength="50" id="disabledDate" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.reqPasswdChange}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <select name="requirePasswordChange" id="requirePasswordChange">
                            <option value="Y" <#if (employeeInfo.requirePasswordChange)?default("") != "" && (employeeInfo.requirePasswordChange)?default("") == "Y">selected="selected"</#if>>YES</option>
                            <option value="N" <#if (employeeInfo.requirePasswordChange)?default("") == "" || (employeeInfo.requirePasswordChange)?default("") == "N">selected="selected"</#if>>NO</option>
                        </select>
                    </td>
                </tr>
            <#if curdType == "RU">
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.successFailedLogins}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                       <input type="text" name="successiveFailedLogins" id="successiveFailedLogins" value="${employeeInfo.successiveFailedLogins!}" size="60" maxlength="255" disabled="disabled"/>
                    </td>
                </tr>
            </#if>
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
