import { Controller } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"

class GalleryController {
  static init() {
    Stimulus.register("gallery", class extends Controller {
      static targets = ["slide"];

      connect() {
        const fadeComplete = () => {
          const slides = this.element.querySelectorAll('.slide');
          this.element.appendChild(slides[0]);
        }

        this.slideTargets.forEach(slide => {
          slide.addEventListener("animationend", fadeComplete);
        });
      }
    })
  }
}

export default GalleryController;
