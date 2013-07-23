

model Verificacion_01 
  "Pruebas de verificación del intercambiador de calor de placas" 
  
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow_1(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    m=0.1,
        T0=308.15) 
               annotation (extent=[-60,30; -40,50]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow_2(medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    m=0.1,
        T0=308.15) 
    annotation (extent=[54,-10; 34,10]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambiente_a_2(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        p_Ambient=101300,
        T_Ambient=308.15) 
    annotation (extent=[68,-10; 88,10]);
  Modelica.Blocks.Sources.Constant caudal_1(k=0.00016666) 
    "Caudal masico consigna primario"    annotation (extent=[-20,70; -40,90]);
  Modelica.Blocks.Sources.Constant caudal_2(k=0.00016666) 
    "Caudal masico consigna secundario"   annotation (extent=[80,70; 60,90]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambiente_b_1(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        p_Ambient=101300,
        T_Ambient=308.15) 
                      annotation (extent=[-40,-10; -60,10]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambiente_b_2(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        p_Ambient=101300,
        T_Ambient=308.15) 
                      annotation (extent=[18,30; 38,50]);
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
      IntercambiadorPlacas intercambiadorPlacas_1(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(), 
    T0_1=308.15, 
    T0_2=308.15, 
    esp=Soltermica.Intercambiadores.Placas.CatalogoEquipos.SA_M3FG_H_8()) 
                annotation (extent=[-18,8; 2,28]);
equation 
      connect(ambiente_a_2.flowPort, prescribedVolumeFlow_2.flowPort_a) 
        annotation (points=[68,0; 54,0], style(color=1, rgbcolor={255,0,0}));
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
      connect(caudal_2.y, prescribedVolumeFlow_2.VolumeFlow) annotation (
          points=[59,80; 44,80; 44,10], style(color=74, rgbcolor={0,0,127}));
      annotation (Diagram);
  connect(prescribedVolumeFlow_1.flowPort_b, intercambiadorPlacas_1.flowPort_a_1)
        annotation (points=[-40,40; -30,40; -30,24; -18,24], style(color=1,
            rgbcolor={255,0,0}));
  connect(intercambiadorPlacas_1.flowPort_b_1, ambiente_b_1.flowPort) 
        annotation (points=[-18,12; -30,12; -30,0; -40,0], style(color=1,
            rgbcolor={255,0,0}));
  connect(intercambiadorPlacas_1.flowPort_a_2, prescribedVolumeFlow_2.flowPort_b)
                                           annotation (points=[2,12; 18,12;
            18,0; 34,0], style(color=1, rgbcolor={255,0,0}));
  connect(intercambiadorPlacas_1.flowPort_b_2, ambiente_b_2.flowPort) 
        annotation (points=[2,24; 10,24; 10,40; 18,40], style(color=1,
            rgbcolor={255,0,0}));
end Verificacion_01;
