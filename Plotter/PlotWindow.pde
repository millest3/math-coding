interface Function {
  float evaluate(float x);
}

public class PlotWindow
{
   private float xMin, xMax, yMin, yMax, xScale, yScale;
   private int windowWidth, windowHeight, precision;
   private boolean showAxes;
   private ArrayList<Plot> plots;
   
   public PlotWindow()
   {
      this(-10, 10, -10, 10, 1, 1); 
   }
  
   public PlotWindow(float xMin, float xMax, float yMin, 
                       float yMax, float xs, float ys)
   {
      this.xMin = xMin;
      this.xMax = xMax;
      this.yMin = yMin;
      this.yMax = yMax;
      xScale = xs;
      yScale = ys;
      
      precision = width/4;
      windowWidth = width;
      windowHeight = height;
      showAxes = true;
   }
   public int getWidth()
   {
     return windowWidth;
   }
   
   public int getHeight()
   {
     return windowHeight;
   }
   
   private float[] tickList(float min, float max, float scale)
   {
     float[] ticks = new float[(int)((max-min)/scale)];
     
     float currentTick = (int)(min/scale) * scale;
     for (int i=0; i<ticks.length; i++)
     {
       ticks[i] = currentTick;
       currentTick += scale;
     }
     return ticks;
   }
   
   public void showGrid()
   {
     float[] xCoords = tickList(xMin, xMax, xScale);
     float[] yCoords = tickList(yMin, yMax, yScale);
     
     for (float x:xCoords)
     {
       stroke(128);
       // TODO: draw vertical lines
       float[] p1 = transformPoint(x, yMin);
       float[] p2 = transformPoint(x, yMax);
       
       line(p1[0], p1[1], p2[0], p2[1]);
     }
     
     for (float y: yCoords)
     {
        // TODO: draw horizontal lines 
       float[] p1 = transformPoint(xMin, y);
       float[] p2 = transformPoint(xMax, y);
       
       line(p1[0], p1[1], p2[0], p2[1]);
     }
     
     if (showAxes)
     {
        // TODO: draw axes 
        float[] px1 = transformPoint(xMin, 0);
        float[] px2 = transformPoint(xMax, 0);
        float[] py1 = transformPoint(0, yMin);
        float[] py2 = transformPoint(0, yMax);
        
        stroke(0);
        strokeWeight(2);
        line(px1[0], px1[1], px2[0], px2[1]);
        line(py1[0], py1[1], py2[0], py2[1]);
        strokeWeight(1);
     }
   }
   
   private float[] transformPoint(float x, float y)
   {
     return transformPoint(new float[]{x, y});
   }
   
   private float[] transformPoint(float[] point)
   {
     return new float[]{(point[0] - xMin)/(xMax - xMin)*windowWidth, 
                          height - (point[1]-yMin)/(yMax-yMin)*windowHeight};
   }
   
   private void transformMatrix()
   {
     translate(windowWidth/2, windowHeight/2);
     scale(windowWidth/(xMax-xMin), -1*windowHeight/(yMax-yMin));
   } 
   
   public void plotPoint(float x, float y)
   {
     float[] point = {x, y};
     plotPoint(point);
   }
   
   public void plotPoint(float[] point)
   {
     plotPoint(point, 0xFFFF0000);
   }
   
   public void plotPoint(float[] point, color c)
   {
       stroke(c);
       fill(c);
       float[] displayPoint = transformPoint(point);
       int radius = (int)Math.max(windowWidth/80, 8);
       circle((float)displayPoint[0], (float)displayPoint[1], radius);
   }
   
   public void plotFunction(Function f, color c)
   {
     float oldX = xMin;
     float x;
     float[] point1, point2;
     stroke(c);
     strokeWeight(3);
     for (int p = 0; p<=precision; p++)
     {
       x = p*(xMax-xMin)/precision + xMin;
       point1 = transformPoint(oldX, f.evaluate(oldX));
       point2 = transformPoint(x, f.evaluate(x));
       line(point1[0], point1[1], point2[0], point2[1]);
       oldX = x;
     }
   }
}
