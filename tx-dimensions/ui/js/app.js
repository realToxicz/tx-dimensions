$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
    // Al pulsar ESC cierra el menu
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://elite-mundos/exit', JSON.stringify({}));
            return
        }
    };
    // Boton cerrar
    $("#close").click(function () {
        $.post('https://elite-mundos/exit', JSON.stringify({}));
        return
    })
    //Boton Select Inicio
    $("#mundo0").click(function () {
        $.post('https://elite-mundos/mundo0', JSON.stringify({
        }));
        return;
    })
    //Boton Select 1
    $("#mundo1").click(function () {
        $.post('https://elite-mundos/mundo1', JSON.stringify({
        }));
        return;
    })
    //Boton Select 2
    $("#mundo2").click(function () {
        $.post('https://elite-mundos/mundo2', JSON.stringify({
        }));
        return;
    })
})
