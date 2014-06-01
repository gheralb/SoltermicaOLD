model Interacumulador_Mezcla 
  
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=
        medium) 
    annotation (extent=[-10,-110; 10,-90]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=
        medium) 
    annotation (extent=[-10,90; 10,110]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a1(final medium
      =medium_int) 
               annotation (extent=[-110,-10; -90,10]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b1(final medium
      =medium_int) 
               annotation (extent=[-110,-90; -90,-70]);
  annotation (Diagram, Icon(Rectangle(extent=[-84,-100; 78,100], style(
          pattern=0,
          gradient=1,
          fillColor=71,
          rgbfillColor={85,170,255})), Line(points=[-100,0; 60,0; -20,-20; 60,
            -40; -20,-60; 60,-80; -100,-80], style(
          color=1,
          rgbcolor={255,0,0},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1))));
  
  Modelica.SIunits.Power PotenciaTotalIntercambida;
  parameter Integer n(min=3)=10;
  parameter Integer n_int(min=2)=2;
  parameter Integer n_aux=div(n,n_int);
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium_int=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  parameter 
    Soltermica.Acumuladores.Interacumuladores.CatalogoEquipos.Especificaciones 
    espec =                                                                                    Soltermica.Acumuladores.Interacumuladores.CatalogoEquipos.Especificaciones();
  
  parameter Modelica.SIunits.Temp_K T_ini;
  Soltermica.ClasesBasicas.VolumenesControl.VolumenesControl1D 
    volumenesControl1D(
    final n=n,
    final medium=medium,
    final volumen=espec.volumen,
    final longitud=espec.altura,
    final dp_nom=espec.dp_nom,
    final V_flow_nom=espec.V_flow_nom,
    final T_ini=T_ini) annotation (extent=[20,-40; 40,-20], rotation=90);
  Soltermica.ClasesBasicas.TransferenciaCalor.TransmisionCalor1D 
    transmisionCalor1D[                               n_int](
    each final A=espec.S_int/n_int,
    each final U=espec.U_int) 
               annotation (extent=[-20,-40; 0,-20]);
  Soltermica.ClasesBasicas.VolumenesControl.VolumenesControl1D 
    volumenesControl1D_int(
    final n=n_int,
    final volumen=espec.volumen_int,
    final longitud=(espec.S_int^2/(4*Modelica.Constants.pi*espec.volumen_int)),
    final dp_nom=espec.dp_nom_int,
    final V_flow_nom=espec.V_flow_nom_int,
    final T_ini=T_ini,
    final medium=medium_int) 
                       annotation (extent=[-42,-40; -62,-20], rotation=90);
  Soltermica.ClasesBasicas.ControlesEquipos.Control_Interacumulador_Mezcla 
    control_Interacumulador_Mezcla(
      final n=n,
    final medium=medium,
    final volumen=espec.volumen,
    final altura=espec.altura,
    cteTiempo=0.3) annotation (extent=[80,-20; 60,0]);
  Modelica.Thermal.HeatTransfer.TemperatureSensor temperatureSensor 
    annotation (extent=[60,40; 80,60]);
  Modelica.Blocks.Interfaces.RealOutput SensorTemperatura 
    annotation (extent=[96,40; 116,60]);
equation 
  connect(volumenesControl1D.flowPort_a, flowPort_a) annotation (points=[30,-40;
        30,-60; 0,-60; 0,-100], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=2));
  connect(volumenesControl1D.flowPort_b, flowPort_b) annotation (points=[30,-20;
        30,20; 0,20; 0,100], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=2));
  connect(transmisionCalor1D[1:n_int].port_b, volumenesControl1D.puertoInt[(n_aux+1):(n_aux+n_int)]) 
    annotation (points=[0,-30; 20,-30], style(
      color=42,
      rgbcolor={191,0,0},
      gradient=1,
      fillColor=71,
      rgbfillColor={85,170,255}));
  connect(flowPort_a1, volumenesControl1D_int.flowPort_b) annotation (points=[
        -100,0; -52,0; -52,-20], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=1,
      fillColor=71,
      rgbfillColor={85,170,255}));
  connect(flowPort_b1, volumenesControl1D_int.flowPort_a) annotation (points=[
        -100,-80; -52,-80; -52,-40], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=1,
      fillColor=71,
      rgbfillColor={85,170,255}));
  connect(volumenesControl1D_int.puertoInt, transmisionCalor1D.port_a) 
    annotation (points=[-42,-30; -20,-30], style(
      color=42,
      rgbcolor={191,0,0},
      gradient=1,
      fillColor=71,
      rgbfillColor={85,170,255}));
  connect(control_Interacumulador_Mezcla.puertoInt, volumenesControl1D.puertoExt) 
    annotation (points=[60,-10; 46,-10; 46,-30; 40,-30],
                                                       style(
      color=42,
      rgbcolor={191,0,0},
      gradient=1,
      fillColor=71,
      rgbfillColor={85,170,255}));
  connect(volumenesControl1D.puertoExt[1], temperatureSensor.port) annotation (
      points=[40,-30; 46,-30; 46,50; 60,50], style(color=42, rgbcolor={191,0,0}));
  connect(temperatureSensor.T, SensorTemperatura) 
    annotation (points=[80,50; 106,50], style(color=74, rgbcolor={0,0,127}));
  PotenciaTotalIntercambida=sum(transmisionCalor1D[i].port_a.Q_flow for i in 1:n_int);
end Interacumulador_Mezcla;
