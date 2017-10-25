<%--
    Created on : 24-October-2017
    Author     : Macar Calancea (mcalancea@acquisio.com)
    url        : http://localhost:9090/jetty-jsp-example/view/QueueList.jsp
--%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="webapp.pojos.FirstQueue"%>
<%@page import="webapp.pojos.Buildings"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Queues</title>

    </head>
    <body>
    <%
        String action = StringUtils.defaultString(request.getParameter("action"), "");
        String success = StringUtils.defaultString(request.getParameter("s"), "");
        if (StringUtils.isNotBlank(action)) {
            System.out.println("jsp;" + action);
            if(Buildings.FIRST.equals(action)){
                FirstQueue first = new FirstQueue();
                first.action();
                //response.sendRedirect("QueueList.jsp?s=success");
                response.sendRedirect("QueueList.jsp");
            }
        }else{
            System.out.println("jsp; empty!!!");
        }

/*
        if (StringUtils.isNotBlank(success) && success.equals("success")) {
            response.sendRedirect("QueueList.jsp");
        }
        */
        //<c:redirect url="/home.html"/>
        //response.sendRedirect("/QueueList.jsp");
        //request.setParameter("action","");

    %>
        <h1>Queues</h1>
        <p>
        <form action="QueueList.jsp" name="QueueList" id="QueueList" method="post">
            <table>
              <tr>
                <th>Name</th>
                <th>Action</th>
              </tr>
              <tr>
                <td><%=Buildings.FIRST%></td>
                <td><button name="action" value="<%=Buildings.FIRST%>" type="submit">Force reinitialize</button></td>
              </tr>
            </table>
        </form>
    </body>
</html>