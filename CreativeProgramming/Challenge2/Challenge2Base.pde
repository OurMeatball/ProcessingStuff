
// ImpressioGuessr
// Inspired by geoguessr, but now in impressionism style.
// The code gets a random image pulled from an Unsplash collection I made for this assigment.
// I made sure that the photographers whose photos I used are given credit, and I put the links to the images in the explanation file
// What my code does: It loads in a random image image which it then hides, after that you can choose the way you can "fill" the canvas. One is more automatic and reveals the canvas better, the other one is more interactive and makes you feel like you are painting the painting
// The two modes make the image more bubbly and make it less realistic. It impressionismifies the pictrure. After you have revealed enough of the picture, you can right click on your mouse to reveal a dropdown menu where you can make a guess on which city is shown
// After you have guessed the iamge correctly, the canavs will be reset and you can start again.
//************************************************
//Music by: // for fair use purposes
//Purple Dream by Ghostrifter bit.ly/ghostrifter-yt
//Creative Commons — Attribution-NoDerivs 3.0 Unported — CC BY-ND 3.0
//Music promoted by https://www.chosic.com/free-music/all/
///

import ddf.minim.*; //import audio library
// GUI library
import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

import java.util.ArrayList; // For usability
import java.util.Arrays; // For usability
import java.util.List; // For usability

import processing.data.JSONObject; //For API usage 

PImage img; // globally define img
JSONObject msg; // globally define msg

ArrayList<Ball> balls = new ArrayList<Ball>(); // Ball class initialization
ArrayList<Stroke> strokes = new ArrayList<Stroke>(); // Stroke class initialization
boolean strokeMode; // strokeMode for choosing the way you want to "paint" the canvas
String imgUrl; // Globally defining this so I can use it in multiple functions

// Declare a Minim object and an AudioPlayer object
Minim minim;
AudioPlayer player;
// settings() needs to be called to prevent NullPointerExceptions, due to the image loading in and creating the size
void settings() {
  msg = loadJSONObject("https://api.unsplash.com/photos/random?collections=jmQohUztvCo&client_id=aiOIJtPsSW-ppYouDw6Qmb44zj_FxBSX27oq9npux-o"); //Get random picture from Unsplash collection : https://unsplash.com/collections/jmQohUztvCo/creative-programming-assignment
  JSONObject urls = msg.getJSONObject("urls"); // Get the nested "urls" JSON object
  imgUrl = urls.getString("regular"); // get the image URL
  img = loadImage(imgUrl, "png"); // Load in the image 
  if (img.width < img.height) { // image will always be fully on the screen and scaled so that it makes sense and no weird image bending happens
    img.resize(800, 1000); // If the width of the picture is smaller than the height scale the image to 800, 1000
  } else {
    img.resize(1200, 800); // If the width is 
  }
  size(img.width, img.height); // set the canvas to the resized image
}
// setup after settings
void setup() {
  image(img, 0, 0, width, height); // place image on the canvas
  background(65); // background color set to a dark grey
  
  //Music time
  minim = new Minim(this);
  player = minim.loadFile("Ghostrifter-Official-Purple-Dream(chosic.com).mp3"); // load in the lo-fi music file, here is the link https://www.chosic.com/download-audio/45401/
  player.play(); // play the loaded music
  player.loop(); // loop the lofi music
  player.setGain(-10.0); // lower the volume to save my ears
 

  ListElement selectedElement = new UiBooster().showList(
    "Select a stroke style",
    "Stroke Mode",
    new ListElement("Painter Style", "- Feel like a Impressionist Painter\n- Takes longer to fill canvas\n- Harder to guess", "Challenge2Base/PainterMode.png"),
    new ListElement("Ball Style", "- For the lazy artist\n- Easier to fill canvas\n- Balls!", "Challenge2Base/BallsMode.png")
    );
// Explaination of interaction 
  new UiBooster().showInfoDialog("Left click to paint on the canvas and right click to submit your guess.");
  
// Setting the stroke mode for the rest of the canvas
  if (selectedElement.getTitle().equals("Painter Style")) {
    strokeMode = true; // Set to StrokeMode
  } else {
    strokeMode = false; // Set to BallsMode
  }
}

// drawing time!! :D I kept the functions outside of draw(), because it makes it more readable and modular
void draw() {
  drawFrame(); // Made a Frame because the borders of the image did not look that great and also to make it look like it is hanging in a museum
  handleMousePress(); // Taking care of the mouse interaction
  if (strokeMode == false) { // Handling the selected strokeMode here 
    updateBalls(); // 
    removeSmallBalls();
  } else {
    updateStrokes();
    removeStrokes();
  }
}

// Update the location of the drawn Balls if in BallsMode
void updateBalls() {
  for (Ball b : balls) { // For each ball 
    b.draw(); // Function explained in Balls Tab
    b.update();  // Function explained in Balls Tab
    b.changeColor();  // Function explained in Balls Tab
  }
}
// Remove the balls that get to tiny to spot and stop the animation 
void removeSmallBalls() {
  for (Ball b : balls) {
    if (b.radius < 0) {
      b.radius = 0;
    }
  }
}

// if mouse is clicked and there are less than the 20 balls currently per mouse location per frame. Create enough balls so that there are 20 balls on the screen 
void addBalls(int numBalls) {
  for (int i=0; i<numBalls; i++) {
    balls.add(new Ball());
  }
}

// Similar to updateBalls() 
void updateStrokes() {
  for (int i = 0; i < strokes.size(); i++) {  // for loop to update every stroke on the canvas
    Stroke s = strokes.get(i); 
    // Read Stroke tab for explanation on these functions
    s.draw();  // Read Stroke tab for explanation on these functions
    s.update(); // Read Stroke tab for explanation on these functions
    s.changeColor(); // Read Stroke tab for explanation on these functions
  }
}

// Remove strokes 
void removeStrokes() {
  for (int i = strokes.size() - 1; i >= 0; i--) { // Go through the entire length of the stroke Array
    if (strokes.get(i).radius < 0) { // if the radius is lower than 0 remove it
      strokes.remove(i);
    }
  }
}

//Add if mouse is pressed 
void addStrokes() {
  if (mousePressed) {
    for (int i = 0; i < 5; i++) { // always have 5 strokes per frame
      strokes.add(new Stroke(mouseX, mouseY, img.get(mouseX, mouseY ))); // Stroke takes (mouseX, mouseY, color) 
    }
  }
}





void handleMousePress() {
  if (mousePressed && (mouseButton == LEFT)) { // left click to "paint"
    if (strokeMode == false) {
      addBalls(20);
    } else {
      addStrokes();
    }
  }
  if (mousePressed && (mouseButton == RIGHT)) { // right click to make a guess
    guessCity(); 
  }
}

void guessCity() {
  String[] citiesArray = {"Select City", "Paris", "Rome", "Vatican City", "New York", "Shanghai", "Tokyo", "Kyoto", "London", "Amsterdam", "Eindhoven"}; // city array to choose from
  List<String> cities = Arrays.asList(citiesArray); // Put the string array in a list
  String guess = new UiBooster().showSelectionDialog( // make a dropdown menu to make a guess
    "Which city is this?",
    "City guess",
    cities);
  // Get the tags array from the JSON response
  JSONArray tags = msg.getJSONArray("tags"); // Unsplash put tags under each photo, usually one of the tags has the city name in it. This can be used for a guessing game. 
  ArrayList<String> tagTitles = new ArrayList<String>(); // Initialize a tag array
  for (int i = 0; i < tags.size(); i++) { //Go through tags 
    JSONObject tag = tags.getJSONObject(i); //get the JSON onject for each tag
    tagTitles.add(tag.getString("title").toLowerCase()); // Put each title in the string from the JSON in an array and convert it to lower case for comparioson
  } 
  if (tagTitles.contains(guess.toLowerCase())) { // Convert guess to lower case so that comparisons are easier and no weird issues happen
    // Get the photographer's name to give credit where its due
    String photographer = msg.getJSONObject("user").getString("name"); 
    new UiBooster().showInfoDialog("Congratulations, You guessed the correct city. This beautiful photo was taken by " + photographer + "." + " You can find the original work on Unsplash.");
    resetCanvas(); // reset the  canvas to continue the game
  } else {
    new UiBooster().showInfoDialog("Unfortunately, your guess was incorrect"); // if the guess is incorrect, you can try again
  }
}

void drawFrame() { // creates a frame for the painting
  int frameThickness = 20; // Adjust this to change the thickness of the frame
  noFill();
  stroke(12); // Change this to change the color of the frame
  strokeWeight(frameThickness); 
  rect(frameThickness/2, frameThickness/2, width - frameThickness, height - frameThickness); // draw frame
}

void resetCanvas() {
  // Clear the balls and strokes
  balls.clear(); //clear all balls on the canvas
  strokes.clear(); // clear all Strokes on the canvas
  
  // Fetch a new image
  msg = loadJSONObject("https://api.unsplash.com/photos/random?collections=jmQohUztvCo&client_id=aiOIJtPsSW-ppYouDw6Qmb44zj_FxBSX27oq9npux-o");
  JSONObject urls = msg.getJSONObject("urls");
  imgUrl = urls.getString("regular");
  img = loadImage(imgUrl, "png");
  
  // resize the canvas
  if (img.width < img.height) {
    img.resize(800, 1000);
    surface.setSize(800,1000);
  } else {
    img.resize(1200, 800);
    surface.setSize(1200, 800);
  }
  image(img, 0, 0, width, height);
  background(65); // overlay and hide painting
  ListElement selectedElement = new UiBooster().showList( // Give option to select PaintMode again
    "Select a stroke style",
    "Stroke Mode",
    new ListElement("Painter Style", "- Feel like a Impressionist Painter\n- Takes longer to fill canvas", "Challenge2Base/PainterMode.png"),
    new ListElement("Ball Style", "- For the lazy artist\n- Easier to fill canvas\n- Balls!", "Challenge2Base/BallsMode.png")
    );
    // Setting the stroke mode for the rest of the canvas
  if (selectedElement.getTitle().equals("Painter Style")) {
    strokeMode = true; // Set to StrokeMode
  } else {
    strokeMode = false; // Set to BallsMode
  }
}
