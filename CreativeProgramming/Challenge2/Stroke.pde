//* Inspired by https://openprocessing.org/sketch/1294739 and adapted to make it work for java and my vision. (Brush Drawing - 王永進, n.d.)
// This version makes the interactivity like you are painting the picture yourself. 
// the drawback of it is, that the end result looks works compared to the balls class and it takes way more time
// to fill the entire canvas. I like the interactivity of this one more though. I edited the radius to be as big as possible and still be able to make out what is shown.
// I took some things from the sketch referenced above and adapated it with some things that I like in the Ball class like the opacity.
// It still take a long time to reveal the entire canvas, so that's why I went for two different painting modes. To make the Usability of the code better
//*
class Stroke {
  PVector location; // A PVector that stores the x and y coordinates of the stroke
  float radius; // The radius of the stroke
  color c; // The color of the stroke
  float xOff, yOff; // Offsets for the noise function
  float nX, nY; // Noise values for x and y
  float opacity; // added opacity so it becomes a better animation

  // The constructor for the Stroke class
  Stroke(float mouseX, float mouseY, color c) {
    location = new PVector(mouseX, mouseY); // Set the location to the mouse coordinates
    radius = random(25, 35); // Set the radius to a random value between 25 and 35
    this.c = c; // Set the color to the passed in color
    xOff = 0.0; // Initialize the x offset for the noise function
    yOff = 0.0; // Initialize the y offset for the noise function
    opacity = random(100); // random value for the opacity to make the animation better
  }




  void update() {
    radius -= random(0.5, 0.75); //How much the radius of the stroke deteriotates over time
    xOff += random(-.5, .5); // how much the the stroke moves from mouseX
    nX = noise(location.x) * xOff; // Create noise and multiply that so that the stroke will randomly move away from the line the mouse draws
    yOff += random(-.5, .5); // Factor of how much the stroke moves from mouseY
    nY = noise(location.y) * yOff; // Create noise and multiply that so that the stroke will randomly move away from the line the mouse draws
    location.x += nX; // update the x location with the amount of Noise created so that it moves away from the mouse line. This creates that vine shape after the mouse has been pressed and drawn
    location.y += nY; // update the y location with the amount of Noise created so that it moves away from the mouse line. This creates that vine shape after the mouse has been pressed and drawn
  }

  void changeColor() {
    c = img.get((int)location.x, (int)location.y); // get the color of the pixel in the spot of the stroke at that moment
  }

  void draw() {
    noStroke(); //No outlines please!
    fill(red(c), green(c), blue(c), opacity); //fill the circle at that point.
    ellipse(location.x, location.y, radius, radius); // draw circles for that nice impressionist aesthetic
  }
}
