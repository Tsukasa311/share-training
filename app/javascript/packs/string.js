let num = 0;
function string(){
  const target = document.getElementById("title");
  HTML1 = 'トレーニングを\n　　見つけよう';
  HTML2 = 'トレーニングを\n　　共有しよう';
  HTML3 = 'トレーニングを\n　　記録しよう';
  const array = new Array(HTML1,HTML2,HTML3);
  
  if( num == 2) {
    num = 0;
  }else{
    num ++;
  }

  target.innerText = array[num];
  target.animate({
    opacity: [0, 1]
  }, 1600)

  const fadeOut = () => {
    target.animate({
      opacity: [1, 0]
    }, 300)
  }

  setTimeout(fadeOut, 5700)
}

setInterval(string, 6000);
