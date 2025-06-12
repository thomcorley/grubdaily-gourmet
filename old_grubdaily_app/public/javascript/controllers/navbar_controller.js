import { Controller } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"

class NavbarController {
  static init() {
    Stimulus.register("navbar", class extends Controller {
      static targets = [
        "burger",
        "menu",
        "closeMenu",
        "openMenu"
      ];

      connect() {
        const handleMenuOnWindowResize = () => {
          if (document.body.clientWidth < 1024) {
            setMenuHeight();
          } else {
            this.menuTarget.style = null;
          }
        };

        const setMenuHeight = () => {
          if (document.body.clientWidth < 1024) {
            const mainContainerHeight = document.getElementById("main-container").clientHeight;
            this.menuTarget.style.height = `${mainContainerHeight + 50}px`;
          }
        };

        // Use the burger menu to reveal the drop-down nav menu
        this.burgerTarget.addEventListener("click", () => {
          this.closeMenuTarget.classList.toggle("is-hidden")
          this.openMenuTarget.classList.toggle("is-hidden")
          this.burgerTarget.classList.toggle("is-active");
          this.menuTarget.classList.toggle("is-active");
        });

        // Set the navMenu height upon page load
        document.addEventListener("turbo:load", () => {
          setMenuHeight();
        });

        setMenuHeight();

        // Ensure the height of the menu is correct after the window is resized
        window.addEventListener("resize", () => {
          handleMenuOnWindowResize();
        });
      }

      goToSubscribeForm() {
        this.burgerTarget.classList.toggle("is-active");
        this.menuTarget.classList.toggle("is-active");
      }
    })
  }
}

export default NavbarController;
