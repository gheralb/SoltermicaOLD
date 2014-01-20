model Verificacion_04 
  "Pruebas de verificación del modelo de interacumulador. Enfriamiento del volumen de acumulación mediante consumo de agua. Sin calor aportado por el intercambiador. Demanda mediante bomba." 
  
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow_1(
    m=0.1,
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    T0=273.15) annotation (extent=[-60,30; -40,50]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient red(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=101300,
    T_Ambient=273.15) 
    annotation (extent=[60,-40; 80,-20]);
  Modelica.Blocks.Sources.Constant caudal_1(k=0.000001) 
    "Caudal masico consigna primario"    annotation (extent=[-20,70; -40,90]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambiente_b_1(
        p_Ambient=101300,
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    T_Ambient=273.15) annotation (extent=[-40,-8; -60,12]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient consumo(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
      p_Ambient=101300,
    T_Ambient=273.15) annotation (extent=[60,40; 80,60]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedAmbient ambiente_a_1(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water()) 
    annotation (extent=[-86,-10; -66,-30], rotation=90);
  Modelica.Blocks.Sources.Trapezoid TdistTemp(
    period=400,
    rising=90,
    width=200,
    falling=90,
    startTime=10,
      amplitude=0,
      offset=343.15) 
    "Distribucion temporal de temperatura de entrada en el primario (senal trapezoidal)"
                  annotation (extent=[-20,-50; -40,-30]);
  Modelica.Blocks.Sources.Constant Pconst_1(k=101300) 
    annotation (extent=[-20,-90; -40,-70]);
    Soltermica.Acumuladores.Interacumuladores.InteracumuladorSerpentin 
    interacumulador_01_1(
      medium_int=Modelica.Thermal.FluidHeatFlow.Media.Water(),
      medium_dep=Modelica.Thermal.FluidHeatFlow.Media.Water(),
      esp=CatalogoEquipos.HEATSUN_ISSWX200(),
    T0=273.15) 
      annotation (extent=[-20,0; 0,20]);
    Modelica.Blocks.Sources.Trapezoid trapezoid(
      nperiod=-1,
    amplitude=0.0003,
    rising=2,
    width=180,
    falling=2,
    period=3600,
    startTime=180, 
    offset=0.000001) 
                   annotation (extent=[60,0; 40,20]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    m=0.1,
    T0=273.15) annotation (extent=[40,-40; 20,-20]);
equation 
      connect(caudal_1.y, prescribedVolumeFlow_1.VolumeFlow) annotation (
          points=[-41,80; -50,80; -50,50], style(color=74, rgbcolor={0,0,
              127}));
      connect(TdistTemp.y, ambiente_a_1.T_Ambient) annotation (points=[-41,
            -40; -70,-40; -70,-30; -69,-30], style(color=74, rgbcolor={0,0,
              127}));
      connect(Pconst_1.y, ambiente_a_1.p_Ambient) annotation (points=[-41,-80;
        -84,-80; -84,-30; -83,-30],          style(color=74, rgbcolor={0,0,
              127}));
      connect(ambiente_a_1.flowPort, prescribedVolumeFlow_1.flowPort_a) 
        annotation (points=[-76,-10; -76,40; -60,40], style(color=1,
            rgbcolor={255,0,0}));
      annotation (Diagram);
  connect(trapezoid.y, prescribedVolumeFlow.VolumeFlow) annotation (points=[39,
        10; 30,10; 30,-20], style(color=74, rgbcolor={0,0,127}));
  connect(red.flowPort, prescribedVolumeFlow.flowPort_a) 
    annotation (points=[60,-30; 40,-30], style(color=1, rgbcolor={255,0,0}));
  connect(prescribedVolumeFlow_1.flowPort_b, interacumulador_01_1.flowPort_a_int) 
    annotation (points=[-40,40; -30,40; -30,10; -20,10], style(color=1, 
        rgbcolor={255,0,0}));
  connect(ambiente_b_1.flowPort, interacumulador_01_1.flowPort_b_int) 
    annotation (points=[-40,2; -30,2; -30,4; -20,4], style(color=1, rgbcolor={
          255,0,0}));
  connect(prescribedVolumeFlow.flowPort_b, interacumulador_01_1.flowPort_a_dep)
    annotation (points=[20,-30; -10,-30; -10,0], style(color=1, rgbcolor={255,0,
          0}));
  connect(interacumulador_01_1.flowPort_b_dep, consumo.flowPort) annotation (
      points=[-10,20; -10,50; 60,50], style(color=1, rgbcolor={255,0,0}));
end Verificacion_04;
