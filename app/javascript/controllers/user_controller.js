import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fileInput", "imagePreview", "circle"];

  connect() {
    if (this.hasImage()) {
      this.showImagePreview();
    }

    if (this.hasFileInputTarget) {
      this.fileInputTarget.addEventListener("change", this.previewImage.bind(this));
    }
  }

  hasImage() {
    let status = imagePreview?.dataset?.imageUrl ? true : false
    return status;
  }

  showImagePreview() {
    imagePreview.style.display = "unset";
    const svgElement = document.querySelector(".circle svg");
    const headingElement = document.querySelector(".circle h6");

    if (svgElement && headingElement) {
      svgElement.style.display = "none";
      headingElement.style.display = "none";
    }
    imagePreview.parentElement.classList.add("has-image");
  }

  previewImage(event) {
    const input = event.target;

    if (input.files && input.files[0]) {
      const reader = new FileReader();

      reader.onload = function (e) {
        if (imagePreview) {
          imagePreview.src = e.target.result;
          imagePreview.style.display = "unset";
          const svgElement = document.querySelector(".circle svg");
          const headingElement = document.querySelector(".circle h6");

          if (svgElement && headingElement) {
            svgElement.style.display = "none";
            headingElement.style.display = "none";
          }
          imagePreview.parentElement.classList.add("has-image");
        }
      };

      reader.readAsDataURL(input.files[0]);
    }
  }
}
