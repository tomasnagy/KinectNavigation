import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import SimpleOpenNI.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Kinect extends PApplet {



SimpleOpenNI kinect;
ArrayList<int[]> left = new ArrayList<int[]>();
ArrayList<int[]> center = new ArrayList<int[]>();
ArrayList<int[]> right = new ArrayList<int[]>();


public void setup(){
  
  //frameRate(1);  
  //noLoop();
  

kinect = new SimpleOpenNI(this);
kinect.enableDepth();
kinect.enableRGB();
//kinect.enableIR();
size(kinect.depthWidth(),kinect.depthHeight());
  
}

public void draw(){
  kinect.update();
  clear();
  noLoop();
  //background(0);
  //image(kinect.depthImage(),0,0);
  image(kinect.rgbImage(),0,0);

  createSectors();
  //image(kinect.irImage(),0,0);
  

}

public void createSectors() {
  int[] depthValues = kinect.depthMap();
  for(int i = 0; i < depthValues.length; i += 640) {
    left.add(Arrays.copyOfRange(depthValues, 0 + i, 213));
    center.add(Arrays.copyOfRange(depthValues, 0 + i + 213, 213 + 214));
    right.add(Arrays.copyOfRange(depthValues, 0 + i + 213 + 214, 213 + 214 + 213));
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Kinect" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
