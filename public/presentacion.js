// Navegación de la presentación: flechas, espacio, Inicio/Fin y F para pantalla completa.
(function () {
  const slides = Array.from(document.querySelectorAll(".slide"));
  if (slides.length === 0) return;

  document.body.classList.add("js-deck");
  const contador = document.getElementById("contador");
  let actual = 0;

  function mostrar(n) {
    actual = Math.max(0, Math.min(slides.length - 1, n));
    slides.forEach((s, i) => s.classList.toggle("activa", i === actual));
    contador.textContent = (actual + 1) + " / " + slides.length;
    history.replaceState(null, "", "#" + slides[actual].id);
    window.scrollTo(0, 0);
  }

  function pantallaCompleta() {
    if (document.fullscreenElement) document.exitFullscreen();
    else document.documentElement.requestFullscreen();
  }

  document.getElementById("anterior").addEventListener("click", () => mostrar(actual - 1));
  document.getElementById("siguiente").addEventListener("click", () => mostrar(actual + 1));
  document.getElementById("completa").addEventListener("click", pantallaCompleta);

  document.addEventListener("keydown", (e) => {
    if (["ArrowRight", "PageDown", " "].includes(e.key)) { e.preventDefault(); mostrar(actual + 1); }
    if (["ArrowLeft", "PageUp"].includes(e.key)) { e.preventDefault(); mostrar(actual - 1); }
    if (e.key === "Home") mostrar(0);
    if (e.key === "End") mostrar(slides.length - 1);
    if (e.key === "f" || e.key === "F") pantallaCompleta();
  });

  // Si el enlace trae #id de una diapositiva, se abre en esa.
  const inicial = slides.findIndex((s) => "#" + s.id === location.hash);
  mostrar(inicial >= 0 ? inicial : 0);
})();
