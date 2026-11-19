# Gestión de versionamiento con GitHub y GitLab

Proyecto del Grupo 2 para la asignatura Arquitectura de Software, Universidad Central del Ecuador.

Sitio estático que compara GitHub y GitLab a partir de un mismo caso práctico: el repositorio se versiona con Git, la rama principal está protegida y cada plataforma publica el sitio mediante su propio pipeline.

## Sitios publicados

- GitHub Pages: https://jhon-avila135.github.io/investigacion-versionamiento/
- GitLab Pages: https://grupo2-versionamiento-uce.gitlab.io/investigacion-versionamiento/
- Documentación del equipo (Confluence, acceso por invitación): https://jhonavilat105.atlassian.net/wiki/spaces/G2V

## Estructura

```
public/                 Sitio publicado: informe, investigación y presentación
docs/SRS.md             Especificación de requisitos (ISO/IEC/IEEE 29148)
scripts/medir.sh        Medición del tiempo de entrega
mediciones.csv          Registro de mediciones
.github/workflows/      Pipeline de GitHub Actions
.gitlab-ci.yml          Pipeline de GitLab CI
.htmlvalidate.json      Reglas del validador de HTML
```

## Flujo de trabajo

1. Crear una rama por tarea: `git switch -c tipo/descripcion`.
2. Registrar los cambios con Conventional Commits (`feat`, `fix`, `docs`, `ci`, `chore`).
3. Publicar la rama y abrir un pull request en GitHub.
4. Fusionar solo cuando el check `validate` esté aprobado.
5. Replicar en GitLab: `git switch main && git pull origin main && git push gitlab main`.

## Validación local

```bash
npx --yes html-validate "public/**/*.html"
```

## Medición

```bash
# GitHub: ejecutar justo antes de fusionar el pull request
./scripts/medir.sh https://jhon-avila135.github.io/investigacion-versionamiento/ github

# GitLab: indicar la versión esperada y luego ejecutar git push gitlab main
./scripts/medir.sh https://grupo2-versionamiento-uce.gitlab.io/investigacion-versionamiento/ gitlab $(git rev-parse --short=8 HEAD)
```
