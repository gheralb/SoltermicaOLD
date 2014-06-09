model TransmisionCalor1D 
  "Modelo transferencia de calor glogal. Desprecia la masa térmica de las capas." 
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
  parameter Real U=1 "Coeficiente global de intercambio de calor";
  parameter Modelica.SIunits.Area A=1 "Superficie de intercambio efectiva";
equation 
  Q_flow=A*U*dT;
  annotation (Icon(
      Rectangle(extent=[-20,80; 20,-80], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=9,
          rgbfillColor={175,175,175},
          fillPattern=7)),
      Line(points=[-100,0; 100,0], style(
          color=1,
          rgbcolor={255,0,0},
          fillColor=9,
          rgbfillColor={175,175,175},
          fillPattern=7)),
      Polygon(points=[50,-8; 50,10; 90,0; 50,-8], style(
          color=1,
          rgbcolor={255,0,0},
          arrow=1,
          fillColor=1,
          rgbfillColor={255,0,0}))));
end TransmisionCalor1D;
