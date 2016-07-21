$ ->
	$("#change_flight").on "change", ->
		result = localStorageDB("flight_db").queryAll("flights",query: {id: $(this).val()})
		console.log result