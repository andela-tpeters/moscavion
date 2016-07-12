var confirmation = function() {
    if (!$(".submit-button").hasClass("disabled")) {
        $(".submit-button").addClass("disabled");
    }
    $("#passengers-info-list").empty();
    var nestedFields = $(".nested-fields");
    for (var i = 0; i < nestedFields.length; i++) {
        var inputs = nestedFields.eq(i).find(".field input");
        var item = $("<div />", { class: "item" });
        var content = $("<div />", { class: "content" });
        var header = $("<div />", { class: "header" });
        header.html(function() {
            var name = inputs[0].value + " " + inputs[1].value;
            return name;
        });
        content.append(header);
        content.append(inputs[2].value);
        item.append(content);
        $("#passengers-info-list").append(item);
    }
    $(".confirmation-modal").modal("show");
}
var closeModal = function() {
    $(".confirmation-modal").modal("hide");
}
var activateSubmit = function() {
    $(".submit-button").removeClass("disabled");
    closeModal();
}
var disableSubmit = function() {
    if (!$(".submit-button").hasClass("disabled")) {
        $(".submit-button").addClass("disabled");
    }
}
