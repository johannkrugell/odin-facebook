// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "modalContent"];

  connect() {
    console.log("Modal controller connected");
  }

  open(event) {
    event.preventDefault();
    this.modalTarget.classList.remove("hidden");
    this.modalTarget.classList.add("flex");
  }

  close(event) {
    event.preventDefault();
    this.modalTarget.classList.add("hidden");
    this.modalTarget.classList.remove("flex");
  }

  closeWithBackgroundClick(event) {
    if (this.modalContentTarget && !this.modalContentTarget.contains(event.target)) {
      this.close(event);
    }
  }
}

