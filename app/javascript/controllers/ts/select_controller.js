import { Controller } from "@hotwired/stimulus"

import TomSelect from "tom-select"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)
    new TomSelect(this.element)
  }
}
