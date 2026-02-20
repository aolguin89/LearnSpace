<%--
  Created by IntelliJ IDEA.
  User: alvaro
  Date: 20/2/26
  Time: 0:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%
    // If already logged in, redirect to dashboard
    if (session != null && session.getAttribute("userId") != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }

    @SuppressWarnings("unchecked")
    List<String> errors = (List<String>) request.getAttribute("errors");

    // Retain form values
    String username = (String) request.getAttribute("username");
    String email = (String) request.getAttribute("email");
    String firstName = (String) request.getAttribute("firstName");
    String lastName = (String) request.getAttribute("lastName");
    String dni = (String) request.getAttribute("dni");
    String address = (String) request.getAttribute("address");
    String phone = (String) request.getAttribute("phone");
    String birthDate = (String) request.getAttribute("birthDate");
    String gender = (String) request.getAttribute("gender");
%>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Registro - LearnSpace"/>
</jsp:include>

<jsp:include page="/WEB-INF/includes/navbar.jsp"/>

<main class="container my-5 flex-grow-1">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">

            <div class="card shadow">
                <div class="card-header bg-primary text-white text-center py-3">
                    <h4 class="mb-0 fw-bold">📚 Registro en LearnSpace</h4>
                    <small>Creá tu cuenta para comenzar</small>
                </div>

                <div class="card-body p-4">

                    <%-- Error messages --%>
                    <% if (errors != null && !errors.isEmpty()) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>Por favor, corregí los siguientes errores:</strong>
                        <ul class="mb-0 mt-2">
                            <% for (String error : errors) { %>
                            <li><%= error %>
                            </li>
                            <% } %>
                        </ul>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

                    <%-- Registration form --%>
                    <form action="${pageContext.request.contextPath}/register" method="post">

                        <h6 class="text-muted mb-3">Información de cuenta</h6>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="username" class="form-label fw-semibold">
                                    Usuario <span class="text-danger">*</span>
                                </label>
                                <input type="text"
                                       class="form-control"
                                       id="username"
                                       name="username"
                                       value="<%= username != null ? username : "" %>"
                                       required>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label fw-semibold">
                                    Email <span class="text-danger">*</span>
                                </label>
                                <input type="email"
                                       class="form-control"
                                       id="email"
                                       name="email"
                                       value="<%= email != null ? email : "" %>"
                                       required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="password" class="form-label fw-semibold">
                                    Contraseña <span class="text-danger">*</span>
                                </label>
                                <input type="password"
                                       class="form-control"
                                       id="password"
                                       name="password"
                                       minlength="6"
                                       required>
                                <small class="text-muted">Mínimo 6 caracteres</small>
                            </div>
                            <div class="col-md-6">
                                <label for="confirmPassword" class="form-label fw-semibold">
                                    Confirmar Contraseña <span class="text-danger">*</span>
                                </label>
                                <input type="password"
                                       class="form-control"
                                       id="confirmPassword"
                                       name="confirmPassword"
                                       minlength="6"
                                       required>
                            </div>
                        </div>

                        <hr class="my-4">

                        <h6 class="text-muted mb-3">Información personal</h6>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="firstName" class="form-label fw-semibold">
                                    Nombre <span class="text-danger">*</span>
                                </label>
                                <input type="text"
                                       class="form-control"
                                       id="firstName"
                                       name="firstName"
                                       value="<%= firstName != null ? firstName : "" %>"
                                       required>
                            </div>
                            <div class="col-md-6">
                                <label for="lastName" class="form-label fw-semibold">
                                    Apellido <span class="text-danger">*</span>
                                </label>
                                <input type="text"
                                       class="form-control"
                                       id="lastName"
                                       name="lastName"
                                       value="<%= lastName != null ? lastName : "" %>"
                                       required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="dni" class="form-label fw-semibold">
                                    DNI
                                </label>
                                <input type="text"
                                       class="form-control"
                                       id="dni"
                                       name="dni"
                                       value="<%= dni != null ? dni : "" %>">
                            </div>
                            <div class="col-md-6">
                                <label for="birthDate" class="form-label fw-semibold">
                                    Fecha de Nacimiento
                                </label>
                                <input type="date"
                                       class="form-control"
                                       id="birthDate"
                                       name="birthDate"
                                       value="<%= birthDate != null ? birthDate : "" %>">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="phone" class="form-label fw-semibold">
                                    Teléfono
                                </label>
                                <input type="tel"
                                       class="form-control"
                                       id="phone"
                                       name="phone"
                                       value="<%= phone != null ? phone : "" %>">
                            </div>
                            <div class="col-md-6">
                                <label for="gender" class="form-label fw-semibold">
                                    Género
                                </label>
                                <select class="form-select" id="gender" name="gender">
                                    <option value="">Seleccionar...</option>
                                    <option value="M" <%= "M".equals(gender) ? "selected" : "" %>>Masculino</option>
                                    <option value="F" <%= "F".equals(gender) ? "selected" : "" %>>Femenino</option>
                                    <option value="other" <%= "other".equals(gender) ? "selected" : "" %>>Otro</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="address" class="form-label fw-semibold">
                                Dirección
                            </label>
                            <input type="text"
                                   class="form-control"
                                   id="address"
                                   name="address"
                                   value="<%= address != null ? address : "" %>">
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">
                                Crear Cuenta
                            </button>
                        </div>

                    </form>

                </div>

                <div class="card-footer text-center py-3">
                    <small class="text-muted">
                        ¿Ya tenés cuenta?
                        <a href="${pageContext.request.contextPath}/login.jsp">Iniciar sesión</a>
                    </small>
                </div>
            </div>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>