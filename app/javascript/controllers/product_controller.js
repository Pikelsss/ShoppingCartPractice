// app/javascript/controllers/product_controller.js

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product"
export default class extends Controller {
  delete(event) {
    event.preventDefault()
    const confirmDelete = confirm("Are you sure you want to delete this product?")
    if (confirmDelete) {
      const url = event.target.href
      fetch(url, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
          'Accept': 'text/vnd.turbo-stream.html'
        }
      })
      .then(response => response.text())
      .then(html => {
        const template = document.createElement('template')
        template.innerHTML = html
        const turboStream = template.content.querySelector('turbo-stream')
        if (turboStream) {
          turboStream.dispatchEvent(new Event("turbo:before-fetch-request"))
        }
      })
      .catch(error => console.error('Error:', error))
    }
  }
}
