<%--
    Created on : 09-March-2016
    Author     : Macar Calancea (mcalancea@acquisio.com)
--%>

<%@page import="org.apache.commons.lang.math.NumberUtils"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.commons.lang.BooleanUtils"%>
<%@page import="webapp.objects.SomeClass"%>
<%@page import="java.io.IOException"%>
<%@page import="java.time.LocalDateTime"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" language="javascript" src="http://code.jquery.com/jquery-2.2.1.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript">
            var getColumns = function(){
                $.post("List", $("#Manager").serialize());
            }


            function confirmAction(message){
                return confirm("Are you sure you wish to delete Column: " + message + "?");
            }
        </script>
        <title>Manager</title>


    </head>
    <body>
        <%!
            private SomeClass executeAction(String execAction, JspWriter out, HttpServletRequest request,
                        String bean, long id, long agencyId,
                        long accountId) throws IOException {
                    SomeClass result = null;
                    try {
                        boolean succeed = false;
                        if (StringUtils.equals("save", execAction)) {
                            //result = bean.getColumn(id, agencyId);
                            ////remove this-start
                            result = new SomeClass();
                            ////remove this-end
                            if (result == null) {
            //                    // column doesn't exist, warn the user.
                                out.println(String.format("<div class='critMsgWhite'>Unable to load the column with ID [%d], Agency ID [%d],"+
                                        " Account ID [%d]</div><br/><br/>", id, agencyId, accountId));
                            } else {
                                result.setFormulaName(StringUtils.defaultString(request.getParameter("formulaName"), ""));
                                result.setFormula(StringUtils.defaultString(request.getParameter("formula"), ""));
                                result.setActive(BooleanUtils.toBoolean(request.getParameter("isActive")));
                                //bean.updatecolumn(result);
                                succeed = true;
                            }
                        } else if (StringUtils.equals("delete", execAction)) {
                            //bean.deleteColumn(agencyId, columnId);
                            succeed = true;
                        } else if (StringUtils.equals("create", execAction)) {
                            result = new SomeClass();
            //                result.setAgencyId(agencyId);
            //                result.setAccountId(accountId);
                            result.setFormulaName(StringUtils.defaultString(request.getParameter("formulaName"), ""));
                            result.setFormula(StringUtils.defaultString(request.getParameter("formula"), ""));
                            result.setActive(BooleanUtils.toBoolean(request.getParameter("isActive")));
                            //bean.createColumns(result);
                            succeed = true;
                        } else {
                            // Reload submitted parameters
                            out.println(String.format("<div class='critMsgWhite'>No action has been selected</div><br/><br/>"));
                            result = new SomeClass();
            //                result.setAgencyId(agencyId);
            //                result.setAccountId(accountId);
                            result.setFormulaName(StringUtils.defaultString(request.getParameter("formulaName"), ""));
                            result.setFormula(StringUtils.defaultString(request.getParameter("formula"), ""));
                            result.setActive(BooleanUtils.toBoolean(request.getParameter("isActive")));
                        }
                        if (succeed) {
                            out.println(String.format("<div class='normMsgWhite'>Action '%s' completed with success at '%s'</div><br/><br/>", execAction,
                                    LocalDateTime.now()));
                        }
                    } catch (Exception e) {
                        out.println(String.format("<div class='critMsgWhite'>Unable to '%s' the column, caused by %s</div><br/><br/>", execAction,
                                e.getMessage()));
                    }
                    return result;
                }
        %>
        <%
            Long id = NumberUtils.toLong(request.getParameter("id"));
            Long agencyId = NumberUtils.toLong(request.getParameter("agencyId"));
            Long accountId = NumberUtils.toLong(request.getParameter("accountId"));
            String execAction = StringUtils.defaultString(request.getParameter("execAction"), "");

            /////////////////////////

            SomeClass someClass = null;

            if (StringUtils.isNotBlank(execAction)) {
                //after execution
                someClass = executeAction(execAction, out, request, "bean", id, agencyId, accountId);
            } else {
                //load page:
                //-edit/delete: id > 0L && agencyId > 0L && accountId > 0L
                //-create: agencyId > 0L && accountId > 0L; id is null
                if(id > 0L && agencyId > 0L && accountId > 0L) {
                    //someClass = bean.getColumn(id, agencyId);
                }
            }

            // If the column is null, assume the user wants to create a new one.
            if (someClass == null) {
                someClass = new SomeClass();
                //someClass.setAgencyId(agencyId);
                //someClass.setAccountId(accountId);
                someClass.setFormulaName("-- New Formula -- ");
                //action = "add";
            }

            // Define form values
            String formulaName = someClass.getFormulaName() == null ? null : someClass.getFormulaName();
            String formula = someClass.getFormula() == null ? null : someClass.getFormula();
            Boolean isActive = someClass.isActive() == null ? true : someClass.isActive();
            
            /*
            String formulaName = "sum";
            String formula = "a+b";
            boolean isActive = false;
            */
        %>
        <%=execAction%>
        <a class="mimicButton" href="List.jsp?agencyId=<%=agencyId%>&accountId=<%=accountId%>">Back to list</a><br/><br/><br/>
        <form action="Manager.jsp" name="Manager" id="Manager" method="post">
            <input type="hidden" name="id" value="<%=id%>"/>
            <input type="hidden" name="agencyId" value="<%=agencyId%>"/>
            <input type="hidden" name="accountId" value="<%=accountId%>"/>
            <table class="tbl" border=1>
                <tr>
                    <td>id:</td>
                    <td><%=id%></td>
                </tr>
                <tr>
                    <td>Agency Id:</td>
                    <td><%=agencyId%></td>
                </tr>
                <tr>
                    <td>Account Id:</td>
                    <td><%=accountId%></td>
                </tr>
                <tr>
                    <td>Formula Name:</td>
                    <td>
                        <input type="text" name="formulaName" value="<%=formulaName%>"/>
                    </td>
                </tr>
                <tr>
                    <td>Formula:</td>
                    <td>
                        <input type="text" name="formula" value="<%=formula%>"/>
                    </td>
                </tr>
                <tr>
                    <td>Is Active:</td>
                    <td>
                        <input type="checkbox" name="isActive"
                            <%= (isActive ? "checked" : "")%>
                        />
                    </td>
                </tr>
            </table>

            <%
            if(id > 0L) {
            %>
                <input type="submit" name="execAction" value="save"/>
                <input type="submit" name="execAction" value="delete"
                    onclick='return confirmAction("<%=String.format("ID: %d with Agency ID: %d and Account ID: %d",id, agencyId, accountId)%>")'/>
            <%
            } else {
            %>
                <input type="submit" name="execAction" value="create"/>
            <%
            }
            %>
        </form>
    </body>
</html>