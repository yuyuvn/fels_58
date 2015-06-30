jQuery ->
  $(".audio-button").on "click", ->
    audio = $(this).nextAll("audio:first")[0]
    audio.currentTime = 0
    audio.play()
    return false
