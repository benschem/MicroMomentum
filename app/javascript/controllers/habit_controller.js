import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="habit"
export default class extends Controller {
  connect() {

    async changeState() {
      // Get the instance variable from the Rails view
      const habit = this.element.getAttribute('data-habit');

      // Send an AJAX request to the Rails controller method
      const response = await fetch('/habits_controller/change_state', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': Rails.csrfToken()
        },
        body: JSON.stringify({ habit })
      });

      // Handle the response
      const result = await response.json();
      console.log(result);
    }
  }
}
