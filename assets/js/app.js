import { Socket } from "phoenix"
import LiveSocket from "phoenix_live_view"
import Alpine from "alpinejs"
import intersect from "@alpinejs/intersect"

// LiveView Hooks
import Hooks from "./hooks"
import Components from "./components"

// Alphine global state
import Store from "./store"

import "../css/app.scss"

import "phoenix_html"

const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
const params = {
  params: {_csrf_token: csrfToken},
  hooks: Hooks,
  dom: {
    onBeforeElUpdated(from, to){
      if(from._x_dataStack){ window.Alpine.clone(from, to) }
    }
  }
}

const { search, list, pager, chat } = Components
const liveSocket = new LiveSocket("/live", Socket, params)
liveSocket.connect()

window.Alpine = Alpine
window.Hooks = Hooks
window.Search = search
window.List = list
window.Pager = pager
window.Chat = chat

Alpine.plugin(intersect)
Alpine.store('pagination', Store.Pagination)
Alpine.start()
