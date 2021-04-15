import { placesAutocomplete } from "../plugins/places_autocomplete";
import { leafletMap } from "../plugins/leaflet_map";

document.addEventListener("turbolinks:load", () => {
  const appId = process.env.PLACES_APP_ID;
  const apiKey = process.env.PLACES_API_KEY;
  placesAutocomplete(appId, apiKey);
  leafletMap();
  $('[data-toggle="tooltip"]').tooltip();
});

window.addEventListener("trix-file-accept", (event) => {
  event.preventDefault();
  alert("File attachment not supported!");
});
