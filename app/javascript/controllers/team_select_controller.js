import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["teamSelect"];

  connect() {
    console.log("TeamSelectController connected");

    if (this.teamSelectTarget) {
      this.teamSelectTarget.addEventListener("change", this.changeTeam.bind(this));
    }
  }

  changeTeam(event) {
    const selectedTeamId = this.teamSelectTarget.value;
    const userId = event.target.dataset.userid;

    if (!userId || !selectedTeamId) {
      console.error("User ID or selected team ID is missing.");
      return;
    }

    let url = `/users/${userId}/save_current_team.json`;
    let csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");

    fetch(url, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({ team_id: selectedTeamId })
    })
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        console.log('Current team saved successfully:', data);
      })
      .catch(error => {
        console.error('Error saving current team:', error);
      });
  }
}
