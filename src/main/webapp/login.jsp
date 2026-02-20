<%--
  Created by IntelliJ IDEA.
  User: alvaro
  Date: 17/2/26
  Time: 0:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // If already logged in, redirect to dashboard
    if (session != null && session.getAttribute("userId") != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }

    String errorMessage = (String) request.getAttribute("errorMessage");
    String username = (String) request.getAttribute("username");
    String logoutParam = request.getParameter("logout");
    boolean loggedOut = "true".equals(logoutParam);
%>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Iniciar Sesión - LearnSpace"/>
</jsp:include>

<jsp:include page="/WEB-INF/includes/navbar.jsp"/>

<main class="container my-5 flex-grow-1">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
            <div class="card shadow">

                <div class="card-header bg-primary text-white text-center py-3">
                    <h4 class="mb-0 fw-bold">📚 LearnSpace</h4>
                    <small>Iniciá sesión para continuar</small>
                </div>

                <div class="card-body p-4">

                    <%-- Logout success message --%>
                    <% if (loggedOut) { %>
                    <div class="alert alert-info alert-dismissible fade show" role="alert">
                        Has cerrado sesión correctamente.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                    <%-- Registration success message --%>
                    <%
                        String registeredParam = request.getParameter("registered");
                        boolean registered = "true".equals(registeredParam);
                    %>
                    <% if (registered) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ¡Cuenta creada exitosamente! Ahora podés iniciar sesión.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                    <%-- Error message --%>
                    <% if (errorMessage != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <%= errorMessage %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                    <%-- Login form --%>
                    <form action="${pageContext.request.contextPath}/login" method="post">

                        <div class="mb-3">
                            <label for="username" class="form-label fw-semibold">
                                Usuario
                            </label>
                            <input type="text"
                                   class="form-control"
                                   id="username"
                                   name="username"
                                   placeholder="Ingresá tu usuario"
                                   value="<%= username != null ? username : "" %>"
                                   required
                                   autofocus>
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label fw-semibold">
                                Contraseña
                            </label>
                            <input type="password"
                                   class="form-control"
                                   id="password"
                                   name="password"
                                   placeholder="Ingresá tu contraseña"
                                   required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">
                                Iniciar Sesión
                            </button>
                        </div>

                    </form>

                </div>

                <div class="card-footer text-center text-muted py-3">
                    <small>UNRC &bull; CITIC &bull; EVELiA Stack</small>
                </div>

            </div>

            <%-- Register link --%>
            <div class="mt-3 text-center">
                <small class="text-muted">
                    ¿No tenés cuenta?
                    <a href="${pageContext.request.contextPath}/register.jsp" class="text-decoration-none">
                        Registrate acá
                    </a>
                </small>
            </div>

            <%-- Test users hint --%>
            <div class="mt-3 text-center">
                <small class="text-muted">
                    <strong>Usuarios de prueba:</strong><br>
                    admin/admin123 | jperez/prof123 | clopez/est123
                </small>
            </div>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
