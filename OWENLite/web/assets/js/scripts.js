$(document).ready(function () {
    $('.collapse.in').prev('.panelHeading').addClass('active');
    $('#accordion, #bs-collapse')
            .on('show.bs.collapse', function (a) {
                $(a.target).prev('.panelHeading').addClass('active');
            })
            .on('hide.bs.collapse', function (a) {
                $(a.target).prev('.panelHeading').removeClass('active');
            });

    $(".question").hover(function () {
        $(this).toggleClass("mdl-shadow--3dp");
    });

    $(".score td").on("click", function () {
        $(".meScore .radioButtons label").removeClass("is-checked");
        $('.meScore .radioButtons label[for*=' + $(this).text() + ']').addClass("is-checked");
    });

    $(".mood td").on("click", function () {
//        console.log($(this).text());
        $(".moodScore .radioButtons label").removeClass("is-checked");
        $('.moodScore .radioButtons label[for*='+ $(this).text() +']').addClass("is-checked");
    });
});