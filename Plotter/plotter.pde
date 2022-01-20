PlotWindow pw;

void setup() {
  size(800, 800);
  pw = new PlotWindow(-1,10, -1, 10, 1, 1);
  background(255);
  noLoop();
  noSmooth();
  pw.showGrid();
  pw.plotPoint(5,3);
  
  Function f = (x) -> (float)Math.pow(x-3,2)+2;
  Function g = (x) -> 4*sin(x);
  pw.plotFunction(f, 0xff0000ff);
  pw.plotFunction(g, #FF0000);
}

void draw(){
  
}
