function importOmnis() {
  if (document.querySelectorAll('section[data-member-id]').length === 1) {
    chrome.storage.sync.get({
      token: '',
      api: ''
    }, function (items) {
      document.querySelector('#top-card-text-details-contact-info').click();

      const api = items.api;
      let profile = {
        token: items.token,
        name: document.querySelector('section[data-member-id] h1').textContent.replace(/([\uE000-\uF8FF]|\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDDFF])/g, ''),
        contacts: {
        }
      };

      let title = document.querySelector('section[data-member-id] .pv-text-details__left-panel div.text-body-medium.break-words')?.textContent?.split(' at ')[0].replaceAll('\n', '');
      while (title.indexOf('  ') > -1) {
        title = title.replaceAll('  ', '');
      }
      if (title && title[0] === ' ') {
        title = title.substring(1);
      }
      if (title) {
        profile.title = title;
      }

      //email
      if (document.querySelectorAll('section.pv-contact-info__contact-type.ci-email a').length) {
        let email = document.querySelectorAll('section.pv-contact-info__contact-type.ci-email a')[0].href;
        email = email.replace('mailto:', '');
        if (email) {
          profile.contacts.email = email;
        }
      }
      //phone
      if (document.querySelectorAll('section.pv-contact-info__contact-type.ci-phone').length) {
        let phone = document.querySelectorAll('section.pv-contact-info__contact-type.ci-phone ul li.pv-contact-info__ci-container span')[0].textContent;
        phone = phone.replaceAll(' ', '').replaceAll('\n', '');
        if (phone) {
          profile.contacts.phone = phone;
        }
      }
      //linkedin
      if (document.querySelectorAll('section.pv-contact-info__contact-type.ci-vanity-url a').length) {
        let linkedin = document.querySelectorAll('section.pv-contact-info__contact-type.ci-vanity-url a')[0].href;
        if (linkedin) {
          profile.contacts.linkedin = linkedin;
        }
      }
      //twitter
      if (document.querySelectorAll('section.pv-contact-info__contact-type.ci-twitter a').length) {
        let twitter = document.querySelectorAll('section.pv-contact-info__contact-type.ci-twitter a')[0].href;
        if (twitter) {
          profile.contacts.twitter = twitter;
        }
      }
      document.querySelector('button[data-test-modal-close-btn]').click();

      (async () => {
        const rawResponse = await fetch(api, {
          method: 'POST',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(profile)
        });
        const content = await rawResponse.json();
        console.log(content);
      })();
    });
  }
}

chrome.action.onClicked.addListener((tab) => {
  if (tab.url.includes("https://www.linkedin.com/")) {
    chrome.scripting.executeScript({
      target: { tabId: tab.id },
      function: importOmnis
    });
  }
});