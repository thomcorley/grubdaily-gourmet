import { Controller } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"
import dragula from "dragula";

class IngredientSetsController {
  static init() {
    Stimulus.register("recipes--ingredient-sets", class extends Controller {
      static targets = [
        "ingredientEntry",
        "ingredientEntryContainer",
        "ingredientEntryInputs"
      ];

      connect() {
        const containers = this.ingredientEntryContainerTargets;
        const drake = dragula(containers, { revertOnSpill: true });

        drake.on('dragend', () => this.updateIngredientsOrder());
      }

      updateIngredientsOrder() {
        const positionData = {};

        // Fill the positionData object with IDs and position values.
        //
        // eg: { 567: 5, 568: 4, 569: 2, 570: 3, 571: 0, 572: 1 }
        this.ingredientEntryTargets.forEach((ingredient, index) => {
          const id = ingredient.getAttribute('ingredient-entry-id');
          const position = index;
          positionData[id] = position;
        });

        const formInputs = [
          ...this.ingredientEntryInputsTarget.querySelectorAll('.ingredient-entry-id')
        ];

        // Assume that the position input is always immediately following the ID input. Look up the
        // position from the positionData object by the element's ID and set it on the input, so when
        // the form is submitted, the position is updated.
        formInputs.forEach(idInput => {
          const id = idInput.getAttribute('value');
          const positionInput = idInput.nextElementSibling;
          positionInput.value = positionData[id];
        });
      }
    })
  }
}

export default IngredientSetsController;
