function importOmnis() {
  if (document.querySelectorAll('section[data-member-id]').length === 1) {
    debugger;
    let profile = {
      name: document.querySelector('section[data-member-id] h1').textContent
    };
    console.log(profile);
  }
  console.log('hello');
}

chrome.action.onClicked.addListener((tab) => {
  if (!tab.url.includes("chrome://")) {
    chrome.scripting.executeScript({
      target: { tabId: tab.id },
      function: importOmnis
    });
  }
});