window.addEventListener("trix-file-accept", (event) => {
  event.preventDefault();
  alert("File attachment is not supported with this editor for now. Please configure Active Storage first.");
});
