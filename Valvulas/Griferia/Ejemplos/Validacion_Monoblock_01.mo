model Validacion_Monoblock_01 
  annotation (uses(Modelica(version="2.2.1")), Diagram);
  Soltermica.Valvulas.Griferia.Monoblock monoblock(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    dp_grifo=200000,
    Kv_grifo=0.0001) annotation (extent=[-4,2; 16,22]);
  Modelica.Blocks.Sources.Trapezoid DemandaCaliente(
    rising=3,
    width=60,
    falling=3,
    startTime=10,
    period=1000,
    amplitude=0.5) annotation (extent=[-72,-2; -52,18]);
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    rising=3,
    width=100,
    falling=3,
    period=1000,
    startTime=50) annotation (extent=[76,-12; 56,8]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient sumidero(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[56,40; 76,60]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient AF(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=301300,
    T_Ambient=Modelica.SIunits.Conversions.from_degC(10)) 
    annotation (extent=[44,-64; 64,-44]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ACS(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=301300,
    T_Ambient=Modelica.SIunits.Conversions.from_degC(60)) 
    annotation (extent=[46,-92; 66,-72]);
equation 
  connect(monoblock.flowPort_b, sumidero.flowPort) annotation (points=[16,14; 
        36,14; 36,50; 56,50], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(monoblock.fria, AF.flowPort) annotation (points=[10,2; 10,-54; 44,-54],
      style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(ACS.flowPort, monoblock.caliente) annotation (points=[46,-82; 2,-82;
        2,2], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(DemandaCaliente.y, monoblock.llaveCaliente) annotation (points=[-51,8;
        -22,8; -22,9; -4,9], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(trapezoid1.y, monoblock.llaveFria) annotation (points=[55,-2; 34,-2;
        34,9; 16,9], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
end Validacion_Monoblock_01;
