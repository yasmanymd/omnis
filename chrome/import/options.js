// Saves options to chrome.storage
function save_options() {
  var api = document.getElementById('api').value;
  var token = document.getElementById('token').value;
  chrome.storage.sync.set({
    api: api,
    token: token
  }, function () {
    // Update status to let user know options were saved.
    var status = document.getElementById('status');
    status.textContent = 'Options saved.';
    setTimeout(function () {
      status.textContent = '';
    }, 750);
  });
}

function restore_options() {
  chrome.storage.sync.get({
    api: '',
    token: ''
  }, function (items) {
    document.getElementById('api').value = items.api;
    document.getElementById('token').value = items.token;
  });
}
document.addEventListener('DOMContentLoaded', restore_options);
document.getElementById('save').addEventListener('click', save_options);