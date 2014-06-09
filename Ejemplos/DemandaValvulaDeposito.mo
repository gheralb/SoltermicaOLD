model DemandaValvulaDeposito 
  "Modelo que integra una instalacon de suministro de ACS" 
  Acumuladores.Acumulador_Orden acumulador_Orden(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    T_ini=343.15,
    espec=Soltermica.Acumuladores.CatalogoEquipos.IDROGAS_CV200SR(),
    n=5) 
    annotation (extent=[12,-28; 32,-8]);
  annotation (Diagram);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient sumidero(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[60,50; 80,70]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient sumidero2(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[-46,-50; -66,-30], rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedAmbient Red(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water()) 
    annotation (extent=[34,12; 54,32]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedAmbient Red1(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water()) 
    annotation (extent=[36,-80; 56,-60]);
  Modelica.Blocks.Sources.CombiTimeTable temperaturaRed(
    tableOnFile=true,
    tableName="Ciudad_Real",
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    offset={273.15},
    fileName="CondicionesContorno\\temperaturasRed.mat") 
                     annotation (extent=[94,-87; 74,-67]);
  Modelica.Blocks.Sources.Constant presionRed(k=251300) 
    annotation (extent=[96,-19; 76,1]);
  Modelica.Blocks.Sources.CombiTimeTable consumoACS(
    tableOnFile=true,
    offset={0},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    tableName="perfilAnual_1",
    fileName="CondicionesContorno\\perfilConsumoAnual.mat") 
                                  annotation (extent=[-50,66; -30,86]);
  Valvulas.Griferia.Monomando monomando(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    dp_grifo=251300,
    Kv_grifo=0.0002) annotation (extent=[2,60; 22,80]);
  Modelica.Blocks.Sources.Constant regulacionTemperatura(k=0) 
    annotation (extent=[-50,36; -30,56]);
  Intercambiadores.Placas.IntercambiadorPlacas intercambiadorPlacas(
    n=4,
    medium_1=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    medium_2=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    espec=Soltermica.Intercambiadores.Placas.CatalogoEquipos.Fagor_IP_50(),
    T_ini=293.15) annotation (extent=[-48,-20; -28,0]);
  Bombas.Circuladores.Circulador circulador(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    espec=Soltermica.Bombas.Circuladores.CatalogoEquipos.GRUNDFOS_UPS_25_120(),
    T_ini=293.15) annotation (extent=[-76,-14; -56,6]);
  Modelica.Blocks.Sources.Trapezoid SenalCirculador(
    rising=0.01,
    width=120,
    falling=0.01,
    period=3600,
    startTime=10) annotation (extent=[-94,26; -74,46]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient fuente(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[-74,-52; -94,-32], rotation=-90);
  Bombas.Circuladores.Circulador circuladorCarga(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    espec=Soltermica.Bombas.Circuladores.CatalogoEquipos.GRUNDFOS_UPS_25_120(),
    T_ini=293.15) annotation (extent=[-6,-16; -26,-36]);
  
  Modelica.Blocks.Sources.Trapezoid SenalCirculadorCarga(
    rising=0.01,
    width=120,
    falling=0.01,
    period=3600,
    startTime=10) annotation (extent=[-40,-82; -20,-62]);
  Modelica.Thermal.FluidHeatFlow.Sources.AbsolutePressure absolutePressure(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(), p=101300) 
    annotation (extent=[-6,-72; 14,-52], rotation=-90);
equation 
  connect(Red1.flowPort, acumulador_Orden.flowPort_a) annotation (points=[36,-70;
        22,-70; 22,-28],        style(color=1, rgbcolor={255,0,0}));
  connect(temperaturaRed.y[1], Red1.T_Ambient) 
    annotation (points=[73,-77; 56,-77], style(color=74, rgbcolor={0,0,127}));
  connect(temperaturaRed.y[1], Red.T_Ambient) annotation (points=[73,-77; 64,
        -77; 64,15; 54,15],   style(color=74, rgbcolor={0,0,127}));
  connect(presionRed.y, Red.p_Ambient) 
    annotation (points=[75,-9; 68,-9; 68,29; 54,29],
                                         style(color=74, rgbcolor={0,0,127}));
  connect(presionRed.y, Red1.p_Ambient) annotation (points=[75,-9; 68,-9; 68,
        -63; 56,-63], style(color=74, rgbcolor={0,0,127}));
  connect(acumulador_Orden.flowPort_b, monomando.caliente) annotation (points=[22,-8;
        22,0; 8,0; 8,60],           style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(monomando.fria, Red.flowPort) annotation (points=[16,60; 16,22; 34,22],
              style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(monomando.flowPort_b, sumidero.flowPort) annotation (points=[22,70;
        22,60; 60,60], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(consumoACS.y[1], monomando.caudal) annotation (points=[-29,76; 1.4,76],
                         style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(regulacionTemperatura.y, monomando.temperatura) annotation (points=[-29,46;
        -20,46; -20,70; 1.4,70],         style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(intercambiadorPlacas.flowPort_b_2, acumulador_Orden.flowPort_a1) 
    annotation (points=[-28,-4; 4,-4; 4,-18; 12,-18], style(color=1, rgbcolor={
          255,0,0}));
  connect(sumidero2.flowPort, intercambiadorPlacas.flowPort_b_1) annotation (
      points=[-56,-30; -56,-16; -48,-16], style(color=1, rgbcolor={255,0,0}));
  connect(SenalCirculador.y, circulador.u) annotation (points=[-73,36; -66,36; 
        -66,6.6], style(color=74, rgbcolor={0,0,127}));
  connect(fuente.flowPort, circulador.flowPort_a) annotation (points=[-84,-32;
        -84,-4; -76,-4], style(color=1, rgbcolor={255,0,0}));
  connect(circulador.flowPort_b, intercambiadorPlacas.flowPort_a_1) 
    annotation (points=[-56,-4; -48,-4], style(color=1, rgbcolor={255,0,0}));
  connect(circuladorCarga.flowPort_b, intercambiadorPlacas.flowPort_a_2) 
    annotation (points=[-26,-26; -26,-16; -28,-16], style(color=1, rgbcolor={
          255,0,0}));
  connect(circuladorCarga.flowPort_a, acumulador_Orden.flowPort_b1) 
    annotation (points=[-6,-26; 12,-26], style(color=1, rgbcolor={255,0,0}));
  connect(SenalCirculadorCarga.y, circuladorCarga.u) annotation (points=[-19,
        -72; -16,-72; -16,-36.6], style(color=74, rgbcolor={0,0,127}));
  connect(absolutePressure.flowPort, circuladorCarga.flowPort_a) annotation (
      points=[4,-52; 4,-26; -6,-26], style(color=1, rgbcolor={255,0,0}));
end DemandaValvulaDeposito;
