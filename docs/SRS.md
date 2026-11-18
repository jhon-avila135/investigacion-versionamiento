# Especificación de Requisitos de Software (SRS)

**Proyecto:** Sitio de investigación "Gestión de versionamiento" · Grupo 2
**Materia:** Arquitectura de Software · Universidad Central del Ecuador
**Versión del documento:** 1.0
**Estructura basada en:** ISO/IEC/IEEE 29148:2018

## 1. Introducción

### 1.1 Propósito
Definir los requisitos de un sitio web que presenta la investigación del Grupo 2 y que, al mismo tiempo, sirve como caso práctico para comparar GitHub y GitLab en el despliegue continuo.

### 1.2 Alcance
El sistema es un sitio estático (HTML, CSS y JavaScript) versionado con Git y publicado automáticamente en GitHub Pages y en GitLab Pages mediante pipelines de CI/CD. Reúne en un solo lugar la investigación, la presentación, la ruta de trabajo y los enlaces del proyecto. No incluye backend, base de datos ni inicio de sesión.

### 1.3 Definiciones
| Término | Significado |
|---|---|
| CI | Integración continua: validar automáticamente cada cambio. |
| CD | Despliegue continuo: publicar automáticamente lo que pasó la validación. |
| PR / MR | Pull request (GitHub) o merge request (GitLab). |
| Pipeline | Secuencia de jobs que ejecuta la plataforma ante un evento del repositorio. |
| Tiempo de entrega | Segundos desde que se aprueba un cambio hasta que es visible en el sitio. |
| Tiempo de recuperación | Segundos desde que se revierte un cambio defectuoso hasta que el sitio vuelve a la versión correcta. |

### 1.4 Referencias
- ISO/IEC/IEEE 29148:2018, Requirements engineering.
- Documentación oficial de GitHub Actions, GitHub Pages, GitLab CI/CD y GitLab Pages.
- Forsgren, N., Humble, J. y Kim, G. (2018). *Accelerate*. IT Revolution.

## 2. Descripción general

### 2.1 Perspectiva del producto
El repositorio en GitHub es la fuente de verdad. La rama `main` se envía también a GitLab. Cada plataforma ejecuta su propio pipeline y publica su propia copia del sitio.

### 2.2 Usuarios
| Usuario | Necesidad |
|---|---|
| Docente y compañeros | Leer la investigación, ver la presentación y descargar el PDF. |
| Integrantes del grupo | Proponer cambios mediante ramas y pull requests, y seguir las tareas en Jira. |

### 2.3 Restricciones
- Costo cero: solo planes gratuitos de GitHub, GitLab y Atlassian.
- Sitio estático, sin dependencias de servidor.
- Entorno de desarrollo: IntelliJ IDEA.

### 2.4 Supuestos
- Los integrantes tienen cuentas con correo institucional.
- GitLab tiene habilitados los runners compartidos (cuenta verificada).

## 3. Requisitos funcionales

| ID | Requisito | Prioridad |
|---|---|---|
| RF-01 | El sitio muestra la investigación en secciones: problema, fundamentos, diferencias, despliegue, reglas, variables, comandos, ejemplo práctico, límites y fuentes. | Alta |
| RF-02 | El sitio incluye la presentación del grupo, navegable con el teclado. | Alta |
| RF-03 | El sitio muestra la ruta de trabajo con el estado de cada etapa. | Alta |
| RF-04 | El sitio reúne los enlaces a los repositorios, pipelines, sitios publicados, Jira y Confluence. | Media |
| RF-05 | El pie de página muestra la versión (commit), la plataforma, el entorno y la fecha de publicación. | Alta |
| RF-06 | El sitio muestra una tabla con las métricas medidas en ambas plataformas. | Media |
| RF-07 | El sitio ofrece la investigación en PDF mediante un enlace y un código QR. | Media |

## 4. Requisitos no funcionales

| ID | Atributo | Requisito | Criterio medible |
|---|---|---|---|
| RNF-01 | Automatización | Todo cambio en `main` se publica sin intervención manual. | 100 % de los despliegues hechos por pipeline. |
| RNF-02 | Rapidez | El tiempo de entrega es corto en ambas plataformas. | Promedio menor a 5 minutos. |
| RNF-03 | Calidad | Ningún cambio llega a `main` sin pasar la validación de HTML. | 0 fusiones con el job `validate` en rojo. |
| RNF-04 | Disponibilidad | El sitio está publicado en dos plataformas independientes. | 2 URLs activas. |
| RNF-05 | Recuperación | Un cambio defectuoso se revierte rápido. | Menos de 10 minutos. |
| RNF-06 | Accesibilidad | Idioma declarado y texto alternativo en todas las imágenes. | html-validate sin errores. |
| RNF-07 | Seguridad | Ningún secreto se guarda en el repositorio. | Configuración solo en variables de cada plataforma. |

## 5. Matriz de trazabilidad

| ID | Cómo se verifica | Evidencia |
|---|---|---|
| RF-01 a RF-04 | Revisión del sitio publicado | URLs de GitHub Pages y GitLab Pages |
| RF-05 | Pie de página después de cada despliegue | Capturas de ambos sitios |
| RNF-01 | Historial de ejecuciones | Pestaña Actions y Build → Pipelines |
| RNF-02 | Script `scripts/medir.sh` | `mediciones.csv` |
| RNF-03 | Ruleset con status check obligatorio | Captura del PR bloqueado |
| RNF-05 | Revert medido con el script | `mediciones.csv` |
| RNF-06 | Job `validate` | Logs del pipeline |
| RNF-07 | Revisión del repositorio | Variables `ENTORNO` en cada plataforma |
