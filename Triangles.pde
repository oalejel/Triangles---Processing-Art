//can use the widht and height varibles to get screen w/h

ArrayList<Triangle> triangles = new ArrayList<Triangle>(100);
ArrayList<Line> paths = new ArrayList<Line>(100);
int numPaths = 0;//number of items in paths arraylist

void setup() {
  size(600, 400);
  background(0);
  frameRate(30);
  addBorderLines();
  noFill();
  frame.setResizable(true);
}

//draw loop
void draw() {
  setRandomStroke();
  ArrayList<Point> threePoints = new ArrayList<Point>();
  ArrayList<Line> threeLines = threeRandomLines();
  for(int i = 0; i < 3; i++) {
    Line l = threeLines.get(i);
    threePoints.add(l.randomPoint());
  }
  Point p1 = threePoints.get(0);
  Point p2 = threePoints.get(1);
  Point p3 = threePoints.get(2);
  Triangle t = new Triangle(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y);
  t.drawTriangle();
  triangles.add(t);
  
  addLineWithPoints(p1, p2);
  addLineWithPoints(p2, p3);
  addLineWithPoints(p3, p2);
}

void keyPressed() {
  background(0);
  numPaths = 4;
  addBorderLines();
}
  
void addLineWithPoints(Point p1, Point p2) {
  Line l = new Line();
  float deltaX = p1.x - p2.x;
  float deltaY = p1.y - p2.y;
  l.slope = deltaY / deltaX;
  l.constant = p1.y - (l.slope * p1.x); //set y intercept equal to the heighest y value (should it be lowest)
  l.xMax = max(p1.x, p2.x);
  l.xMin = min(p1.x, p2.x);
  paths.add(l);
  numPaths++;
}

//important functions

void setRandomStroke() {
  int r = (int)random(255);
  int g = (int)random(255);
  int b = (int)random(255);
  stroke(r, g, b);
}

ArrayList<Line> threeRandomLines() {
  ArrayList<Line> returnLines = new ArrayList<Line>();
  ArrayList<Line> tempLines = paths;
  int testNumPaths = numPaths;
  int[] possibleIndexes = new int[numPaths];
  
  for (int i = 0; i < testNumPaths; i++) {
    possibleIndexes[i] = i;
  }
  for(int i = 0; i < 3; i++) { 
    int randomIndex = possibleIndexes[(int)random(testNumPaths)];
    println(randomIndex);
    Line randomLine = tempLines.get(randomIndex);
    returnLines.add(randomLine);
    testNumPaths--;
  }
  
  return returnLines;
}

void addBorderLines() {
  Line top = new Line();
  top.xMax = width;
  top.constant = 1; //this is y = 1 + (0*x)
  paths.add(0, top);
  
  Line left = new Line();
  left.constantX = true;
  left.yMax = height;
  left.constant = 1; //this means x = 1
  paths.add(1, left);
  
  Line right = new Line();
  right.constantX = true;
  right.yMax = height;
  right.constant = width - 1; // x = width - 1
  paths.add(2, right);
  
  Line bottom = new Line();
  bottom.xMax = width;
  bottom.constant = height - 1;//y = (0*x) + height - 1
  paths.add(3, bottom);
  
  numPaths = 4;
}

//classes

class Point {
  float x;
  float y;

  Point (float a, float b) {
    x = a;
    y = b;
  }
}

class Triangle { 
  float x1;
  float x2;
  float x3;
  float y1;
  float y2;
  float y3;
  
  Triangle (float a, float b, float c, float d, float e, float f) {  
    x1 = a;
    y1 = b;
    
    x2 = c;
    y2 = d;
    
    x3 = e;
    y3 = f;
  } 
  
  void drawTriangle() { 
    triangle(x1, y1, x2, y2, x3, y3);
  } 
} 

class Line {
  float xMin = 0;
  float xMax = 0;
  float slope = 0;
  float constant = 0;
  
  //these are for x = 4 types
  float yMin = 0;
  float yMax = 0;
  boolean constantX = false;

  Point randomPoint() {
    if (constantX) {//x is always same, give a random y
      float x = constant;
      float y = random(yMin, yMax);
      return new Point(x,y);
    } else { //normal function
      float x = random(xMin, xMax);
      float y = (slope * x) + constant;
      return new Point(x,y);
    }
  }
}
