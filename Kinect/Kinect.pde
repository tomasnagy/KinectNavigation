import SimpleOpenNI.*;
import java.util.*;
SimpleOpenNI kinect;
int[] left = new int[0];
int[] center = new int[0];
int[] right = new int[0];


void setup(){
  
  frameRate(10);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
  //kinect.enableIR();
  size(kinect.depthWidth(),kinect.depthHeight());
    
}

void draw(){
  kinect.update();
  clear();
  //noLoop();
  //background(0);
  //image(kinect.depthImage(),0,0);
  image(kinect.rgbImage(),0,0);

  left = new int[0];
  center = new int[0];
  right = new int[0];

  createSectors();
  //image(kinect.irImage(),0,0);
  drawSectors();

}

void createSectors() {
  int[] depthValues = kinect.depthMap();
  for(int i = 0; i < depthValues.length; i += 640) {
     left = combine(left, Arrays.copyOfRange(depthValues, 0 + i, 213 + i));
     center = combine(center, Arrays.copyOfRange(depthValues, 0 + i + 213, 213 + i + 214));
     right = combine(right, Arrays.copyOfRange(depthValues, 0 + i+213+214, 213 + i+213+214));
  }
  
  println(left.length + center.length + right.length);
}

void drawSectors() {
  println("left: " + checkNearestPoint(left) + " right: " + checkNearestPoint(right));
  drawLeftSector(checkNearestPoint(left));
  drawRightSector(checkNearestPoint(right));
  
}

void drawLeftSector(int  depth) {
  if(depth < 1100 && depth > 750) {
    fill(255, 0, 0, 125);
    rect(0, 0, 213, 640);
  } else if( depth < 750) {
    fill(255, 0, 0);
    rect(0, 0, 213, 640);
  }
  
}

void drawRightSector(int  depth) {
  if(depth < 1100 && depth > 750) {
    fill(255, 0, 0, 125);
    rect(427, 0, 480, 640);
  } else if( depth < 750) {
    fill(255, 0, 0);
     rect(427, 0, 480, 640);
  }
  
}

int checkNearestPoint(int[] arr) {
  int lowestPoint = 8000;
  for(int i = 0; i < arr.length; i++) {
    if(arr[i] < lowestPoint && arr[i] > 200) {
      lowestPoint = arr[i];
    }
  }
  return lowestPoint;
}

int[] combine(int[] a, int[] b) {
  int length =  a.length + b.length;
  int[] result = new int[length];
  System.arraycopy(a, 0, result, 0, a.length);
  System.arraycopy(b, 0, result, a.length, b.length);
  return result;
}  
