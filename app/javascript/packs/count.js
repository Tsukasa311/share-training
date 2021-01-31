function count () {
  const countText = document.getElementById("text_counting")
  const inputForm = document.getElementById("text_area_id")
  inputForm.addEventListener("keyup", () => {
    const countVal = inputForm.value.length
    if (countVal >= 210) {
      countText.setAttribute("style", "color: red;")
    } else if(countVal >= 180) {
      countText.setAttribute("style", "color: orange;")
    } else {
      countText.removeAttribute("style")
    }
    countText.innerHTML = `${countVal}文字`;
  });
}

window.addEventListener("load",count);