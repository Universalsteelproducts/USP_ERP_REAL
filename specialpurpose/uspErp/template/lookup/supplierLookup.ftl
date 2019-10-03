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
		var supplierListTable = $("#supplierList").DataTable({
            dom : "lfrtip",
            processing : true,
            scrollY : true,
            scrollX : true,
            ajax : {
                "type"		: "POST",
                "url"		: '<@ofbizUrl>schSupplier</@ofbizUrl>',
                "data"		: function(d) {
                    d.draw = "0";
                    d.supplierId = $("input[name=supplierId]").val();
                    d.supplierNm = $("input[name=supplierNm]").val();
                }
            },
            columns : [
                {
                    "data" : "vendorId",
                    "render": function ( data, type, row ) {
                        return "<a href='javascript:set_value(\"" + data + "\")' class='buttontext'>" + data + "</a>";
                    }
                },
                {
                    "data" : "vendorNm"
                },
                {
                    "data" : "vendorInitials"
                }
            ]
        });

		/***************************************************************************
		 ******************			Table change Event			********************
		 ***************************************************************************/
        $('#supplierList tbody').on( 'click', 'tr', function () {
            $(this).toggleClass('selected');
        } );

		/***************************************************************************
		 ******************			SelectBox Control			********************
		 ***************************************************************************/

		/***************************************************************************
		 ******************				Button Control			********************
		 ***************************************************************************/
		$("#searchBtn").on("click", function() {
		    supplierListTable.ajax.reload();
		});

		$("#addGroupBtn").on("click", function() {
		    var selectRow = supplierListTable.rows(".selected").data();
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
<!-- Search Condition -->
<div class="screenlet">
    <div class="screenlet-title-bar">
        <ul>
            <li class="h3">${uiLabelMap.securityGroup}</li>
        </ul>
    </div>
    <div class="screenlet-body no-padding">
        <div id="search-options">
            <form name="searchForm" id="searchForm" method="post" class="basic-form">
            <table class="basic-table" cellspacing="0">
                <tbody>
                    <tr>
                        <td class="label" align="right" >
                            ${uiLabelMap.groupId}
                        </td>
                        <td width="2%">&nbsp;</td>
                        <td>
                            <input type="text" name="supplierId" id="supplierId" maxlength="255"/>
                        </td>
                        <td class="label" align="right" >
                            ${uiLabelMap.supplier}
                        </td>
                        <td width="2%">&nbsp;</td>
                        <td>
                            <input type="text" name="supplierNm" id="supplierNm" maxlength="255"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label" align="right">
                            &nbsp;
                        </td>
                        <td width="2%">&nbsp;</td>
                        <td colspan="4">
                            <input type="button" id="searchBtn" value="${uiLabelMap.CommonFind}" class="buttontext" />
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
    <div>
        <ul style="text-align:right;">
            <input id="addGroupBtn" type="button" value="${uiLabelMap.confirm}" class="buttontext"/>
        </ul>
    </div>
    <br/>
    <table id="supplierList" class="hover cell-border stripe" style="width:100%">
        <thead>
            <tr>
                <th style="vertical-align: middle;">${uiLabelMap.supplierId}</th>
                <th style="vertical-align: middle;">${uiLabelMap.supplierNm}</th>
                <th style="vertical-align: middle;">${uiLabelMap.supplierIt}</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
        </tfoot>
    </table>
</div>