$(window).load(function() {
    var db = new localStorageDB("flight_db", localStorage);
    if (db.tableExists("flights")) {
      db.dropTable("flights");
      console.log("Flights Table dropped");
    }
    var q = "utf8=%E2%9C%93&query%5Bdeparture_location%5D=&query%5Barrival_location%5D=&query%5Bdeparture_date%5D="
    $.get("/search", q).then(function(res) {
        db.createTableWithData("flights", res);
        db.commit();
    });
    console.log("Flights Tables set");
});
