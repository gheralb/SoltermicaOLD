  model DemandaACSvalvulas 
    "Modelo en el que se simula la demanda de ACS mediante la apertura de valvulas" 
      Modelica.Thermal.FluidHeatFlow.Components.Valve valve(
        medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        m=0.1,
        Kv1=0.0001,
        kv0=0.0001,
        rho0=995.6,
        dp0=300000) 
                   annotation (extent=[-20,0; 0,20]);
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient(medium=
            Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=401300) 
        annotation (extent=[-60,0; -80,20]);
      Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(medium=
            Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
        annotation (extent=[40,0; 60,20]);
      annotation (Diagram);
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=1,
        rising=0.5,
        width=60,
        falling=0.5,
        period=300,
        startTime=30) annotation (extent=[-66,52; -46,72]);
  equation 
      connect(ambient.flowPort, valve.flowPort_a) annotation (points=[-60,10;
            -20,10], style(color=1, rgbcolor={255,0,0}));
      connect(valve.flowPort_b, ambient1.flowPort) 
        annotation (points=[0,10; 40,10], style(color=1, rgbcolor={255,0,0}));
      connect(trapezoid.y, valve.y) annotation (points=[-45,62; -10,62; -10,19],
          style(color=74, rgbcolor={0,0,127}));
  end DemandaACSvalvulas;