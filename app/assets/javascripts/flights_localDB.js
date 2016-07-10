$(document).ready(function() {
    let db = new localStorageDB("flight_db", sessionStorage);
    let form_data = $("#search_flight_form").serialize();
    if (db.isNew()) {
        $.get("<%= search_path %>", form_data).then(function(res) {
            db.createTableWithData("flights", res);
        });
    } else {
        console.log("Local storage is already set");
    }
});
