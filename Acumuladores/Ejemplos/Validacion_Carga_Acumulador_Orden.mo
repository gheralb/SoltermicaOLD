model Validacion_Carga_Acumulador_Orden 
  "Modelo que muestra el comportamiento basico del acumulador cuando se carga de energía" 
  annotation (uses(Modelica(version="2.2.1")), Diagram);
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow CaudalEntrada(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(), m=0.1) 
            annotation (extent=[-38,-18; -18,2]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ida(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=101300,
    T_Ambient=Modelica.SIunits.Conversions.from_degC(70)) 
    annotation (extent=[-60,-60; -40,-40], rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient retorno(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[-22,-60; -2,-40],  rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient red(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[40,-60; 60,-40],rotation=0);
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=0.0002,
    rising=10,
    falling=10,
    startTime=10,
    period=86400,
    width=1000,
    offset=0)         annotation (extent=[-60,20; -40,40]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient sumidero(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[60,20; 40,40], rotation=-180);
  Acumulador_Orden acumulador_Orden(
    n=4,
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    espec=Soltermica.Acumuladores.CatalogoEquipos.IDROGAS_CV200SR(),
    T_ini=293.15) annotation (extent=[0,-20; 20,0]);
equation 
  connect(ida.flowPort, CaudalEntrada.flowPort_a)            annotation (points=[-50,-40;
        -50,-8; -38,-8],            style(color=1, rgbcolor={255,0,0}));
  connect(trapezoid.y, CaudalEntrada.VolumeFlow)        annotation (points=[-39,30;
        -28,30; -28,2],     style(color=74, rgbcolor={0,0,127}));
  connect(CaudalEntrada.flowPort_b, acumulador_Orden.flowPort_a1) annotation (
      points=[-18,-8; -10,-8; -10,-10; 0,-10], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(retorno.flowPort, acumulador_Orden.flowPort_b1) annotation (points=[
        -12,-40; -12,-18; 0,-18], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(red.flowPort, acumulador_Orden.flowPort_a) annotation (points=[40,-50;
        10,-50; 10,-20], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(acumulador_Orden.flowPort_b, sumidero.flowPort) annotation (points=[
        10,0; 10,30; 40,30], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
end Validacion_Carga_Acumulador_Orden;
