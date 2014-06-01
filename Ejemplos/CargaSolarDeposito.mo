model CargaSolarDeposito 
  
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow CirculadorSolar(
      medium=Soltermica.Media.Propilenglicol_30(), m=0.1) 
    annotation (extent=[-20,-40; -40,-60]);
  annotation (Diagram);
  Modelica.Blocks.Sources.Constant TemperaturaExterior(k=303.15) 
    annotation (extent=[-100,-2; -80,18]);
    Modelica.Blocks.Sources.Trapezoid DistribucionDemanda(
    rising=1,
    falling=1,
    startTime=20,
    period=28800,
    amplitude=1,
    width=600)          annotation (extent=[-8,72; 12,92]);
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Red(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    T_Ambient=293.15,
    p_Ambient=301300) 
                     annotation (extent=[80,-52; 100,-32]);
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Consumo(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=101300,
    T_Ambient=293.15) 
      annotation (extent=[80,40; 100,60]);
  Modelica.Blocks.Sources.Trapezoid DistribucionRadiacion(
    startTime=40,
    amplitude=600,
    rising=14400,
    width=1440,
    falling=14400,
    period=96400,
    offset=1)  annotation (extent=[-100,32; -80,52]);
  Controladores.ControladorSolar controladorSolar(
    DeltaT_on=4,
    DeltaT_off=1,
    Temp_Acum=333) annotation (extent=[46,12; 66,32]);
  Modelica.Thermal.FluidHeatFlow.Sources.AbsolutePressure PresionReferencia(
      medium=Soltermica.Media.Propilenglicol_30(), p=251300) 
    annotation (extent=[0,-76; 20,-56]);
  Acumuladores.Interacumuladores.Interacumulador_Mezcla interacumulador_Mezcla(
    n=5,
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    medium_int=Soltermica.Media.Propilenglicol_30(),
    espec=
        Soltermica.Acumuladores.Interacumuladores.CatalogoEquipos.LAPESA_CV_80_M1S(),
    T_ini=293.15,
    n_int=3) annotation (extent=[0,-20; 20,0]);
  
  Modelica.Thermal.FluidHeatFlow.Components.Valve valve(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    rho0=995.6,
    Kv1=0.0001,
    dp0=100000) annotation (extent=[20,40; 40,60]);
  ColectoresSolares.ColectorSolar colectorSolar(
    medium=Soltermica.Media.Propilenglicol_30(),
    espec=Soltermica.ColectoresSolares.CatalogoEquipos.BAXIROCA_PS_2_0(),
    T_ini=293.15) annotation (extent=[-58,-20; -38,0]);
equation 
  connect(controladorSolar.y, CirculadorSolar.VolumeFlow) annotation (points=[
        66.6,22; 70,22; 70,-80; -30,-80; -30,-60], style(color=74, rgbcolor={0,
          0,127}));
  connect(PresionReferencia.flowPort, CirculadorSolar.flowPort_a) annotation (
      points=[0,-66; -10,-66; -10,-50; -20,-50], style(color=1, rgbcolor={255,0,
          0}));
  connect(valve.flowPort_b, Consumo.flowPort) 
    annotation (points=[40,50; 80,50], style(color=1, rgbcolor={255,0,0}));
  connect(interacumulador_Mezcla.flowPort_b, valve.flowPort_a) annotation (
      points=[10,0; 10,50; 20,50], style(color=1, rgbcolor={255,0,0}));
  connect(Red.flowPort, interacumulador_Mezcla.flowPort_a) annotation (points=[
        80,-42; 10,-42; 10,-20], style(color=1, rgbcolor={255,0,0}));
  connect(interacumulador_Mezcla.SensorTemperatura, controladorSolar.TempDep) 
    annotation (points=[20.6,-5; 33.3,-5; 33.3,22; 46,22], style(color=74,
        rgbcolor={0,0,127}));
  connect(colectorSolar.SenTemp, controladorSolar.TempCol) annotation (points=[
        -37.4,-6; -30,-6; -30,28; 46,28], style(color=74, rgbcolor={0,0,127}));
  connect(colectorSolar.flowPort_b, interacumulador_Mezcla.flowPort_a1) 
    annotation (points=[-38,-2; -20,-2; -20,-10; 0,-10], style(color=1,
        rgbcolor={255,0,0}));
  connect(interacumulador_Mezcla.flowPort_b1, CirculadorSolar.flowPort_a) 
    annotation (points=[0,-18; -10,-18; -10,-50; -20,-50], style(color=1,
        rgbcolor={255,0,0}));
  connect(CirculadorSolar.flowPort_b, colectorSolar.flowPort_a) annotation (
      points=[-40,-50; -76,-50; -76,-18; -58,-18], style(color=1, rgbcolor={255,
          0,0}));
  connect(TemperaturaExterior.y, colectorSolar.senalTemperatura) annotation (
      points=[-79,8; -70,8; -70,-10; -58.8,-10], style(color=74, rgbcolor={0,0,
          127}));
  connect(DistribucionRadiacion.y, colectorSolar.senalIrradiacion) annotation (
      points=[-79,42; -68,42; -68,-2; -58.8,-2], style(color=74, rgbcolor={0,0,
          127}));
  connect(DistribucionDemanda.y, valve.y) annotation (points=[13,82; 30,82; 30,
        59], style(color=74, rgbcolor={0,0,127}));
end CargaSolarDeposito;
