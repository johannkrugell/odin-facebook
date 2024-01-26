// search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["searchBox" , "searchParent", "searchLogo", "searchField"];

  toggleSearch() {
    this.searchBoxTarget.classList.toggle('hidden');
    
    // Logo, Search and Navigation
    this.searchParentTarget.classList.toggle('grid-cols-3'); // Original state
    this.searchParentTarget.classList.toggle('grid-cols-5'); // Expanded state
    
    this.searchParentTarget.classList.toggle('col-end-1'); // Original state
    this.searchParentTarget.classList.toggle('col-end-5'); // Expanded state
    
    //Logo
    this.searchLogoTarget.classList.toggle('col-end-3'); // Original state
    this.searchLogoTarget.classList.toggle('col-end-1'); // Expanded state

    // Search box col span increase from 2 to 5
    this.searchFieldTarget.classList.toggle('col-span-1'); // Original state
    this.searchFieldTarget.classList.toggle('col-span-4'); // Expanded state

    const event = new CustomEvent('searchToggle', { bubbles: true });
    this.element.dispatchEvent(event);
  }
}
