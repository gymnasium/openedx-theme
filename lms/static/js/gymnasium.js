/// File:         Gymnasium.js
/// Description:  library containing helper functions used on Gymnasium
/// Author:       @mbifulco

function Gymnasium() {}

Gymnasium.prototype.setBackgroundColorOfElementFromImage = function (
  element,
  image
) {
  var canvas = document.createElement("canvas");
  var myImg = document.createElement("img");

  $(image).each(function (i, imgObj) {
    myImg.src = imgObj.src;

    $(myImg).one("load", function () {
      var context = canvas.getContext("2d");
      context.drawImage(myImg, 0, 0);

      data = context.getImageData(1, 1, 1, 1).data;

      var r = data[0];
      var g = data[1];
      var b = data[2];
      var a = data[3];

      $(element).css(
        "background-color",
        "rgba(" + r + "," + g + "," + b + "," + a + ")"
      );
    });
  });
};

///get a URL parameter passed in with HTTP GET
///NOTE: this function is not case sensitive
Gymnasium.prototype.getUrlParameter = function getUrlParameter(sParam) {
  var sPageURL = decodeURIComponent(window.location.search.substring(1)),
    sURLVariables = sPageURL.split("&"),
    sParameterName,
    i;

  for (i = 0; i < sURLVariables.length; i++) {
    sParameterName = sURLVariables[i].split("=");

    if (sParameterName[0].toLowerCase() === sParam.toLowerCase()) {
      return sParameterName[1] === undefined ? true : sParameterName[1];
    }
  }
};

Gymnasium.prototype.injectFBTrackingPixel = function () {
  var trackingPix = $(
    '<noscript><img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=1074612282557779&ev=PageView&noscript=1" /></noscript>'
  );
  $("body").append(trackingPix);
  fbq("init", "1074612282557779");
  fbq("track", "PageView");
};

Gymnasium.prototype.RecordCourseEnrollment = function (
  firstName,
  lastName,
  emailAddress,
  courseId,
  callback
) {
  var data = {
    first_name: firstName,
    last_name: lastName,
    email: emailAddress,
    course: courseId,
    utm_campaign: courseId + " - Enrollment",
    carrot_type: "Gymnasium Enrollment",
    carrot_topic: "GYM-" + courseId,
    PROC: "AWUISubmitExternalLead",
  };
  Gymnasium.RecordCloudwallRecord(data, callback);
};

Gymnasium.prototype.RecordExamGrade = function (
  email,
  courseId,
  grade,
  callback
) {
  var data = {
    leadDestination: "cw-rc",
    email: email,
    score: grade,
    course_id: courseId,
    utm_campaign: courseId + " - Grade",
  };
  return Gymnasium.RecordCloudwallRecord(data, callback);
};

Gymnasium.prototype.RecordRegistration = function (
  emailAddress,
  firstName,
  lastName,
  cityId,
  callback
) {
  var data = {
    first_name: firstName,
    last_name: lastName,
    email: emailAddress,
    location: cityId,
    utm_campaign: "Registration",
    carrot_type: "Gymnasium Registration",
    carrot_topic: "GYM REG",
    PROC: "AWUISubmitExternalLead",
  };

  Intercom("trackEvent", "registration", data);
  return Gymnasium.RecordCloudwallRecord(data, callback);
};

Gymnasium.prototype.RecordCloudwallRecord = function (jsonData, callback) {
  jsonData.utm_source = "gymnasium.com";
  jsonData.utm_medium = "web";
  jsonData.utm_content = "not-provided";
  jsonData.utm_term = "not-provided";
  jsonData.agent_email = "gymleads@aquent.com";
  jsonData.agent_id = "1694600";
  jsonData.agent_name = "TALENT LEAD NURTURING";
  jsonData.carrot = "thegymnasium.com";
  jsonData.subdomain = CW_ENV;
  jsonData.language = "en_US";
  jsonData.medium = "1009";
  jsonData.referring_site = "thegymnasium.com";
  jsonData.status = "Talent";
  jsonData.referer = "thegymnasium.com";

  $.ajax("https://aquent.com/application/gymnasium-lead.htm", {
    contentType: "application/json",
    dataType: "jsonp",
    data: jsonData,
  })
    .done(function (event) {
      //console.log("Success!\n", event);
    })
    .fail(function (event, textStatus, errorThrown) {
      //console.log("Failure:\n", textStatus, "\n", errorThrown);
    })
    .always(function (e) {
      //console.log("always:\n", e);
      if (callback) {
        callback();
      }
    });
};

// <!-- Facebook Pixel Code -->
!(function (f, b, e, v, n, t, s) {
  if (f.fbq) return;
  n = f.fbq = function () {
    n.callMethod ? n.callMethod.apply(n, arguments) : n.queue.push(arguments);
  };
  if (!f._fbq) f._fbq = n;
  n.push = n;
  n.loaded = !0;
  n.version = "2.0";
  n.queue = [];
  t = b.createElement(e);
  t.async = !0;
  t.src = v;
  s = b.getElementsByTagName(e)[0];
  s.parentNode.insertBefore(t, s);
})(window, document, "script", "//connect.facebook.net/en_US/fbevents.js");
// <!-- End Facebook Pixel Code -->

var Gymnasium = new Gymnasium();
