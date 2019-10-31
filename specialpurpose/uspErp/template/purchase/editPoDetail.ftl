<style type="text/css">
    /* Style the tab */
    .tab {
        overflow: hidden;
        border: 1px solid #ccc;
        background-color: #f1f1f1;
    }

    /* Style the buttons that are used to open the tab content */
    .tab button {
        background-color: inherit;
        float: left;
        border: none;
        outline: none;
        cursor: pointer;
        padding: 14px 16px;
        transition: 0.3s;
    }

    /* Change background color of buttons on hover */
    .tab button:hover {
        background-color: #ddd;
    }

    /* Create an active/current tablink class */
    .tab button.active {
        background-color: #ccc;
    }

    /* Style the tab content */
    .tabcontent {
        padding: 6px 12px;
        border: 1px solid #ccc;
        border-top: none;
        animation: fadeEffect 1s; /* Fading effect takes 1 second */
    }

    /* Go from zero to full opacity */
    @keyframes fadeEffect {
        from {opacity: 0;}
        to {opacity: 1;}
    }

    div.dt-buttons {
        float: right;
    }
</style>

<script type="text/javascript">
	var initCrudMode = "${crudMode}";

	jQuery(document).ready(function() {
		/***************************************************************************
	     ******************				Init Table				********************
	     ***************************************************************************/
        var fullfillmentTable = $("#fullfillmentList").DataTable({
            dom : "lfrtip",
            processing : true,
            scrollY : true,
            scrollX : true,
            ajax : {
                "type"	: "POST",
                "url"	: '<@ofbizUrl>fullfillmentList</@ofbizUrl>',
                "data"	: function(d) {
                    d.crudMode = "R";
                    d.poNo = $("#poNo").val();
                }
            },
            columns : [
                {
                    "data" : "soNo",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        return data;
                    },
                    "width": "90px",
                    "className" : "align-middle"
                },
                {
                    "data" : "lotNo",
                    "render" : function ( data, type, row ) {
                        return "LOT" + checkNull(data);
                    },
                    "width": "45px",
                    "className" : "align-middle"
                },
                {
                    "data" : "referenceNo",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        return data;
                    },
                    "width": "100px",
                    "className" : "align-middle"
                },
                {
                    "data" : "productId",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        var returnStr = "";
                    <#if productTmp??>
                        <#list productTmp as productTmpInfo>
                        if("${productTmpInfo.productId}" == data) {
                            returnStr = "${productTmpInfo.productNm}";
                        }
                        </#list>
                    </#if>
                        return returnStr;
                    },
                    "width" : "200px",
                    "className" : "align-middle"
                },
                {
                    "data" : "paintCode",
                    "width" : "100px"
                },
                {
                    "data" : "paintName",
                    "width" : "150px"
                },
                {
                    "data" : "orderQty",
                    "width" : "90px"
                },
                {
                    "data" : "producedQtySubTotal",
                    "width" : "120px"
                },
                {
                    "data" : "invoicedQtySubTotal",
                    "width" : "80px"
                }
            ]
        });

        var itemListTable = $("#itemList").DataTable({
            dom : "<'float-right'B><'clear'>lfrtip",
            processing : true,
            scrollY : true,
            scrollX : true,
            ajax : {
                "type"	: "POST",
                "url"	: '<@ofbizUrl>CRUPoList</@ofbizUrl>',
                "data"	: function(d) {
                    d.crudMode = "R";
                    d.poNo = $("#poNo").val();
                }
            },
            columns : [
                {
                    "name" : "soNo",
                    "data" : "soNo",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        return data;
                    },
                    "width": "80px",
                    "className" : "dt-body-center"
                },
                {
                    "name" : "lotNo",
                    "data" : "lotNo",
                    "render" : function ( data, type, row ) {
                        return "LOT" + checkNull(data);
                    },
                    "width": "45px",
                    "className" : "dt-body-center"
                },
                {
                    "name" : "referenceNo",
                    "data" : "referenceNo",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        return data;
                    },
                    "width": "100px",
                    "className" : "dt-body-center"
                },
                {
                    "name" : "itemId",
                    "data" : "itemId",
                    "width": "80px",
                    "className" : "dt-body-center"
                },
                {
                    "name" : "productId",
                    "data" : "productId",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        var returnStr = "";
                    <#if productTmp??>
                        <#list productTmp as productTmpInfo>
                        if("${productTmpInfo.productId}" == data) {
                            returnStr = "${productTmpInfo.productNm}";
                        }
                        </#list>
                    </#if>
                        return returnStr;
                    },
                    "width" : "270px",
                    "className" : "dt-body-center"
                },
                {
                    "name" : "paintCode",
                    "data" : "paintCode",
                    "width" : "100px",
                    "className" : "dt-body-center"
                },
                {
                    "name" : "paintName",
                    "data" : "paintName",
                    "width" : "120px"
                },
                {
                    "name" : "orderThickness",
                    "data" : "orderThickness",
                    "render": function ( data, type, row ) {
                        return $.fn.dataTable.render.number( ',', '.', 4, '').display(data);
                    },
                    "width" : "100px",
                    "className" : "dt-body-center"
                },
                {
                    "name" : "producedThickness",
                    "data" : "producedThickness",
                    "render": function ( data, type, row ) {
                        return $.fn.dataTable.render.number( ',', '.', 4, '').display(data);
                    },
                    "width" : "100px",
                    "className" : "dt-body-center"
                },
                {
                    "name" : "orderWidth",
                    "data" : "orderWidth",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        if(data.indexOf(".") == -1) {
                            return $.fn.dataTable.render.number( ',', '.', 0, '').display(data);
                        } else {
                            return $.fn.dataTable.render.number( ',', '.', 4, '').display(data);
                        }
                    },
                    "width" : "50px",
                    "className" : "dt-body-center"
                },
                {
                    "name" : "producedWidth",
                    "data" : "producedWidth",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        if(data.indexOf(".") == -1) {
                            return $.fn.dataTable.render.number( ',', '.', 0, '').display(data);
                        } else {
                            return $.fn.dataTable.render.number( ',', '.', 4, '').display(data);
                        }
                    },
                    "width" : "50px",
                    "className" : "dt-body-center"
                },
                {
                    "name" : "fobPoint",
                    "data" : "fobPoint",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        var returnStr = "";
                    <#if fobPointTmp??>
                        <#list fobPointTmp as fobPointTmpInfo>
                        if("${fobPointTmpInfo.fobPointId}" == data) {
                            returnStr = "${fobPointTmpInfo.fobPointNm}";
                        }
                        </#list>
                    </#if>

                        return returnStr;
                    },
                    "width" : "90px",
                    "className" : "dt-body-center"
                },
                {
                    "name" : "producedQty",
                    "data" : "producedQty",
                    "render": function ( data, type, row ) {
                        return $.fn.dataTable.render.number( ',', '.', 2, '').display(data);
                    },
                    "width" : "90px",
                    "className" : "dt-body-right"
                },
                {
                    "name" : "itemLength",
                    "data" : "itemLength",
                    "render": function ( data, type, row ) {
                        return $.fn.dataTable.render.number( ',', '.', 2, '').display(data);
                    },
                    "width" : "90px",
                    "className" : "dt-body-right"
                },
                {
                    "name" : "unitPrice",
                    "data" : "unitPrice",
                    "render": function ( data, type, row ) {
                        return "$ " + $.fn.dataTable.render.number( ',', '.', 2, '').display(data);
                    },
                    "width" : "90px",
                    "className" : "dt-body-right"
                },
                {
                    "name" : "poNo",
                    "data" : "poNo",
                    "visible": false
                },
                {
                    "name" : "referenceSeq",
                    "data" : "referenceSeq",
                    "visible": false
                },
                {
                    "data" : "lotNo",
                    "visible": false
                },
                {
                    "data" : "productId",
                    "visible": false
                },
                {
                    "name" : "commercialInvoiceNo",
                    "data" : "commercialInvoiceNo",
                    "visible": false
                },
                {
                    "name" : "commercialInvoiceDate",
                    "data" : "commercialInvoiceDate",
                    "visible": false
                },
                {
                    "name" : "blNo",
                    "data" : "blNo",
                    "visible": false
                },
                {
                    "name" : "shippingLine",
                    "data" : "shippingLine",
                    "visible": false
                },
                {
                    "name" : "blDate",
                    "data" : "blDate",
                    "visible": false
                },
                {
                    "name" : "mtcRequiredYN",
                    "data" : "mtcRequiredYN",
                    "visible": false
                },
                {
                    "name" : "mtcVerified",
                    "data" : "mtcVerified",
                    "visible": false
                },
                {
                    "name" : "fobPrice",
                    "data" : "fobPrice",
                    "visible": false
                },
                {
                    "name" : "qtyUnit",
                    "data" : "qtyUnit",
                    "visible": false
                },
                {
                    "name" : "orderQty",
                    "data" : "orderQty",
                    "visible": false
                }
            ],
            buttons: [
                {
                    extend: 'selectAll',
                    text: "${uiLabelMap.selectAll}",
                    className: "buttonsToHide",
                    action: function ( e, dt, button, config ) {
                        var dataLength = dt.rows().data().length;
                        var selectedRowCnt = dt.rows(".selected").data().length;

                        if(dataLength == selectedRowCnt) {
                            itemListTable.$('tr.selected').removeClass('selected');
                            itemListTable.button( 'selected:name' ).disable();
                        } else if(dataLength > selectedRowCnt) {
                            itemListTable.button( 'selected:name' ).enable();
                            itemListTable.$('tr').addClass('selected');
                        }
                    }
                },
                {
                    extend: 'selected',
                    className: "buttonsToHide",
                    name: 'selected',
                    text: "${uiLabelMap.applySelectedBtn}",
                    action: function ( e, dt, button, config ) {
                        var selectRow = dt.rows( '.selected' ).data();

                        if(selectRow.length  > 0) {
                            for(var i=0 ; selectRow.length > i ; i++) {
                                var rowIdx = selectRow[i];
                                var data = dt.row(rowIdx).data();

                                var producedThickness = $("#inputDataForm #producedThickness").val();
                                var producedWidth = $("#inputDataForm #producedWidth").val();
                                var producedQty = $("#inputDataForm #producedQty").val();
                                var itemLength = $("#inputDataForm #itemLength").val();
                                var commercialInvoice = $("#inputDataForm #commercialInvoice").val();
                                var commercialInvoiceDate = $("#inputDataForm #commercialInvoiceDate").val();
                                var blNo = $("#inputDataForm #blNo").val();
                                var blDate = $("#inputDataForm #blDate").val();
                                var shippingLine = $("#inputDataForm #shippingLine").val();
                                var shippingAgent = $("#inputDataForm #shippingAgent").val();
                                var mtcRequiredYN = $("#inputDataForm #mtcRequiredYN").val();
                                var mtcVerified = "N";
                                if($("#inputDataForm #mtcVerified").is("checked")) {
                                    mtcVerified = "Y";
                                }
                                var fobPrice = $("#inputDataForm #fobPrice").val();

                                if(producedThickness != "") {
                                    data["producedThickness"] = producedThickness;
                                }
                                if(producedWidth != "") {
                                    data["producedWidth"] = producedWidth;
                                }
                                if(producedQty != "") {
                                    data["producedQty"] = producedQty;
                                }
                                if(itemLength != "") {
                                    data["itemLength"] = itemLength;
                                }
                                if(commercialInvoice != "") {
                                    data["commercialInvoice"] = commercialInvoice;
                                }
                                if(commercialInvoiceDate != "") {
                                    data["commercialInvoiceDate"] = commercialInvoiceDate;
                                }
                                if(blNo != "") {
                                    data["blNo"] = blNo;
                                }
                                if(blDate != "") {
                                    data["blDate"] = blDate;
                                }
                                if(shippingLine != "") {
                                    data["shippingLine"] = shippingLine;
                                }
                                if(shippingAgent != "") {
                                    data["shippingAgent"] = shippingAgent;
                                }
                                if(mtcRequiredYN != "") {
                                    data["mtcRequiredYN"] = mtcRequiredYN;
                                }
                                if(mtcVerified != "") {
                                    data["mtcVerified"] = mtcVerified;
                                }
                                if(fobPrice != "") {
                                    data["fobPrice"] = fobPrice;
                                }
                                dt.row(rowIdx).data(data).draw();
                            }
                        }
                        itemListTable.$('tr.selected').removeClass('selected');
                    }
                },
                // 컬럼 위치 변경시 index 변경
                {
                    extend: 'csv',
                    filename: $("#poNo").val() + "_Upload_Form",
                    text: 'Download CSV Upload Form',
                    className: "buttonsToHide",
                    exportOptions: {
                            columns: [15, 1, 2, 3, 18, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
                    },
                    //Function which customize the CSV (input : csv is the object that you can preprocesss)
                    customize: function (csv) {
                        //Split the csv to get the rows
                        var split_csv = csv.split("\n");

                        //Remove the row one to personnalize the headers
                        var newSplit_csv = "".split("\n");
                        newSplit_csv[0] = 'poNo,lotNo,referenceNo,itemId,productId,productNm,paintCode,paintName,orderThickness,producedThickness,orderWidth,producedWidth,fobPoint,producedQty,itemLength,unitPrice';

                        //For each row except the first one (header)
                        var newIdx = 1;
                        $.each(split_csv.slice(1), function (index, csv_row) {
                            //Split on quotes and comma to get each cell
                            var csv_cell_array = csv_row.split('","');
                                console.log(index);
                            if(csv_cell_array[9] == ""
                                && csv_cell_array[11] == ""
                                && csv_cell_array[13] == ""
                                && csv_cell_array[14] == "") {
                                //Remove replace the two quotes which are left at the beginning and the end (first and last cell)
                                csv_cell_array[0] = csv_cell_array[0].replace(/"/g, '');
                                csv_cell_array[(csv_cell_array.length-1)] = csv_cell_array[(csv_cell_array.length-1)].replace(/"/g, '');

                                //Join the table on the quotes and comma; add back the quotes at the beginning and end
                                csv_cell_array_quotes = '"' + csv_cell_array.join('","') + '"';
                                //Insert the new row into the rows array at the previous index (index +1 because the header was sliced)
                                newSplit_csv[newIdx] = csv_cell_array_quotes;
                                newIdx++;
                            }
                        });

                        //Join the rows with line breck and return the final csv (datatables will take the returned csv and process it)
                        csv = newSplit_csv.join("\n");
                        return csv;
                    }
                }
            ]
        });

        // column value update
        $("#itemList").on("change", ":input,textarea,select,check", function() {
            var val;
            var valType = typeof $(this).val();
            var type = typeof itemListTable.cell( $(this).parent() ).data();
            if(type == "number") {
                if(valType == "string") {
                    val = Number($(this).val().replace(/\,/g, ""));
                } else {
                    val = Number($(this).val());
                }
            } else {
                val = $(this).val();
            }
            itemListTable.cell( $(this).parent() ).data(val).draw();
        });

        $('#itemList tbody').on( 'click', 'tr', function () {
            if ( $(this).hasClass('selected') ) {
                $(this).removeClass('selected');
            } else {
                //itemListTable.$('tr.selected').removeClass('selected');
 	            $(this).addClass('selected');
 	            itemListTable.button( 'selected:name' ).enable();
            }

            var selectedRowCnt = itemListTable.rows(".selected").data().length;
            if(selectedRowCnt == 0) {
                itemListTable.button( 'selected:name' ).disable();
            }

            var tableData = itemListTable.row(this).data();
            var qtyUnit = tableData["qtyUnit"];
            selectedColTotal(itemListTable, ["producedQty," + "LB" + ",10", "itemLength,,14"]);
        });

        var shipmentSatusList = $("#shipmentSatusList").DataTable({
            dom : "lfrtip",
            processing : true,
            scrollY : true,
            scrollX : true,
            columns : [
                {
                    "data" : "soNo",
                    "width": "90px",
                    "className" : "align-middle"
                },
                {
                    "data" : "lotNo",
                    "render" : function ( data, type, row ) {
                        return "LOT" + checkNull(data);
                    },
                    "width": "45px",
                    "className" : "align-middle"
                },
                {
                    "data" : "referenceNo",
                    "width": "100px",
                    "className" : "align-middle"
                },
                {
                    "data" : "productId",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        var returnStr = "";
                    <#if productTmp??>
                        <#list productTmp as productTmpInfo>
                        if("${productTmpInfo.productId}" == data) {
                            returnStr = "${productTmpInfo.productNm}";
                        }
                        </#list>
                    </#if>
                        return returnStr;
                    },
                    "width" : "200px",
                    "className" : "align-middle"
                },
                {
                    "data" : "paintCode",
                    "width" : "100px"
                },
                {
                    "data" : "paintName",
                    "width" : "150px"
                },
                {
                    "data" : "producedThickness",
                    "width" : "100px"
                },
                {
                    "data" : "orderWidth",
                    "render": function ( data, type, row ) {
                        return "<input type='text' name='orderWidth' id='orderWidth' value='" + data + "' />";
                    },
                    "width" : "50px"
                },
                {
                    "data" : "fobPoint",
                    "render": function ( data, type, row ) {
                        data = checkNull(data);
                        var $select = $("<select></select>", {
                            "id" : "fobPoint",
                            "value" : data
                        });
                        var $option = "<option value=''></option>";
                    <#if fobPointTmp??>
                        <#list fobPointTmp as fobPointTmpInfo>
                        $option += "<option value='${fobPointTmpInfo.fobPointId!}'>${fobPointTmpInfo.fobPointNm!}</option>";
                        </#list>
                    </#if>

                        $select.append($option);
                        $select.find("[value='" + data + "']").attr("selected", "selected");
                        $select.attr("class", "fobPoint");
                        return $select.prop("outerHTML");
                    },
                    "width" : "90px"
                },
                {
                    "data" : "orderQty",
                    "width" : "90px"
                },
                {
                    "data" : "producedQty",
                    "width" : "120px"
                },
                {
                    "data" : "invoicedQty",
                    "width" : "80px"
                }
            ]
         });

        /***************************************************************************
         ******************			Common Control				********************
         ***************************************************************************/
        $("#fullFillmentBtn").click();

        if("${poStatus}" == "CP") {
            itemListTable.buttons('.buttonsToHide').nodes().addClass('hidden');
        }

	    /***************************************************************************
	     ******************			InputBox Control			********************
	     ***************************************************************************/

	    /***************************************************************************
	     ******************			SelectBox Control			********************
	     ***************************************************************************/

	    /***************************************************************************
	     ******************				Button Control			********************
	     ***************************************************************************/
	    $("#moveListBtn").on("click", function() {
            $.confirm({
                title: 'Move To List',
                boxWidth: '500px',
                useBootstrap: false,
                content: '<font style="font-size: 16px;">Are you sure you want to move to before saving?</font>',
                buttons: {
                    confirm: function () {
                        $("#pageMoveForm").attr("action", "<@ofbizUrl>schPoList</@ofbizUrl>");
                        $("#pageMoveForm").submit();
                    },
                    cancel: function () {
                    }
                }
            });
        });

	    $("#submitBtn").on("click", function() {
            var reqData = itemListTable.rows().data();
            var reqArray = makeArrayData(reqData);

            jQuery.ajax({
                url: '<@ofbizUrl>CRUPoList</@ofbizUrl>',
                type: 'POST',
                data: "crudMode=U&reqData=" + JSON.stringify(reqArray),
                error: function(msg) {
                    showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
                },
                success: function(data, status) {
                    if(data.successStr == "success") {
                        alert("PO Create Completed");

                        /*$("#pageMoveForm").attr("action", "<@ofbizUrl>editPo?poNo=" + $("#poNo").val() + "</@ofbizUrl>");
                        $("#pageMoveForm").submit();*/
                    } else {
                        alert("PO Create Fail");
                    }
                }
            });
        });

	    $("#uploadCSVFileBtn").on("click", function(event) {
	        $("#uploadCSVFile").click();
	    });
	    $("#uploadCSVFile").on("change", function(event) {
            var csvData = covertFileToData(event);

            csvData.then(res => {
                var allRow = itemListTable.rows().indexes();
                if(allRow.length > 0) {
                    if(res.length > 0) {
                        var addRowArray = new Array();
                        for(var i=0 ; res.length > i ; i++) {
                            var csvData = res[i];
                            var csvLotNo = csvData["lotNo"];
                            csvLotNo = csvLotNo.replace("LOT", "");
                            var csvReferenceNo = csvData["referenceNo"];
                            var csvProductId = csvData["productId"];
                            var csvPaintCode = (csvData["paintCode"] == null || csvData["paintCode"] == "") == true ? "" : csvData["paintCode"];
                            var csvPaintName = (csvData["paintName"] == null || csvData["paintName"] == "") == true ? "" : csvData["paintName"];

                            var csvItemId = csvData["itemId"];
                            var csvProducedThickness = csvData["producedThickness"];
                            var csvProducedWidth = csvData["producedWidth"];
                            var csvProducedQty = csvData["producedQty"];
                            var csvItemLength = csvData["itemLength"];

                            var eqDataCnt = 0;
                            var baseDataCnt = 0;
                            var baseData = new Object();
                            var rowIdxArry = "";
                            for(var j=0 ; allRow.length > j ; j++) {
                                var rowIdx = allRow[j];
                                var data = itemListTable.row(rowIdx).data();
                                var lotNo = data["lotNo"];
                                var referenceSeq = data["referenceSeq"];
                                var referenceNo = data["referenceNo"];
                                var productId = data["productId"];
                                var paintCode = (data["paintCode"] == null || data["paintCode"] == "") == true ? "" : data["paintCode"];
                                var paintName = (data["paintName"] == null || data["paintName"] == "") == true ? "" : data["paintName"];

                                if(csvLotNo == lotNo
                                    && csvReferenceNo == referenceNo
                                    && csvProductId == productId
                                    && csvPaintCode == paintCode
                                    && csvPaintName == paintName) {

                                    if(baseDataCnt == 0 ) {
                                        baseData = makeMapData(data);
                                        baseDataCnt++;
                                    }

                                    if(referenceSeq != null && referenceSeq != "") {
                                        if(data["itemId"] == null || data["itemId"] == "") {
                                            if(rowIdxArry == "") {
                                                rowIdxArry += rowIdx;
                                            } else {
                                                rowIdxArry += rowIdx + ",";
                                            }
                                        } else {
                                            if(data["itemId"] == csvItemId) {
                                                eqDataCnt++;
                                            }
                                        }
                                    } else {
                                        if(data["itemId"] != null && data["itemId"] != "") {
                                            if(data["itemId"] == csvItemId) {
                                                eqDataCnt++;
                                            }
                                        }
                                    }
                                }
                            }

                            console.log(eqDataCnt);

                            if(eqDataCnt == 0) {
                                if(rowIdxArry != "") {
                                    if(rowIdxArry.indexOf(",") > -1) {
                                        alert("Data Upload Fail.");
                                    } else {
                                        var data = itemListTable.row(rowIdxArry).data();
                                        data["itemId"] = csvItemId;
                                        data["producedThickness"] = csvProducedThickness;
                                        data["producedWidth"] = csvProducedWidth;
                                        data["producedQty"] = csvProducedQty;
                                        data["itemLength"] = csvItemLength;
                                        data["paintCode"] = (data["paintCode"] == null || data["paintCode"] == "") == true ? "" : data["paintCode"];
                                        data["paintName"] = (data["paintName"] == null || data["paintName"] == "") == true ? "" : data["paintName"];
                                        data["commercialInvoice"] = "";
                                        data["commercialInvoiceDate"] = "";
                                        data["blNo"] = "";
                                        data["blDate"] = "";
                                        data["shippingLine"] = "";
                                        data["shippingAgent"] = "";
                                        data["mtcRequiredYN"] = "";
                                        data["mtcVerified"] = "";
                                        data["fobPrice"] = "";

                                        itemListTable.row(rowIdxArry).data(data).draw();
                                    }
                                } else {
                                    baseData["itemId"] = csvItemId;
                                    baseData["producedThickness"] = csvProducedThickness;
                                    baseData["producedWidth"] = csvProducedWidth;
                                    baseData["producedQty"] = csvProducedQty;
                                    baseData["itemLength"] = csvItemLength;
                                    baseData["referenceSeq"] = "";
                                    baseData["paintCode"] = (baseData["paintCode"] == null || baseData["paintCode"] == "") == true ? "" : baseData["paintCode"];
                                    baseData["paintName"] = (baseData["paintName"] == null || baseData["paintName"] == "") == true ? "" : baseData["paintName"];
                                    baseData["commercialInvoice"] = "";
                                    baseData["commercialInvoiceDate"] = "";
                                    baseData["blNo"] = "";
                                    baseData["blDate"] = "";
                                    baseData["shippingLine"] = "";
                                    baseData["shippingAgent"] = "";
                                    baseData["mtcRequiredYN"] = "";
                                    baseData["mtcVerified"] = "";
                                    baseData["fobPrice"] = "";

                                    itemListTable.row.add(baseData).draw();
                                }
                            }
                        }
                    }
                }
            })
            .catch(err => {
                alert(err);
            });
        });

        $("#createPurchaseShippmentBtn").on("click", function() {
            alert("Under Developing.");
        });
	});
</script>

<!-- Tab links -->
<div class="tab">
  <button id="fullFillmentBtn" class="tablinks" onclick="openTab(event, 'fullFillment')">Fullfillment</button>
  <button id="shipmentBtn" class="tablinks" onclick="openTab(event, 'shipment')">Shipment</button>
</div>

<!-- Tab content -->
<div id="fullFillment" class="tabcontent">
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">
                    ${uiLabelMap.fullFillMent}
                </li>
            </ul>
            <br class="clear">
        </div>

    	<form name="fullfillmentForm" id="fullfillmentForm" method="post">
    		<table class="display cell-border stripe" id="fullfillmentList" name="fullfillmentList" style="width:100%">
    			<thead>
    				<tr>
    					<th style="vertical-align: middle;">${uiLabelMap.soNo}</th>
    					<th style="vertical-align: middle;">${uiLabelMap.lot}</th>
    					<th style="vertical-align: middle;">${uiLabelMap.internalRef}</th>
    					<th style="vertical-align: middle;">${uiLabelMap.productId}</th>
    					<th style="vertical-align: middle;">${uiLabelMap.paintCode}</th>
    					<th style="vertical-align: middle;">${uiLabelMap.paintName}</th>
    					<!--<th style="vertical-align: middle;">${uiLabelMap.thickness}</th>
    					<th style="vertical-align: middle;">${uiLabelMap.width}</th>
    					<th style="vertical-align: middle;">${uiLabelMap.fobPoint}</th>-->
    					<th style="vertical-align: middle;">${uiLabelMap.orderQty}</th>
    					<th style="vertical-align: middle;">${uiLabelMap.producedQty}</th>
    					<th style="vertical-align: middle;">${uiLabelMap.invoicedQty}</th>
    				</tr>
    			</thead>
    			<tbody>
    			</tbody>
    			<tfoot>
    				<tr>
    					<th style="vertical-align: middle;">${uiLabelMap.soNo}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.lot}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.internalRef}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.productId}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.paintCode}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.paintName}</th>
                        <!--<th style="vertical-align: middle;">${uiLabelMap.thickness}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.width}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.fobPoint}</th>-->
                        <th style="vertical-align: middle;">${uiLabelMap.orderQty}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.producedQty}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.invoicedQty}</th>
    				</tr>
    			</tfoot>
    		</table>
    	</form>
    </div>

    <div class="screenlet">
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">
                    ${uiLabelMap.itemList}
                </li>
            </ul>
            <br class="clear">
        </div>
        <#if poStatus != "CP">
        <form name="inputDataForm" id="inputDataForm" method="post">
            <table class="basic-table" cellspacing="0" id="itemInfo">
                <tr>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.producedThickness}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <input type="text" name="producedThickness" id="producedThickness" />
                    </td>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.producedWidth}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <input type="text" name="producedWidth" id="producedWidth" />
                    </td>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.producedQty}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <input type="text" name="producedQty" id="producedQty" />
                    </td>
                </tr>
                <tr>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.itemLength}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <input type="text" name="itemLength" id="itemLength" />
                    </td>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.commercialInvoice}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <input type="text" name="commercialInvoice" id="commercialInvoice" />
                    </td>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.blNo}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <input type="text" name="blNo" id="blNo" />
                    </td>
                </tr>
                <tr>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.shippingLine}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <select name="shippingLine" id="shippingLine">
                            <option value=""></option>
                        <#if shippingLine??>
                            <#list shippingLine as shippingLineInfo>
                            <option value="${shippingLineInfo.shippingLineId!}">${shippingLineInfo.shippingLineNm!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.commercialInvoiceDate}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <@htmlTemplate.renderDateTimeField name="commercialInvoiceDate" id="commercialInvoiceDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd" value="" size="10" maxlength="10" dateType="date" shortDateInput=true timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
                    </td>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.blDate}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <input type="text" name="blDate" id="blDate" />
                    </td>
                </tr>
                <tr>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.shippingAgent}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <select name="shippingAgent" id="shippingAgent">
                            <option value=""></option>
                        <#if shippingAgent??>
                            <#list shippingAgent as shippingAgentInfo>
                            <option value="${shippingAgentInfo.shippingAgentId!}">${shippingAgentInfo.shippingAgentId!}</option>
                            </#list>
                        </#if>
                        </select>
                    </td>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.mtcRequiredYN}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <select name="mtcRequiredYN" id="mtcRequiredYN">
                            <option></option>
                            <option value="Y">Y</option>
                            <option value="N">N</option>
                        </select>
                    </td>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.mtcVerified}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td width="20%" >
                        <input type="checkbox" name="mtcVerified" id="mtcVerified" value="Y" />
                    </td>
                </tr>
                <tr>
                    <td class="label" width="13%" align="right">
                        ${uiLabelMap.fobPrice}
                    </td>
                    <td width="1%">&nbsp;</td>
                    <td colspan="7">
                        <input type="text" name="fobPrice" id="fobPrice" />
                    </td>
                </tr>
            </table>
        </form>
        </#if>

        <form name="itemListForm" id="itemListForm" method="post">
            <table class="display cell-border stripe" id="itemList" name="itemList" style="width:100%">
                <thead>
                    <tr>
                        <th style="vertical-align: middle;" rowspan="2">${uiLabelMap.soNo}</th>
                        <th style="vertical-align: middle;" rowspan="2">${uiLabelMap.lot}</th>
                        <th style="vertical-align: middle;" rowspan="2">${uiLabelMap.internalRef}</th>
                        <th style="vertical-align: middle;" rowspan="2">${uiLabelMap.itemId}</th>
                        <th style="vertical-align: middle;" rowspan="2">${uiLabelMap.productId}</th>
                        <th style="vertical-align: middle;" rowspan="2">${uiLabelMap.paintCode}</th>
                        <th style="vertical-align: middle;" rowspan="2">${uiLabelMap.paintName}</th>
                        <th style="vertical-align: middle;text-align: center;" colspan="2">${uiLabelMap.thickness}</th>
                        <th style="vertical-align: middle;text-align: center;" colspan="2">${uiLabelMap.width}</th>
                        <th style="vertical-align: middle;" rowspan="2">${uiLabelMap.fobPoint}</th>
                        <th style="vertical-align: middle;" rowspan="2">${uiLabelMap.producedQty}</th>
                        <th style="vertical-align: middle;" rowspan="2">${uiLabelMap.itemLength}</th>
                        <th style="vertical-align: middle;" rowspan="2">${uiLabelMap.unitCost}</th>
                    </tr>
                    <tr>
                        <th style="vertical-align: middle;">${uiLabelMap.orderThickness}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.producedThickness}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.orderWidth}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.producedWidth}</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="2" style="text-align:right"></th>
                        <th colspan="2" style="text-align:right"></th>
                        <th colspan="2" style="text-align:right"></th>
                        <th colspan="2" style="text-align:right"></th>
                        <th colspan="2" style="text-align:right">Produced Qty :</th>
                        <th colspan="2" style="text-align:right"></th>
                        <th colspan="2" style="text-align:right">Item Length :</th>
                        <th colspan="2" style="text-align:right"></th>
                    </tr>
                </tfoot>
            </table>
        </form>

        <form name="uploadCSV" id="uploadCSV" method="post" enctype="multipart/form-data">
            <table class="basic-table" cellspacing="0" id="itemInfo">
                <tr>
                    <td align="left">
                        <input type="button" id="moveListBtn" value="${uiLabelMap.list}" class="buttontext"/>
                    <#if poStatus != "CP">
                        <input type="button" id="submitBtn" value="${uiLabelMap.submit}" class="buttontext"/>
                        <input type="file" name="uploadCSVFile" id="uploadCSVFile" accept=".csv" style="display:none;" />
                        <input type="button" id="uploadCSVFileBtn" value="${uiLabelMap.uploadCSVFileBtn}" class="buttontext"/>
                        <input type="button" id="createPurchaseShippmentBtn" value="${uiLabelMap.createPurchaseShippmentBtn}" class="buttontext"/>
                    </#if>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

<div id="shipment" class="tabcontent">
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">
                    ${uiLabelMap.shipmentStatus}
                </li>
            </ul>
            <br class="clear">
        </div>

        <form name="shipmentForm" id="shipmentForm" method="post">
            <table class="display cell-border stripe" id="shipmentSatusList" name="shipmentSatusList" style="width:100%">
                <thead>
                    <tr>
                        <th style="vertical-align: middle;">${uiLabelMap.soNo}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.lot}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.internalRef}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.productId}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.paintCode}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.paintName}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.thickness}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.width}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.fobPoint}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.orderQty}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.producedQty}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.invoicedQty}</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
                <tfoot>
                    <tr>
                        <th style="vertical-align: middle;">${uiLabelMap.soNo}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.lot}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.internalRef}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.productId}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.paintCode}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.paintName}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.thickness}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.width}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.fobPoint}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.orderQty}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.producedQty}</th>
                        <th style="vertical-align: middle;">${uiLabelMap.invoicedQty}</th>
                    </tr>
                </tfoot>
            </table>
        </form>
    </div>
</div>