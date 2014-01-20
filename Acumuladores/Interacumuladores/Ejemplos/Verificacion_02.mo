model Verificacion_02 
  "Pruebas de verificación del modelo de interacumulador. Calentamiento del volumen de acumulación mediante el intercambiador" 
  
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow_1(
    m=0.1,
        T0=308.15,
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water()) 
               annotation (extent=[-60,30; -40,50]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient red(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
      p_Ambient=401300,
      T_Ambient=283.15) 
    annotation (extent=[20,-42; 40,-22]);
  Modelica.Blocks.Sources.Constant caudal_1(k=0.00055555556) 
    "Caudal masico consigna primario"    annotation (extent=[-20,70; -40,90]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambiente_b_1(
        p_Ambient=101300,
        T_Ambient=308.15,
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water()) 
                      annotation (extent=[-40,-10; -60,10]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient consumo(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
      p_Ambient=101300,
      T_Ambient=283.15) 
                      annotation (extent=[40,40; 60,60]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedAmbient ambiente_a_1(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water()) 
    annotation (extent=[-86,-10; -66,-30], rotation=90);
  Modelica.Blocks.Sources.Trapezoid TdistTemp(
    period=400,
    rising=90,
    width=200,
    falling=90,
    startTime=10,
        offset=308.15,
        amplitude=20) 
    "Distribucion temporal de temperatura de entrada en el primario (senal trapezoidal)"
                  annotation (extent=[-20,-50; -40,-30]);
  Modelica.Blocks.Sources.Constant Pconst_1(k=101300) 
    annotation (extent=[-20,-90; -40,-70]);
    Soltermica.Acumuladores.Interacumuladores.InteracumuladorSerpentin 
    interacumulador_1(
    medium_int=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    medium_dep=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    esp=CatalogoEquipos.HEATSUN_ISSWX200(),
    T0=283.15) 
      annotation (extent=[-20,0; 0,20]);
    Modelica.Thermal.FluidHeatFlow.Components.Valve valve(
      m=0.1,
      dp0=10000,
      rho0=1000,
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
      T0=283.15,
      LinearCharacteristic=true,
      Kv1=0.0003,
      kv0=0.0000000001) 
                 annotation (extent=[10,40; 30,60]);
    Modelica.Blocks.Sources.Constant const(k=0) 
      annotation (extent=[60,70; 40,90]);
equation 
      connect(caudal_1.y, prescribedVolumeFlow_1.VolumeFlow) annotation (
          points=[-41,80; -50,80; -50,50], style(color=74, rgbcolor={0,0,
              127}));
      connect(TdistTemp.y, ambiente_a_1.T_Ambient) annotation (points=[-41,
            -40; -70,-40; -70,-30; -69,-30], style(color=74, rgbcolor={0,0,
              127}));
      connect(Pconst_1.y, ambiente_a_1.p_Ambient) annotation (points=[-41,
            -80; -82,-80; -82,-30; -83,-30], style(color=74, rgbcolor={0,0,
              127}));
      connect(ambiente_a_1.flowPort, prescribedVolumeFlow_1.flowPort_a) 
        annotation (points=[-76,-10; -76,40; -60,40], style(color=1,
            rgbcolor={255,0,0}));
      annotation (Diagram);
  connect(ambiente_b_1.flowPort, interacumulador_1.flowPort_b_1) 
      annotation (points=[-40,0; -30,0; -30,2; -20,2], style(color=1,
          rgbcolor={255,0,0}));
  connect(prescribedVolumeFlow_1.flowPort_b, interacumulador_1.flowPort_a_1) 
      annotation (points=[-40,40; -30,40; -30,10; -20.2,10], style(color=
            1, rgbcolor={255,0,0}));
  connect(red.flowPort, interacumulador_1.flowPort_a)      annotation (
        points=[20,-32; -10,-32; -10,0], style(color=1, rgbcolor={255,0,0}));
  connect(interacumulador_1.flowPort_b, valve.flowPort_a) 
      annotation (points=[-10,20; -10,50; 10,50], style(color=1, rgbcolor=
           {255,0,0}));
    connect(valve.flowPort_b, consumo.flowPort) annotation (points=[30,50;
          40,50], style(color=1, rgbcolor={255,0,0}));
    connect(valve.y, const.y) annotation (points=[20,59; 20,80; 39,80],
        style(color=74, rgbcolor={0,0,127}));
end Verificacion_02;
