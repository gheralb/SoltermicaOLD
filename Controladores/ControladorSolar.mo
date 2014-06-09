model ControladorSolar "Controlador solar sencillo. Termostato diferencial" 
  annotation (
    Documentation(info="<HTML>
    <p>
    Centralita solar. Funcionamiento de los más simples como termostato diferencial.<br>
    </p>
    <img src=\"../Imagenes/EsquemaControlDiferencial.png\"><br>
    </HTML>"),
    Diagram, Icon(
      Polygon(points=[-52,-40; -52,40; 28,20; 28,-60; -52,-40], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=30,
          rgbfillColor={215,215,215})),
      Polygon(points=[28,-60; 48,-40; 48,40; 28,20; 28,-60], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1)),
      Polygon(points=[-52,40; -32,60; 48,40; 28,20; -52,40], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=9,
          rgbfillColor={175,175,175},
          fillPattern=1)),
      Polygon(points=[-44,30; 20,14; 20,-16; -44,0; -44,30], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=61,
          rgbfillColor={0,255,128},
          fillPattern=1))));
  Modelica.Blocks.Interfaces.RealInput TempCol 
    "Senal de temperatura del colector" 
    annotation (extent=[-120,40; -80,80]);
  Modelica.Blocks.Interfaces.RealInput TempDep 
    "Senal de temperatura del deposito" 
    annotation (extent=[-120,-20; -80,20]);
  Modelica.Blocks.Interfaces.RealOutput y "Senal de control del circulador" 
    annotation (extent=[96,-10; 116,10]);
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
    amplitude=1,
    rising=0.1,
    offset=0) 
    annotation (extent=[48,0; 68,20]);
  Modelica.Blocks.Math.Add add(k1=+1, k2=-1) 
    annotation (extent=[-60,0; -40,20]);
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=DeltaT_off,
    uHigh=DeltaT_on) 
    annotation (extent=[-22,0; -2,20]);
  Modelica.Blocks.Logical.And and1 
    annotation (extent=[14,0; 34,20]);
  Modelica.Blocks.Logical.LessThreshold TempAcu(threshold=Temp_Acum) 
    annotation (extent=[-40,-70; -20,-50]);
  parameter Modelica.SIunits.TemperatureDifference DeltaT_on 
    "Diferencia tempertura para el arranque del circulador";
  parameter Modelica.SIunits.TemperatureDifference DeltaT_off 
    "Diferencia de temperatura para la parada del circulador";
  parameter Modelica.SIunits.CelsiusTemperature Temp_Acum 
    "Temperatura de consigna del acumulador";
  
equation 
  connect(triggeredTrapezoid.y, y) 
    annotation (
      points=[69,10; 82,10; 82,0; 106,0],
      style(
        color=74, rgbcolor={0,0,127}));
  connect(add.u1, TempCol) 
    annotation (
      points=[-62,16; -70,16; -70,60; -100,60],
      style(
        color=74,
        rgbcolor={0,0,127}));
  connect(add.u2, TempDep) 
    annotation (
      points=[-62,4; -70,4; -70,0; -100,0],
      style(
        color=74,
        rgbcolor={0,0,127}));
  connect(add.y, hysteresis.u) 
    annotation (
      points=[-39,10; -24,10],
      style(
        color=74,
        rgbcolor={0,0,127}));
  connect(hysteresis.y, and1.u1) 
    annotation (
      points=[-1,10; 12,10],
      style(
        color=5,
        rgbcolor={255,0,255}));
  connect(and1.y, triggeredTrapezoid.u) 
    annotation (
      points=[35,10; 46,10],
      style(
        color=5,
        rgbcolor={255,0,255}));
  connect(TempAcu.y, and1.u2) 
    annotation (
      points=[-19,-60; 8,-60; 8,2; 12,2],
      style(
        color=5,
        rgbcolor={255,0,255}));
  connect(TempDep, TempAcu.u) 
    annotation (
      points=[-100,0; -70,0; -70,-60; -42,-60],
      style(
        color=74,
        rgbcolor={0,0,127}));
end ControladorSolar;
