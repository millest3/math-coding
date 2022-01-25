public abstract class Plot
{
  public abstract void display();
}

public class FunctionPlot extends Plot
{
  PShape path;
  Function f;
  float[] domain;
  boolean[] endpoints;
  float plotStep;
  color plotColor;
  float sWeight;
  
  public FunctionPlot(Function f)
  {
    this(f,#FF0000);
  }
  
  public FunctionPlot(Function f, color c)
  {
    this(f, c, 3*(xMax-xMin)/width);;
  }
  
  public FunctionPlot(Function f, color c, float sw)
  {
    this(f, c, sw,  xMin, xMax, true, true);
  }
  
  public FunctionPlot(Function f, color c, float sw, Float xStart, Float xEnd, 
                      Boolean includeStart, Boolean includeEnd)
  {
    this.f = f;
    sWeight = sw;
    plotColor = c;
    
    if (xStart != null)
    {
      domain = new float[]{xStart, xEnd};
      endpoints = new boolean[]{includeStart, includeEnd};
    }
    else
    {
      domain = new float[]{-10, 10};
      endpoints = new boolean[]{true, true};
    }
    int precision = 100;
    plotStep = (domain[1]-domain[0])/precision;
    noFill();
    stroke(plotColor);
    strokeWeight(sWeight);
    path = createShape();
    path.beginShape();
    float x = domain[0];
    for (int i=0;i<precision;i++)
    {
      path.vertex(x, f.evaluate(x));
      x += plotStep;
    }
    path.endShape();
  } 
  
  public void display()
  {
    shape(path);
  }
}
