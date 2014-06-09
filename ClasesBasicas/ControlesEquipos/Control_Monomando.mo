model Control_Monomando 
  "Bloque que controla la regulacion de la griferia monomando" 
  annotation (Diagram, Icon(
      Rectangle(extent=[-100,-100; 100,100], style(color=3, rgbcolor={0,0,255})),
      Polygon(points=[80,-76; 80,-84; 100,-80; 80,-76], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=0,
          rgbfillColor={0,0,0})),
      Line(points=[0,-80; 0,60],     style(color=0, rgbcolor={0,0,0})),
      Polygon(points=[-12,60; 12,60; 0,98; -12,60],    style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=0,
          rgbfillColor={0,0,0})),
      Line(points=[-80,-80; 80,-80], style(color=0, rgbcolor={0,0,0})),
      Line(points=[-60,-80; 60,40], style(color=1, rgbcolor={255,0,0})),
      Line(points=[-60,40; 60,-80], style(color=3, rgbcolor={0,0,255}))));
  Modelica.Blocks.Interfaces.RealInput SenalCaudal 
    "Senal de caudal entre 0 y 1. Corresponde al porcentaje de apertura total de grifo"
    annotation (extent=[-128,20; -88,60]);
  Modelica.Blocks.Interfaces.RealInput SenalTemperatura 
    "Senal de temperatura entre 1 y -1. Corresponde al porcentaje de caudal de agua caliente (positiva) y agua fria (negativa)"
    annotation (extent=[-128,-60; -88,-20]);
  Modelica.Blocks.Interfaces.RealOutput SenalCaliente 
    "Senal de apertura del agua caliente" 
    annotation (extent=[92,20; 132,60]);
  Modelica.Blocks.Interfaces.RealOutput SenalFria 
    "Senal de apertura del agua fria" 
    annotation (extent=[92,-60; 132,-20]);
  
equation 
SenalCaliente=SenalCaudal*(0.5*SenalTemperatura+0.5);
SenalFria=SenalCaudal*(-0.5*SenalTemperatura+0.5);
  
end Control_Monomando;
