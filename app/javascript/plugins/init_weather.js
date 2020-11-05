// const baseUrl = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}";
const initWeather = () => {
  const stickyCard = document.getElementById("sticky-card");
    if (stickyCard) {
      const city = document.querySelector("#city").innerHTML;
      const date = document.querySelector("#date");
      const condition = document.querySelector("#condition");
      const celcius = document.querySelector("#celcius");
      const icon = document.querySelector("#icon-weather");
      const img = document.createElement('img');
      fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=61a7e230f70139f2153a3e93945427ba&units=metric`)
        .then(response => response.json())
        .then((data) => {
          console.log(data);
          date.innerText = `${new Date().toDateString()}`;
          condition.innerText = `${data.weather[0].description}`;
          img.src = `https://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png`
          icon.appendChild(img);
          celcius.innerText = `${data.main.temp}°C`;
      });
    };
};
export { initWeather };


// const stickyCard = document.getElementById("sticky-card");
//     if (stickyCard) {
//       stickyCard.addEventListener("load", getCityByName());
//     };
