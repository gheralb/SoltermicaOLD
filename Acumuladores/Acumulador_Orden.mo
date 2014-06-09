model Acumulador_Orden 
  "Deposito acumulador cerrado. Estratificacion mediante ordenamiento de carga" 
  
  annotation (Diagram, Icon(Rectangle(extent=[-80,-100; 82,100], style(
          pattern=0,
          gradient=1,
          fillColor=71,
          rgbfillColor={85,170,255}))));
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(
    final medium=medium) "Entrada de agua fria de red" 
    annotation (extent=[-10,-110; 10,-90]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(
    final medium=medium) "Salida de agua caliente para consumo" 
    annotation (extent=[-10,90; 10,110]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a1(
    final medium=medium) "Entrada de agua caliente intercambiada" 
    annotation (extent=[-110,-10; -90,10]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b1(
    final medium=medium) "Salida de agua menos caliente intercambiada" 
    annotation (extent=[-110,-90; -90,-70]);
  Soltermica.ClasesBasicas.VolumenesControl.VolumenControlUnico volumenControl(
    final Volumen=0,
    final dP_nom=espec.dp_nom,
    final cV_nom=espec.V_flow_nom,
    final medium=medium) 
    annotation (extent=[-60,-40; -80,-60], rotation=90);
  Modelica.Thermal.FluidHeatFlow.Sensors.m_flowSensor m_flowSensor(
    final medium=medium) 
    annotation (extent=[-80,-10; -60,-30], rotation=90);
  Modelica.Thermal.FluidHeatFlow.Sensors.TSensor tSensor(
    final medium=medium) 
    annotation (extent=[-68,4; -48,24]);
  Soltermica.ClasesBasicas.ControlesEquipos.Control_Acumulador_Orden 
    ControlEstratificacion(
    final medium=medium,
    final n=n,
    final volumen=espec.volumen,
    final altura=espec.altura) 
    annotation (extent=[-20,-40; 0,-20]);
  Soltermica.ClasesBasicas.VolumenesControl.VolumenesControl1D 
    volumenesControl1D(
    final n=n,
    final medium=medium,
    final volumen=espec.volumen,
    final longitud=espec.altura,
    final dp_nom=espec.dp_nom,
    final V_flow_nom=espec.V_flow_nom,
    final T_ini=T_ini) 
    annotation (extent=[20,-40; 40,-20], rotation=90);
  parameter Integer n(min=2)=2 
    "Numero de segmentos que se divide el volumen de control";
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium() 
    "Fluido contenido en el deposito";
  parameter Soltermica.Acumuladores.CatalogoEquipos.Especificaciones espec = Soltermica.Acumuladores.CatalogoEquipos.Especificaciones() 
    "Especificaciones del equipo";
    parameter Modelica.SIunits.Temp_K T_ini=293.15 
    "Temperatura inicial de todo el deposito";
equation 
  connect(flowPort_a1, m_flowSensor.flowPort_a) 
    annotation (points=[-100,0; -70,0; -70,-10],style(
      color=1,
      rgbcolor={255,0,0}));
  connect(m_flowSensor.flowPort_b, volumenControl.flowPort_a) 
    annotation (points=[-70,-30; -70,-40],style(
      color=1,
      rgbcolor={255,0,0}));
  connect(volumenControl.flowPort_b, flowPort_b1) 
    annotation (points=[-70,-60;-70,-80; -100,-80], style(
      color=1,
      rgbcolor={255,0,0}));
  connect(tSensor.flowPort, flowPort_a1) 
    annotation (points=[-68,14; -86,14;-86,0; -100,0], style(
      color=1,
      rgbcolor={255,0,0},
      pattern=0,
      gradient=1,
      fillColor=71,
      rgbfillColor={85,170,255}));
  connect(tSensor.y, ControlEstratificacion.T_in) 
    annotation (points=[-47,14;-34,14; -34,-24; -20,-24], style(
      color=74,
      rgbcolor={0,0,127},
      pattern=3,
      gradient=1,
      fillColor=0,
      rgbfillColor={0,0,0}));
  connect(m_flowSensor.y, ControlEstratificacion.m_flow) 
    annotation (points=[-59,-20;-40,-20; -40,-30; -20,-30], style(
      color=74,
      rgbcolor={0,0,127},
      pattern=3,
      gradient=1,
      fillColor=0,
      rgbfillColor={0,0,0}));
  connect(volumenControl.puertoInt, ControlEstratificacion.port_a) 
    annotation (points=[-60,-50; -40,-50; -40,-36; -20,-36], style(
      color=42,
      rgbcolor={191,0,0},
      gradient=1,
      fillColor=0,
      rgbfillColor={0,0,0}));
  connect(volumenesControl1D.flowPort_a, flowPort_a) 
    annotation (points=[30,-40;30,-60; 0,-60; 0,-100], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=2));
  connect(volumenesControl1D.flowPort_b, flowPort_b) 
    annotation (points=[30,-20;30,20; 0,20; 0,100], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=2));
  connect(ControlEstratificacion.puertoInt, volumenesControl1D.puertoInt) 
    annotation (points=[0,-30; 20,-30], style(
      color=42,
      rgbcolor={191,0,0},
      gradient=2));
end Acumulador_Orden;
