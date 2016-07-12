$(document).ready(function() {
    var db = new localStorageDB("flight_db", localStorage);
    var form_data = $("#search_flight_form").serialize();
    if (db.isNew()) {
        $.get("/search", form_data).then(function(res) {
        		console.log(res);
            db.createTableWithData("flights", res);
        });
    } else {
        console.log("Local storage is already set");
    }
});
