model Validacion_01 "Validacion basica del circulador" 
annotation (Documentation(info="<HTML>
<p>
Este modelo de validación representa el ensayo común para obtener la curva de una bomba.<br>
Como actualmente el modelo del circulador está muy simplificado esta validación no resulta definitoria.<br>
</p>
</HTML>"));
  
  Circulador circulador(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    espec=Soltermica.Bombas.Circuladores.CatalogoEquipos.GRUNDFOS_UPS_25_120(),
    T_ini=293.15) annotation (extent=[-40,-20; -20,0]);
  
  Modelica.Thermal.FluidHeatFlow.Components.Valve valve(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    y1=1,
    Kv1=0.0002,
    kv0=0.00001,
    dp0=151300,
    rho0=995.6) annotation (extent=[10,-20; 30,0]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient fuente(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[-68,-20; -88,0]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[60,-20; 80,0]);
  annotation (Diagram);
  Modelica.Blocks.Sources.Trapezoid SenalCirculador(
    rising=0.01,
    width=120,
    falling=0.01,
    period=3600,
    startTime=10) annotation (extent=[-66,32; -46,52]);
  Modelica.Blocks.Sources.Trapezoid SenalValvula(
    amplitude=0.5,
    rising=2,
    width=10,
    falling=2,
    period=3600,
    startTime=60) annotation (extent=[-14,32; 6,52]);
equation 
  connect(valve.flowPort_b, ambient1.flowPort) 
    annotation (points=[30,-10; 60,-10], style(color=1, rgbcolor={255,0,0}));
  connect(circulador.flowPort_b, valve.flowPort_a) 
    annotation (points=[-20,-10; 10,-10], style(color=1, rgbcolor={255,0,0}));
  connect(fuente.flowPort, circulador.flowPort_a) 
    annotation (points=[-68,-10; -40,-10], style(color=1, rgbcolor={255,0,0}));
  connect(SenalCirculador.y, circulador.u) annotation (points=[-45,42; -30,42; 
        -30,0.6], style(color=74, rgbcolor={0,0,127}));
  connect(SenalValvula.y, valve.y) annotation (points=[7,42; 20,42; 20,-1],
      style(color=74, rgbcolor={0,0,127}));
end Validacion_01;
