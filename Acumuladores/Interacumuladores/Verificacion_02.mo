model Verificacion_02 
  "Pruebas de calentamiento de un acumulador introduccon agua caliente." 
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
      p_Ambient=101300,
    T_Ambient=293.15) 
                     annotation (extent=[40,-40; 60,-20]);
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(medium=
          Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300,
    T_Ambient=293.15) 
      annotation (extent=[40,60; 60,80]);
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      rising=1,
      falling=1,
      startTime=20,
    width=180,
    period=600, 
    amplitude=0)        annotation (extent=[42,-74; 22,-54]);
    annotation (Diagram);
    Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow(  medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        m=0.1,
    T0=293.15) annotation (extent=[20,-20; 0,-40]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient3(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[-60,-60; -80,-40]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedAmbient prescribedAmbient(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water()) 
    annotation (extent=[-56,42; -76,62]);
  Modelica.Blocks.Sources.Constant const(k=101300) 
    annotation (extent=[-102,76; -82,96]);
  Modelica.Blocks.Sources.Ramp ramp(
    height=20,
    offset=273.15,
    startTime=10) annotation (extent=[-100,12; -80,32]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow1(medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
      m=0.1)              annotation (extent=[-52,18; -32,38]);
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=0.00025, 
    rising=10, 
    width=60, 
    falling=10, 
    period=3600, 
    offset=20) 
    annotation (extent=[-60,74; -40,94]);
  InteracumuladorSerpentin interacumuladorSerpentin(
    medium_int=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    medium_dep=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    esp=Soltermica.Acumuladores.Interacumuladores.CatalogoEquipos.HEATSUN_ISSWX200(),
    T0=273.15) annotation (extent=[-18,-2; 2,18]);
equation 
    connect(trapezoid.y, prescribedVolumeFlow.VolumeFlow) annotation (points=[21,-64;
        10,-64; 10,-40],                          style(color=74, rgbcolor={0,
            0,127}));
    connect(ambient.flowPort, prescribedVolumeFlow.flowPort_a) annotation (
        points=[40,-30; 20,-30], style(color=1, rgbcolor={255,0,0}));
  connect(const.y, prescribedAmbient.p_Ambient) annotation (points=[-81,86; -78,
        86; -78,59; -76,59], style(color=74, rgbcolor={0,0,127}));
  connect(ramp.y, prescribedAmbient.T_Ambient) annotation (points=[-79,22; -78,
        22; -78,45; -76,45], style(color=74, rgbcolor={0,0,127}));
  connect(prescribedAmbient.flowPort, prescribedVolumeFlow1.flowPort_a) 
    annotation (points=[-56,52; -54,52; -54,28; -52,28], style(color=1,
        rgbcolor={255,0,0}));
  connect(trapezoid1.y, prescribedVolumeFlow1.VolumeFlow) annotation (points=[
        -39,84; -36,84; -36,38; -42,38], style(color=74, rgbcolor={0,0,127}));
  connect(prescribedVolumeFlow1.flowPort_b, interacumuladorSerpentin.flowPort_a_int) 
    annotation (points=[-32,28; -24,28; -24,8; -18,8], style(color=1, rgbcolor=
          {255,0,0}));
  connect(ambient3.flowPort, interacumuladorSerpentin.flowPort_b_int) 
    annotation (points=[-60,-50; -38,-50; -38,0; -18,0], style(color=1,
        rgbcolor={255,0,0}));
  connect(interacumuladorSerpentin.flowPort_b_dep, ambient1.flowPort) 
    annotation (points=[-8,18; -8,70; 40,70], style(color=1, rgbcolor={255,0,0}));
  connect(prescribedVolumeFlow.flowPort_b, interacumuladorSerpentin.flowPort_a_dep) 
    annotation (points=[0,-30; -8,-30; -8,-2], style(color=1, rgbcolor={255,0,0}));
end Verificacion_02;
