jQuery ->
  $(".answer-form").hide()
  $(".answer-form").first().show()
  total_question = parseInt($("#total").html())
  $(".answer-button input").click ->
    question_no = parseInt($("#answer_count").html())+1
    if question_no <= total_question
      $("#answer_count").html(question_no)
      current_question = $(this).closest(".answer-form")
      current_question.hide()
      current_question.nextAll(".answer-form:first").show()
    else
      $("#question_form").submit()
  $(".answer-button input:checked").each ->
    $(this).click()