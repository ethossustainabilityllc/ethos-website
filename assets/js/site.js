/* ETHOS Sustainability - small site script. No external dependencies. */
(function () {
  "use strict";

  var CONTACT_EMAIL = "bill@ethossustainability.com";

  /* ---------- Mobile menu ---------- */
  var drawer = document.getElementById("drawer");
  var openBtn = document.querySelector("[data-menu-open]");
  var closeBtn = document.querySelector("[data-menu-close]");

  function setDrawer(open) {
    if (!drawer) return;
    drawer.classList.toggle("is-open", open);
    document.body.classList.toggle("drawer-open", open);
    drawer.setAttribute("aria-hidden", open ? "false" : "true");
    if (openBtn) openBtn.setAttribute("aria-expanded", open ? "true" : "false");
    if (open && closeBtn) closeBtn.focus();
    if (!open && openBtn) openBtn.focus();
  }
  if (openBtn) openBtn.addEventListener("click", function () { setDrawer(true); });
  if (closeBtn) closeBtn.addEventListener("click", function () { setDrawer(false); });
  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape" && drawer && drawer.classList.contains("is-open")) setDrawer(false);
  });

  /* ---------- Forms: open the visitor's email app (mailto) ---------- */
  function mailto(subject, body) {
    window.location.href =
      "mailto:" + CONTACT_EMAIL +
      "?subject=" + encodeURIComponent(subject) +
      "&body=" + encodeURIComponent(body);
  }

  var contact = document.getElementById("contact-form");
  if (contact) {
    contact.addEventListener("submit", function (e) {
      e.preventDefault();
      if (!contact.reportValidity()) return;
      var f = contact.elements;
      var lines = [
        "Name: " + f.name.value.trim(),
        "Email: " + f.email.value.trim()
      ];
      if (f.phone.value.trim()) lines.push("Phone: " + f.phone.value.trim());
      lines.push("", f.message.value.trim());
      mailto("Website inquiry from " + f.name.value.trim(), lines.join("\n"));
    });
  }

  var subscribe = document.getElementById("subscribe-form");
  if (subscribe) {
    subscribe.addEventListener("submit", function (e) {
      e.preventDefault();
      if (!subscribe.reportValidity()) return;
      var email = subscribe.elements.email.value.trim();
      mailto("Newsletter sign up", "Please add " + email + " to the ETHOS Sustainability news and updates list.");
    });
  }
})();
