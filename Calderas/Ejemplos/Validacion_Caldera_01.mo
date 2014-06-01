model Validacion_Caldera_01 
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow(medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
      m=0.1) annotation (extent=[-44,-38; -24,-18]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient fuenteCaudal(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=101300,
    T_Ambient=Modelica.SIunits.Conversions.from_degC(20)) 
    annotation (extent=[-62,-52; -82,-32]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient sumideroCaudal(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[40,-20; 60,0]);
  annotation (Diagram);
  Modelica.Blocks.Sources.Constant const(k=293.15) 
    annotation (extent=[-58,40; -38,60]);
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=0.0002,
    rising=10,
    falling=10,
    offset=0.0000001,
    startTime=10,
    width=400,
    period=3600) annotation (extent=[-74,-6; -54,14]);
  Caldera caldera(
    espec=Soltermica.Calderas.CatalogoEquipos.BAXI_PLATINIUM_24_24F(),
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    T_ini=293.15) annotation (extent=[0,0; 20,20]);
equation 
  connect(fuenteCaudal.flowPort, prescribedVolumeFlow.flowPort_a) annotation (
     points=[-62,-42; -54,-42; -54,-28; -44,-28], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=7,
      rgbfillColor={255,255,255},
      fillPattern=1));
  connect(trapezoid.y, prescribedVolumeFlow.VolumeFlow) annotation (points=[
        -53,4; -34,4; -34,-18], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=7,
      rgbfillColor={255,255,255},
      fillPattern=1));
  connect(const.y, caldera.T_amb) annotation (points=[-37,50; -18,50; -18,16;
        -0.8,16], style(
      color=74,
      rgbcolor={0,0,127},
      pattern=0,
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(prescribedVolumeFlow.flowPort_b, caldera.flowPort_a) annotation (
      points=[-24,-28; -10,-28; -10,0; 4,0], style(
      color=1,
      rgbcolor={255,0,0},
      pattern=0,
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(caldera.flowPort_b, sumideroCaudal.flowPort) annotation (points=[16,0;
        30,0; 30,-10; 40,-10], style(
      color=1,
      rgbcolor={255,0,0},
      pattern=0,
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
end Validacion_Caldera_01;
