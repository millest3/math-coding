PlotWindow pw;
float xMin = -10;
float xMax = 10;
float yMin = -10;
float yMax = 10;
float xStep = 1;
float yStep = 1;

FunctionPlot fPlot, gPlot;

void setup() {
  size(800, 800);
  pw = new PlotWindow(xMin, xMax, yMin, yMax, xStep, yStep);
  background(255);
  noLoop();
  noSmooth();
  pw.showGrid();
  pw.plotPoint(5,3);
  
  float fsw = 3*(xMax-xMin)/width;
  Function f = (x) -> (float)Math.pow(x-3,2)+2;
  Function g = (x) -> 4*sin(x);
  fPlot = new FunctionPlot(f);
  gPlot = new FunctionPlot(g, #0000FF);
  
  pw.transformMatrix();
 
  fPlot.display();
  gPlot.display();
  //pw.plotFunction(f, 0xff0000ff);
  //pw.plotFunction(g, #FF0000);
}

void draw(){
  
}
