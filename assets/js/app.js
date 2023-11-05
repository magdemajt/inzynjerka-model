// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

let eventQueue= []


const addTokenToParams = () => {
  let token = localStorage.getItem("token") || null;
  let elements = [...document.querySelectorAll('a'), ...document.querySelectorAll('[path]')];
  console.log(elements)
  elements.forEach(element => {
    let attr = element.tagName === 'A' ? 'href' : 'path';
    let url = new URL(element.getAttribute(attr), window.location.origin);
    let params = new URLSearchParams(url.search);

    if (!params.has('token')) {
      params.set('token', token);
      url.search = params.toString();
      element.setAttribute(attr, url.toString());
    }
  })
}



// https://itsopensource.com/how-to-call-a-function-on-URL-change-in-javascript/
(function(history){
  var pushState = history.pushState;
  history.pushState = function(state) {
    addTokenToParams()
    return pushState.apply(history, arguments);
  };
})(window.history);


window.onload = () => {
  addTokenToParams()
  document.querySelectorAll('a').forEach(a => {
    a.addEventListener('click', event => {
      event.preventDefault();
      console.log(event, 'eventy')
      let params = window.location.search;
      let dest = a.getAttribute('href') + params;
      console.log(params, dest)
      setTimeout(() => {
        location.replace(dest)
      }, 100)
    })
  })
}

window.addEventListener('message', event => {
  if (typeof event.data === 'object' && event.data?.token) {
    const token = event.data.token;
    window.localStorage.setItem('token', token);
    eventQueue.push(token)
  }
})

let Hooks = {};

Hooks.AddToken = {
  mounted() {
    addTokenToParams()
  },
  destroyed(){
    addTokenToParams()
  },
  updated(){
    addTokenToParams()
  }
}

Hooks.GetToken = {
  mounted() {

    setInterval(() => {
      const token = eventQueue.shift();
      if (token) {
        console.log(token)

        this.pushEvent('update_token', {token})
      }
    }, 500)
  },
}

let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken, token: window.localStorage.getItem("token")}, hooks: Hooks});

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

