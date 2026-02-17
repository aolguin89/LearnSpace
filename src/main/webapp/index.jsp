<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Inicio - LearnSpace"/>
</jsp:include>

<jsp:include page="/WEB-INF/includes/navbar.jsp"/>

<main class="container my-5 flex-grow-1">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow">
                <div class="card-body text-center p-5">

                    <h1 class="display-5 fw-bold text-primary mb-3">
                        📚 LearnSpace
                    </h1>
                    <p class="lead text-muted mb-4">
                        Plataforma de gestión de aprendizaje
                    </p>
                    <hr class="my-4">

                    <div class="row text-start mb-4">
                        <div class="col-6">
                            <small class="text-muted d-block">
                                <strong>Servidor:</strong> Apache Tomcat 9
                            </small>
                            <small class="text-muted d-block">
                                <strong>Java:</strong> 17 LTS
                            </small>
                        </div>
                        <div class="col-6">
                            <small class="text-muted d-block">
                                <strong>Fecha:</strong> <%= new java.util.Date() %>
                            </small>
                            <small class="text-muted d-block">
                                <strong>Session:</strong> <%= request.getSession().getId().substring(0, 8) %>...
                            </small>
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/login.jsp"
                       class="btn btn-primary btn-lg w-100">
                        Iniciar Sesión
                    </a>

                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>