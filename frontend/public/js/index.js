var tweets = {};
var tweet_template = '';

$(document).ready(function() {
  $('#topicButton').click(function() {
    setupTemplate();
    askForMore();
  })
});

function setupTemplate() {
  tweet_template = Handlebars.compile($('#tweet_template').html());
}

function merge_and_redraw(received_tweets) {
  if (!received_tweets || received_tweets.length == 0) {
    alert('No tweets on this.');
    return;
  }
  merge(received_tweets);
  redraw();
}

function askForMore() {
  $.ajax({
    dataType: "json",
    url: 'http://' + window.location.hostname + ':3030/api/v1/tweets',
    data: { topic: $('#topic').val() },
    success: merge_and_redraw
  });
}

function merge(received_tweets) {
  if (!tweets[$('#topic').val()]) {
    tweets[$('#topic').val()] = {};
  }
  for (var i = 0; i < received_tweets.length; i++) {
    var tweet = received_tweets[i];
    if (!tweets[$('#topic').val()][tweet.twitterid]) {
      tweets[$('#topic').val()][tweet.twitterid] = tweet;
    }
  }
}

function redraw() {
  clear_tweets();
  draw_tweets();
}

function clear_tweets() {
  $('div.twitter').remove();
}

function draw_tweets() {
  var tweets_for_rendering = [];
  for (var key in tweets[$('#topic').val()]) {
    tweets_for_rendering.push(tweets[$('#topic').val()][key]);
  }
  $('hr#start').append(tweet_template({tweets: tweets_for_rendering}));
}
