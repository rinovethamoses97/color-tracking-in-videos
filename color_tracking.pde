import processing.video.*;
Capture video;
//Initially tracking red color
color target=color(255,0,0);
PImage sample;
float min;
int colorx;
int colory;
void setup(){
  size(640,480);
  String[] cameras=Capture.list();
  video=new Capture(this,cameras[0]);
  video.start();
  
}
void captureEvent(Capture video) {
  video.read();
}
float euc(float x1,float y1,float z1,float x2,float y2,float z2){
  return sqrt(((x2-x1)*(x2-x1))+((y2-y1)*(y2-y1))+((z2-z1)*(z2-z1)));
}
void draw(){
video.loadPixels();
  image(video,0,0,640,480);
  min=500;
  colorx=0;
  colory=0;
  for(int i=0;i<video.width;i++){
    for(int j=0;j<video.height;j++){
      int index=i+j*video.width;
      color current=video.pixels[index];
      float d=euc(red(current),green(current),blue(current),red(target),green(target),green(target));
      if(d<min){
        min=d;
        colorx=i;
        colory=j;
      }
    }
  }
  ellipse(colorx,colory,10,10);
}
void mousePressed(){
  video.loadPixels();
  print(mouseX+mouseY*video.width);
  target=video.pixels[mouseX+mouseY*video.width];
}
