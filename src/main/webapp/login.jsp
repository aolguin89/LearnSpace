<%--
  Created by IntelliJ IDEA.
  User: alvaro
  Date: 17/2/26
  Time: 0:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

                    <%-- Error message (will be used when backend is implemented) --%>
                    <%
                        String errorMsg = (String) request.getAttribute("errorMessage");
                        if (errorMsg != null) {
                    %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <%= errorMsg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% } %>

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
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>
