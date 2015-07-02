jQuery ->
  $(".audio-button").on "click", (event)->
    event.preventDefault()
    audio = $(this).nextAll("audio:first")[0]
    audio.currentTime = 0
    audio.play()
