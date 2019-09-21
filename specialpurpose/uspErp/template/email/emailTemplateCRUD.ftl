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
		$("input[name=contentType]").on("change", function() {
		    var curVal = $(this).val();
		    if(curVal == "ELECTRONIC_TEXT") {
		        $("#elecTextTr").show();
		        $("#contentFileTr").hide();
		    } else if(curVal == "CONTEXT_FILE") {
                $("#elecTextTr").hide();
		        $("#contentFileTr").show();
		    }
        });

		/***************************************************************************
		 ******************				Button Control			********************
		 ***************************************************************************/
		$("#contentStatusBtn").on("click", function() {
            var statusId = $("#statusId").val();

            if(statusId == "EMAIL_PUBLISHED") {
                $("#contentStatus").text("Inactive");
                $("#statusId").val("EMAIL_DEACTIVATED");
                $(this).val("${uiLabelMap.changeActive}");
            } else {
                $("#contentStatus").text("Active");
                $("#statusId").val("EMAIL_PUBLISHED");
                $(this).val("${uiLabelMap.changeInactive}");
            }
        });

		$("#listBtn").on("click", function() {
            var targetForm = $("#detailForm");
            targetForm.attr("method", "post");
            targetForm.attr("action", "<@ofbizUrl>emailTemplate</@ofbizUrl>");
            targetForm.submit();
		});

		$("#updateBtn").on("click", function() {
            var targetForm = $("#detailForm");
            targetForm.attr("method", "post");
            targetForm.attr("action", "<@ofbizUrl>updateEmailTemplate</@ofbizUrl>");
            targetForm.submit();
        });

		$("#submitBtn").on("click", function() {
            var targetForm = $("#detailForm");
            targetForm.attr("method", "post");
            targetForm.attr("action", "<@ofbizUrl>createEmailTemplate</@ofbizUrl>");
            targetForm.submit();
        });

        if("${dataResourceTypeId}" == "" || "${dataResourceTypeId}" == "ELECTRONIC_TEXT") {
            $("#elecTextTr").show();
		    $("#contentFileTr").hide();
        } else if("${dataResourceTypeId}" == "CONTEXT_FILE") {
            $("#elecTextTr").hide();
            $("#contentFileTr").show();
        }
	});
</script>

<div class="page-title">
	<span>
	<#if curdType == "RU" >
        ${uiLabelMap.emailTemplateDetail}
    <#elseif curdType == "C" >
        ${uiLabelMap.createEmail}
    </#if>
	</span>
</div>

<form name="detailForm" id="detailForm" method="post">
    <input type="hidden" name="contentTypeId" id="contentTypeId" value="${contentTypeId}" />
    <input type="hidden" name="createdStamp" value="${nowTimestamp}">

    <div class="screenlet">
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">${uiLabelMap.template}</li>
            </ul>
            <br class="clear"/>
        </div>
        <div class="screenlet-body">
            <table class="basic-table" cellspacing="0">
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.contentId}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <#if curdType == "RU">
                            ${(contentInfo.contentId)?default("")}
                            <input type="hidden" name="contentId" id="contentId" value="${(contentInfo.contentId)?default("")}" size="60" maxlength="255"/>
                        <#elseif curdType == "C" >
                            <input type="text" name="contentId" id="contentId" size="60" maxlength="255"/>
                        </#if>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.contentName}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="text" name="contentName" id="contentName" value="${(contentInfo.contentName)?default("")}" size="60" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.description}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <textarea name="description" id="description" rows="3">${(contentInfo.description)?default("")}</textarea>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.type}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="radio" id="elecText" name="dataResourceTypeId" <#if dataResourceTypeId?exists && (dataResourceTypeId=="ELECTRONIC_TEXT" || dataResourceTypeId=="") >checked="checked"<#elseif !(dataResourceTypeId?exists)>checked="checked"</#if> value="ELECTRONIC_TEXT" checked="checked" /> ${uiLabelMap.htmlCode}
                        <input type="radio" id="contentFile" name="dataResourceTypeId" <#if dataResourceTypeId=="CONTEXT_FILE">checked="checked"</#if> value="CONTEXT_FILE" /> ${uiLabelMap.contextFile}
                    </td>
                </tr>
                <tr id="elecTextTr">
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.Content}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <textarea name="textData" cols="50" rows="20">${eText?default("")}</textarea>
                    </td>
                </tr>
                <tr id="contentFileTr">
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.file}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="text" name="objectInfo" id="objectInfo" value="${objectInfo?default("")}" size="60" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.createDate}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        ${(createdStamp)?default("")}
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.status}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <span id="contentStatus">${statusDesc?default("")}</span>
                        <input type="hidden" id="statusId" name="statusId" value="${statusId?default("")}" />
                        <#if statusId == "EMAIL_PUBLISHED">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="contentStatusBtn" type="button" class="standardBtn" name="approveBtn" value="${uiLabelMap.changeInactive}" />
                        <#else>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="contentStatusBtn" type="button" class="standardBtn" name="approveBtn" value="${uiLabelMap.changeActive}" />
                        </#if>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.file}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        ${(lastUpdatedStamp)?default("")}
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
