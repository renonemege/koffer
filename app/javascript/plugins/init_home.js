
const initHome = () => {
  const colors = ['#151514','#151514','#F2C94C'];
  const numLines = 3;
  var currCount = numLines;
  const texts = document.querySelectorAll("#textClip text");
  if (!texts) {
      return;
    }
  const blobs = document.querySelectorAll("#background path");

  function colorBlobs() {
      blobs.forEach(blob => {
          blob.style.fill = colors[Math.floor(Math.random() * colors.length)];
      });
  }

  function nextIteration() {
      // Change the color of all the blobs
      colorBlobs();

      // Hide the old set of lines
      let startVal = currCount - numLines;
      if(startVal < 0) {
          startVal = texts.length - numLines;
      }
      for(let i = startVal; i < startVal + numLines; i++) {
          texts[i].style.display = "none";
      }
      // Show new set of lines
      for(let j = currCount; j < currCount + numLines; j++) {
          texts[j].style.display = "inline";
      }
      currCount += numLines;
      if(currCount >= texts.length) {
          currCount = 0;
      }
  }

  // Since all of our blobs are using the same animation, we only
  // need to listen to one of them
  blobs[0].addEventListener("animationiteration", nextIteration);

  colorBlobs();
  };

export { initHome };
