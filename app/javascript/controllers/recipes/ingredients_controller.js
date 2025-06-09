import { Controller } from "@hotwired/stimulus";

class IngredientsController extends Controller {
  static targets = [ "entries" ]

  connect() {
    const ingredientEntries = Array.from(this.entriesTarget.children);

    ingredientEntries.forEach((entry) => {
      entry.addEventListener("click", () => {
        entry.classList.toggle("selected");
      });
    });
  }
};

export default IngredientsController;
