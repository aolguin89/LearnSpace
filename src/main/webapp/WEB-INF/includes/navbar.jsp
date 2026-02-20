<%--
  Created by IntelliJ IDEA.
  User: alvaro
  Date: 17/2/26
  Time: 0:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    boolean isAuthenticated = (session != null && session.getAttribute("userId") != null);
    String userFirstName = isAuthenticated ? (String) session.getAttribute("firstName") : null;
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">

        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">
            📚 LearnSpace
        </a>

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav"
                aria-controls="navbarNav"
                aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">
                        Inicio
                    </a>
                </li>

                <% if (isAuthenticated) { %>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                        Dashboard
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        👤 <%= userFirstName %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                Cerrar Sesión
                            </a>
                        </li>
                    </ul>
                </li>
                <% } else { %>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">
                        Iniciar Sesión
                    </a>
                </li>
                <% } %>
            </ul>
        </div>

    </div>
</nav>
