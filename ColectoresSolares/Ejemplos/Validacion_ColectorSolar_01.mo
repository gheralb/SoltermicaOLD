model Validacion_ColectorSolar_01 
  annotation (uses(Modelica(version="2.2.1")), Diagram);
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=29,
    rising=60,
    falling=60,
    offset=273.15,
    startTime=300,
    width=3600,
    period=14400) annotation (extent=[-100,0; -80,20]);
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=16,
    rising=10,
    falling=10,
    width=3600,
    offset=0,
    startTime=1200,
    period=14400) annotation (extent=[-100,-40; -80,-20]);
  Modelica.Blocks.Sources.Trapezoid trapezoid2(
    amplitude=29,
    rising=10,
    width=3600,
    falling=10,
    startTime=2400,
    period=14400) annotation (extent=[-100,-80; -80,-60]);
  Soltermica.ColectoresSolares.ColectorSolar colectorSolar(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    espec=Soltermica.ColectoresSolares.CatalogoEquipos.BAXIROCA_PS_2_0(),
    T_ini=288.15) annotation (extent=[22,18; 42,38]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[60,26; 80,46]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow(medium=Modelica.Thermal.FluidHeatFlow.Media.Water(), m=
       0.1) annotation (extent=[-2,-20; 18,0], rotation=90);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedAmbient prescribedAmbient(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water()) 
    annotation (extent=[18,-40; -2,-60], rotation=90);
  Modelica.Blocks.Sources.Trapezoid trapezoid3(
    amplitude=0.00011,
    rising=5,
    width=7200,
    falling=5,
    offset=0,
    startTime=2,
    period=25000) annotation (extent=[-44,20; -24,40]);
  Modelica.Blocks.Sources.Constant const(k=101300) 
    annotation (extent=[58,-82; 38,-62]);
  Modelica.Blocks.Sources.Constant tempExt(k=273.15 + 30) 
    annotation (extent=[-62,62; -42,82]);
  Modelica.Blocks.Math.Add add annotation (extent=[-60,-30; -40,-10]);
  Modelica.Blocks.Math.Add add1 annotation (extent=[-30,-74; -10,-54]);
  Modelica.Blocks.Sources.Ramp ramp(
    duration=10,
    offset=883,
    height=-882,
    startTime=10800) annotation (extent=[50,66; 30,86]);
equation 
  connect(colectorSolar.flowPort_b, ambient.flowPort) 
    annotation (points=[42,36; 60,36], style(color=1, rgbcolor={255,0,0}));
  connect(prescribedVolumeFlow.flowPort_b, colectorSolar.flowPort_a) 
    annotation (points=[8,0; 8,20; 22,20], style(color=1, rgbcolor={255,0,0}));
  connect(prescribedAmbient.flowPort, prescribedVolumeFlow.flowPort_a) 
    annotation (points=[8,-40; 8,-30; 8,-20; 8,-20], style(color=1, rgbcolor={
          255,0,0}));
  connect(trapezoid3.y, prescribedVolumeFlow.VolumeFlow) annotation (points=[
        -23,30; -10,30; -10,-10; -2,-10], style(color=74, rgbcolor={0,0,127}));
  connect(const.y, prescribedAmbient.p_Ambient) annotation (points=[37,-72; 14,
        -72; 14,-60; 15,-60], style(color=74, rgbcolor={0,0,127}));
  connect(tempExt.y, colectorSolar.senalTemperatura) annotation (points=[-41,72;
        -6,72; -6,28; 21.2,28], style(color=74, rgbcolor={0,0,127}));
  connect(trapezoid.y, add.u1) annotation (points=[-79,10; -66,10; -66,-14; -62,
        -14], style(color=74, rgbcolor={0,0,127}));
  connect(trapezoid1.y, add.u2) annotation (points=[-79,-30; -70,-30; -70,-26;
        -62,-26], style(color=74, rgbcolor={0,0,127}));
  connect(trapezoid2.y, add1.u2) annotation (points=[-79,-70; -32,-70], style(
        color=74, rgbcolor={0,0,127}));
  connect(add.y, add1.u1) annotation (points=[-39,-20; -36,-20; -36,-58; -32,
        -58], style(color=74, rgbcolor={0,0,127}));
  connect(add1.y, prescribedAmbient.T_Ambient) annotation (points=[-9,-64; 2,
        -64; 2,-60; 1,-60], style(color=74, rgbcolor={0,0,127}));
  connect(ramp.y, colectorSolar.senalIrradiacion) annotation (points=[29,76; 8,
        76; 8,36; 21.2,36], style(color=74, rgbcolor={0,0,127}));
end Validacion_ColectorSolar_01;
