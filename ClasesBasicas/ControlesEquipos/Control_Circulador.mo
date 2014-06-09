model Control_Circulador "Bloque de control del circulador" 
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
  Modelica.SIunits.Power cons_elec "Consumo electrico instantaneo";
  parameter Modelica.SIunits.Power pot_elec_nom 
    "Potencia electrica consumida en condiciones nominales";
  Modelica.Blocks.Interfaces.BooleanOutput y 
    annotation (extent=[96,-10; 116,10]);
equation 
//control salida booleana
y=if SenalEntrada>0 then true else false;
cons_elec=noEvent(if SenalEntrada>0 then pot_elec_nom else 0);
  
end Control_Circulador;
