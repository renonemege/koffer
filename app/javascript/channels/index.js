// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)


const baseUrl = "https://api.teleport.org/api/";




// const getCity = () => {
//   const results = document.querySelector("#results");
//   fetch("https://api.teleport.org/api/")
//     .then(response => response.json())
//     .then((data) => {
//       console.log(data);
//       // data.forEach((result) => {
//       //   const city = `<li class="list-inline-item">
//       //     <p>${result.summary}</p>
//       //   </li>`;
//       //   results.insertAdjacentHTML("beforeend", city);
//       // });
//     });
// };
// export { getCity };

