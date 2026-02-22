# 📚 LearnSpace

> Sistema de gestión de aprendizaje desarrollado con Java EE, JSP y MySQL

[![Java](https://img.shields.io/badge/Java-17-orange?logo=java)](https://www.oracle.com/java/)
[![Apache Tomcat](https://img.shields.io/badge/Tomcat-9.0-yellow?logo=apache-tomcat)](https://tomcat.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.x-blue?logo=mysql)](https://www.mysql.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3.3-purple?logo=bootstrap)](https://getbootstrap.com/)

---

## 🎯 Descripción

**LearnSpace** es una plataforma de gestión de aprendizaje (LMS) desarrollada como proyecto de portfolio para la
postulación al equipo de desarrollo del Sistema de Aulas Virtuales [EVELiA](https://www.evelia.unrc.edu.ar/) de la
Universidad Nacional de Río Cuarto (UNRC).

El proyecto se encuentra alineado con el stack tecnológico utilizado en EVELiA, funcionando como un entorno práctico de consolidación y exploración técnica en Java, 
arquitectura MVC, persistencia relacional y desarrollo de interfaces web responsivas.

---

## ✨ Características

### Implementadas

- ✅ **Sistema de autenticación completo** con login/logout y manejo de sesiones
- ✅ **Gestión de usuarios CRUD completa:**
    - Registro de nuevos usuarios (CREATE)
    - Visualización de perfil (READ)
    - Edición de información personal (UPDATE)
    - Desactivación de cuenta con soft delete (DELETE)
- ✅ **Roles diferenciados** (admin, profesor, estudiante)
- ✅ **Dashboard personalizado** según rol de usuario
- ✅ **Contraseñas hasheadas** (SHA-256)
- ✅ **Validación de formularios** (cliente y servidor)
- ✅ **Manejo de caracteres especiales** (UTF-8) con filtro application-wide
- ✅ **Interfaz responsive** con Bootstrap 5 (WebJars)
- ✅ **Base de datos relacional** con MySQL 8
- ✅ **Arquitectura MVC** con separación de capas

### En desarrollo

- 🔄 **Cambio de contraseña** para usuarios autenticados
- 🔄 **Gestión de cursos** (CRUD de cursos)
- 🔄 **Sistema de inscripciones** a cursos
- 🔄 **Sistema de exámenes** con intentos múltiples
- 🔄 **Panel de administración** para gestión de usuarios

---

## 🛠️ Stack Tecnológico

| Categoría                    | Tecnología                      | Versión |
|------------------------------|---------------------------------|---------|
| **Lenguaje**                 | Java                            | 17 LTS  |
| **Servidor de aplicaciones** | Apache Tomcat                   | 9.0.115 |
| **Base de datos**            | MySQL                           | 8.x     |
| **Frontend**                 | JSP + HTML5 + CSS3 + JavaScript | -       |
| **Framework CSS**            | Bootstrap (via WebJars)         | 5.3.3   |
| **Build tool**               | Maven                           | 3.x     |
| **Control de versiones**     | Git + GitHub                    | -       |

---

## 📂 Estructura del Proyecto

```
LearnSpace/
├── src/main/
│   ├── java/ar/edu/unrc/citic/
│   │   ├── controller/              # Servlets (MVC Controllers)
│   │   │   ├── LoginServlet.java
│   │   │   ├── LogoutServlet.java
│   │   │   ├── DashboardServlet.java
│   │   │   ├── RegisterServlet.java
│   │   │   ├── ProfileServlet.java
│   │   │   └── DeactivateAccountServlet.java
│   │   ├── model/                   # Entidades (POJOs)
│   │   │   └── User.java
│   │   ├── dao/                     # Data Access Objects
│   │   │   ├── UserDAO.java
│   │   │   └── UserDAOImpl.java
│   │   ├── service/                 # Lógica de negocio (futuro)
│   │   └── util/                    # Utilidades
│   │       ├── DatabaseConnection.java
│   │       └── CharacterEncodingFilter.java
│   │
│   ├── resources/
│   │   ├── db/
│   │   │   ├── schema.sql           # Estructura de la BD
│   │   │   ├── data.sql             # Datos de prueba
│   │   │   └── README.md            # Instrucciones de setup
│   │   ├── db.properties.example
│   │   └── db.properties            # (gitignored)
│   │
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── includes/            # Fragmentos JSP reutilizables
│       │   │   ├── header.jsp
│       │   │   ├── footer.jsp
│       │   │   └── navbar.jsp
│       │   ├── views/               # Páginas protegidas
│       │   │   ├── dashboard.jsp
│       │   │   └── profile.jsp
│       │   └── web.xml
│       ├── css/
│       │   └── custom.css
│       ├── js/
│       │   └── app.js
│       ├── index.jsp                # Landing page
│       ├── login.jsp                # Página de login
│       └── register.jsp             # Página de registro
│
├── pom.xml                          # Dependencias Maven
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

| Usuario   | Contraseña | Rol           |
|-----------|------------|---------------|
| admin     | admin123   | Administrador |
| jperez    | prof123    | Profesor      |
| mgarcia   | prof123    | Profesor      |
| clopez    | est123     | Estudiante    |
| lmartinez | est123     | Estudiante    |
| psanchez  | est123     | Estudiante    |

---

## 🔑 Funcionalidades Implementadas

### Autenticación y Sesiones

- **Login:** Validación de credenciales con UserDAO.authenticate()
- **Logout:** Invalidación de sesión HTTP
- **Sesiones:** Timeout de 30 minutos, almacenamiento de datos de usuario
- **Protección de rutas:** Páginas en `/WEB-INF/views/` solo accesibles vía servlets autenticados

### CRUD de Usuarios

| Operación  | Endpoint              | Descripción                                                 |
|------------|-----------------------|-------------------------------------------------------------|
| **CREATE** | `/register`           | Registro de nuevos usuarios (rol student por defecto)       |
| **READ**   | `/profile` (GET)      | Visualización de información personal                       |
| **UPDATE** | `/profile` (POST)     | Edición de datos personales (email, nombre, teléfono, etc.) |
| **DELETE** | `/deactivate-account` | Soft delete (is_active = false)                             |

### Validaciones

- **Registro:** Username único, email único, contraseñas coincidentes, formato de email
- **Perfil:** Email único (si se modifica), campos requeridos
- **Login:** Credenciales válidas, usuario activo

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
    - Soft delete via `is_active` boolean
    - Roles: admin, professor, student
    - Campos: username, email, password (SHA-256), first_name, last_name, dni, address, phone, birth_date, gender
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
│   Model     │  POJOs + DAO
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

- **Presentation (View):** JSP con Bootstrap 5, includes reutilizables (header, footer, navbar)
- **Control (Controller):** Servlets para manejar requests HTTP (Login, Register, Profile, etc.)
- **Business Logic (Service):** Lógica de negocio (futuro, actualmente en controladores)
- **Data Access (DAO):** Acceso a base de datos con JDBC, patrón DAO con interfaces
- **Model (Entity):** POJOs representando entidades del dominio (User)

---

## 🔐 Seguridad

- **Contraseñas hasheadas** con SHA-256 via SQL (`SHA2(password, 256)`)
  > ⚠️ TODO: Migrar a bcrypt para producción
- **PreparedStatements** en todos los DAOs para prevenir SQL Injection
- **Archivos de configuración sensibles** excluidos del repositorio (`.gitignored`)
- **Sesiones HTTP** para autenticación y autorización
- **Páginas protegidas** en `/WEB-INF/views/` (no accesibles directamente desde el navegador)
- **Soft delete** en lugar de hard delete (preserva integridad referencial)
- **UTF-8 encoding** application-wide via `CharacterEncodingFilter`
- **Validación de usuario activo** en `UserDAO.authenticate()` (usuarios desactivados no pueden loguearse)

---

## 📝 Decisiones Técnicas

### ¿Por qué WebJars y no CDN para Bootstrap?

**Deployment auto-contenido:** El archivo WAR incluye todas las dependencias, permitiendo que la aplicación funcione
completamente offline. Esto es crítico para:

- Demos en vivo sin conexión a internet
- Deployments enterprise sin dependencias externas
- Alineación con prácticas de EVELiA

### ¿Por qué Singleton para DatabaseConnection?

Para una aplicación de este tamaño, un Singleton con una sola conexión es apropiado. En producción con mayor carga, se
migraría a un Connection Pool (HikariCP, C3P0).

### ¿Por qué separar DAO interface de implementation?

**Dependency Inversion Principle (SOLID):** El código depende de abstracciones, no de implementaciones concretas. Esto
permite:

- Cambiar la implementación sin afectar código dependiente
- Testing más fácil (mock de interfaces)
- Migración futura a JPA/Hibernate sin refactoring masivo

### ¿Por qué soft delete en lugar de hard delete?

```sql
-- ❌ Hard delete (rompe integridad referencial)
DELETE
FROM users
WHERE id = 5;
-- Problema: enrollments y exam_attempts quedan huérfanos

-- ✅ Soft delete (preserva integridad)
UPDATE users
SET is_active = false
WHERE id = 5;
-- Ventajas: datos preservados, reversible, audit trail
```

### ¿Por qué CharacterEncodingFilter?

Tomcat por defecto usa ISO-8859-1 para request parameters. El filtro aplica UTF-8 application-wide, evitando corrupción
de caracteres especiales (ñ, á, é, í, ó, ú) en formularios.

---

## 🧪 Testing

### Tests manuales ejecutados durante desarrollo

**Autenticación:**

- ✅ Login con credenciales válidas
- ✅ Login con credenciales inválidas
- ✅ Login con usuario desactivado (rechazado)
- ✅ Logout e invalidación de sesión
- ✅ Acceso a rutas protegidas sin autenticación (redirect a login)

**CRUD de usuarios:**

- ✅ Registro con datos válidos
- ✅ Registro con username duplicado (rechazado)
- ✅ Registro con email duplicado (rechazado)
- ✅ Edición de perfil con datos válidos
- ✅ Edición con email duplicado (rechazado)
- ✅ Desactivación de cuenta
- ✅ Intento de login con cuenta desactivada (rechazado)

**UTF-8 encoding:**

- ✅ Formularios guardan correctamente caracteres especiales
- ✅ Títulos de página renderizan correctamente en browser tabs

### TODO: Tests automatizados

- [ ] JUnit 5 para capa DAO (CRUD operations)
- [ ] Tests de integración para servlets
- [ ] Tests de validación de formularios
- [ ] Coverage con JaCoCo

---

## 📋 Roadmap

### Fase 1: Fundamentos ✅ COMPLETADO

- [x] Setup del proyecto (Maven, Tomcat, MySQL)
- [x] Estructura MVC completa
- [x] Bootstrap + layout reutilizable (WebJars)
- [x] Schema de base de datos
- [x] Connection manager (Singleton)
- [x] User model + DAO (CRUD completo)
- [x] UTF-8 encoding filter

### Fase 2: Autenticación ✅ COMPLETADO

- [x] LoginServlet + manejo de sesiones HTTP
- [x] LogoutServlet
- [x] DashboardServlet (entry point protegido)
- [x] Dashboard con contenido por rol
- [x] Protección de rutas (páginas en /WEB-INF/)
- [x] RegisterServlet (registro de usuarios)
- [x] ProfileServlet (visualización y edición)
- [x] DeactivateAccountServlet (soft delete)

### Fase 3: Mejoras de seguridad 🔄

- [ ] AuthenticationFilter para verificar is_active en cada request
- [ ] Cambio de contraseña (usuarios autenticados)
- [ ] Recuperación de contraseña vía email

### Fase 4: Funcionalidades core 📋

- [ ] CRUD de cursos
- [ ] Sistema de inscripciones
- [ ] Vista de cursos por estudiante
- [ ] Vista de estudiantes por profesor

### Fase 5: Sistema de exámenes 📝

- [ ] CRUD de exámenes
- [ ] Interfaz de resolución de exámenes
- [ ] Calificación y feedback
- [ ] Historial de intentos

### Fase 6: Mejoras y optimizaciones 🚀

- [ ] Tests automatizados (JUnit)
- [ ] Makefile para tareas comunes
- [ ] Logs con Log4j
- [ ] Documentación Javadoc completa
- [ ] Migración a bcrypt para passwords

---

## 👨‍💻 Autor

**Alvaro Olguin Armendariz**

- 📧 Email: alvaroarmendariz11@gmail.com
- 💼
  LinkedIn: [linkedin.com/in/alvaro-olguin-armendariz-8a6765104](https://www.linkedin.com/in/alvaro-olguin-armendariz-8a6765104/)
- 🐙 GitHub: [@aolguin89](https://github.com/aolguin89)

---

## 📄 Licencia

Este proyecto fue desarrollado como portfolio académico para la postulación al equipo de desarrollo de EVELiA (UNRC -
CITIC).

---

## 🙏 Agradecimientos

- **UNRC - CITIC:** Por la oportunidad de postularme al equipo de desarrollo de EVELiA
- **Sistema EVELiA:** Por ser la inspiración y referencia técnica de este proyecto

---

<p align="center">
  Desarrollado con ☕ y 💻 por Alvaro Olguin Armendariz
</p>