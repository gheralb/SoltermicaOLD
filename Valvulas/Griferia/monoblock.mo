model Monoblock "Modelo de griferia tradicional monoblock" 
  
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a caliente(final medium=
        medium) annotation (extent=[-50,-110; -30,-90]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a fria(final medium=medium) 
    annotation (extent=[30,-110; 50,-90]);
  annotation (Diagram, Icon(
      Polygon(points=[-68,-50; -68,30; -42,-10; -68,-50],
                                                        style(
          pattern=0,
          fillColor=1,
          rgbfillColor={255,0,0},
          fillPattern=1)),
      Polygon(points=[42,-10; 64,30; 64,-50; 42,-10],
                                                    style(
          pattern=0,
          fillColor=3,
          rgbfillColor={0,0,255})),
      Line(points=[-40,-100; -22,-48], style(
          color=1,
          rgbcolor={255,0,0},
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1)),
      Line(points=[40,-98; 26,-48], style(
          pattern=0,
          fillColor=3,
          rgbfillColor={0,0,255},
          fillPattern=1)),
      Polygon(points=[102,42; 84,42; 82,50; 28,20; 42,-10; 36,-48; -36,-48; -42,
            -10; -30,20; -14,36; 94,70; 102,42], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=9,
          rgbfillColor={175,175,175},
          fillPattern=1))));
  Modelica.Thermal.FluidHeatFlow.Components.Valve valve(
    final medium=medium,
    final Kv1=Kv_grifo,
    final dp0=dp_grifo,
    final rho0=rho_referencia,
    kv0=0.00001) annotation (extent=[-50,-40; -30,-20], rotation=90);
  Modelica.Thermal.FluidHeatFlow.Components.Valve valve1(
    final medium=medium,
    final Kv1=Kv_grifo,
    final dp0=dp_grifo,
    final rho0=rho_referencia,
    kv0=0.00001) annotation (extent=[50,-40; 30,-20], rotation=90);
  Modelica.Blocks.Interfaces.RealInput llaveCaliente 
    annotation (extent=[-120,-50; -80,-10]);
  Modelica.Blocks.Interfaces.RealInput llaveFria 
    annotation (extent=[120,-50; 80,-10]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=
        medium) annotation (extent=[90,10; 110,30]);
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  parameter Modelica.SIunits.Pressure dp_grifo=1;
  parameter Real Kv_grifo=1;
  parameter Modelica.SIunits.Density rho_referencia=995.6;
  Modelica.Thermal.FluidHeatFlow.Sensors.V_flowSensor v_flowSensor(final medium
      =medium) annotation (extent=[52,30; 72,50]);
equation 
  connect(llaveCaliente, valve.y) annotation (points=[-100,-30; -49,-30], style(
        color=74, rgbcolor={0,0,127}));
  connect(caliente, valve.flowPort_a) annotation (points=[-40,-100; -40,-40],
      style(color=1, rgbcolor={255,0,0}));
  connect(fria, valve1.flowPort_a) 
    annotation (points=[40,-100; 40,-40], style(color=1, rgbcolor={255,0,0}));
  connect(llaveFria, valve1.y) 
    annotation (points=[100,-30; 49,-30], style(color=74, rgbcolor={0,0,127}));
  connect(valve.flowPort_b, v_flowSensor.flowPort_a) annotation (points=[-40,
        -20; -40,40; 52,40], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(valve1.flowPort_b, v_flowSensor.flowPort_a) annotation (points=[40,
        -20; 40,40; 52,40], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(v_flowSensor.flowPort_b, flowPort_b) annotation (points=[72,40; 86,40;
        86,20; 100,20],
             style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(flowPort_b, flowPort_b) annotation (points=[100,20; 100,20; 100,20],
      style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=9,
      rgbfillColor={175,175,175},
      fillPattern=1));
end Monoblock;
