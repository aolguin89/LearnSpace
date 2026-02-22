<%--
  Created by IntelliJ IDEA.
  User: alvaro
  Date: 21/2/26
  Time: 21:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="ar.edu.unrc.citic.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    @SuppressWarnings("unchecked")
    List<String> errors = (List<String>) request.getAttribute("errors");
    String successMessage = (String) request.getAttribute("successMessage");
%>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Mi Perfil - LearnSpace"/>
</jsp:include>

<jsp:include page="/WEB-INF/includes/navbar.jsp"/>

<main class="container my-5 flex-grow-1">
    <div class="row justify-content-center">
        <div class="col-md-10 col-lg-8">

            <div class="card shadow">
                <div class="card-header bg-primary text-white py-3">
                    <h4 class="mb-0">👤 Mi Perfil</h4>
                </div>

                <div class="card-body p-4">

                    <%-- Success message --%>
                    <% if (successMessage != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>✅ <%= successMessage %>
                        </strong>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

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

                    <%-- Profile form --%>
                    <form action="${pageContext.request.contextPath}/profile" method="post">

                        <h6 class="text-muted mb-3">Información de cuenta</h6>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="username" class="form-label fw-semibold">
                                    Usuario
                                </label>
                                <input type="text"
                                       class="form-control"
                                       id="username"
                                       value="<%= user.getUsername() %>"
                                       readonly
                                       disabled>
                                <small class="text-muted">El usuario no se puede modificar</small>
                            </div>
                            <div class="col-md-6">
                                <label for="role" class="form-label fw-semibold">
                                    Rol
                                </label>
                                <input type="text"
                                       class="form-control"
                                       id="role"
                                       value="<%= user.getRole().equals("admin") ? "Administrador" :
                                                  user.getRole().equals("professor") ? "Profesor" : "Estudiante" %>"
                                       readonly
                                       disabled>
                                <small class="text-muted">El rol es asignado por administradores</small>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label fw-semibold">
                                Email <span class="text-danger">*</span>
                            </label>
                            <input type="email"
                                   class="form-control"
                                   id="email"
                                   name="email"
                                   value="<%= user.getEmail() %>"
                                   required>
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
                                       value="<%= user.getFirstName() %>"
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
                                       value="<%= user.getLastName() %>"
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
                                       value="<%= user.getDni() != null ? user.getDni() : "" %>">
                            </div>
                            <div class="col-md-6">
                                <label for="birthDate" class="form-label fw-semibold">
                                    Fecha de Nacimiento
                                </label>
                                <input type="date"
                                       class="form-control"
                                       id="birthDate"
                                       name="birthDate"
                                       value="<%= user.getBirthDate() != null ? user.getBirthDate().toString() : "" %>">
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
                                       value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
                            </div>
                            <div class="col-md-6">
                                <label for="gender" class="form-label fw-semibold">
                                    Género
                                </label>
                                <select class="form-select" id="gender" name="gender">
                                    <option value="">Seleccionar...</option>
                                    <option value="M" <%= "M".equals(user.getGender()) ? "selected" : "" %>>Masculino
                                    </option>
                                    <option value="F" <%= "F".equals(user.getGender()) ? "selected" : "" %>>Femenino
                                    </option>
                                    <option value="other" <%= "other".equals(user.getGender()) ? "selected" : "" %>>
                                        Otro
                                    </option>
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
                                   value="<%= user.getAddress() != null ? user.getAddress() : "" %>">
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <button type="submit" class="btn btn-primary w-100">
                                    💾 Guardar Cambios
                                </button>
                            </div>
                            <div class="col-md-6">
                                <a href="${pageContext.request.contextPath}/dashboard"
                                   class="btn btn-secondary w-100">
                                    ↩️ Volver al Dashboard
                                </a>
                            </div>
                        </div>

                    </form>

                </div>

                <div class="card-footer text-muted text-center py-3">
                    <small>
                        Cuenta creada: <%= user.getCreatedAt() != null ?
                            new java.text.SimpleDateFormat("dd/MM/yyyy").format(user.getCreatedAt()) : "N/A" %>
                    </small>
                </div>
            </div>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
