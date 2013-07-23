model ColectorSolar "Implementación colector solar térmico 0.1." 
  
  annotation (uses(Modelica(version="2.2.1")), DymolaStoredErrors,
    Diagram(
      Polygon(points=[-80,-40; -20,80; 60,60; 0,-60; -80,-40], style(
          color=7,
          rgbcolor={255,255,255},
          gradient=1,
          fillColor=0,
          rgbfillColor={0,0,0})),
      Polygon(points=[-80,-40; 0,-60; 0,-70; -80,-50; -80,-40], style(
          color=10,
          rgbcolor={135,135,135},
          fillColor=9,
          rgbfillColor={175,175,175})),
      Polygon(points=[0,-60; 60,60; 60,50; 0,-70; 0,-60], style(
          color=10,
          rgbcolor={135,135,135},
          fillColor=9,
          rgbfillColor={175,175,175})),
      Line(points=[58,52; 80,52; 80,0; 100,0], style(
          color=45,
          rgbcolor={255,128,0},
          thickness=2,
          fillColor=9,
          rgbfillColor={175,175,175},
          fillPattern=1)),
      Line(points=[-100,0; -90,0; -90,-40; -80,-40], style(
          color=45,
          rgbcolor={255,128,0},
          thickness=2,
          fillColor=45,
          rgbfillColor={255,128,0}))),
    Icon(
      Polygon(points=[-70,-46; -10,74; 70,54; 10,-66; -70,-46], style(
          color=7,
          rgbcolor={255,255,255},
          fillColor=0,
          rgbfillColor={0,0,0})),
      Polygon(points=[-70,-46; 10,-66; 10,-76; -70,-56; -70,-46], style(
          color=7,
          rgbcolor={255,255,255},
          fillColor=10,
          rgbfillColor={135,135,135})),
      Polygon(points=[10,-66; 70,54; 70,44; 10,-76; 10,-66], style(
          color=7,
          rgbcolor={255,255,255},
          fillColor=10,
          rgbfillColor={135,135,135},
          fillPattern=1))));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a 
    annotation (extent=[-10,90; 10,110]);
  Modelica.Blocks.Interfaces.RealInput u annotation (extent=[-120,60; -80,100]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=
        medium) 
    annotation (extent=[-110,-10; -90,10]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=
        medium) 
    annotation (extent=[90,-10; 110,10]);
  //Variables
  Real Rend_captador;//Rendimiento instantáneo del captador. Mirar como se define de 0 a 1
  Modelica.SIunits.Energy H;//Entalpia del colector
  Modelica.SIunits.Temp_K T_col;//Temperatura del captador a efectos de cálculo. Puede definirse inicialmente como la media
  Modelica.SIunits.Pressure dp;//Caída de presión en el captador
  
  //Variables auxiliares
  Modelica.SIunits.Temp_K T_amb;
  Modelica.SIunits.Temp_K T_in;
  Modelica.SIunits.Temp_K T_out;
  
  //Parametros
  //Medio circulante captador
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  
  /*//Hidraulicos
  parameter Modelica.SIunits.MassFlowRate m_flow_nom=1;
  parameter Modelica.SIunits.Pressure dp_nom=1;
  
  //Propios del captador
 
  parameter Real Rend_optico=1;
  parameter Real Coef_perdidas_1=1;
  parameter Real Coef_perdidas_2=1;
  parameter Modelica.SIunits.Volume V_col=1;*/
  
  parameter ColectoresSolares.Especificaciones esp=Especificaciones();
  
  parameter Real T0=293.15;//Temperatura inicial del captador
  
equation 
  //Temperaturas
  H=esp.V_col*medium.rho*medium.cp*T_col;
  T_in=flowPort_a.h/medium.cp;
  T_out=T_col;
  //T_out=flowPort_b.h/medium.cp;
  flowPort_a.H_flow=if flowPort_a.m_flow >0 then flowPort_a.m_flow*medium.cp*T_in else 0;
  flowPort_b.H_flow=if flowPort_b.m_flow <0 then flowPort_b.m_flow*medium.cp*T_out else 0;
  
  //Temperatura ambiente
  T_amb=u;
  
  //Temperatura conexión puerto calor
  port_a.T=T_col;
  
  //Caudal másico por el captador. Balance másico
  flowPort_a.m_flow+flowPort_b.m_flow=0;
  
  //Caída de presión en el captador
  dp=flowPort_b.p-flowPort_a.p;
  dp = if flowPort_a.m_flow >0 then - esp.dp_nom * (flowPort_a.m_flow^2) / (esp.m_flow_nom^2) else 0;
  
  //Rendimiento del captador
  port_a.Q_flow*esp.A_apertura*Rend_captador=port_a.Q_flow*esp.A_apertura*esp.Rend_optico-esp.Coef_perdidas_1*(T_col-T_amb)-esp.Coef_perdidas_2*((T_col-T_amb)^2);
  
  //Balance energético. Energía entrante debe ser la misma que la que la sale y la que se acumula
  der(H)=port_a.Q_flow*Rend_captador+flowPort_a.H_flow+flowPort_b.H_flow;
  
initial equation 
H=esp.V_col*medium.rho*medium.cp*T0;
  
end ColectorSolar;
