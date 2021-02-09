let num = 0
function slideTimer() {
  const homeTop = document.getElementById("home");
  const classLists = new Array("home_top1","home_top2","home_top3")

  if (num == 2) {
    num = 0;
  }else {
    num ++;
  }
  
  homeTop.className = classLists[num];
}

setInterval(slideTimer, 6000);