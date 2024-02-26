// app/javascript/controllers/user_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["profilePicture", "bannerImage", "userName", "userNameDisplay", "userNameForm", "penIcon"]

  connect() {
    console.log("User controller connected");
  }

  triggerProfileInput() {
    this.profilePictureTarget.click();
  }

  triggerBannerInput() {
    this.bannerImageTarget.click();
  }

   // Call this method when the pen icon is clicked
   triggerUserInput() {
    this.userNameDisplayTarget.classList.toggle('hidden');
    this.userNameFormTarget.classList.toggle('hidden');
    if (!this.userNameDisplayTarget.classList.contains('hidden')) {
      this.userNameTarget.focus();
    }
  }

   // You can call this method when you want to hide the form, such as after submission
   hideUserNameForm() {
    this.userNameDisplayTarget.classList.remove('hidden');
    this.userNameFormTarget.classList.add('hidden');
  }

  submitForm(event) {
    // For text fields, you might want to check for some other condition to auto-submit
    if (event.target.type === 'text' && event.target.value.length > 0) {
      // Submit the closest form
      event.target.closest("form").requestSubmit();
    }
    // For file inputs
    if (event.target.type === 'file' && event.target.files.length) {
      // Submit the closest form
      event.target.closest("form").requestSubmit();
    }
  }
}

