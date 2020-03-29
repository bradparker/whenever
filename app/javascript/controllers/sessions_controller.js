import { Controller } from "stimulus";
import { createClient } from "../authentication";

export default class SessionsController extends Controller {
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
    const client_A = client.getPublicKey();

    const headers = {
      "X-CSRF-Token": authenticityToken,
      "Content-type": "application/json"
    };

    const challengeResponse = await fetch("/authentication/challenges.json", {
      method: "POST",
      headers,
      body: JSON.stringify({
        challenge: { username, A: client_A }
      })
    });
    const challenge = await challengeResponse.json();
    console.log(challenge);

    client.setSalt(challenge.salt);
    client.setServerPublicKey(challenge.B);
    const client_M = client.getProof();

    const proofResponse = await fetch("/authentication/proofs.json", {
      method: "POST",
      headers,
      body: JSON.stringify({
        username,
        M: client_M
      })
    });
    const proof = await proofResponse.json();
    console.log(proof);
    console.log(client.checkServerProof(proof.H_AMK));
  }
}
