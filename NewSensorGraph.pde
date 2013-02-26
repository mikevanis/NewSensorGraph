import processing.serial.*;

Serial myPort;

int[] valueArray = new int[width];

void setup() {
  size(400, 300);
  println(Serial.list());
  
  myPort = new Serial(this, Serial.list()[4], 9600);
  myPort.bufferUntil('\n');
  
  background(0);
}

void draw() {
  for(int i=valueArray.length; i>0; i--) {
    stroke(127, 34, 255);
    line(i, height, i, height - valueArray[i]);
  }
}

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  
  if(inString != null) {
    inString = trim(inString);
    int inByte = int(inString);
    inByte = int(map(inByte, 0, 1023, 0, height));
    
    // Add last value to array
    shiftAndAdd(valueArray, inByte);
  }
}

void shiftAndAdd(int a[], int val) {
  int a_length = a.length;
  System.arraycopy(a, 1, a, 0, a_length-1);
  a[a_length-1] = val;
}
