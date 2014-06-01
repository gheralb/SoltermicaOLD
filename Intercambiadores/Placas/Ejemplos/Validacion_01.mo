model Validacion_01 
  "Pruebas de verificación de funcionamiento del modelo del intercambiador de placas 0.5" 
  
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow circulador_1(
    m=0.1,
    T0=348.15,
    medium=Soltermica.Media.Propilenglicol_30()) 
               annotation (extent=[-52,18; -32,38]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow circulador_2(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    m=0.1,
    T0=323.15) 
    annotation (extent=[50,-40; 30,-20], rotation=90);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient fuenteCaudal_2(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=101300,
    T_Ambient=Modelica.SIunits.Conversions.from_degC(50)) 
    annotation (extent=[50,-66; 30,-86], rotation=90);
  Modelica.Blocks.Sources.Constant SenalCaudal_1(k=0.001553) 
    "Caudal masico consigna primario"    annotation (extent=[0,60; -20,80]);
  Modelica.Blocks.Sources.Constant SenalCaudal_2(k=0.00148) 
    "Caudal masico consigna secundario"   annotation (extent=[86,0; 66,20]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient sumideroCaudal_1(
    p_Ambient=101300,
    T_Ambient=293.15,
    medium=Soltermica.Media.Propilenglicol_30()) 
                      annotation (extent=[-28,-16; -48,4]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient sumideroCaudal_2(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=101300,
    T_Ambient=293.15) annotation (extent=[32,40; 52,60]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedAmbient fuenteCaudal_1(
      medium=Soltermica.Media.Propilenglicol_30()) 
    annotation (extent=[-80,0; -60,-20],   rotation=90);
  Modelica.Blocks.Sources.Constant SenalP_cte(k=101300) 
    annotation (extent=[-46,-80; -66,-60]);
  Modelica.Blocks.Sources.Constant SenalT_cte(k=348.15) 
    annotation (extent=[-20,-60; -40,-40]);
  IntercambiadorPlacas intercambiadorPlacas(
    medium_1=Soltermica.Media.Propilenglicol_30(),
    medium_2=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    espec=Soltermica.Intercambiadores.Placas.CatalogoEquipos.Fagor_IP_50(),
    T_ini=293.15,
    n=100)        annotation (extent=[-10,-10; 10,10]);
equation 
  connect(fuenteCaudal_2.flowPort, circulador_2.flowPort_a) 
        annotation (points=[40,-66; 40,-40],
                                         style(color=1, rgbcolor={255,0,0}));
  connect(SenalCaudal_1.y, circulador_1.VolumeFlow)          annotation (
          points=[-21,70; -42,70; -42,38], style(color=74, rgbcolor={0,0,
              127}));
  connect(SenalP_cte.y, fuenteCaudal_1.p_Ambient) annotation (points=[-67,-70;
        -78,-70; -78,-20; -77,-20],          style(color=74, rgbcolor={0,0,
              127}));
  connect(fuenteCaudal_1.flowPort, circulador_1.flowPort_a) 
        annotation (points=[-70,0; -70,28; -52,28],   style(color=1,
            rgbcolor={255,0,0}));
  connect(SenalCaudal_2.y, circulador_2.VolumeFlow)          annotation (
          points=[65,10; 60,10; 60,-30; 50,-30],
                                        style(color=74, rgbcolor={0,0,127}));
      annotation (Diagram);
  connect(fuenteCaudal_1.T_Ambient, SenalT_cte.y) 
                                              annotation (points=[-63,-20; -64,
        -20; -64,-50; -41,-50], style(color=74, rgbcolor={0,0,127}));
  connect(circulador_1.flowPort_b, intercambiadorPlacas.flowPort_a_1) 
    annotation (points=[-32,28; -22,28; -22,6; -10,6], style(color=1, rgbcolor=
          {255,0,0}));
  connect(sumideroCaudal_1.flowPort, intercambiadorPlacas.flowPort_b_1) 
    annotation (points=[-28,-6; -10,-6], style(color=1, rgbcolor={255,0,0}));
  connect(intercambiadorPlacas.flowPort_a_2, circulador_2.flowPort_b) 
    annotation (points=[10,-6; 40,-6; 40,-20], style(color=1, rgbcolor={255,0,0}));
  connect(intercambiadorPlacas.flowPort_b_2, sumideroCaudal_2.flowPort) 
    annotation (points=[10,6; 20,6; 20,50; 32,50], style(color=1, rgbcolor={255,
          0,0}));
end Validacion_01;
