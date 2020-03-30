import { Controller } from "stimulus";
import { createClient } from "../authentication";

export default class SessionsController extends Controller {
  async submit(event) {
    event.preventDefault();

    const authenticityToken = document
      .querySelector("meta[name=csrf-token]")
      .getAttribute("content");
    const form = event.target;
    const username = form.querySelector("[name='user[username]']").value;
    const password = form.querySelector("[name='user[password]']").value;

    const client = await createClient({
      username,
      password,
    });

    const headers = {
      "X-CSRF-Token": authenticityToken,
      "Content-type": "application/json",
    };

    const sessionResponse = await fetch("/sessions.json", {
      method: "POST",
      headers,
      body: JSON.stringify({
        session: { username, A: client.getPublicKey() },
      }),
    });

    const session = await sessionResponse.json();

    client.setSalt(session.salt);
    client.setServerPublicKey(session.B);

    const clientProof = client.getProof();

    const proofResponse = await fetch(`/sessions/${session.id}/verify.json`, {
      method: "POST",
      headers,
      body: JSON.stringify({
        proof: { M: clientProof },
      }),
    });

    const serverProof = await proofResponse.json();

    if (client.checkServerProof(serverProof.H_AMK)) {
      document.cookie = `SID=${session.id}; path=/; samesite=strict; secure`;
      document.cookie = `SM=${clientProof}; path=/; samesite=strict; secure`;

      window.location.href = "/";
    }
  }
}
