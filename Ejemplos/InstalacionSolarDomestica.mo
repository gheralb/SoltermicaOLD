model InstalacionSolarDomestica "Modelo de instalacion solare termica basica" 
  annotation (Diagram,
    experiment,
    experimentSetupOutput);
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Consumo(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=101300,
    T_Ambient=293.15) 
      annotation (extent=[80,38; 100,58]);
  Modelica.Thermal.FluidHeatFlow.Sources.AbsolutePressure PresionReferencia(
      medium=Soltermica.Media.Propilenglicol_30_25(),
                                                   p=251300) 
    annotation (extent=[-14,-66; 6,-86], rotation=90);
  Acumuladores.Interacumuladores.Interacumulador_Mezcla interacumulador_Mezcla(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    medium_int=Soltermica.Media.Propilenglicol_30_25(),
    espec=
        Soltermica.Acumuladores.Interacumuladores.CatalogoEquipos.LAPESA_CV_80_M1S(),
    T_ini=293.15,
    n_int=2,
    n=5)     annotation (extent=[4,-20; 24,0]);
  
  ColectoresSolares.ColectorSolar colectorSolar(
    medium=Soltermica.Media.Propilenglicol_30_25(),
    espec=Soltermica.ColectoresSolares.CatalogoEquipos.BAXIROCA_PS_2_0(),
    T_ini=293.15) annotation (extent=[-60,-12; -40,8]);
  Modelica.Blocks.Sources.CombiTimeTable consumoACS(
    tableOnFile=true,
    offset={0},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    tableName="perfilAnual_1",
    fileName="CondicionesContorno\\perfilConsumoAnual.mat") 
                                  annotation (extent=[0,80; 20,100]);
  Modelica.Blocks.Sources.CombiTimeTable irradiacion(
    tableOnFile=true,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    offset={1},
    tableName="IrradAnual",
    extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
    fileName="CondicionesContorno\\D3pen_Irrad_39_20.mat") 
                            annotation (extent=[-100,40; -80,60]);
  Modelica.Blocks.Sources.CombiTimeTable temperaturaSeca(
    tableOnFile=true,
    offset={0},
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    tableName="D3_TempSec",
    fileName="CondicionesContorno\\TemperaturasSeca.mat") 
                                  annotation (extent=[-100,0; -80,20]);
  Modelica.Blocks.Sources.CombiTimeTable temperaturaRed(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    tableName="Ciudad_Real",
    offset={273.15},
    fileName="CondicionesContorno\\temperaturasRed.mat") 
                                  annotation (extent=[100,-80; 80,-60]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedAmbient Red(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water()) 
    annotation (extent=[56,-36; 36,-56], rotation=180);
  Modelica.Blocks.Sources.Constant presionRed(k=251300) 
    annotation (extent=[100,-40; 80,-20]);
  Bombas.Circuladores.Circulador circulador(
    medium=Soltermica.Media.Propilenglicol_30_25(),
    espec=Soltermica.Bombas.Circuladores.CatalogoEquipos.GRUNDFOS_UPS_25_120(),
    T_ini=293.15) annotation (extent=[-26,-68; -46,-48]);
  
  Controladores.ControladorSolar controladorSolar(
    Temp_Acum=333,
    DeltaT_on=4,
    DeltaT_off=2) annotation (extent=[-30,-40; -10,-20]);
  Calderas.Caldera caldera(
    espec=Soltermica.Calderas.CatalogoEquipos.BAXI_PLATINIUM_24_24F(),
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    T_ini=293.15,
    TempReg=50)   annotation (extent=[16,20; 36,40]);
  Modelica.Blocks.Sources.Constant tempAmbInt(k=293.15) 
    annotation (extent=[-40,20; -20,40]);
  Valvulas.Griferia.Monomando monomando(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    dp_grifo=251300,
    Kv_grifo=0.0002) annotation (extent=[46,44; 66,64]);
  Modelica.Blocks.Sources.Constant regulacionTempertura(k=0) 
    annotation (extent=[-40,60; -20,80]);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedAmbient AF(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water()) 
    annotation (extent=[66,0; 46,-20],   rotation=180);
  Modelica.Blocks.Sources.Constant factorSombras(k=0) 
    annotation (extent=[-100,-40; -80,-20]);
equation 
  connect(colectorSolar.flowPort_b, interacumulador_Mezcla.flowPort_a1) 
    annotation (points=[-40,6; -20,6; -20,-10; 4,-10],   style(color=1,
        rgbcolor={255,0,0}));
  connect(temperaturaSeca.y[1], colectorSolar.senalTemperatura) annotation (
      points=[-79,10; -72,10; -72,0; -60.8,0],     style(color=74, rgbcolor={0,
          0,127}));
  connect(irradiacion.y[1], colectorSolar.senalIrradiacion) annotation (points=[-79,50;
        -66,50; -66,6; -60.8,6],            style(color=74, rgbcolor={0,0,127}));
  connect(Red.flowPort, interacumulador_Mezcla.flowPort_a) annotation (points=[36,-46;
        14,-46; 14,-20],         style(color=1, rgbcolor={255,0,0}));
  connect(temperaturaRed.y[1], Red.T_Ambient) annotation (points=[79,-70; 66,
        -70; 66,-53; 56,-53], style(color=74, rgbcolor={0,0,127}));
  connect(presionRed.y, Red.p_Ambient) annotation (points=[79,-30; 64,-30; 64,
        -39; 56,-39], style(color=74, rgbcolor={0,0,127}));
  connect(circulador.flowPort_b, colectorSolar.flowPort_a) annotation (points=[-46,-58;
        -70,-58; -70,-10; -60,-10],          style(color=1, rgbcolor={255,0,0}));
  connect(circulador.flowPort_a, interacumulador_Mezcla.flowPort_b1) 
    annotation (points=[-26,-58; -4,-58; -4,-18; 4,-18], style(color=1,
        rgbcolor={255,0,0}));
  connect(colectorSolar.SenTemp, controladorSolar.TempCol) annotation (points=[-39.4,2;
        -34,2; -34,-24; -30,-24],         style(color=74, rgbcolor={0,0,127}));
  connect(interacumulador_Mezcla.SensorTemperatura, controladorSolar.TempDep) 
    annotation (points=[24.6,-5; -38,-5; -38,-30; -30,-30],
                                                       style(color=74, rgbcolor=
         {0,0,127}));
  connect(PresionReferencia.flowPort, circulador.flowPort_a) annotation (points=[-4,-66; 
        -4,-58; -26,-58],                  style(color=1, rgbcolor={255,0,0}));
  connect(interacumulador_Mezcla.flowPort_b, caldera.flowPort_a) annotation (points=[14,0; 14,
        20; 20,20],          style(color=1, rgbcolor={255,0,0}));
  connect(tempAmbInt.y, caldera.T_amb) annotation (points=[-19,30; -4,30; -4,36;
        15.2,36], style(color=74, rgbcolor={0,0,127}));
  connect(monomando.flowPort_b, Consumo.flowPort) annotation (points=[66,54; 66,
        48; 80,48], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(caldera.flowPort_b, monomando.caliente) annotation (points=[32,20; 32,
        14; 52,14; 52,44], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(consumoACS.y[1], monomando.caudal) annotation (points=[21,90; 38,90;
        38,60; 45.4,60], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(controladorSolar.y, circulador.u) annotation (points=[-9.4,-30; -8,
        -30; -8,-40; -36,-40; -36,-47.4], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(regulacionTempertura.y, monomando.temperatura) annotation (points=[
        -19,70; 14,70; 14,54; 45.4,54], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(AF.p_Ambient, presionRed.y) annotation (points=[66,-3; 76,-3; 76,-30; 
        79,-30], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(AF.T_Ambient, temperaturaRed.y[1]) annotation (points=[66,-17; 74,-17;
        74,-70; 79,-70], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(AF.flowPort, monomando.fria) annotation (points=[46,-10; 40,-10; 40,
        10; 60,10; 60,44], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
  connect(factorSombras.y, colectorSolar.factorSombras) annotation (points=[-79,
        -30; -74,-30; -74,-6; -60.8,-6], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
end InstalacionSolarDomestica;
