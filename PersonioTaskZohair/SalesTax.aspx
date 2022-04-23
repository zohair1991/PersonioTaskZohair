<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesTax.aspx.cs" Inherits="PersonioTaskZohair.SalesTax" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sales Tax Application</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert-dev.min.js" type="text/javascript"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/js/i18n/grid.locale-en.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/js/jquery.jqGrid.min.js"></script>


    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/4.6.0/css/ui.jqgrid.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />


    <style type="text/css">
        .ui-jqgrid tr.jqgrow td {
            height: 50px;
            white-space: normal !important;
            word-wrap: break-word;
            font-size: medium;
            font-family: Arial;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Solution to the Problem # 1</h2>
            <div id="MainDiv" style="padding: 10px">
                <ul>
                    <li><a id="A1" href="#Tab1">Problem # 1</a></li>
                    <li><a id="A2" href="#Tab2">About Developer</a></li>
                </ul>

                <br />

                <div id="Tab1">

                    <div class="form-group">
                        <label>Basic Sales Tax (%):</label>
                        <input type="text" value="10" disabled="disabled" class="form-control" id="txtBasicSalesTax" />
                    </div>

                    <div class="form-group">
                        <label>Additional Sales Tax / Import Duty (%):</label>
                        <input type="text" value="5" disabled="disabled" class="form-control" id="txtImportDuty" />
                    </div>
                    <br />




                    <div class="form-group">
                        <label>Item Name:</label>
                        <input type="text" class="form-control" id="txtItemName" />
                    </div>

                    <div class="form-group">
                        <label>Quantity:</label>
                        <input type="text" class="form-control" onkeypress="return decimalOnly(this);" onpaste="return false" id="txtQuantity" maxlength="5" />
                    </div>

                    <div class="form-group">
                        <label>Unit Price:</label>
                        <input type="text" class="form-control" onkeypress="return decimalOnly(this);" onpaste="return false" id="txtUnitPrice" />
                    </div>

                    <div class="form-group">
                        <label>Product Type:</label>
                        <select class="form-control" id="ddlProductType">
                            <option value="0">Other</option>
                            <option value="1">Books</option>
                            <option value="2">Food</option>
                            <option value="3">Medical</option>
                        </select>
                    </div>

                    <div class="checkbox">
                        <label>
                            <input type="checkbox" id="chkImportedProduct" />
                            Is this Product Imported?</label>
                    </div>

                    <div class="form-group">
                        <input type="button" id="btnAdd" class="form-control btn btn-primary" value="Add" />
                    </div>

                    <div>

                        <table id="ItemGrid" class="tbl">
                        </table>

                        <div id="Pager_main" style="height: 23px;">
                        </div>
                        <br />
                        <label style="font-size: 30px;">
                            Total Sales Taxes :
                            <label id="lblTotalSalesTaxes"></label>
                        </label>
                        <br />
                        <label style="font-size: 30px;">
                            Total :
                            <label id="lblTotal"></label>
                        </label>
                        <br />
                    </div>
                </div>

                <div id="Tab2">
                    <p>Task : Problem # 1 about Sales Tax Invoice</p>
                    <p>Designed & Developed by Syed Zohair Ahmed</p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>


<script type="text/javascript">

    var basicSalesTaxRate = 10;
    var additionalSalesTaxRate = 5;

    $(document).ready(function () {
        $("#MainDiv").tabs();
        FormatGrid();
        $("#lblTotalSalesTaxes,#lblTotal").text("0");
    });



    function decimalOnly(evt) {
        var charCode = (event.which) ? event.which : (window.event.keyCode) ? window.event.keyCode : -1;
        if ((charCode < 48 || charCode > 57)
            && (charCode != 46 && charCode > 31)) {
            return false;
        }
        return true;
    }

    $("#btnAdd").click(function () {


        if ($("#txtItemName").val() == "") {
            swal("Item Name", "Please input Item Name", "info");
            return;
        }

        if ($("#txtQuantity").val() == "") {
            swal("Quantity", "Please input Item Quantity", "info");
            return;
        }

        if ($("#txtUnitPrice").val() == "") {
            swal("Unit Price", "Please input Unit Price", "info");
            return;
        }

        CalculateTotalItemCost();
    });


    function CalculateTotalItemCost() {
        debugger
        var basicSalesTax = parseFloat($("#txtBasicSalesTax").val());
        var importDuty = parseFloat($("#txtImportDuty").val());
        var itemName = $("#txtItemName").val();
        var Qty = parseInt($("#txtQuantity").val());
        var UnitPrice = parseFloat($("#txtUnitPrice").val());
        var SalesTax = parseFloat("0");
        var ImportDuty = parseFloat("0");
        var total = parseFloat("0");

        //if Product Type is 'Other'
        if ($("#ddlProductType").val() == "0") {
            SalesTax = (UnitPrice / 100) * basicSalesTax;
            SalesTax = (Math.ceil(SalesTax * 20) / 20).toFixed(2);
        }

        //if Product is Imported
        if ($("#chkImportedProduct").is(":checked")) {
            ImportDuty = (UnitPrice / 100) * importDuty;
            ImportDuty = (Math.ceil(ImportDuty * 20) / 20).toFixed(2);
        }

        total = (parseFloat(UnitPrice) * parseFloat(Qty)) + parseFloat(SalesTax) + parseFloat(ImportDuty);
        total = parseFloat(total);
        total = (Math.ceil(total * 20) / 20).toFixed(2);

        var totalSalesTax = parseFloat($("#lblTotalSalesTaxes").text());
        totalSalesTax = totalSalesTax + parseFloat(SalesTax) + parseFloat(ImportDuty)
        $("#lblTotalSalesTaxes").text((Math.ceil(totalSalesTax * 20) / 20).toFixed(2));

        var lbltotal = parseFloat($("#lblTotal").text());
        lbltotal = lbltotal + parseFloat(total)
        $("#lblTotal").text((Math.ceil(lbltotal * 20) / 20).toFixed(2));


        var row_id = Math.floor((Math.random() * 1000000000000) + 1);
        var data = { Item_Name: itemName, Quantity: Qty, Unit_Price: UnitPrice, Sales_Tax: SalesTax, Import_Duty: ImportDuty, Total: total };
        jQuery("#ItemGrid").jqGrid('addRowData', row_id, data, 'first');
        jQuery("#ItemGrid").setSelection(row_id, true);
    }

    function FormatGrid() {
        $('#ItemGrid').jqGrid("GridUnload");
        $('#ItemGrid').jqGrid({
            datatype: "json",
            mtype: 'POST',
            ajaxGridOptions: { contentType: 'application/json; charset=utf-8' },
            serializeGridData: function (postData) {
            },
            jsonReader: { root: "d" },
            colNames: ['Item', 'Quantity', 'Unit Price', 'Basic Sales Tax', 'Import Duty', 'Total'],
            colModel: [
                { name: 'Item_Name', index: 'Item_Name', width: 5, sortable: true, sorttype: 'integer', align: 'center' },
                { name: 'Quantity', index: 'Quantity', width: 3, sortable: true, align: 'center' },
                { name: 'Unit_Price', index: 'Unit_Price', width: 3, sortable: true, align: 'center' },
                { name: 'Sales_Tax', index: 'Sales_Tax', width: 4, sortable: true, align: 'center' },
                { name: 'Import_Duty', index: 'Import_Duty', width: 4, sortable: true, align: 'center' },
                { name: 'Total', index: 'Total', width: 4, sortable: true, align: 'center' },
            ],
            loadonce: true,
            sortable: true,
            autoencode: true,
            gridview: true,
            pager: '#Pager_main',
            mtype: 'Post',
            rowNum: 100,
            height: 250,
            rownumbers: true,
            rowList: [100, 200, 500, 1000, 3000],
            viewrecords: true,
            multiple: true,
            shrinkToFit: true,
            autowidth: true,
            caption: 'Items',
            sortorder: 'asc',
            viewrecords: true,
            gridComplete: function () {
                $("#ItemGrid").setGridParam({ datatype: 'local' });
            },
            ondblClickRow: function (rowid) {
            }
        });

        $('#ItemGrid').jqGrid('navGrid', '#Pager_main',
            {
                edit: false,
                add: false,
                del: false,
                search: false,
                refresh: false,
                refreshtext: "",
            },
            {//SEARCH
                closeOnEscape: true
            }
        );
    }

</script>
