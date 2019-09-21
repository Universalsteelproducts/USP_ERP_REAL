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
        var $("input[name=simplTest]").val();
        if(simplTest == "N") {
            if (simpleTestValue == "N") {
                $("#emailTextTr").hide();
                $("#contentIdTr").show();
                showTestContentIdTr('#contentId');
            } else  {
                $("#emailTextTr").show();
                $("#contentIdTr").hide();
                $("#customerIdTr").hide();
                $("#orderNumTr").hide();
            }
        }

        function showTestContentIdTr(contentId) {
            var contentIdValue = $(contentId).val();
            if ((contentIdValue == "E_CHANGE_CUSTOMER") || (contentIdValue == "E_NEW_CUSTOMER") || (contentIdValue == "E_FORGOT_PASSWORD") ) {
                $("#customerIdTr").show();
                $("#orderNumTr").hide();
            } else if ((contentIdValue == "E_ORDER_CHANGE") || (contentIdValue == "E_ORDER_CONFIRM") || (contentIdValue == "E_ORDER_DETAIL") || (contentIdValue == "E_SHIP_REVIEW") || (contentIdValue == "E_ABANDON_CART")) {
                $("#customerIdTr").hide();
                $("#orderNumTr").show();
            } else if ((contentIdValue == "E_CONTACT_US") || (contentIdValue == "E_REQUEST_CATALOG") || (contentIdValue == "E_MAILING_LIST")) {
                $("#customerIdTr").hide();
                $("#orderNumTr").hide();
            } else{
                $("#customerIdTr").hide();
                $("#orderNumTr").hide();
            }
        }

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
        ${uiLabelMap.sendTestEmail}
	</span>
</div>

<form name="sendForm" id="sendForm" method="post">
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">${uiLabelMap.sendTestEmail}</li>
            </ul>
            <br class="clear"/>
        </div>
        <div class="screenlet-body">
            <table class="basic-table" cellspacing="0">
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.testMode}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="radio" id="simplTestY" name="simplTest" <#if (!simpleTest?exists || (simpleTest?exists && simpleTest?string == "Y"))>checked="checked"</#if> /> ${uiLabelMap.htmlCode}
                        <input type="radio" id="simplTestN" name="simplTest" <#if (simpleTest?exists && simpleTest?string == "N")>checked="checked"</#if> /> ${uiLabelMap.contextFile}
                    </td>
                </tr>
                <tr id="contentIdTr">
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.EmailTemplate}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        ${(contentInfo.contentId)?default("")}
                        <input type="hidden" id="contentId" name="contentId" value="${(contentInfo.contentId)?default("")}" />
                    </td>
                </tr>
                <tr id="customerIdTr">
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.customerId}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <@htmlTemplate.lookupField value="" formName="sendForm" name="customerId" id="customerId" fieldFormName="LookupCustomer" position="center" />
                        <input type="hidden" id="customerName" name="customerName" value="" />
                    </td>
                </tr>
                <tr id="orderNumTr">
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.orderNum}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="text" name="orderId" id="orderId" value="" size="60" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.fromEmailAddr}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="email" name="fromAddress" id="fromAddress" value="" size="60" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.toEmailAddr}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="email" name="toAddress" id="toAddress" value="" size="60" maxlength="255"/>
                    </td>
                </tr>
                <tr id="subjectTr">
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.subject}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <input type="text" name="emailSubject" id="emailSubject" value="" size="60" maxlength="255"/>
                    </td>
                </tr>
                <tr id="emailTextTr">
                    <td class="label" width="15%" align="right" >
                        ${uiLabelMap.emailText}
                    </td>
                    <td width="2%">&nbsp;</td>
                    <td>
                        <textarea name="testEmailText" id="testEmailText" rows="5"></textarea>
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
