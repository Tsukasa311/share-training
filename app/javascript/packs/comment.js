// function comment () {
//   const sumbit = document.getElementById("comment_submit");
//   const postId = document.getElementById("add_comment").getAttribute("data-id");
//     sumbit.addEventListener("click", (e) => {
//       const formData = new FormData(document.getElementById("comment_form_js"));
//       const XHR = new XMLHttpRequest();
//       XHR.open("POST", `/posts/${postId}/comments`, true);
//       XHR.responseType = "json";
//       XHR.send(formData);
//       XHR.onload = () => {
//         if (XHR.status != 200 ) {
//           alert(`Error ${XHR.status}: ${XHR.statusText}`);
//           return null;
//         }
//         const item = XHR.response.comment;
//         const list = document.getElementById("add_comment");
//         const formText = document.getElementById("comment_content");
//         const HTML = `
//                 <div class= "comment">
//                   ${item.text}
//                 </div>`;
//         list.insertAdjacentHTML("afterend", HTML);
//         formText.value = "";
//       };
//       e.preventDefault();
//     });
// }

// window.addEventListener("load", comment);