// app/javascript/controllers/navbar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  connect() {
    this.setActiveLink();
  }

  setActiveLink() {
    const currentPath = window.location.pathname;

    this.linkTargets.forEach((link) => {
      // Reset all links to default state
      link.classList.remove('border-indigo-500', 'text-gray-900');
      link.classList.add('border-transparent', 'text-gray-500');

      // Set the active link based on current path
      if (link.getAttribute('href') === currentPath) {
        link.classList.add('border-indigo-500', 'text-gray-900');
        link.classList.remove('border-transparent', 'text-gray-500');
      }
    });
  }
}

