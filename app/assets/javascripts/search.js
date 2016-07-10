var db = localStorageDB("flight_db");
var flights;
var current_page = 1;
$(document).on("click", "#search_flight", function() {
    var form_data = form_obj($("#search_flight_form").serializeArray());
    var def = $.Deferred();
    var result = "";
    if ($.isEmptyObject(form_data)) {
        flights = db.queryAll("flights");
    } else {
        flights = db.queryAll("flights", { query: form_data });
    }
    $("#result_count").html(flights.length);
    paginate(1, flights);
    $(".ui.modal").modal("show");
});

var paginate = function(page = 1, data = flights) {
    if (current_page == 0) {
        current_page = 1;
    } else {
        current_page = page;
    }
    var perPage = 100;
    var pages = Math.ceil(data.length / perPage);
    var limit = data.length > perPage ? (page * perPage) : data.length;
    var offset = (page - 1) * perPage;
    var pagin = $(".flight_result_pagination");
    pagin.empty();


    if (page > 1) {
        pagin.append(function() {
            var link = "";
            link += "<a class='item p-link' onclick='paginate(" + (current_page - 1) + ");'>\
                  Previous</a>";
            return link;
        });
    }
    if (limit < data.length) {
        pagin.append(function() {
            var link = "";
            link += "<a class='item p-link' onclick='paginate(" + (current_page + 1) + ");'>\
                  Next</a>";
            return link;
        });
    }

    $("#flights_results > table > tbody").empty();
    for (var i = offset; i < limit; i++) {
        var flight_data = "";
        if (!$.isEmptyObject(data[i])) {
            $("#flights_results > table > tbody").append(function() {
                flight_data += table_cell(data[i].id);
                flight_data += table_cell(data[i].departure_location);
                flight_data += table_cell(data[i].arrival_location);
                flight_data += table_cell(new Date(data[i].departure_date).toLocaleString());
                flight_data += table_cell("$ " + data[i].price);
                flight_data += table_cell(booking_button(data[i].id));
                return "<tr>" + flight_data + "</tr>";
            });
        }
    };


}

var booking_button = function(id) {
    var button = "<a href='#" + id + "' class='ui basic button m-button'><i class='book icon'></i>Book</a>";
    return button;
}

var form_obj = function(data) {
    var output = {};
    for (var i = 1; i < data.length; i++) {
        if (data[i].value.length > 0) {
            var key = slice_word(data[i].name);
            output[key] = data[i].value;
        }
    }
    return output;
}

var slice_word = function(word) {
    return word.slice(6, -1);
}

var table_cell = function(value) {
    return "<td>" + value + "</td>";
}
