// menu_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {    
  static targets = ["toggleable", "openIcon", "closeIcon", "icons"]

  connect() {
    console.log("Menu controller connected");
    this.element.addEventListener('searchToggle', this.handleSearchToggle);
  }    

  toggle() {
    this.toggleableTarget.classList.toggle('hidden');
    this.openIconTarget.classList.toggle('hidden');
    this.closeIconTarget.classList.toggle('hidden');
  }

  closeMenu() {
    if (!this.toggleableTarget.classList.contains('hidden')) {
      this.toggleableTarget.classList.add('hidden');
      this.openIconTarget.classList.remove('hidden');
      this.closeIconTarget.classList.add('hidden');
    }
  }

  disconnect() {
    this.element.removeEventListener('searchToggle', this.handleSearchToggle);
  }

  handleSearchToggle = () => {
    // Toggles the visibility of the icons
    this.iconsTarget.classList.toggle('hidden');
  }                                              
}