let num = -1
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

window.addEventListener('load',slideTimer);
setInterval(slideTimer, 6000);