<%--
    Created on : 07-March-2016
    Author     : Macar Calancea (mcalancea@acquisio.com)
    url        : http://localhost:9090/jetty-jsp-example/view/List.jsp
--%>
<%@page import="java.util.Collection" %>
<%@page import="org.apache.commons.lang.math.NumberUtils"%>
<%@page import="webapp.objects.SomeClass"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" language="javascript" src="http://code.jquery.com/jquery-2.2.1.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>


        <script type="text/javascript">
                $(document).ready(function() {
                    $("#columnsTable").dataTable( {
                        "aaSorting": [[ 1, 'asc' ], [ 2, 'asc' ], [ 3, 'asc' ]],
                        "sDom": 'lfr<"giveHeight"t>ip',
                        "bStateSave": true,
                        "bPaginate": false,
                        "bLengthChange": false,
                        "bFilter": true,
                        "bInfo": true,
                        "bAutoWidth": false,
                        "bSort": true
                    });


                });
                var getcolumns = function(){
                    $.post("List", $("#columnsV2").serialize())
                        //.done(function( data ) {
                        //    console.log(data);
                        //})
                        ;
                }


                var getcolumns = function(){
                    $.post("List", $("#columnsV2").serialize())
                        .done(function( data ) {
                            console.log(data);
                            //$("#columnsTable tbody").html("");
                            $("#columns").html("");
                            $("#columns").append(
                                "<table id='columnsTable' border=1>"+
                                    "<thead>"+
                                        "<tr>"+
                                            "<th>ID</th>"+
                                            "<th>Name</th>"+
                                            "<th>Formula</th>"+
                                            "<th>Status</th>"+
                                            "<th>Action</th>"+
                                        "</tr>"+
                                    "</thead>"+
                                    "<tbody>"+
                                    "</tbody>"+
                                "</table>");
                            $.each( data, function( key, value ) {
                                console.log( key + ":> " + value );
                                $("#columnsTable tbody").append(
                                    "<tr>"+
                                        "<td>"+value.id+"</td>"+
                                        "<td>"+value.formulaName+"</td>"+
                                        "<td>"+value.formula+"</td>"+
                                        "<td>"+value.isActive+"</td>"+
                                        "<td>edit delete</td>"+
                                    "</tr>"
                                )
                            });
                        });
                 }
        </script>
        <title>Columns</title>

        <%
            final long agencyId = NumberUtils.toLong(request.getParameter("agencyId"), -1L);
            final long accountId = NumberUtils.toLong(request.getParameter("accountId"), -1L);
        %>
    </head>
    <body>
        <h1>Columns</h1>
        <p>
        <!--<form action="List.jsp" method="post" id="columnsV2">--
        <form action="columnsServlet" method="post" id="columnsV2">
            <p><b>Agency ID :</b></p>
            <select name="agencyId">
                <option value="">&nbsp;</option>
                <optgroup label="johnny (localhost:8080)">
                <option value="0">apple</option><option value="2">banana</option><option value="3">tomato</option></optgroup>
            </select>
            </br>
            <!--
             onchange="getcolumns();"
            -->
            <select name="accountId" >
                <option value="">&nbsp;</option>
                <optgroup label="johnny (localhost:8080)">
                <option value="0">apple_1</option><option value="3">banana_1</option><option value="2">tomato_1</option></optgroup>
            </select>
            </br>
            <input type="submit" value="submit" id="submit" onclick="getcolumns();">
            <br/>
            <br/><br/>
        </form>

        <%

        if (agencyId > -1L && accountId > -1L) {
        %>

            <div id="columns">
            </div>
         <%
         }
         %>
<div id="result"></div>
    </body>
</html>