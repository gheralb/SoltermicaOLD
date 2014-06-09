model Control_Caldera "Bloque de control de la caldera" 
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
      Polygon(points=[-60,-80; -58,-40; -50,0; -34,20; -14,34; 0,40; 60,40; 60,
            -80; -60,-80], style(
          pattern=0,
          fillColor=10,
          rgbfillColor={135,135,135})),
      Line(points=[-80,-80; 80,-80], style(color=0, rgbcolor={0,0,0}))));
  Modelica.Blocks.Interfaces.RealInput T_in 
    annotation (extent=[-128,-20; -88,20]);
  Modelica.Blocks.Interfaces.RealOutput potenciaTeorica 
    annotation (extent=[96,-10; 116,10]);
  Modelica.Blocks.Interfaces.RealInput V_flow_in 
    annotation (extent=[-128,-80; -88,-40]);
  Modelica.Blocks.Interfaces.RealInput Pot_Real 
    annotation (extent=[-128,40; -88,80]);
  Real encendido 
    "Variable que determina si existe el caudal minima para que la caldera se encienda";
  Real gastoInstantaneoCombustible "Gasto de combustible";
//Parametros para el control. Se tienen que definir en las especificaciones
  parameter Real caudalMinACS=1;
  parameter Real rendimientoInstantaneo=1;
  parameter Real GradoModulacionMin=1;
  parameter Real PotenciaNominal=1;
  parameter Real PCCombustible=1;
  parameter Real TempRegulacion=1;
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  
equation 
encendido=noEvent(if (V_flow_in>caudalMinACS) then 1 else 0);
//Energia aportada al fluido
potenciaTeorica=noEvent(
  if T_in<273.15+20 then PotenciaNominal*encendido else 
    if (T_in>=273.15+TempRegulacion-30 and T_in<273.15+TempRegulacion-15) then PotenciaNominal*(((1-GradoModulacionMin)/2)+GradoModulacionMin)*encendido else 
    if (T_in>=273.15+TempRegulacion-15 and T_in<273.15+TempRegulacion) then PotenciaNominal*GradoModulacionMin*encendido else 
         0);
//Gasto combustible
gastoInstantaneoCombustible=(potenciaTeorica/(rendimientoInstantaneo*PCCombustible));
  
end Control_Caldera;
