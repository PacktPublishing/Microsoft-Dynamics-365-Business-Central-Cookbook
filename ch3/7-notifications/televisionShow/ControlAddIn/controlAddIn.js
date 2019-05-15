function SetTelevisionShow(TelevisionShow) {
    var controlAddIn = document.getElementById('controlAddIn');
    controlAddIn.innerHTML =
        "<div class=\"showName\">" + TelevisionShow.name + "</div>";

    if (TelevisionShow.url != "") {
        controlAddIn.innerHTML +=
            "<br><input align=center type='button' class=\"myButton\" onclick=\"parent.open('" + TelevisionShow.url + "')\" value=\"Search TVDB\"/>";
    }
}