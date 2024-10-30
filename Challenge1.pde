//**********************************************************************************************************************************************************************************************************
//This work was inspired by Bowhowz by -RobA> (aka Cartocopia), which I definetely recommend you check out because the result and the code are both very interesting. It is written in javascript however. 
// So it is not that relevant for the course, but I still thought it was interesting.
//Bowhowz - -RobA> (aka Cartocopia). (n.d.). https://openprocessing.org/sketch/2165806
//I used Bing-Ai was used to clean up the code and to come up with ideas on how to randomise the colors within a color palette. I also used it to make me different color palettes with their hexcodes.
//The central circle I took from the inspired work, since I could not find a way myself. 
// The font I used is called Baumans created by Henadij Zarechnjuk. 
//Fonts. (2016, May 18). Baumans Font · 1001 fonts. 1001 Fonts. https://www.1001fonts.com/baumans-font.html
//************************************************************************************************************************************************************************************************************
import processing.pdf.*;
// Bauhaus colors for the rectangles
color[] bauhaus = { 
  #08101a, // Dark Navy
  #f9a30e, // Soft Gold
  #cc2a1f, // Coral Red
  #006aab, // Gentle Blue
  #71878c, // Misty Gray
  #d2d4c9  // Pale Silver
};
// Circle colorpalette, has more colours that pop more than the rectangles
color[] circlebauhaus = { 
  #faad01, //Pastel yellow
  #fe8700, //Pastel orange
  #2f4a50, //Pastel teal
  #cc2a1f, //Pastel red
  #79adb4, //Pastel blue-gray
};

void setup() {
  size(800, 1000); // poster shape
  beginRecord(PDF, "Challenge1.pdf");
  background(#060029); // blueish dark background which makes the circle more interesting
  rectMode(CENTER); // Rectangles aligned in the center
  noStroke(); //Gives a nice aesthetic
  noLoop(); // no loop to avoid me having an epilepsy attack
  textAlign(CENTER); // Text aligned from the center
  
}
void draw() {
  // Generate rectangles
  for (int i = 0; i < 75; i++) { // generate 75 randomly place rectangles
    color randomColor = bauhaus[int(random(bauhaus.length))]; // random color from the color palette / solution created by AI
    float sizex = random(150, 350); 
    float sizey = random(50, 150);
    float x = random(200, 600);
    float y = random(0, 600);
    fill(randomColor);
    rect(x, y, sizex, sizey);
  }

  // Generate circles 
  for (int j = 0; j < 50; j++) {
    color randomColor = circlebauhaus[int(random(circlebauhaus.length))]; // choose a random color from the color palette circleBauhaus  / solution created by AI
    float sizeC = random(25, 125); // generate a random size for the circle within bounds
    float cx = random(125, 700); // generate a random x location for the circle within bounds
    float cy = random(100, 700);// generate a random ylocation for the circle within bounds
    fill(randomColor); // fill circle for the random  color 
    ellipse(cx, cy, sizeC, sizeC); // draw circle
  }

  // Draw the central circle (taken from 
  push();
  translate(400, 360); // translate to center of the central circle 
  noFill(); // inside has to transparent so that it shows the 
  stroke(#fef2c8); // background for the artpiece
  strokeWeight(0.6 * width + 3); // extremely wide strokeweight so that it covers the entire canvas
  circle(0, 0, 1200); // draw the circle
  pop();

  // Adding text 
  PFont font = createFont("Baumans", 48); // creating the font I want to use
  textFont(font); // using the font
  textSize(128); 
  int text_x = 400; // postion of text
  int text_c = 0; // color of text 
  for (int k = 0; k < 3; k++) {
    text_c = text_c + 55;
    fill(text_c);
    text_x = text_x + 8;
    text("Motor", text_x, 880);
  }
  
// Adding extra circle to create same effect as text
  int size_circle = 0; // initial extra radius of circle
  int grad_circle = 0; // initial color of circle
  for (int l=0; l<3; l++) { // execute three times
    push();
    translate(400, 360); // center of central circle
    noFill(); // circle need to transparent
    stroke(grad_circle); // color of the outline 
    strokeWeight(10); // thickness of outline
    circle(0, 0, (720 + size_circle)); // draw circle with extra radius
    size_circle = size_circle + 15; //increments at which the radius increases
    grad_circle = grad_circle + 75; // increments at which the gradient changes
    pop();
  };
  endRecord();
}
