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
        var emailTemplateListTable = $("#emailTemplateList").DataTable({
            dom : "lfrtip",
            processing : true,
            scrollY : true,
            scrollX : true,
            ajax : {
                "type"		: "POST",
                "url"		: '<@ofbizUrl>searchEmailTemplateList</@ofbizUrl>',
                "data"		: function(d) {
                    d.draw = "0";
                    d.contentTypeId = "${contentTypeId}";
                    d.productStoreId = "${productStoreId}";
                }
            },
            columns : [
                {
                    "data" : "contentId",
                    "render": function ( data, type, row ) {
                        return "<a href='<@ofbizUrl>updateEmailDetailForm?contentId=" + data + "&contentTypeId=" + row.contentTypeId + "</@ofbizUrl>' class='buttontext'>" + data + "</a>";
                    }
                },
                {
                    "data" : "contentName"
                },
                {
                    "data" : "statusId",
                    "render": function ( data, type, row ) {
                        var returnStr = "";
                        if(data == "EMAIL_DEACTIVATED") {
                            returnStr = "Inactive";
                        } else if(data == "EMAIL_PUBLISHED") {
                            returnStr = "Active";
                        } else if(data == "EMAIL_IN_PROGRESS") {
                            returnStr = "Pending";
                        } else {
                            returnStr = "Inactive";
                        }

                        return returnStr;
                    }
                },
                {
                    "data" : "description"
                },
                {
                    "data" : "lastUpdatedStamp",
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
                    "data" : "createdStamp",
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
                    "data" : "",
                    "render": function ( data, type, row ) {
                        return "<a href='<@ofbizUrl>sendTestEmailForm?contentId=" + row.contentId + "&simpleTest=N</@ofbizUrl>' class='buttontext'>Send Test Email</a>";
                    }
                },
                {
                    "data" : "contentTypeId",
                    "visible": false
                },
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
	});
</script>

<div class="page-title">
	<span>
		${uiLabelMap.EmailTemplate}
	</span>
</div>

<div class="button-bar">
    <a class="buttontext create" href="/uspErp/control/createEmailDetailForm">
        ${uiLabelMap.createEmail}
    </a>
</div>

<!-- Search Result -->
<div class="screenlet">
	<table id="emailTemplateList" class="hover cell-border stripe" style="width:100%">
		<thead>
			<tr>
				<th style="vertical-align: middle;">${uiLabelMap.contentId}</th>
				<th style="vertical-align: middle;">${uiLabelMap.contentName}</th>
				<th style="vertical-align: middle;">${uiLabelMap.statusId}</th>
				<th style="vertical-align: middle;">${uiLabelMap.description}</th>
				<th style="vertical-align: middle;">${uiLabelMap.activeDate}</th>
				<th style="vertical-align: middle;">${uiLabelMap.createDate}</th>
				<th style="vertical-align: middle;"></th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<th style="vertical-align: middle;">${uiLabelMap.contentId}</th>
                <th style="vertical-align: middle;">${uiLabelMap.contentName}</th>
                <th style="vertical-align: middle;">${uiLabelMap.statusId}</th>
                <th style="vertical-align: middle;">${uiLabelMap.description}</th>
                <th style="vertical-align: middle;">${uiLabelMap.activeDate}</th>
                <th style="vertical-align: middle;">${uiLabelMap.createDate}</th>
                <th style="vertical-align: middle;"></th>
			</tr>
		</tfoot>
	</table>
</div>