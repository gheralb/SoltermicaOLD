model Control_Circulador 
  
  annotation (Diagram, Icon(
      Rectangle(extent=[-100,-100; 100,100], style(color=3, rgbcolor={0,0,255})),
      Polygon(points=[80,-76; 80,-84; 100,-80; 80,-76], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=0,
          rgbfillColor={0,0,0})),
      Line(points=[-80,-80; -80,60], style(color=0, rgbcolor={0,0,0})),
      Polygon(points=[-84,60; -76,60; -80,80; -84,60], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=0,
          rgbfillColor={0,0,0})),
      Line(points=[-80,-80; 80,-80], style(color=0, rgbcolor={0,0,0})),
      Line(points=[-80,60; -40,50; 0,34; 40,6; 80,-32], style(color=58,
            rgbcolor={0,127,0})),
      Line(points=[-80,40; -40,20; 0,4; 40,-12; 80,-40], style(color=58,
            rgbcolor={0,127,0})),
      Line(points=[-80,20; -40,-12; 0,-26; 40,-38; 80,-56], style(color=58,
            rgbcolor={0,127,0})),
      Line(points=[-80,-80; -40,-74; -4,-60; 24,-20; 40,20; 44,60], style(color=
             3, rgbcolor={0,0,255}))));
  Modelica.Blocks.Interfaces.RealInput SenalEntrada 
    annotation (extent=[-128,-20; -88,20]);
  Real encendido;
  Real gastoInstantaneoCombustible;
//Especificaciones
  parameter Real caudalMinACS=1;
  parameter Real rendimientoInstantaneo=1;
  parameter Real GradoModulacionMin=1;
  parameter Real PotenciaNominal=1;
  parameter Real PCCombustible=1;
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  
  Modelica.Blocks.Interfaces.BooleanOutput y 
    annotation (extent=[96,-10; 116,10]);
equation 
encendido=noEvent(if (V_flow_in>caudalMinACS) then 1 else 0);
//Energia aportada al fluido
potenciaDesarrollada=noEvent(
  if T_in<273.15+20 then PotenciaNominal*encendido else 
       if (T_in>=273.15+20 and T_in<273.15+30) then PotenciaNominal*(((1-GradoModulacionMin)/2)+GradoModulacionMin)*encendido else 
       if (T_in>=273.15+30 and T_in<273.15+40) then PotenciaNominal*GradoModulacionMin*encendido else 
       0);
//Gasto combustible
gastoInstantaneoCombustible=(potenciaDesarrollada/rendimientoInstantaneo*PCCombustible);
  
end Control_Circulador;
