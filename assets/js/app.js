"use strict";

import "phoenix_html";

import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";

const csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

const liveSocket = new LiveSocket(
  "/live",
  Socket,
  {params: {_csrf_token: csrfToken}}
);

liveSocket.connect();

// liveSocket.enableDebug();

window.liveSocket = liveSocket;
