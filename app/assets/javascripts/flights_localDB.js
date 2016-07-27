$(document).ready(function() {
    var db = new localStorageDB("flight_db", localStorage);
    if (db.tableExists("flights")) {
    	db.dropTable("flights");
    	console.log("Flights Table dropped");
    }
    var form_data = $("#search_flight_form").serialize();
    $.get("/search", form_data).then(function(res) {
        db.createTableWithData("flights", res);
        db.commit();
    });
    console.log("Flights Tables set");
});
