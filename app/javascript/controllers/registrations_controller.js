import { Controller } from "stimulus";
import { createClient } from "../authentication";

export default class RegistationsController extends Controller {
  async submit (event) {
    event.preventDefault();
    const form = event.target;
    const authenticityToken = document.querySelector("meta[name=csrf-token]").getAttribute("content");
    const username = form.querySelector("[name='user[username]']").value;
    const password = form.querySelector("[name='user[password]']").value;

    const client = await createClient({
      username,
      password
    });

    const { salt, verifier } = await client.createVerifier();

    const headers = {
      "X-CSRF-Token": authenticityToken,
      "Content-type": "application/json"
    };
    const body = {
      user: { username, salt, verifier }
    };

    const response = await fetch("/registrations.json", {
      method: "POST",
      headers,
      body: JSON.stringify(body)
    });
    const result = await response.json();
    window.location.href = "/sign_in";
  }
}
