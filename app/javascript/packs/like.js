// function like() {
//   const likeSubmits = document.querySelectorAll(".like_btn")
//   likeSubmits.forEach( (submit) => {
//     submit.addEventListener("mouseover", () => {
//       const postId = submit.getAttribute("data_id");
//       const XHR = new XMLHttpRequest();
//       XHR.open("POST", "/posts/postId/likes", true);
//       XHR.responseType = "json";
//       XHR.send();
//       XHR.onload = () => {
//         if (XHR.status != 200 ) {
//           alert(`Erroe ${XHR.status}: ${XHR.statusText}`);
//           return null;
//         }

//       }
//     })
//   });
// }

// window.addEventListener("load", like);

