# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.Questions =
  preview: (body) ->
    $("#preview").text "Loading..."

    $.post "/questions/preview",
      "body": body,
      (data) ->
        $("#preview").html data.body
      "json"
      
  hookPreview: (switcher, textarea) ->
    # put div#preview after textarea
    preview_box = $(document.createElement("div")).attr "id", "preview"
    preview_box.addClass("body")
    $(textarea).after preview_box
    preview_box.hide()

    $(".edit a",switcher).click ->
      $(".preview",switcher).removeClass("active")
      $(this).parent().addClass("active")
      $(preview_box).hide()
      $(textarea).show()
      false
    $(".preview a",switcher).click ->
      $(".edit",switcher).removeClass("active")
      $(this).parent().addClass("active")
      $(preview_box).show()
      $(textarea).hide()
      Questions.preview($(textarea).val())
      false

  answerCallback: (success, msg) ->
    if success
      Util.notice(msg, '#new_answer')
    else
      Util.alert(msg, '#new_answer')
      
          

$(document).ready ->
  $("#question_add_image").on "click", () ->
    $("#question_upload_images").click()
    return false
  $(".comment label").on "click", () ->
    $(this).hide().next(".comment-form").show()
  $(".comment-form a").on "click", () ->
    $(this).closest(".comment-form").hide().closest(".comment").find("label").show()
    
  Questions.hookPreview($(".editor_toolbar"), $(".questions_editor"))
  return
