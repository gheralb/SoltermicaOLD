model Circulador 
  "Modelo de circulador como fuente de un determinado caudal nominal" 
  annotation (Documentation(info="<HTML>
<p>
Modelo muy sencillo de circulador hidráulico. Basicamente es una fuente de caudal constante independiente de aspectos relacionados con el resto de la instalación.<br>
En las especificaciones hay que indicar las características nominales (en condiciones que se consideren próximas a la que va a trabajar)<br>
</p>
</HTML>"),
    uses(Modelica(version="2.2.1")),
    Diagram,
    Icon(Ellipse(extent=[-80,-78; 80,80], style(
          color=1,
          rgbcolor={255,0,0},
          gradient=3,
          fillColor=1,
          rgbfillColor={255,0,0})), Polygon(points=[-50,-60; -50,60; 80,0; -50,
            -60], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1))));
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow(
    final medium=medium,
    final T0=T_ini,
    final m=espec.V_circ*medium.rho) 
    annotation (extent=[-10,-40; 10,-20]);
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(
    final amplitude=espec.V_flow_nom,
    rising=5,
    offset=0.00000001) 
    annotation (extent=[-10,2; 10,22], rotation=-90);
  Soltermica.ClasesBasicas.ControlesEquipos.Control_Circulador 
    control_Circulador(final pot_elec_nom=espec.Pot_elec_nom) 
    annotation (extent=[-10,40; 10,60], rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(
    final medium=medium) "Aspiracion del circulador" 
    annotation (extent=[-110,-10; -90,10]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(
    final medium=medium) "Descarga del circulador" 
    annotation (extent=[90,-10; 110,10]);
  Modelica.Blocks.Interfaces.RealInput u "Senal de encendido del circulador" 
    annotation (extent=[-20,126; 20,86], rotation=90);
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium() 
    "Fluido que bombea el circulador";
  parameter Soltermica.Bombas.Circuladores.CatalogoEquipos.Especificaciones 
    espec = Soltermica.Bombas.Circuladores.CatalogoEquipos.Especificaciones() 
    "especificaciones del equipo";
  parameter Modelica.SIunits.Temperature T_ini=293.15 
    "Temperatura inicial del equipo";
  
equation 
  connect(triggeredTrapezoid.y, prescribedVolumeFlow.VolumeFlow) 
    annotation (points=[6.73533e-016,1; 6.73533e-016,-20; 0,-20], style(
      color=74,
      rgbcolor={0,0,127}));
  connect(control_Circulador.y, triggeredTrapezoid.u) 
    annotation (points=[6.49041e-016,39.4; 0,39.4; 0,24; -7.34764e-016,24], style(
      color=5,
        rgbcolor={255,0,255}));
  connect(flowPort_a, prescribedVolumeFlow.flowPort_a) 
    annotation (points=[-100,0; -74,0; -74,-30; -10,-30], style(
      color=1, rgbcolor={255,0,0}));
  connect(prescribedVolumeFlow.flowPort_b, flowPort_b) 
    annotation (points=[10,-30; 62,-30; 62,0; 100,0], style(
      color=1, rgbcolor={255,0,0}));
  connect(control_Circulador.SenalEntrada, u) 
    annotation (points=[-6.61287e-016,60.8; 0,60.8; 0,106], style(
    color=74, rgbcolor={0,0,127}));
end Circulador;
