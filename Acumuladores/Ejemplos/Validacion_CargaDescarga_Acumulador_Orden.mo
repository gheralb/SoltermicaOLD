model Validacion_CargaDescarga_Acumulador_Orden 
  "Modelo que muestra el comportamiento del acumulador cuando se carga y descarga de energia" 
    annotation (uses(Modelica(version="2.2.1")), Diagram);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow CaudalEntrada(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(), m=0.1) 
            annotation (extent=[-40,0; -20,20]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ida(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=101300,
    T_Ambient=Modelica.SIunits.Conversions.from_degC(70)) 
    annotation (extent=[-62,-60; -42,-40], rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient retorno(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[-28,-58; -8,-38],  rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient red(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[60,-60; 80,-40],rotation=0);
  Modelica.Blocks.Sources.Trapezoid SenalCarga(
    amplitude=0.0002,
    rising=10,
    falling=10,
    startTime=10,
    period=86400,
    width=1000,
    offset=0)         annotation (extent=[-60,42; -40,62]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient sumidero(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[60,42; 40,62], rotation=-180);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow CaudalConsumo(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(), m=0.1) 
            annotation (extent=[40,-60; 20,-40]);
  Modelica.Blocks.Sources.Trapezoid SenalConsumo(
    amplitude=0.0002,
    rising=10,
    falling=10,
    offset=0.0000001,
    period=86400,
    width=600,
    startTime=1000)   annotation (extent=[60,-20; 40,0]);
  Acumulador_Orden acumulador_Orden(
    n=4,
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    espec=Soltermica.Acumuladores.CatalogoEquipos.IDROGAS_CV200SR(),
    T_ini=293.15) annotation (extent=[-6,-18; 14,2]);
equation 
  connect(ida.flowPort, CaudalEntrada.flowPort_a)            annotation (points=[-52,-40;
        -52,10; -40,10],            style(color=1, rgbcolor={255,0,0}));
  connect(SenalCarga.y, CaudalEntrada.VolumeFlow)       annotation (points=[-39,52;
        -30,52; -30,20],    style(color=74, rgbcolor={0,0,127}));
  connect(SenalConsumo.y, CaudalConsumo.VolumeFlow) annotation (points=[39,-10;
        30,-10; 30,-40], style(
      color=74,
      rgbcolor={0,0,127},
      gradient=1,
      fillColor=0,
      rgbfillColor={0,0,0}));
  connect(CaudalConsumo.flowPort_a, red.flowPort) annotation (points=[40,-50;
        60,-50], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=1,
      fillColor=0,
      rgbfillColor={0,0,0}));
  connect(CaudalEntrada.flowPort_b, acumulador_Orden.flowPort_a1) annotation (
      points=[-20,10; -14,10; -14,-8; -6,-8], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(acumulador_Orden.flowPort_b1, retorno.flowPort) annotation (points=[
        -6,-16; -18,-16; -18,-38], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(acumulador_Orden.flowPort_a, CaudalConsumo.flowPort_b) annotation (
      points=[4,-18; 4,-50; 20,-50], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(acumulador_Orden.flowPort_b, sumidero.flowPort) annotation (points=[4,
        2; 4,52; 40,52], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
end Validacion_CargaDescarga_Acumulador_Orden;
