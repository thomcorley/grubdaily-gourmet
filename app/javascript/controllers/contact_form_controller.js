import { Controller } from "@hotwired/stimulus";

class ContactFormController extends Controller {
  static targets = [
    "name",
    "email",
    "emailError",
    "subscribeCheckbox",
  ];

  connect() {
    const errorFieldsArray = Array.from(document.getElementsByClassName("field_with_errors"));
    const formFieldElements = Array.from(document.getElementsByClassName("form-field"));

    // Only proceed if there are any divs with the class `field_with_errors`,
    // which is the error div created by Rails upon redirect with the model errors.
    // This will prevent any error highlighting appearing upon first visit to the page.
    if (errorFieldsArray.length > 0) {
      let blankFields = 0;
      this.nameTarget.focus();

      // Remove the Rails error class so we can apply our own styles
      errorFieldsArray.forEach(errorField => {
        errorField.classList.remove("field_with_errors");
      });

      // Add the `is-danger` Bulma class to all blank form fields
      formFieldElements.forEach(formField => {
        if (this.formFieldValueIsBlank(formField)) {
          blankFields += 1;
          formField.classList.add("is-danger");
        }
      });

      // Add the `is-danger` Bulma class to the email field if the email is invalid
      if ( this.emailErrorTarget != null ) {
        this.emailTarget.classList.add("is-danger");
        // Remove the invalid message if the field is empty
        if (this.formFieldValueIsBlank(this.emailTarget)) {
          this.emailErrorTarget.remove();
        }
      }

      if (blankFields > 0) {
        const notice = document.createElement("div");
        notice.classList.add("block");
        notice.classList.add("form-error-message");
        notice.innerHTML = "Please complete all fields";

        this.element.insertBefore(notice, this.subscribeCheckboxTarget);
      };
    }
  }

  formFieldValueIsBlank(formField) {
    return formField.value === "" || formField.value === null;
  }
}

export default ContactFormController;

// const errorFieldsArray = Array.from(document.getElementsByClassName("field_with_errors"));
// const formFieldElements = document.getElementsByClassName("form-field");
// const subscribeElement = document.getElementById("subscribe-checkbox");
// const emailErrorDiv = document.querySelector(".email-error.form-error-message")
// const emailField = document.querySelector(".input.form-field.email")
// const formParentElement = document.getElementById("contact-form");
// const firstFormField = document.getElementById("first-form-field");
