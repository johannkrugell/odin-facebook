// sidebar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {        
  static targets = ["section"];

  connect() {
    console.log("Connected to sidebar controller");
    console.log(this.sectionTargets);
  }

  show(event) {
    event.preventDefault();
    const sectionId = event.currentTarget.dataset.section;
    console.log("Clicked section ID:", sectionId);
  
    // Hide all sections first
    this.hideAllSections();
    
    this.sectionTargets.forEach((section, index) => {
      console.log(`Section target ${index}: ID = ${section.id}`);
    });
  
    const sectionToShow = this.sectionTargets.find(section => section.id === sectionId);
    console.log("Section to show:", sectionToShow);

    if (sectionToShow) {
      sectionToShow.classList.remove('hidden');  // Remove Tailwind's 'hidden' class to show the element
    }
  }

  hideAllSections() {
    this.sectionTargets.forEach(section => section.classList.add('hidden'));  // Add Tailwind's 'hidden' class to hide the element
  }
}