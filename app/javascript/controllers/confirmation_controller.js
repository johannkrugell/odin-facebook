// app/javascript/controllers/confirmation_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    console.log("confirmation controller connected");
  } 

  delete(event) {
    event.preventDefault(); // Prevent the default button click behavior
  
    // Confirm with the user
    if (confirm("Are you sure you want to delete this post?")) {
      // Find the form element within the current confirmation controller scope
      let form = this.element.querySelector('form');
  
      if (form) {
        // Submit the form
        form.requestSubmit();
      } else {
        // Log an error if the form is not found
        console.error("Form not found for delete action");
      }
    }
  }
  
   
}
