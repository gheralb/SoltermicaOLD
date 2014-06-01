model ColectorSolar 
  
  annotation (uses(Modelica(version="2.2.1")), DymolaStoredErrors,
    Diagram,
    Icon(
      Polygon(points=[-70,-46; -10,74; 70,54; 10,-66; -70,-46], style(
          color=7,
          rgbcolor={255,255,255},
          fillColor=0,
          rgbfillColor={0,0,0})),
      Polygon(points=[-70,-46; 10,-66; 10,-76; -70,-56; -70,-46], style(
          color=7,
          rgbcolor={255,255,255},
          fillColor=10,
          rgbfillColor={135,135,135})),
      Polygon(points=[10,-66; 70,54; 70,44; 10,-76; 10,-66], style(
          color=7,
          rgbcolor={255,255,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1))));
  Modelica.Blocks.Interfaces.RealInput senalIrradiacion 
                                         annotation (extent=[-128,60; -88,100]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=
        medium) 
    annotation (extent=[-110,-90; -90,-70]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=
        medium) 
    annotation (extent=[90,70; 110,90]);
  
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  
  parameter ColectoresSolares.CatalogoEquipos.Especificaciones espec=ColectoresSolares.CatalogoEquipos.Especificaciones();
  
  parameter Real T_ini;
  
  Modelica.Blocks.Interfaces.RealOutput SenTemp 
    annotation (extent=[96,30; 116,50]);
  Modelica.Thermal.HeatTransfer.HeatCapacitor masaTermica(final C=espec.CapacidadTermicaVacio) 
    annotation (extent=[20,20; 40,40]);
  Modelica.Thermal.HeatTransfer.PrescribedHeatFlow gananciaSolar 
    annotation (extent=[-14,64; 6,44], rotation=90);
  Modelica.Thermal.HeatTransfer.PrescribedHeatFlow perdidasAmbiente 
    annotation (extent=[-40,34; -20,54], rotation=-90);
  Modelica.Blocks.Interfaces.RealInput senalTemperatura 
                                         annotation (extent=[-128,-20; -88,20]);
  Soltermica.ClasesBasicas.ControlesEquipos.Control_Colector control_Colector(
                                                  final espec=espec) 
    annotation (extent=[-64,60; -44,80]);
  Modelica.Thermal.HeatTransfer.TemperatureSensor temperatureSensor 
    annotation (extent=[-20,-48; 0,-68], rotation=90);
  Soltermica.ClasesBasicas.VolumenesControl.VolumenControlUnico 
    volumenControlUnico1(
    final medium=medium,
    final Volumen=espec.V_col,
    final dP_nom=espec.dp_nom,
    final cV_nom=espec.V_flow_nom,
    final T_ini=T_ini) annotation (extent=[-20,-36; 0,-16]);
equation 
  
  connect(control_Colector.ganancias, gananciaSolar.Q_flow) annotation (points=[-43.4,74;
        -4,74; -4,64],                     style(color=74, rgbcolor={0,0,127}));
  connect(control_Colector.perdidas, perdidasAmbiente.Q_flow) annotation (
      points=[-43.4,66; -30,66; -30,54],         style(color=74, rgbcolor={0,0,
          127}));
  connect(senalTemperatura, control_Colector.senalTemperaturaAmbiente) 
    annotation (points=[-108,0; -84,0; -84,70; -64.8,70], style(color=74,
        rgbcolor={0,0,127}));
  connect(senalIrradiacion, control_Colector.senalIrradiacion) annotation (
      points=[-108,80; -102,80; -102,76; -64.8,76], style(color=74, rgbcolor={0,
          0,127}));
  connect(temperatureSensor.T, SenTemp) annotation (points=[-10,-68; -10,-76;
        80,-76; 80,40; 106,40], style(
      color=74,
      rgbcolor={0,0,127},
      gradient=2));
  connect(control_Colector.senalTemperaturaCaptador, temperatureSensor.T) 
    annotation (points=[-64.6,64; -76,64; -76,-76; -10,-76; -10,-68], style(
      color=74,
      rgbcolor={0,0,127},
      gradient=2));
  connect(volumenControlUnico1.puertoExt, temperatureSensor.port) annotation (
      points=[-10,-36; -10,-48], style(
      color=42,
      rgbcolor={191,0,0},
      gradient=2));
  connect(flowPort_a, volumenControlUnico1.flowPort_a) annotation (points=[-100,
        -80; -60,-80; -60,-26; -20,-26], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=2));
  connect(volumenControlUnico1.flowPort_b, flowPort_b) annotation (points=[0,
        -26; 50,-26; 50,80; 100,80], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=2));
  connect(masaTermica.port, volumenControlUnico1.puertoInt) annotation (points=
        [30,20; -10,20; -10,-16], style(
      color=42,
      rgbcolor={191,0,0},
      gradient=2));
  connect(gananciaSolar.port, volumenControlUnico1.puertoInt) annotation (
      points=[-4,44; -4,20; -10,20; -10,-16], style(
      color=42,
      rgbcolor={191,0,0},
      gradient=2));
  connect(perdidasAmbiente.port, volumenControlUnico1.puertoInt) annotation (
      points=[-30,34; -30,20; -10,20; -10,-16], style(
      color=42,
      rgbcolor={191,0,0},
      gradient=2));
end ColectorSolar;
