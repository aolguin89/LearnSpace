<%--
  Created by IntelliJ IDEA.
  User: alvaro
  Date: 19/2/26
  Time: 12:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
    String role = (String) session.getAttribute("role");
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
%>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Dashboard - LearnSpace"/>
</jsp:include>

<jsp:include page="/WEB-INF/includes/navbar.jsp"/>

<main class="container my-5 flex-grow-1">
    <div class="row justify-content-center">
        <div class="col-md-10">

            <%-- Welcome Alert --%>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <h4 class="alert-heading">✅ ¡Bienvenido, <%= firstName %>!</h4>
                <p class="mb-0">Has iniciado sesión correctamente.</p>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>

            <%-- User Info Card --%>
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">📊 Información de Sesión</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Nombre completo:</strong> <%= firstName %> <%= lastName %></p>
                            <p><strong>Usuario:</strong> <%= username %></p>
                            <p><strong>Email:</strong> <%= email %></p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Rol:</strong>
                                <span class="badge bg-<%= role.equals("admin") ? "danger" :
                                                          role.equals("professor") ? "info" : "success" %>">
                                    <%= role.equals("admin") ? "Administrador" :
                                            role.equals("professor") ? "Profesor" : "Estudiante" %>
                                </span>
                            </p>
                            <p><strong>ID de sesión:</strong> <code><%= session.getId().substring(0, 12) %>...</code></p>
                            <p><strong>Tiempo de inactividad:</strong> <%= session.getMaxInactiveInterval() / 60 %> minutos</p>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Role-specific content --%>
            <% if ("admin".equals(role)) { %>
            <div class="card shadow-sm">
                <div class="card-header bg-danger text-white">
                    <h5 class="mb-0">🔧 Panel de Administrador</h5>
                </div>
                <div class="card-body">
                    <p>Funcionalidades de administración en desarrollo.</p>
                    <ul>
                        <li>Gestión de usuarios</li>
                        <li>Gestión de cursos</li>
                        <li>Reportes del sistema</li>
                    </ul>
                </div>
            </div>

            <% } else if ("professor".equals(role)) { %>
            <div class="card shadow-sm">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0">👨‍🏫 Panel de Profesor</h5>
                </div>
                <div class="card-body">
                    <p>Funcionalidades para profesores en desarrollo.</p>
                    <ul>
                        <li>Mis cursos</li>
                        <li>Gestión de exámenes</li>
                        <li>Lista de estudiantes</li>
                    </ul>
                </div>
            </div>

            <% } else { %>
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">🎓 Panel de Estudiante</h5>
                </div>
                <div class="card-body">
                    <p>Funcionalidades para estudiantes en desarrollo.</p>
                    <ul>
                        <li>Mis cursos</li>
                        <li>Exámenes disponibles</li>
                        <li>Calificaciones</li>
                    </ul>
                </div>
            </div>
            <% } %>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
