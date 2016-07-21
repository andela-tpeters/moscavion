# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	password = $('#user_password')
	confirm = $('#user_password_confirm')
	submit = $("#signup-submit")

	@confirmPassword = ->
		if confirm.val() == password.val()
			confirm.get(0).setCustomValidity ""
			submit.removeClass "disabled" 
		else
			confirm.get(0).setCustomValidity "Passwords dont match"
			submit.addClass "disabled"

