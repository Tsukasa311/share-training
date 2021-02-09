function fixed() {
  const target = document.getElementById('is_fixed');
  let winTop = window.pageYOffset;

  if (winTop > 125){
    target.classList.add('fixed');
  } else if (winTop < 125){
    target.classList.remove('fixed')
  }
}

window.addEventListener('scroll',fixed);