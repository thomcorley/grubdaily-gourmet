import { Controller } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"

class SearchController {
  static init() {
    Stimulus.register("search", class extends Controller {
      static targets = [ 'searchInput' ]

      connect() {
        this.searchInputTarget.focus();
      }
    })
  }
}

export default SearchController;
