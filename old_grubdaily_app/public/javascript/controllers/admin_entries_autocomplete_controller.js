import { Application } from '@hotwired/stimulus'
import { Autocomplete } from 'stimulus-autocomplete'

class AdminEntriesAutocompleteController {
  static init() {
    Stimulus.register("admin-entries-autocomplete", class extends Autocomplete {
      static targets = [
        "entry",
        "selectedList",
        "hiddenInput"
      ]

      clearInput(event) {
        event.preventDefault();
        this.visibleInputTarget.value = "";
        this.resultsTarget.removeAttribute('hidden')
      }

      selectEntry(event) {
        const entry = event.currentTarget;
        this.selectedListTarget.append(entry);
        entry.classList.add('selected');

        let ids = JSON.parse(this.hiddenInputTarget.value);
        console.log(ids)
        ids.push(entry.dataset.entryId);
        console.log(ids)
        this.hiddenInputTarget.value = JSON.stringify(ids);
      }

      removeEntry(event) {
        const entry = event.currentTarget.parentElement;
        const ids = JSON.parse(this.hiddenInputTarget.value);
        console.log(ids)
        const index = ids.indexOf(entry.dataset.entryId);
        const newIds = ids.toSpliced(index, 1);
        console.log(newIds)
        this.hiddenInputTarget.value = JSON.stringify(newIds);

        entry.remove();
      }

      commit(selected) {
        if (selected.getAttribute("aria-disabled") === "true") {
          return;
        }

        if (selected instanceof HTMLAnchorElement) {
          selected.click();
          this.close();
          return;
        }

        const value = selected.getAttribute("data-admin-entries-autocomplete-value");
        this.inputTarget.value = value;

        this.inputTarget.focus()

        this.element.dispatchEvent(
          new CustomEvent("autocomplete.change", {
            bubbles: true,
            detail: { value: value, textValue: value, selected: selected }
          })
        )
      }
    })
  }
}

export default AdminEntriesAutocompleteController;
