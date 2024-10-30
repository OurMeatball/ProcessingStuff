//* More automatic function and the end result looks better in my opinion
// Got this idea from https://openprocessing.org/sketch/1309535, (Random Impressionism Vibe Dog - Hugo Wu, n.d.) 
// I did not really change anything from the javascript version, I only converted it java
// The reason for why I used it. Is because it looks very good and the Usability of the Mode is better than the Stroke.
// The thing I changed from the original is the way the canavas is set up, because in the original the canvas would sometimes have black parts. Due to the image being than the canvas set up
// The class is very similar to the stroke class, they just use different values
//*
class Ball {
  PVector location; // A PVector that stores the x and y coordinates of the stroke
  float radius; // The radius of the stroke
  color c; // The color of the stroke
  float xOff, yOff; // Offsets for the noise function
  float nX, nY; // Noise values for x and y
  float opacity; // added opacity so it becomes a better animation

  Ball() {
    location = new PVector(mouseX, mouseY); // Set the location to the mouse coordinates
    radius = random(5, 20); //set the radius to a random value between 5 and 20 
    c = img.get((int)location.x, (int)location.y); // Get the color on the mouse loaction at the moment 
    xOff = 0.0; // Initialize the x offset for the noise function
    yOff = 0.0; // Initialize the y offset for the noise function
    opacity = random(100); // random value for the opacity to make the animation better
  }

  void update() {
    radius -= random(0.001, 0.015); //How much the radius of the stroke deteriotates over time
    xOff = xOff + random(-0.05, 0.05); // how much the the stroke moves from mouseX
    float nX = noise(location.x) * xOff; // Create noise and multiply that so that the stroke will randomly move away from the line the mouse draws
    yOff = yOff + random(-0.05, 0.05); // Factor of how much the stroke moves from mouseY
    float nY = noise(location.y) * yOff; // Create noise and multiply that so that the stroke will randomly move away from the line the mouse draws
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
