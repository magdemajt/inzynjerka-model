// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"
import Chart from "chart.js/auto";


const BACKGROUND_COLOR = [
  'rgba(255, 99, 132, 0.2)',
  'rgba(255, 159, 64, 0.2)',
  'rgba(255, 205, 86, 0.2)',
  'rgba(75, 192, 192, 0.2)',
  'rgba(54, 162, 235, 0.2)',
  'rgba(153, 102, 255, 0.2)',
  'rgba(201, 203, 207, 0.2)',
  'rgba(255, 99, 132, 0.2)',
  'rgba(255, 159, 64, 0.2)',
  'rgba(255, 205, 86, 0.2)',
  'rgba(75, 192, 192, 0.2)',
  'rgba(54, 162, 235, 0.2)',
  'rgba(153, 102, 255, 0.2)',
  'rgba(201, 203, 207, 0.2)',
  'rgba(255, 99, 132, 0.2)',
  'rgba(255, 159, 64, 0.2)',
  'rgba(255, 205, 86, 0.2)',
  'rgba(75, 192, 192, 0.2)',
  'rgba(54, 162, 235, 0.2)',
]
const BORDER_COLOR = [
  'rgb(255, 99, 132)',
  'rgb(255, 159, 64)',
  'rgb(255, 205, 86)',
  'rgb(75, 192, 192)',
  'rgb(54, 162, 235)',
  'rgb(153, 102, 255)',
  'rgb(201, 203, 207)',
  'rgb(255, 99, 132)',
  'rgb(255, 159, 64)',
  'rgb(255, 205, 86)',
  'rgb(75, 192, 192)',
  'rgb(54, 162, 235)',
  'rgb(153, 102, 255)',
  'rgb(201, 203, 207)',
  'rgb(255, 99, 132)',
  'rgb(255, 159, 64)',
  'rgb(255, 205, 86)',
  'rgb(75, 192, 192)',
  'rgb(54, 162, 235)',
]


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

window.addEventListener('message', event => {
  if (typeof event.data === 'object' && event.data?.token) {
    const token = event.data.token;
    window.localStorage.setItem('token', token);
    eventQueue.push(token)
  }
})

let Hooks = {};

Hooks.MostFrequently = {
  mounted() {
    const ctx = this.el
    ctx.style.maxHeight = '700px'; // Set the maximum height of the chart
    const data = {
      type: 'bar',
      data: {
        labels: [],
        datasets: [{data: [], label: 'Most Frequently Asked Questions', backgroundColor: BACKGROUND_COLOR, borderColor: BORDER_COLOR, }]
      }};

    const chart = new Chart(ctx, data);
    this.handleEvent('most-frequently', (payload) => {
      chart.data.labels = payload.most_frequently.map(({content}) => content);
      chart.data.datasets[0].data = payload.most_frequently.map(({count}) => count);
      chart.update();
    })
  },
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