import { Controller } from "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"

class HelloController {
  static init() {
    Stimulus.register("hello", class extends Controller {
      static targets = [ "name" ]

      connect() {
        console.log('hello connected!')
        console.log(this.nameTarget)
      }
    })
  }
}

export default HelloController;
