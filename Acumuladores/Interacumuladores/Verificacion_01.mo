model Verificacion_01 
  "Pruebas de enfriamiento de un acumulador. Enfriamiento por consumo del volumen de acumulación." 
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
      p_Ambient=101300, 
    T_Ambient=293.15) 
                     annotation (extent=[20,-34; 40,-14]);
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(medium=
          Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300, 
    T_Ambient=293.15) 
      annotation (extent=[22,46; 42,66]);
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      rising=1,
      falling=1,
      startTime=20,
      amplitude=0.0003, 
    width=180, 
    period=600)         annotation (extent=[42,-74; 22,-54]);
    annotation (Diagram);
    Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow(  medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        m=0.1, 
    T0=293.15) annotation (extent=[-8,-14; -28,-34]);
  Acumulador acumulador(
    medium_dep=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    V_dep=0.1,
    T0=340,
    m_flow_dep_nom=0.1,
    dp_dep_nom=10000) annotation (extent=[-62,0; -42,20]);
equation 
    connect(trapezoid.y, prescribedVolumeFlow.VolumeFlow) annotation (points=[21,-64;
        6,-64; 6,-46; -18,-46; -18,-34],          style(color=74, rgbcolor={0,
            0,127}));
    connect(ambient.flowPort, prescribedVolumeFlow.flowPort_a) annotation (
        points=[20,-24; -8,-24], style(color=1, rgbcolor={255,0,0}));
  connect(acumulador.flowPort_b, ambient1.flowPort) annotation (points=[-52,20;
        -52,56; 22,56], style(color=1, rgbcolor={255,0,0}));
  connect(prescribedVolumeFlow.flowPort_b, acumulador.flowPort_a) annotation (
      points=[-28,-24; -52,-24; -52,0], style(color=1, rgbcolor={255,0,0}));
end Verificacion_01;
