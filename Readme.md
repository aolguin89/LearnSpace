# 📚 LearnSpace

> Sistema de gestión de aprendizaje desarrollado con Java EE, JSP y MySQL

[![Java](https://img.shields.io/badge/Java-17-orange?logo=java)](https://www.oracle.com/java/)
[![Apache Tomcat](https://img.shields.io/badge/Tomcat-9.0-yellow?logo=apache-tomcat)](https://tomcat.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.x-blue?logo=mysql)](https://www.mysql.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3.3-purple?logo=bootstrap)](https://getbootstrap.com/)

---

## 🎯 Descripción

**LearnSpace** es una plataforma de gestión de aprendizaje (LMS) desarrollada como proyecto de portfolio para la postulación al equipo de desarrollo del Sistema de Aulas Virtuales [EVELiA](https://www.evelia.unrc.edu.ar/) de la Universidad Nacional de Río Cuarto (UNRC).

El proyecto replica el stack tecnológico utilizado en EVELiA, demostrando competencias en desarrollo backend con Java, gestión de bases de datos relacionales, arquitectura MVC y desarrollo de interfaces web responsivas.

---

## ✨ Características

### Implementadas
- ✅ **Gestión de usuarios** con roles diferenciados (admin, profesor, estudiante)
- ✅ **Autenticación segura** con contraseñas hasheadas (SHA-256)
- ✅ **Capa de acceso a datos (DAO)** con operaciones CRUD para usuarios
- ✅ **Interfaz responsive** con Bootstrap 5
- ✅ **Base de datos relacional** con MySQL 8
- ✅ **Arquitectura MVC** bien estructurada

### En desarrollo
- 🔄 **Sistema de login/logout** con manejo de sesiones HTTP
- 🔄 **Dashboard** por rol de usuario
- 🔄 **Interfaz de gestión de usuarios** (registro, edición, eliminación)
- 🔄 **Gestión de cursos** y inscripciones
- 🔄 **Sistema de exámenes** con intentos múltiples
---

## 🛠️ Stack Tecnológico

| Categoría | Tecnología | Versión |
|-----------|-----------|---------|
| **Lenguaje** | Java | 17 LTS |
| **Servidor de aplicaciones** | Apache Tomcat | 9.0.115 |
| **Base de datos** | MySQL | 8.x |
| **Frontend** | JSP + HTML5 + CSS3 + JavaScript | - |
| **Framework CSS** | Bootstrap (via WebJars) | 5.3.3 |
| **Build tool** | Maven | 3.x |
| **Control de versiones** | Git + GitHub | - |

---

## 📂 Estructura del Proyecto
```
LearnSpace/
├── src/main/
│   ├── java/ar/edu/unrc/citic/
│   │   ├── controller/      # Servlets (MVC Controllers)
│   │   ├── model/           # Entidades (POJOs)
│   │   │   └── User.java
│   │   ├── dao/             # Data Access Objects
│   │   │   ├── UserDAO.java
│   │   │   └── UserDAOImpl.java
│   │   ├── service/         # Lógica de negocio
│   │   └── util/            # Utilidades
│   │       └── DatabaseConnection.java
│   │
│   ├── resources/
│   │   ├── db/
│   │   │   ├── schema.sql   # Estructura de la BD
│   │   │   ├── data.sql     # Datos de prueba
│   │   │   └── README.md    # Instrucciones de setup
│   │   ├── db.properties.example
│   │   └── db.properties    # (gitignored)
│   │
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── includes/    # Fragmentos JSP reutilizables
│       │   │   ├── header.jsp
│       │   │   ├── footer.jsp
│       │   │   └── navbar.jsp
│       │   ├── views/       # Páginas protegidas
│       │   └── web.xml
│       ├── css/
│       │   └── custom.css
│       ├── js/
│       │   └── app.js
│       ├── index.jsp        # Landing page
│       └── login.jsp        # Página de login
│
├── pom.xml                  # Dependencias Maven
└── README.md
```

---

## 🚀 Instalación y Configuración

### Prerequisitos

- **Java JDK 17** o superior
- **Apache Tomcat 9.x**
- **MySQL 8.x**
- **Maven 3.x**
- **Git**

### 1. Clonar el repositorio
```bash
git clone https://github.com/aolguin89/LearnSpace.git
cd LearnSpace
```

### 2. Configurar la base de datos

#### Crear la base de datos y tablas
```bash
mysql -u root -p < src/main/resources/db/schema.sql
```

#### Cargar datos de prueba
```bash
mysql -u root -p learnspace_db < src/main/resources/db/data.sql
```

### 3. Configurar credenciales de base de datos
```bash
# Copiar el archivo de ejemplo
cp src/main/resources/db.properties.example src/main/resources/db.properties

# Editar con tus credenciales
nano src/main/resources/db.properties
```

**Contenido de `db.properties`:**
```properties
db.url=jdbc:mysql://localhost:3306/learnspace_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
db.user=root
db.password=tu_password_aqui
db.driver=com.mysql.cj.jdbc.Driver
```

### 4. Compilar el proyecto
```bash
mvn clean install
```

### 5. Desplegar en Tomcat

#### Opción A: Desde IntelliJ IDEA
1. Configurar Tomcat 9 en Run/Debug Configurations
2. Context path: `/learnspace`
3. Run

#### Opción B: Manual
1. Copiar el archivo WAR generado a `TOMCAT_HOME/webapps/`
2. Iniciar Tomcat
3. Acceder a `http://localhost:8080/learnspace/`

---

## 👤 Usuarios de Prueba

Una vez desplegado, podés usar estas credenciales para testing:

| Usuario | Contraseña | Rol |
|---------|------------|-----|
| admin | admin123 | Administrador |
| jperez | prof123 | Profesor |
| mgarcia | prof123 | Profesor |
| clopez | est123 | Estudiante |
| lmartinez | est123 | Estudiante |
| psanchez | est123 | Estudiante |

---

## 🗄️ Modelo de Base de Datos

### Diagrama de relaciones
```
users ──────────────────────────────────────────┐
  │                                              │
  │ professor_id                                 │ user_id
  ▼                                              ▼
courses ──── course_id ────► enrollments    exam_attempts
  │                                         ▲
  │ course_id                               │
  ▼                                         │ user_id + exam_id
exams ───────────────────────────────────────
```

### Tablas principales

- **users:** Usuarios del sistema (admin, profesores, estudiantes)
- **courses:** Cursos/aulas virtuales
- **enrollments:** Inscripciones de estudiantes a cursos
- **exams:** Exámenes asociados a cursos
- **exam_attempts:** Intentos de examen de los estudiantes

---

## 🏗️ Arquitectura

### Patrón MVC (Model-View-Controller)
```
┌─────────────┐
│    View     │  JSP + Bootstrap
│   (JSP)     │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ Controller  │  Servlets
│ (Servlets)  │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   Model     │  POJOs + DAO + Service
│ (Java)      │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Database   │  MySQL
│   (MySQL)   │
└─────────────┘
```

### Capas de la aplicación

- **Presentation (View):** JSP con Bootstrap 5
- **Control (Controller):** Servlets para manejar requests HTTP
- **Business Logic (Service):** Lógica de negocio
- **Data Access (DAO):** Acceso a base de datos con JDBC
- **Model (Entity):** POJOs representando entidades del dominio

---

## 🔐 Seguridad

- **Contraseñas hasheadas** con SHA-256 (TODO: migrar a bcrypt en producción)
- **PreparedStatements** para prevenir SQL Injection
- **Archivos de configuración sensibles** excluidos del repositorio (.gitignored)
- **Sesiones HTTP** para autenticación y autorización
- **Páginas protegidas** en `/WEB-INF/views/` (no accesibles directamente)

---

## 📝 Decisiones Técnicas

### ¿Por qué WebJars y no CDN para Bootstrap?

**Deployment auto-contenido:** El archivo WAR incluye todas las dependencias, permitiendo que la aplicación funcione completamente offline. Esto es crítico para:
- Demos en vivo sin conexión a internet
- Deployments enterprise sin dependencias externas
- Alineación con prácticas de EVELiA

### ¿Por qué Singleton para DatabaseConnection?

Para una aplicación de este tamaño, un Singleton con una sola conexión es apropiado. En producción con mayor carga, se migraría a un Connection Pool (HikariCP, C3P0).

### ¿Por qué separar DAO interface de implementation?

**Dependency Inversion Principle (SOLID):** El código depende de abstracciones, no de implementaciones concretas. Esto permite:
- Cambiar la implementación sin afectar código dependiente
- Testing más fácil (mock de interfaces)
- Migración futura a JPA/Hibernate sin refactoring masivo

---

## 🧪 Testing

### TODO: Tests automatizados

- [ ] JUnit 5 para capa DAO
- [ ] Tests de integración
- [ ] Tests de Servlets

> Los tests manuales se ejecutaron durante el desarrollo para verificar funcionalidad.
> La implementación de tests automatizados con JUnit está planificada para futuras iteraciones.

---

## 📋 Roadmap

### Fase 1: Fundamentos ✅
- [x] Setup del proyecto (Maven, Tomcat, MySQL)
- [x] Estructura MVC completa
- [x] Bootstrap + layout reutilizable
- [x] Schema de base de datos
- [x] Connection manager (Singleton)
- [x] User model + DAO (CRUD completo)

### Fase 2: Autenticación 🔄
- [ ] LoginServlet + manejo de sesiones
- [ ] LogoutServlet
- [ ] Dashboard por rol
- [ ] Protección de rutas

### Fase 3: Funcionalidades core 📋
- [ ] CRUD de cursos
- [ ] Sistema de inscripciones
- [ ] Vista de cursos por estudiante
- [ ] Vista de estudiantes por profesor

### Fase 4: Sistema de exámenes 📝
- [ ] CRUD de exámenes
- [ ] Interfaz de resolución de exámenes
- [ ] Calificación y feedback
- [ ] Historial de intentos

### Fase 5: Mejoras 🚀
- [ ] Tests automatizados (JUnit)
- [ ] Makefile para tareas comunes
- [ ] Logs con Log4j
- [ ] Documentación Javadoc completa

---

## 👨‍💻 Autor

**Alvaro Olguin Armendariz**

- 📧 Email: alvaroarmendariz11@gmail.com
- 💼 LinkedIn: [linkedin.com/in/alvaro-olguin-armendariz-8a6765104](https://www.linkedin.com/in/alvaro-olguin-armendariz-8a6765104/)
- 🐙 GitHub: [@aolguin89](https://github.com/aolguin89)

---

## 📄 Licencia

Este proyecto fue desarrollado como portfolio académico para la postulación al equipo de desarrollo de EVELiA (UNRC - CITIC).

---

## 🙏 Agradecimientos

- **UNRC - CITIC:** Por la oportunidad de postularme al equipo de desarrollo de EVELiA
- **Sistema EVELiA:** Por ser la inspiración y referencia técnica de este proyecto

---

<p align="center">
  Desarrollado con ☕ y 💻 por Alvaro Olguin Armendariz
</p>