// friendship_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["friendsSection", "requestsSection", "suggestionsSection", 
  "mobilefriendsButton", "desktopfriendsButton", "mobilerequestsButton", "desktoprequestsButton",
  "mobilesuggestionsButton", "desktopsuggestionsButton" ];

  connect() {
    console.log("Friendship controller connected");
    this.showFriends(); // Call a method to show friends by default
  }

  toggleSection(event) {
    const buttonName = event.currentTarget.getAttribute('data-friendship-target').replace('Button', '');
    // const sectionName = `${buttonName}Section`;
    const buttonType = event.currentTarget.getAttribute('data-friendship-target');
    // Extract the base name of the button to match with the section
    const baseButtonName = buttonType.replace('Button', '').replace('mobile', '').replace('desktop', '');
    const sectionName = `${baseButtonName}Section`;

    // Deactivate all buttons
    this.mobilefriendsButtonTargets.concat(this.desktopfriendsButtonTargets).forEach(button => button.classList.remove('bg-sky-500'));
    this.mobilefriendsButtonTargets.concat(this.desktopfriendsButtonTargets).forEach(button => button.classList.add('bg-gray-300'));
    this.mobilefriendsButtonTargets.concat(this.desktopfriendsButtonTargets).forEach(button => button.classList.remove('text-white'));
    this.mobilefriendsButtonTargets.concat(this.desktopfriendsButtonTargets).forEach(button => button.classList.add('text-gray-800'));

    this.mobilerequestsButtonTargets.concat(this.desktoprequestsButtonTargets).forEach(button => button.classList.remove('bg-sky-500'));
    this.mobilerequestsButtonTargets.concat(this.desktoprequestsButtonTargets).forEach(button => button.classList.add('bg-gray-300'));
    this.mobilerequestsButtonTargets.concat(this.desktoprequestsButtonTargets).forEach(button => button.classList.remove('text-white'));
    this.mobilerequestsButtonTargets.concat(this.desktoprequestsButtonTargets).forEach(button => button.classList.add('text-gray-800'));

    this.mobilesuggestionsButtonTargets.concat(this.desktopsuggestionsButtonTargets).forEach(button => button.classList.remove('bg-sky-500'));
    this.mobilesuggestionsButtonTargets.concat(this.desktopsuggestionsButtonTargets).forEach(button => button.classList.add('bg-gray-300'));
    this.mobilesuggestionsButtonTargets.concat(this.desktopsuggestionsButtonTargets).forEach(button => button.classList.remove('text-white'));
    this.mobilesuggestionsButtonTargets.concat(this.desktopsuggestionsButtonTargets).forEach(button => button.classList.add('text-gray-800'));

    // Add the active state to the clicked button
    event.currentTarget.classList.remove('bg-gray-300');
    event.currentTarget.classList.add('bg-sky-500');
    event.currentTarget.classList.remove('text-gray-800');
    event.currentTarget.classList.add('text-white');

    // Hide all sections
    this.friendsSectionTarget.classList.add('hidden');
    this.requestsSectionTarget.classList.add('hidden');
    this.suggestionsSectionTarget.classList.add('hidden');

    // Show the clicked section
    this[`${sectionName}Target`].classList.remove('hidden');
  }

  // Method to show friends by default
  showFriends() {
    // Highlight the friends button
    this.friendsButtonTarget.classList.add('bg-sky-500', 'text-white');
    // Other buttons should not be highlighted
    this.requestsButtonTarget.classList.remove('bg-sky-500', 'text-white');
    this.suggestionsButtonTarget.classList.remove('bg-sky-500', 'text-white');

    // Show the friends section
    this.friendsSectionTarget.classList.remove('hidden');
    // Hide other sections
    this.requestsSectionTarget.classList.add('hidden');
    this.suggestionsSectionTarget.classList.add('hidden');
  }
}
