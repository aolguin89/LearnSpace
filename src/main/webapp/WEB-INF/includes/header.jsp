<%--
  Created by IntelliJ IDEA.
  User: alvaro
  Date: 17/2/26
  Time: 0:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title != null ? param.title : 'LearnSpace'}</title>

    <%-- Bootstrap CSS via WebJars (self-contained, works offline) --%>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">

    <%-- Custom styles --%>
    <link href="${pageContext.request.contextPath}/css/custom.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">
