model InteracumuladorSerpentin 
  "Primera implementación de un interacumulador. Es un depósito de acumulación que incluye un intercambiador tubular (serpentín). Modelando la entrada y salida de AF y ACS" 
  
  annotation (
    uses(Modelica(version="2.2.1")),
    Diagram,
    Icon(Rectangle(extent=[-60,100; 60,-100], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=2,
          gradient=1,
          fillColor=75,
          rgbfillColor={85,85,255})), Line(points=[-100,-80; 40,-80; -40,-60;
            40,-40; -40,-20; 40,0; -100,0], style(color=0, rgbcolor={0,0,0}))),
      DymolaStoredErrors);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b_1(final 
      medium=medium_int) 
    annotation (extent=[-110,-90; -90,-70]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a_1(final 
      medium=medium_int) 
                     annotation (extent=[-112,-10; -92,10]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=
        medium_dep) 
                annotation (extent=[-10,-110; 10,-90]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=
        medium_dep) 
                annotation (extent=[-10,90; 10,110]);
  Modelica.SIunits.Energy H_int;
  Modelica.SIunits.Energy H_dep;
  Modelica.SIunits.Temp_K T_in_1;
  Modelica.SIunits.Temp_K T_out_1;
  Modelica.SIunits.Temp_K T_int;
  Modelica.SIunits.Temp_K T_dep;//Temperatura uniforme del deposito
  Modelica.SIunits.Temp_K T_in_AF;
  Modelica.SIunits.Temp_K T_out_ACS;
  Modelica.SIunits.EnergyFlowRate Q_int_1;
  Modelica.SIunits.EnergyFlowRate Q_int_dep;
  Modelica.SIunits.TemperatureDifference DeltaT;
  
  //Parametros
  //Medios circulantes por el intercambiador
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium_int=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium_dep=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  
  /*//Hidraulicos
  parameter Modelica.SIunits.MassFlowRate m_flow_nom_1=1;
  parameter Modelica.SIunits.Pressure dp_nom_1=1;
  parameter Modelica.SIunits.MassFlowRate m_flow_dep=1;
  parameter Modelica.SIunits.Pressure dp_dep=1;
  //Propios del intercambiador-serpentin
  parameter Modelica.SIunits.Volume V_int=1;
  parameter Real U_int=1;//Coeficiente global de intercambio
  parameter Modelica.SIunits.Area A_int=1;//Area de intercambio
  //Propios del deposito
  parameter Modelica.SIunits.Volume V_dep=1;//Volumen del depositoparameter*/
  parameter Acumuladores.Interacumuladores.Especificaciones esp=
      Especificaciones();
  //Condiciones iniciales
  parameter Modelica.SIunits.Temp_K T0;
equation 
  //Temperaturas
  T_in_1=flowPort_a_1.h/medium_int.cp;
  T_out_1=T_int;
  T_in_AF=flowPort_a.h/medium_dep.cp;
  T_out_ACS=T_dep;
  
  //Entalpias
  H_int=esp.V_int*medium_int.rho*medium_int.cp*T_int;
  H_dep=esp.V_dep*medium_dep.rho*medium_dep.cp*T_dep;
  flowPort_a_1.H_flow=flowPort_a_1.m_flow*medium_int.cp*T_in_1;
  flowPort_b_1.H_flow=flowPort_b_1.m_flow*medium_int.cp*T_out_1;
  flowPort_a.H_flow=flowPort_a.m_flow*medium_dep.cp*T_in_AF;
  flowPort_b.H_flow=flowPort_b.m_flow*medium_dep.cp*T_out_ACS;
  
  //Caidas de presion
  flowPort_a_1.p-flowPort_b_1.p = -esp.dp_int_nom * (flowPort_a_1.m_flow^2) / (esp.m_flow_int_nom^2);
  flowPort_a.p-flowPort_b.p = -esp.dp_dep_nom*(flowPort_a.m_flow^2) / (esp.m_flow_dep_nom^2);
  //Tengo que ver como modelar las caídas de presión en el depósitos->orificios, como una forma más modular
  
  //Balance de materia
  flowPort_a_1.m_flow+flowPort_b_1.m_flow=0;
  flowPort_a.m_flow+flowPort_b.m_flow=0;
  
  //Balance de energia
  flowPort_a_1.H_flow+flowPort_b_1.H_flow+Q_int_1=der(H_int);
  flowPort_a.H_flow+flowPort_b.H_flow+Q_int_dep=der(H_dep);
  Q_int_1+Q_int_dep=0;
  
  //Potencia intercambiada
  DeltaT=((T_in_1+T_int)/2)-T_dep;
  Q_int_dep=esp.U_int*esp.A_int*DeltaT;
  
initial equation 
  H_int=esp.V_int*medium_int.rho*medium_int.cp*T0;
  H_dep=esp.V_dep*medium_dep.rho*medium_dep.cp*T0;
  
end InteracumuladorSerpentin;
