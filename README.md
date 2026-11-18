# Gestión de versionamiento · Grupo 2

Proyecto de Arquitectura de Software (Universidad Central del Ecuador).

Una página web con nuestra investigación, guardada con Git, que se publica sola en GitHub y en GitLab cada vez que se aprueba un cambio. Además, medimos cuál de las dos plataformas lo hace mejor.

## Enlaces

- Sitio en GitHub Pages: https://jhon-avila135.github.io/investigacion-versionamiento/
- Sitio en GitLab Pages: https://grupo2-versionamiento-uce.gitlab.io/investigacion-versionamiento/
- Confluence (ruta, tareas, SRS y decisiones): https://jhonavilat105.atlassian.net/wiki/spaces/G2V

## Estructura

```
public/                 Sitio que se publica (inicio, investigación y presentación)
docs/SRS.md             Requisitos del proyecto (ISO/IEC/IEEE 29148)
scripts/medir.sh        Mide el tiempo de entrega de cada despliegue
.github/workflows/      Pipeline de GitHub Actions
.gitlab-ci.yml          Pipeline de GitLab CI
.htmlvalidate.json      Reglas del validador de HTML
```

## Cómo trabajar

1. Crear una rama por tarea: `git switch -c feat/nombre-de-la-tarea`
2. Hacer commits con Conventional Commits: `feat:`, `fix:`, `docs:`, `ci:`
3. Subir la rama y abrir un pull request en GitHub.
4. Esperar a que el job `validate` esté en verde y fusionar.
5. Actualizar GitLab: `git switch main && git pull origin main && git push gitlab main`

## Validar en local

```bash
npx --yes html-validate "public/**/*.html"
```

## Medir un despliegue

```bash
./scripts/medir.sh URL_DEL_SITIO github
```
