model DemandaValvulaDeposito 
  Valvulas.Griferia.monoblock monoblock(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(), 
    dp_grifo=100000, 
    Kv_grifo=0.0002)                    annotation (extent=[20,20; 40,40]);
  Acumuladores.Acumulador_Orden acumulador_Orden(
    n=6, 
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(), 
    espec=Soltermica.Acumuladores.CatalogoEquipos.IDROGAS_CV300SR(), 
    T_ini=343.15) 
    annotation (extent=[-22,-20; -2,0]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient red(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=301300,
    T_Ambient=Modelica.SIunits.Conversions.from_degC(10)) 
    annotation (extent=[58,-60; 78,-40]);
  annotation (Diagram);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient sumidero(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[68,24; 88,44]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=301300) 
    annotation (extent=[-62,-16; -82,4]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient red1(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=301300,
    T_Ambient=Modelica.SIunits.Conversions.from_degC(10)) 
    annotation (extent=[60,-88; 80,-68]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=301300) 
    annotation (extent=[-60,-60; -80,-40]);
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    rising=3, 
    falling=3, 
    period=3600, 
    startTime=11, 
    width=600, 
    amplitude=0.4) 
    annotation (extent=[-44,42; -24,62]);
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=0.5, 
    rising=3, 
    falling=3, 
    period=3600, 
    startTime=10, 
    width=600)                                 annotation (extent=[0,70; 20,90]);
equation 
  connect(red.flowPort, monoblock.fria) annotation (points=[58,-50; 34,-50; 34,
        20], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(monoblock.flowPort_b, sumidero.flowPort) annotation (points=[40,34;
        68,34], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(acumulador_Orden.flowPort_b, monoblock.caliente) annotation (points=[-12,0; 
        -12,20; 26,20],        style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(ambient.flowPort, acumulador_Orden.flowPort_a1) annotation (points=[-62,-6; 
        -42,-6; -42,-10; -22,-10],         style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(acumulador_Orden.flowPort_a, red1.flowPort) annotation (points=[-12,-20; 
        -12,-78; 60,-78],      style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(ambient1.flowPort, acumulador_Orden.flowPort_b1) annotation (points=[-60,-50; 
        -40,-50; -40,-18; -22,-18],          style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(trapezoid.y, monoblock.llaveCaliente) annotation (points=[-23,52; -2,
        52; -2,27; 20,27], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(trapezoid1.y, monoblock.llaveFria) annotation (points=[21,80; 50,80;
        50,27; 40,27], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
end DemandaValvulaDeposito;
