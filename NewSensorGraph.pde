import processing.serial.*;

Serial myPort;

int windowWidth = 700;
int windowHeight = 300;

int[] valueArray = new int[windowWidth];

void setup() {
  size(windowWidth, windowHeight);
  println(Serial.list());

  myPort = new Serial(this, Serial.list()[4], 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  background(0);
  if (valueArray != null) {
    for (int i=0; i<valueArray.length; i++) {
      stroke(127, 34, 255);
      line(i, height, i, height - valueArray[i]);
    }
  }
}

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    inString = trim(inString);
    float inByte = float(inString);
    println(inByte);
    inByte = map(inByte, 0, 1023, 0, height);

    // Add last value to array
    shiftAndAdd(valueArray, int(inByte));
  }
}

void shiftAndAdd(int a[], int val) {
  int a_length = a.length;
  System.arraycopy(a, 1, a, 0, a_length-1);
  a[a_length-1] = val;
}

