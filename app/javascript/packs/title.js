let num = 0;
function title() {
  const title = document.getElementById("title");
  const array = new Array("darkblue","darkOrange","yellow");

  if (num == 2) {
    num = 0;
  }else {
    num ++;
  }
  
  title.style.color = array[num];
}

setInterval(title, 6000);