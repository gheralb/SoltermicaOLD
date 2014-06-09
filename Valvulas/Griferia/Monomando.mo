model Monomando "Modelo de griferia monomando" 
  
annotation (Documentation(info="<HTML>
<p>
La grifería monomando dispone de dos entradas de caudal, una de agua caliente y otra de agua fría, y una salida a consumo.<br>
El modelo incluye dos señales de entrada correspondiente al porcentaje de caudal y a la regulación de temperatura.<br>
La señal de caudal tiene un rango 0 a 1. La señal de temperatura tiene un rango de 1 a -1, correspondiendo los valores positivos a un mayor porcentaje de agua caliente y viceversa.<br>
El siguiente gráfico explica de manera ilustrativa como varían los poncentajes de ambos caudales en función de la señal de temperatura:<br>
</p>
<img src=\"../Imagenes/graficasMezclaMonomando.png\"><br>
</HTML>"),
  Diagram, Icon(
      Polygon(points=[-40,-48; 40,-48; 20,-2; 80,18; 82,10; 100,10; 92,38; -36,
            18; -40,-48], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=9,
          rgbfillColor={175,175,175})),
      Polygon(points=[-34,22; 10,28; 8,50; 74,72; 72,76; -30,52; -34,22], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=9,
          rgbfillColor={175,175,175},
          fillPattern=1)),
      Line(points=[-40,-92; -20,-48], style(
          color=1,
          rgbcolor={255,0,0},
          fillColor=9,
          rgbfillColor={175,175,175},
          fillPattern=1)),
      Line(points=[40,-100; 20,-48], style(
          color=3,
          rgbcolor={0,0,255},
          fillColor=9,
          rgbfillColor={175,175,175},
          fillPattern=1))));
  
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a caliente(
    final medium=medium) "Entrada de agua caliente" 
    annotation (extent=[-50,-110; -30,-90]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a fria(
    final medium=medium) "Entrada de agua fria de red" 
    annotation (extent=[30,-110; 50,-90]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(
    final medium=medium) "Salida a consumo" 
    annotation (extent=[90,-10; 110,10]);
  Modelica.Thermal.FluidHeatFlow.Components.Valve cal(
    final medium=medium,
    final Kv1=Kv_grifo,
    final dp0=dp_grifo,
    final rho0=rho_referencia,
    kv0=0.00001) 
    annotation (extent=[-20,-40; 0,-20],   rotation=90);
  Modelica.Thermal.FluidHeatFlow.Components.Valve fri(
    final medium=medium,
    final Kv1=Kv_grifo,
    final dp0=dp_grifo,
    final rho0=rho_referencia,
    kv0=0.00001) 
    annotation (extent=[30,-40; 50,-20], rotation=90);
  Modelica.Blocks.Interfaces.RealInput caudal 
    "Senal de entrada de regulacion de cuadal" 
    annotation (extent=[-126,40; -86,80],  rotation=0);
  Modelica.Blocks.Interfaces.RealInput temperatura 
    "Senal de entrada de regulacion de temperatura" 
    annotation (extent=[-126,-20; -86,20],rotation=0);
  Modelica.Thermal.FluidHeatFlow.Sensors.V_flowSensor v_flowSensor(
    final medium=medium) 
    annotation (extent=[70,-10; 90,10]);
  ClasesBasicas.ControlesEquipos.Control_Monomando control_Monomando 
    annotation (extent=[-52,16; -32,36]);
  Modelica.Thermal.FluidHeatFlow.Sensors.TSensor tSensor(
    final medium=medium) 
    annotation (extent=[70,-40; 90,-20]);
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium() 
    "Fluido de trabajo";
  parameter Modelica.SIunits.Pressure dp_grifo=1 "Caida de presion nominal";
  parameter Real Kv_grifo=1 
    "Coeficiente de caudal de la valvula. Caudal para una determinada caida de presion nominal";
  parameter Modelica.SIunits.Density rho_referencia=995.6 
    "Densidad de referencia para el calculo de caudal";
  
equation 
  connect(caliente, cal.flowPort_a) 
    annotation (
      points=[-40,-100; -40,-80;-10,-80; -10,-40],
      style(color=1, rgbcolor={255,0,0}));
  connect(fria, fri.flowPort_a) 
    annotation (
      points=[40,-100; 40,-40],
      style(color=1, rgbcolor={255,0,0}));
  connect(v_flowSensor.flowPort_b, flowPort_b) 
    annotation (
      points=[90,0; 100,0],
      style(
        color=1,
        rgbcolor={255,0,0},
        fillColor=10,
        rgbfillColor={135,135,135},
        fillPattern=1));
  connect(cal.flowPort_b, v_flowSensor.flowPort_a) 
    annotation (
      points=[-10,-20;-10,0; 70,0],
      style(color=1, rgbcolor={255,0,0}));
  connect(fri.flowPort_b, v_flowSensor.flowPort_a) 
    annotation (
      points=[40,-20;40,0; 70,0],
      style(color=1, rgbcolor={255,0,0}));
  connect(control_Monomando.SenalCaliente, cal.y) 
    annotation (
      points=[-30.8,30; -24,30; -24,-30; -19,-30],
      style(color=74, rgbcolor={0,0,127}));
  connect(control_Monomando.SenalFria, fri.y) 
    annotation (
      points=[-30.8,22; 20,22; 20,-30; 31,-30],
      style(color=74, rgbcolor={0,0,127}));
  connect(tSensor.flowPort, v_flowSensor.flowPort_a) 
    annotation (
      points=[70,-30;70,0],
      style(
        color=1,
        rgbcolor={255,0,0},
        fillColor=9,
        rgbfillColor={175,175,175},
        fillPattern=1));
  connect(caudal, control_Monomando.SenalCaudal) 
    annotation (
      points=[-106,60;-80,60; -80,30; -52.8,30],
      style(
        color=74,
        rgbcolor={0,0,127},
        fillColor=9,
        rgbfillColor={175,175,175},
        fillPattern=1));
  connect(temperatura, control_Monomando.SenalTemperatura) 
    annotation (
      points=[-106,0; -80,0; -80,22; -52.8,22],
      style(
        color=74,
        rgbcolor={0,0,127},
        fillColor=9,
        rgbfillColor={175,175,175},
        fillPattern=1));
end Monomando;
