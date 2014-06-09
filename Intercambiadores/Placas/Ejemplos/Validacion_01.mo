model Validacion_01 
  "Pruebas de verificación de funcionamiento del modelo del intercambiador de placas 0.5" 
  
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow_1(
    m=0.1,
    T0=348.15,
    medium=Soltermica.Media.Propilenglicol_30_25()) 
               annotation (extent=[-62,30; -42,50]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow_2(medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    m=0.1,
    T0=323.15) 
    annotation (extent=[54,-10; 34,10]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambiente_a_2(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        p_Ambient=101300,
    T_Ambient=Modelica.SIunits.Conversions.from_degC(50)) 
    annotation (extent=[68,-10; 88,10]);
  Modelica.Blocks.Sources.Constant caudal_2(k=0.00148) 
    "Caudal masico consigna secundario"   annotation (extent=[80,70; 60,90]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambiente_b_1(
        p_Ambient=101300,
    T_Ambient=293.15,
    medium=Soltermica.Media.Propilenglicol_30_25()) 
                      annotation (extent=[-40,-10; -60,10]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambiente_b_2(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        p_Ambient=101300,
    T_Ambient=293.15) annotation (extent=[18,30; 38,50]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedAmbient ambiente_a_1(medium=
        Soltermica.Media.Propilenglicol_30_25()) 
    annotation (extent=[-86,-10; -66,-30], rotation=90);
  Modelica.Blocks.Sources.Constant Pconst_1(k=101300) 
    annotation (extent=[-20,-90; -40,-70]);
  Modelica.Blocks.Sources.Constant Pconst_2(k=348.15) 
    annotation (extent=[-22,-50; -42,-30]);
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=0.001553,
    rising=60,
    falling=60,
    period=600,
    startTime=10,
    width=500)    annotation (extent=[-90,64; -70,84]);
  IntercambiadorPlacas intercambiadorPlacas(
    n=5,
    medium_1=Soltermica.Media.Propilenglicol_30_25(),
    medium_2=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    espec=Soltermica.Intercambiadores.Placas.CatalogoEquipos.Fagor_IP_50(),
    T_ini=293.15) annotation (extent=[-22,2; -2,22]);
equation 
      connect(ambiente_a_2.flowPort, prescribedVolumeFlow_2.flowPort_a) 
        annotation (points=[68,0; 54,0], style(color=1, rgbcolor={255,0,0}));
      connect(Pconst_1.y, ambiente_a_1.p_Ambient) annotation (points=[-41,
            -80; -82,-80; -82,-30; -83,-30], style(color=74, rgbcolor={0,0,
              127}));
      connect(ambiente_a_1.flowPort, prescribedVolumeFlow_1.flowPort_a) 
        annotation (points=[-76,-10; -76,40; -62,40], style(color=1,
            rgbcolor={255,0,0}));
      connect(caudal_2.y, prescribedVolumeFlow_2.VolumeFlow) annotation (
          points=[59,80; 44,80; 44,10], style(color=74, rgbcolor={0,0,127}));
      annotation (Diagram);
  connect(ambiente_a_1.T_Ambient, Pconst_2.y) annotation (points=[-69,-30; -54,
        -30; -54,-40; -43,-40], style(color=74, rgbcolor={0,0,127}));
  connect(trapezoid.y, prescribedVolumeFlow_1.VolumeFlow) annotation (points=[
        -69,74; -52,74; -52,50], style(color=74, rgbcolor={0,0,127}));
  connect(prescribedVolumeFlow_1.flowPort_b, intercambiadorPlacas.flowPort_a_1) 
    annotation (points=[-42,40; -32,40; -32,18; -22,18], style(color=1,
        rgbcolor={255,0,0}));
  connect(ambiente_b_1.flowPort, intercambiadorPlacas.flowPort_b_1) annotation (
     points=[-40,0; -32,0; -32,6; -22,6], style(color=1, rgbcolor={255,0,0}));
  connect(intercambiadorPlacas.flowPort_a_2, prescribedVolumeFlow_2.flowPort_b) 
    annotation (points=[-2,6; 16,6; 16,0; 34,0], style(color=1, rgbcolor={255,0,
          0}));
  connect(intercambiadorPlacas.flowPort_b_2, ambiente_b_2.flowPort) annotation (
     points=[-2,18; 8,18; 8,40; 18,40], style(color=1, rgbcolor={255,0,0}));
end Validacion_01;
