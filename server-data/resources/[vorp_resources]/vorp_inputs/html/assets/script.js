$(function () {
  window.addEventListener("message", function (event) {
    if (event.data.type == "enableinput") {
      const data = event.data;
      document.body.style.display = data.style;

      let inputEle = document.getElementById("inputUser");
      const inputHeaderEle = document.getElementById("inputHeader");
      const buttonEle = document.getElementById("submitButton");
      var inputContainer = document.getElementById("vorpSingleInput");
      var textareaContainer = document.getElementById("vorpTextarea");

      inputHeaderEle.style.display = "none";

      if (data.style == "block") {
        buttonEle.innerHTML = data.button;
        inputEle.placeholder = data.placeholder;
        inputEle.value = data?.attributes?.value ?? "";

        if (data.inputType == "textarea") {
          textareaContainer.style.display = "unset";
          inputContainer.style.display = "none";
          inputEle = document.getElementById("inpTextarea");
        } else if (data.inputType == "input") {
          textareaContainer.style.display = "none";
          inputContainer.style.display = "inline";
        }

        for (const key in data?.attributes) {
          if (key === "inputHeader") {
            inputHeaderEle.innerHTML = data.attributes[key];
            inputHeaderEle.style.display = "block";
          } else {
            inputEle.setAttribute(`${key}`, `${data.attributes[key]}`);
          }
        }
      }

      if (data.inputType == "textarea") {
        $("#inpTextarea").focus();
      } else {
        $("#inputUser").focus();
      }
    }
  });

  document.onkeyup = function (data) {
    if (data.which == 27) {
      // Escape key
      $.post(
        "http://vorp_inputs/close",
        JSON.stringify({
          stringtext: "close",
        })
      );
    }
  };

  $("#closeButton").click(function () {
    $.post(
      "http://vorp_inputs/close",
      JSON.stringify({
        stringtext: "close",
      })
    );
  });

  $("#formInputs").submit(function (event) {
    //event.preventDefault(); // Prevent form from submitting

    let fieldValue = $("#inputUser").val();

    if ($("#vorpTextarea").is(":visible")) {
      fieldValue = $("#inpTextarea").val();
    }

    $.post(
      "http://vorp_inputs/submit",
      JSON.stringify({
        stringtext: fieldValue,
      })
    );
  });
});
