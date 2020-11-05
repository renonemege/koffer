// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
var $ = require( "jquery" )
require("slick-carousel")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// const typeformEmbed = require('@typeform/embed')
// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports

import "bootstrap";
// import 'select2';
// import * as typeformEmbed from '@typeform/embed'
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initMapbox } from '../plugins/init_mapbox';
import { initChatroomCable } from '../channels/chatroom_channel';
import { initHome } from '../plugins/init_home';
import { initWeather } from '../plugins/init_weather';
import { initWizard } from '../plugins/init_wizard';
import { initSlideshow } from '../plugins/init_slideshow';
import { initSelect2 } from '../plugins/init_select2';


document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  initSelect2();
  initMapbox();
  initHome();
  initWeather();
  initWizard();
  $('.scroller').slick();
  initSlideshow();
  initChatroomCable();
});




