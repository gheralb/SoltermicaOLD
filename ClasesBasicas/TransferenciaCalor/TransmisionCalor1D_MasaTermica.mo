model TransmisionCalor1D_MasaTermica 
  "Modelo transferencia de calor glogal. Tienen en cuenta la inercia termica medio material separador." 
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a 
    annotation (extent=[-110,-10; -90,10]);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b 
    annotation (extent=[90,-10; 110,10]);
  Soltermica.ClasesBasicas.TransferenciaCalor.TransmisionCalor1D 
    transmisionCalor1D(
    final A=A,
    final U=U_a) 
    annotation (extent=[-60,-10; -40,10]);
  Soltermica.ClasesBasicas.TransferenciaCalor.TransmisionCalor1D 
    transmisionCalor1D1(
    final U=U_b,
    final A=A) 
    annotation (extent=[40,-10; 60,10]);
  Modelica.Thermal.HeatTransfer.HeatCapacitor masaTermica(
    final C=C) 
    annotation (extent=[-10,0; 10,20]);
  annotation (Diagram, DymolaStoredErrors,
    Icon(
      Line(points=[-90,0; -30,0], style(
          color=1,
          rgbcolor={255,0,0},
          fillColor=9,
          rgbfillColor={175,175,175},
          fillPattern=7)),
      Rectangle(extent=[-20,80; 20,-80], style(
          color=1,
          rgbcolor={255,0,0},
          fillColor=9,
          rgbfillColor={175,175,175},
          fillPattern=7)),
      Polygon(points=[-60,-8; -60,10; -20,0; -60,-8], style(
          color=1,
          rgbcolor={255,0,0},
          arrow=1,
          fillColor=1,
          rgbfillColor={255,0,0})),
      Polygon(points=[50,-8; 50,10; 90,0; 50,-8], style(
          color=1,
          rgbcolor={255,0,0},
          arrow=1,
          fillColor=1,
          rgbfillColor={255,0,0})),
      Line(points=[20,0; 80,0], style(
          color=1,
          rgbcolor={255,0,0},
          fillColor=9,
          rgbfillColor={175,175,175},
          fillPattern=7))));
  parameter Real U_a=1 
    "Coeficiente global de intercambio de calor para el lado a";
  parameter Real U_b=1 
    "Coeficiente global de intercambio de calor para el lado b";
  parameter Modelica.SIunits.Area A=1 "Superficie de intercambio efectiva";
  parameter Real C=1 "Capacidad calorifica de la masa";
equation 
  connect(port_a, transmisionCalor1D.port_a) annotation (points=[-100,0; -60,0],
      style(
      color=42,
      rgbcolor={191,0,0},
      fillColor=1,
      rgbfillColor={255,0,0},
      fillPattern=1));
  connect(transmisionCalor1D.port_b, masaTermica.port) annotation (points=[-40,
        0; 0,0], style(
      color=42,
      rgbcolor={191,0,0},
      fillColor=1,
      rgbfillColor={255,0,0},
      fillPattern=1));
  connect(masaTermica.port, transmisionCalor1D1.port_a) annotation (points=[0,0;
        40,0], style(
      color=42,
      rgbcolor={191,0,0},
      fillColor=1,
      rgbfillColor={255,0,0},
      fillPattern=1));
  connect(transmisionCalor1D1.port_b, port_b) annotation (points=[60,0; 100,0],
      style(
      color=42,
      rgbcolor={191,0,0},
      fillColor=1,
      rgbfillColor={255,0,0},
      fillPattern=1));
  connect(port_b, port_b) annotation (points=[100,0; 100,0], style(
      color=42,
      rgbcolor={191,0,0},
      fillColor=1,
      rgbfillColor={255,0,0},
      fillPattern=1));
end TransmisionCalor1D_MasaTermica;
