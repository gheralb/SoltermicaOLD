model CargaSolarDeposito 
  
  ColectoresSolares.ColectorSolar colectorSolar(medium=
        Soltermica.Media.Propilenglicol_30(), esp=
        Soltermica.ColectoresSolares.CatalogoEquipos.BAXIROCA_PS_2_0()) 
    annotation (extent=[-42,-10; -22,10]);
  Acumuladores.Interacumuladores.InteracumuladorSerpentin 
    interacumuladorSerpentin(
    medium_int=Soltermica.Media.Propilenglicol_30(),
    medium_dep=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    esp=Soltermica.Acumuladores.Interacumuladores.CatalogoEquipos.LAPESA_CV80M1S(),
    T0=293.15) annotation (extent=[12,-20; 32,0]);
  
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow CirculadorSolar(
      medium=Soltermica.Media.Propilenglicol_30(), m=0.1) 
    annotation (extent=[-20,-40; -40,-60]);
  annotation (Diagram);
  Modelica.Thermal.HeatTransfer.PrescribedHeatFlow FuenteRadiacion 
    annotation (extent=[-60,32; -40,52]);
  Modelica.Blocks.Sources.Constant TemperaturaExterior(k=303.15) 
    annotation (extent=[-100,-2; -80,18]);
    Modelica.Blocks.Sources.Trapezoid DistribucionDemanda(
    rising=1, 
    falling=1, 
    startTime=20, 
    amplitude=0.0002, 
    width=300, 
    period=28800)       annotation (extent=[98,-94; 78,-74]);
    Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow FuenteDemanda(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(), 
    m=0.1, 
    T0=293.15) annotation (extent=[54,-32; 34,-52]);
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient Red(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(), 
    p_Ambient=101300, 
    T_Ambient=293.15) 
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
    offset=0)  annotation (extent=[-100,32; -80,52]);
  Controladores.ControladorSolar controladorSolar(
    DeltaT_on=4, 
    DeltaT_off=1, 
    Temp_Acum=333) annotation (extent=[46,12; 66,32]);
  Modelica.Thermal.FluidHeatFlow.Sources.AbsolutePressure PresionReferencia(
      medium=Soltermica.Media.Propilenglicol_30(), p=251300)
    annotation (extent=[0,-76; 20,-56]);
equation 
  connect(CirculadorSolar.flowPort_a, interacumuladorSerpentin.flowPort_b_int) 
    annotation (points=[-20,-50; 10,-50; 10,-18; 12,-18],
                                                        style(color=1, rgbcolor=
         {255,0,0}));
  connect(CirculadorSolar.flowPort_b, colectorSolar.flowPort_a) 
    annotation (points=[-40,-50; -56,-50; -56,0; -42,0],     style(color=1,
        rgbcolor={255,0,0}));
  connect(colectorSolar.flowPort_b, interacumuladorSerpentin.flowPort_a_int) 
    annotation (points=[-22,0; 4,0; 4,-10; 12,-10],
                                        style(color=1, rgbcolor={255,0,0}));
  connect(FuenteRadiacion.port, colectorSolar.port_a)    annotation (points=[-40,42; 
        -32,42; -32,10],        style(color=42, rgbcolor={191,0,0}));
  connect(TemperaturaExterior.y, colectorSolar.u) 
                                     annotation (points=[-79,8; -42,8],
                 style(color=74, rgbcolor={0,0,127}));
  connect(DistribucionDemanda.y, FuenteDemanda.VolumeFlow) 
                                                         annotation (points=[77,-84; 
        44,-84; 44,-52],      style(color=74, rgbcolor={0,0,127}));
  connect(FuenteDemanda.flowPort_a, Red.flowPort)             annotation (
      points=[54,-42; 80,-42],                 style(color=1, rgbcolor={255,0,0}));
  connect(FuenteDemanda.flowPort_b, interacumuladorSerpentin.flowPort_a_dep) 
    annotation (points=[34,-42; 22,-42; 22,-20],         style(color=1,
        rgbcolor={255,0,0}));
  connect(interacumuladorSerpentin.flowPort_b_dep, Consumo.flowPort) 
    annotation (points=[22,0; 22,50; 80,50], style(color=1, rgbcolor={255,0,0}));
  connect(DistribucionRadiacion.y, FuenteRadiacion.Q_flow) 
                                                  annotation (points=[-79,42; 
        -60,42], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=61,
      rgbfillColor={0,255,128},
      fillPattern=1));
  connect(colectorSolar.SenTemp, controladorSolar.TempCol) annotation (points=[
        -21.4,8; 14,8; 14,28; 46,28], style(color=74, rgbcolor={0,0,127}));
  connect(interacumuladorSerpentin.SenTemp, controladorSolar.TempDep) 
    annotation (points=[32.6,-2; 42,-2; 42,22; 46,22], style(color=74, rgbcolor
        ={0,0,127}));
  connect(controladorSolar.y, CirculadorSolar.VolumeFlow) annotation (points=[
        66.6,22; 70,22; 70,-80; -30,-80; -30,-60], style(color=74, rgbcolor={0,
          0,127}));
  connect(PresionReferencia.flowPort, CirculadorSolar.flowPort_a) annotation (
      points=[0,-66; -10,-66; -10,-50; -20,-50], style(color=1, rgbcolor={255,0,
          0}));
end CargaSolarDeposito;
