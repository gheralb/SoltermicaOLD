model Caldera "Modelo de caledra simplificado" 
annotation (Diagram, Icon(
      Polygon(points=[-60,60; -20,100; 80,80; 40,40; -60,60], style(
          color=10,
          rgbcolor={95,95,95},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=1)),
      Polygon(points=[-60,-60; -60,60; 40,40; 40,-80; -60,-60], style(
          color=10,
          rgbcolor={95,95,95},
          fillColor=7,
          rgbfillColor={255,255,255})),
      Polygon(points=[40,-80; 40,40; 80,80; 80,-40; 40,-80], style(
          color=10,
          rgbcolor={95,95,95},
          fillColor=30,
          rgbfillColor={215,215,215},
          fillPattern=1)),
      Polygon(points=[-32,-46; 8,-54; 8,-34; -32,-26; -32,-46], style(
          color=10,
          rgbcolor={95,95,95},
          fillColor=7,
          rgbfillColor={255,255,255},
          fillPattern=8))));
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(
    final medium=medium) "Entrada de agua fria" 
    annotation (extent=[-70,-110; -50,-90]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(
    final medium=medium) "Salida de agua caliente" 
    annotation (extent=[50,-110; 70,-90]);
  Soltermica.ClasesBasicas.VolumenesControl.VolumenControlUnico 
    volumenControlUnico(
    final medium=medium,
    final T_ini=T_ini,
    final dP_nom=espec.dp_nom,
    final cV_nom=espec.V_flow_nom,
    final Volumen=espec.V_cald) 
    annotation (extent=[-10,40; 10,20]);
  Modelica.Thermal.FluidHeatFlow.Sensors.V_flowSensor v_flowSensor(
    final medium=medium) 
    annotation (extent=[-50,-42; -70,-62], rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sensors.TSensor tSensor(
    final medium=medium) 
    annotation (extent=[-50,-80; -30,-60]);
  Modelica.Thermal.HeatTransfer.PrescribedHeatFlow prescribedHeatFlow1 
    annotation (extent=[-10,-18; 10,2], rotation=90);
  Soltermica.ClasesBasicas.ControlesEquipos.Control_Caldera control_Caldera(
    final medium=medium,
    final caudalMinACS=espec.V_flow_min,
    final rendimientoInstantaneo=espec.RendimientoInstantaneo,
    final GradoModulacionMin=espec.ModulacionMinima,
    final PotenciaNominal=espec.PotenciaNominal,
    final PCCombustible=espec.PCCombustible,
    final TempRegulacion=TempReg) 
    annotation (extent=[-16,-56; 4,-36]);
  Modelica.Blocks.Interfaces.RealInput T_amb 
    "Temperatura ambiental que rodea a la caldera" 
    annotation (extent=[-128,40; -88,80]);
  parameter Soltermica.Calderas.CatalogoEquipos.Especificaciones espec=Soltermica.Calderas.CatalogoEquipos.Especificaciones() 
    "Especificaciones del equipo";
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium() 
    "Fluido de trabajo";
  parameter Modelica.SIunits.CelsiusTemperature TempReg=40 
    "Temperatura de consigna de salida de la caldera";
  parameter Modelica.SIunits.Temp_K T_ini=293.15 
    "Temperatura inicial del conjunto de la caldera";
  Soltermica.ClasesBasicas.TransferenciaCalor.TransmisionCalor1D_MasaTermica 
    transmisionCalor1D_MasaTermica(
    U_a=5000 "Coeficiente estimado conveccion liquido",
    final A=espec.S_cald,
    final C=espec.CapacidadTermicaVacio,
    U_b=20 "Coeficiente estimado de conveccion natural con el ambiente") 
    annotation (extent=[-18,70; -38,50]);
  Modelica.Thermal.HeatTransfer.PrescribedTemperature prescribedTemperature 
    annotation (extent=[-74,50; -54,70]);
  Modelica.Thermal.FluidHeatFlow.Sensors.H_flowSensor h_flowSensor_in(
    final medium=medium) 
    annotation (extent=[-50,20; -30,40]);
  Modelica.Thermal.FluidHeatFlow.Sensors.H_flowSensor h_flowSensor_out(
    final medium=medium) 
    annotation (extent=[22,20; 42,40]);
  Modelica.Blocks.Math.Add diferencia(k2=-1) 
    annotation (extent=[-44,-20; -24,0], rotation=-90);
equation 
  connect(flowPort_a, v_flowSensor.flowPort_a) 
    annotation (
      points=[-60,-100;-60,-62],
      style(
        color=1,
        rgbcolor={255,0,0}));
  connect(flowPort_a, tSensor.flowPort) 
    annotation (
      points=[-60,-100; -60,-70;-50,-70],
      style(
        color=1,
        rgbcolor={255,0,0}));
  connect(prescribedHeatFlow1.port, volumenControlUnico.puertoInt) 
    annotation (
      points=[6.12303e-016,2; 0,2; 0,20],
      style(
        color=42,
        rgbcolor={191,0,0}));
  connect(v_flowSensor.y, control_Caldera.V_flow_in) 
    annotation (
      points=[-49,-52;-16.8,-52],
      style(
        color=74,
        rgbcolor={0,0,127}));
  connect(tSensor.y, control_Caldera.T_in) 
    annotation (points=[-29,-70; -24,-70;-24,-46; -16.8,-46], style(
      color=74,
      rgbcolor={0,0,127}));
  connect(T_amb, prescribedTemperature.T) 
    annotation (
      points=[-108,60; -76,60],
      style(
        color=74,
        rgbcolor={0,0,127}));
  connect(prescribedTemperature.port, transmisionCalor1D_MasaTermica.port_b) 
    annotation (
    points=[-54,60; -38,60],
    style(
        color=42,
        rgbcolor={191,0,0}));
  connect(transmisionCalor1D_MasaTermica.port_a, volumenControlUnico.puertoExt) 
    annotation (
      points=[-18,60; 0,60; 0,40],
      style(
        color=42,
        rgbcolor={191,0,0}));
  connect(control_Caldera.potenciaTeorica, prescribedHeatFlow1.Q_flow) 
    annotation (
      points=[4.6,-46; 20,-46; 20,-28; 0,-28; 0,-18; -6.12303e-016,-18],
      style(
        color=74,
        rgbcolor={0,0,127},
        fillColor=7,
        rgbfillColor={255,255,255},
        fillPattern=1));
  connect(h_flowSensor_in.flowPort_b, volumenControlUnico.flowPort_a) 
    annotation (
      points=[-30,30; -10,30],
      style(
        color=1,
        rgbcolor={255,0,0},
        fillColor=9,
        rgbfillColor={175,175,175},
        fillPattern=1));
  connect(v_flowSensor.flowPort_b, h_flowSensor_in.flowPort_a) 
    annotation (
      points=[-60,-42; -60,30; -50,30],
      style(
        color=1,
        rgbcolor={255,0,0},
        fillColor=9,
        rgbfillColor={175,175,175},
        fillPattern=1));
  connect(volumenControlUnico.flowPort_b, h_flowSensor_out.flowPort_a) 
    annotation (
      points=[10,30; 22,30],
      style(
        color=1,
        rgbcolor={255,0,0},
        fillColor=9,
        rgbfillColor={175,175,175},
        fillPattern=1));
  connect(h_flowSensor_out.flowPort_b, flowPort_b) 
    annotation (
      points=[42,30;60,30; 60,-100],
      style(
        color=1,
        rgbcolor={255,0,0},
        fillColor=9,
        rgbfillColor={175,175,175},
        fillPattern=1));
  connect(h_flowSensor_out.y, diferencia.u1) 
    annotation (
      points=[32,19; 32,10;-28,10; -28,2],
      style(
        color=74,
        rgbcolor={0,0,127},
        fillColor=9,
        rgbfillColor={175,175,175},
        fillPattern=1));
  connect(h_flowSensor_in.y, diferencia.u2) 
    annotation (
      points=[-40,19; -40,2],
      style(
        color=74,
        rgbcolor={0,0,127},
        fillColor=9,
        rgbfillColor={175,175,175},
        fillPattern=1));
  connect(diferencia.y, control_Caldera.Pot_Real) 
    annotation (
      points=[-34,-21;-34,-40; -16.8,-40],
      style(
        color=74,
        rgbcolor={0,0,127},
        fillColor=9,
        rgbfillColor={175,175,175},
        fillPattern=1));
end Caldera;
