model Validacion_Monomando_02 
  annotation (uses(Modelica(version="2.2.1")), Diagram);
  Modelica.Blocks.Sources.Trapezoid DemandaCaudal(
    rising=3,
    falling=3,
    startTime=10,
    period=1000,
    amplitude=1,
    width=120)     annotation (extent=[-60,20; -40,40]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient sumidero(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[40,0; 60,20]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient AF(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    T_Ambient=Modelica.SIunits.Conversions.from_degC(10),
    p_Ambient=251300) 
    annotation (extent=[40,-40; 60,-20]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ACS(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    T_Ambient=Modelica.SIunits.Conversions.from_degC(60),
    p_Ambient=251300) 
    annotation (extent=[40,-80; 60,-60]);
  Monomando monomando(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    dp_grifo=150000,
    Kv_grifo=0.0002) annotation (extent=[0,0; 20,20]);
  Modelica.Blocks.Sources.Trapezoid regulacionTempertura(
    period=1000,
    amplitude=1,
    rising=5,
    width=60,
    falling=5,
    startTime=40)  annotation (extent=[-60,-20; -40,0]);
equation 
  connect(monomando.flowPort_b, sumidero.flowPort) annotation (points=[20,10;
        40,10], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(AF.flowPort, monomando.fria) annotation (points=[40,-30; 14,-30; 14,0],
      style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(ACS.flowPort, monomando.caliente) annotation (points=[40,-70; 6,-70;
        6,0], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(DemandaCaudal.y, monomando.caudal) annotation (points=[-39,30; -20,30; 
        -20,16; -0.6,16], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(regulacionTempertura.y, monomando.temperatura) annotation (points=[
        -39,-10; -12,-10; -12,10; -0.6,10], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
end Validacion_Monomando_02;
