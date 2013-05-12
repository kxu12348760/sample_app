# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
    if $('#micropost_content').length > 0
      updateCountdown();
      $('#micropost_content').change(updateCountdown);
      $('#micropost_content').keyup(updateCountdown);

updateCountdown = () ->
    numCharactersRemaining = 140 - $('#micropost_content').val().length;
    if numCharactersRemaining < 0
        $('#numCharacters').text('You can\'t input more than 140 characters');
        $('#numCharacters').addClass('error_text');
    else
        characterString = if numCharactersRemaining == 1 then ' character' else ' characters'
        $('#numCharacters').text(numCharactersRemaining.toString() + characterString + ' remaining');
        $('#numCharacters').removeClass('error_text');
