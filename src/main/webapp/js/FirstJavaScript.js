function btnBand() {
    var stri = document.getElementById("user_text").value;
    var str = "欢迎" + stri + "!\n";
    alert(str);

    var form1 = document.getElementById("input_form");
    // var btn = document.getElementById("btn");
    // var input = document.getElementById("user_text");
    // var lab = document.getElementById("lab1")
    // form1.removeChild(btn);
    // form1.removeChild(input);
    // form1.removeChild(lab);

    form1.innerHTML = "";
    var name = document.createElement("h2");
    name.id = "user";
    name.name = stri;
    name.innerText = stri + isMorning() + "好!";

    var time_lab = document.createElement("input");
    time_lab.type = "text";
    time_lab.id = "time_label";
    time_lab.value = new Date().toLocaleTimeString();

    form1.appendChild(name);
    form1.appendChild(time_lab);

    setTime();
};

// function removeEle(msg) {
//     msg.innerHTML = "";
// }
//
// function addDate(msg) {
//     var time = document.createElement("div");
//     time.value = new Date().toLocaleTimeString();
//     msg.appendChild(time);
// }

function setTime() {
    document.getElementById("time_label").value = new Date().toLocaleTimeString();
    setTimeout("setTime()", 1000);
}

function isMorning() {
    return new Date().toLocaleTimeString().replace(/\d|[:]/g, "");
}