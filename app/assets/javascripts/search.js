var db = localStorageDB("flight_db");
var flights;
var current_page = 1;

var searchFlight = function(allFlights = false) {
    if (allFlights) {
        flights = getFlights();
    } else {
        var form_data = form_obj($("#search_flight_form").serializeArray());
        var result = "";
        if ($.isEmptyObject(form_data)) {
            flights = [];
        } else {
            flights = getFlights(form_data);
        }
    }
    $("#result_count").html(flights.length);
    paginate(1, flights);
    $(".ui.modal.flight-search-modal").modal("show");
    return false;
};

var getFlights = function(query = {}) {
    if ($.isEmptyObject(query)) {
        return db.queryAll("flights", {
            query: function(row) {
                if (new Date(row.departure_date) > new Date()) {
                    return true;
                } else {
                    return false;
                }
            }
        });
    } else {
        return db.queryAll("flights", { query: query });
    }
}

var paginate = function(page, data) {
    page = page || 1;
    data = data || flights;
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
            return "<a class='item p-link' onclick='paginate(" + (current_page - 1) + ");'>Previous</a>";
        });
    }
    if (limit < data.length) {
        pagin.append(function() {
            return "<a class='item p-link' onclick='paginate(" + (current_page + 1) + ");'>Next</a>";
        });
    }

    $("#flights_results > table > tbody").empty();
    if ($.isEmptyObject(data)) {
        $("#flights_results > table > tbody").append(function() {
            return "<tr><td colspan='6'><h1 class='ui center aligned'>No flight(s) found</h1></td></tr>";
        });
    } else {
        for (var i = offset; i < limit; i += 1) {
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
        }
    }
};

var booking_button = function(id) {
    var path = "/user/booking/book/" + id;
    var button = "<a href='" + path + "' class='ui basic button m-button book-btn'><i class='book icon'></i>Book</a>";
    return button;
};

var form_obj = function(data) {
    var output = {};
    for (var i = 1; i < data.length; i++) {
        if (data[i].value.length > 0) {
            var key = slice_word(data[i].name);
            output[key] = data[i].value;
        }
    }
    return output;
};

var slice_word = function(word) {
    return word.slice(6, -1);
};

var table_cell = function(value) {
    return "<td>" + value + "</td>";
};

var formCheck = function(elem) {
    var dloc = $("[name='query[departure_location]']");
    var aloc = $("[name='query[arrival_location]']");
    if ((dloc.val().length > 0 && aloc.val().length > 0) && (dloc.val() == aloc.val())) {
        $('.cookie.nag').nag('show');
    }
}

$("#help_icon").popup({
    position: "bottom center"
});
