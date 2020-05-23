// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import '../css/app.scss'

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import 'phoenix_html'

import { Socket, Presence } from 'phoenix'
// import socket from './socket'

let socket = new Socket('/socket', {
  params: { user_id: window.location.search.split('=')[1] },
})

let channel = socket.channel('room:lobby', {})
let presence = new Presence(channel)

function renderOnlineUsers(presence) {
  let response = ''

  presence.list((id, { metas: [first, ...rest] }) => {
    let count = rest.length + 1
    response += `<br>${id} (count: ${count})</br>`
  })

  document.querySelector('main[role=main]').innerHTML = response
}

socket.connect()

presence.onSync(() => renderOnlineUsers(presence))

channel.join()
