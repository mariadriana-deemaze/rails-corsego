import { Controller } from "@hotwired/stimulus"

import Rails from '@rails/ujs'

import TomSelect from "tom-select"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)
    new TomSelect(this.element, {
      create: true,
      plugins: ['remove_button'],
      onItemAdd: function(value) {

        Rails.ajax({
          url: '/tags',
          type: "post",
          beforeSend(xhr, options) {
            xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
            options.data = JSON.stringify({tag:{name:value}})
            return true
          },
        })
      }
    })
  }

}
