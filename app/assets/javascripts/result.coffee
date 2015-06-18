$(".audioButton").on "click", ->
  $(".audio-play")[0].currentTime = 0
  $(".audio-play")[0].play()