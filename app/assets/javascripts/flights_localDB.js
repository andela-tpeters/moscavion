$(document).ready(function() {
    var db = new localStorageDB("flight_db", localStorage);
    var form_data = $("#search_flight_form").serialize();
    $.get("/search", form_data).then(function(res) {
        db.createTableWithData("flights", res);
    });
    console.log("Local storage is set");
});
