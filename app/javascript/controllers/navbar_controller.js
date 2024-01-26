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
      link.classList.remove('border-sky-600', 'text-gray-900', 'pointer-events-none');
      link.classList.add('border-transparent', 'text-gray-500', 'hover:bg-gray-100');
      this.changeSvgFill(link, false); // Reset SVG fill

      // Set the active link based on current path
      if (link.getAttribute('href') === currentPath) {
        link.classList.add('border-sky-600', 'text-gray-900');
        link.classList.remove('border-transparent', 'text-gray-500', 'hover:bg-gray-100');
        this.changeSvgFill(link, true); // Set SVG fill
        // Add class to disable pointer events
        link.classList.add('pointer-events-none');
      }
    });
  }

  changeSvgFill(link, isActive) {
    const svg = link.querySelector('.svg-icon');
    if (svg) {
      svg.classList.toggle('fill-sky-600', isActive);
      svg.classList.toggle('fill-gray-700', !isActive);
    }
  }
}

