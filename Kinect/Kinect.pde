import SimpleOpenNI.*;
import java.util.*;
SimpleOpenNI kinect;
int[] left = new int[0];
int[] center = new int[0];
int[] right = new int[0];
int[] leftUp = new int[0];
int[] leftDown = new int[0];
int[] centerUp = new int[0];
int[] centerDown = new int[0];
int[] rightUp = new int[0];
int[] rightDown = new int[0];


void setup(){
  
  frameRate(2);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  //kinect.enableRGB();
  //kinect.enableIR();
  //size(kinect.depthWidth(),kinect.depthHeight());
    
}

void draw(){
  kinect.update();
  clear();
  //noLoop();
  //background(0);
  //image(kinect.depthImage(),0,0);
  //image(kinect.rgbImage(),0,0);

  left = new int[0];
  center = new int[0];
  right = new int[0];
  leftUp = new int[0];
  leftDown = new int[0];
  centerUp = new int[0];
  centerDown = new int[0];
  rightUp = new int[0];
  rightDown = new int[0];
  

  createSectors();
  createSubsectors();
  //image(kinect.irImage(),0,0);
  drawSectors();

}

void createSubsectors() {
  leftUp = Arrays.copyOfRange(left, 0, left.length/2);
  leftDown = Arrays.copyOfRange(left, left.length/2, left.length);
  centerUp = Arrays.copyOfRange(center, 0, center.length/2);
  centerDown = Arrays.copyOfRange(center, center.length/2, center.length);
  rightUp = Arrays.copyOfRange(right, 0, right.length/2);
  rightDown = Arrays.copyOfRange(right, right.length/2, right.length);
}

void createSectors() {
  int[] depthValues = kinect.depthMap();
  for(int i = 0; i < depthValues.length; i += (640*4)) {
     left = combine(left, Arrays.copyOfRange(depthValues, 0 + i, 213 + i));
     center = combine(center, Arrays.copyOfRange(depthValues, 0 + i + 213, 213 + i + 214));
     right = combine(right, Arrays.copyOfRange(depthValues, 0 + i+213+214, 213 + i+213+214));
  }
  
  //println(left.length + center.length + right.length);
}

void drawSectors() {
  //println("left: " + checkNearestPoint(left) + " right: " + checkNearestPoint(right));
  //drawLeftUp(getDistanceStrength(checkNearestPoint(leftUp)));
  //drawLeftDown(getDistanceStrength(checkNearestPoint(leftDown)));
  //drawCenterUp(getDistanceStrength(checkNearestPoint(centerUp)));
  //drawCenterDown(getDistanceStrength(checkNearestPoint(centerDown)));
  //drawRightUp(getDistanceStrength(checkNearestPoint(rightUp)));
  //drawRightDown(getDistanceStrength(checkNearestPoint(rightDown)));
  
  println("Min points of sectors: \n"+
    getDistanceStrength(checkNearestPoint(leftUp))+" "+getDistanceStrength(checkNearestPoint(centerUp))+" "+getDistanceStrength(checkNearestPoint(rightUp))+"\n"+
    getDistanceStrength(checkNearestPoint(leftDown))+" "+getDistanceStrength(checkNearestPoint(centerDown))+" "+getDistanceStrength(checkNearestPoint(rightDown))
  );
  
}

int getDistanceStrength(int distance) {
  int result =(int)Math.floor(map(distance, 500, 1100, 255, 0));
  if(result < 0) {
    return 0;
  } else if (result > 255) {
    return 255;
  } else {
    return result;
  }
}

void drawLeftUp(int opa) {
 //fill(255, 0, 0, opa);
 //rect(0, 0 , 213, 240);
}

void drawLeftDown(int opa) {
 //fill(255, 0, 0, opa);
 //rect(0, 240 , 213, 240);
}

void drawCenterUp(int opa) {
 //fill(255, 0, 0, opa);
 //rect(213, 0 ,  214, 240);
}

void drawCenterDown(int opa) {
 //fill(255, 0, 0, opa);
 //rect(213, 240 , 214, 240);
}

void drawRightUp(int opa) {
 //fill(255, 0, 0, opa);
 //rect(427, 0 , 213, 240);
}

void drawRightDown(int opa) {
 //fill(255, 0, 0, opa);
 //rect(427, 240, 213, 240);
}


int checkNearestPoint(int[] arr) {
  int lowestPoint = 8000;
    for(int i = 0; i < arr.length; i+=4) {
    if(arr[i] < lowestPoint && arr[i] > 200) {
      lowestPoint = arr[i];
    }
    if(arr[i+1] < lowestPoint && arr[i+1] > 200) {
      lowestPoint = arr[i+1];
    }
    if(arr[i+2] < lowestPoint && arr[i+2] > 200) {
      lowestPoint = arr[i+2];
    }
    if(arr[i+3] < lowestPoint && arr[i+3] > 200) {
      lowestPoint = arr[i+3];
    }
    /*if(arr[i+4] < lowestPoint && arr[i+4] > 200) {
      lowestPoint = arr[i+4];
    }
    if(arr[i+5] < lowestPoint && arr[i+5] > 200) {
      lowestPoint = arr[i+5];
    }
    if(arr[i+6] < lowestPoint && arr[i+6] > 200) {
      lowestPoint = arr[i+6];
    }
    if(arr[i+7] < lowestPoint && arr[i+7] > 200) {
      lowestPoint = arr[i+7];
    }*/
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
