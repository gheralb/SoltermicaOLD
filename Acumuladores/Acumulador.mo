model Acumulador "Modelo simplificado acumulador sin aportación de energía" 
  
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=
        medium_dep) 
    annotation (extent=[-10,-110; 10,-90]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=
        medium_dep) 
    annotation (extent=[-10,90; 10,110]);
  annotation (Icon(
         Rectangle(extent=[-60,100; 60,-100], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=2,
          gradient=1,
          fillColor=75,
          rgbfillColor={85,85,255}))), DymolaStoredErrors,
      Diagram);
  //Modelica.SIunits.Energy H_dep_abajo;
  //Modelica.SIunits.Temp_K T_dep_abajo;
  //Modelica.SIunits.Energy H_dep_arriba;
  //Modelica.SIunits.Temp_K T_dep_arriba;
  Modelica.SIunits.Energy H_dep;
  Modelica.SIunits.Temp_K T_dep;
  Modelica.SIunits.Temp_K T_in_AF;
  Modelica.SIunits.Temp_K T_out_ACS;
  Modelica.SIunits.EnergyFlowRate Q_int;
  
  //Medios
  //parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium_dep=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium_dep=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  
  //Hidraulicos
  parameter Modelica.SIunits.MassFlowRate m_flow_dep_nom=1;
  parameter Modelica.SIunits.Pressure dp_dep_nom=1;
  
  //Propios del deposito
  parameter Modelica.SIunits.Volume V_dep=1;//Volumen del depositoparameter
  
  //Condiciones iniciales
  parameter Modelica.SIunits.Temp_K T0;
  
equation 
  //Temperaturas
  T_in_AF=if noEvent(flowPort_a.m_flow>0) then flowPort_a.h/medium_dep.cp else T_dep;
  T_out_ACS=T_dep;
  
  //Caidas de presion
  flowPort_a.p-flowPort_b.p = -dp_dep_nom*(flowPort_a.m_flow^2) / (m_flow_dep_nom^2);
  
  //Balance de materia
  flowPort_a.m_flow+flowPort_b.m_flow=0;
  
  //Balance de energia
  flowPort_a.H_flow+flowPort_b.H_flow+Q_int=V_dep*medium_dep.rho*medium_dep.cp*der(T_dep);
  Q_int=0;
  
  //Entalpias
  H_dep=V_dep*medium_dep.rho*medium_dep.cp*T_dep;
  //flowPort_a.H_flow=flowPort_a.m_flow*medium_dep.cp*T_in_AF;
  //flowPort_b.H_flow=flowPort_b.m_flow*medium_dep.cp*T_out_ACS;
  flowPort_a.H_flow=if noEvent(flowPort_a.m_flow >0) then flowPort_a.m_flow*medium_dep.cp*T_in_AF else 0;
  flowPort_b.H_flow=if noEvent(flowPort_b.m_flow <0) then flowPort_b.m_flow*medium_dep.cp*T_out_ACS else 0;
  //flowPort_a.H_flow=flowPort_a.m_flow*flowPort_a.h;
  //flowPort_b.H_flow=flowPort_b.m_flow*flowPort_b.h;
  //flowPort_a.H_flow=if flowPort_a.m_flow >0 then flowPort_a.m_flow*flowPort_a.h else 0;
  //flowPort_b.H_flow=if flowPort_b.m_flow <0 then flowPort_b.m_flow*(-flowPort_b.h) else 0;
  
initial equation 
  T_dep=T0;
  T_in_AF=T_dep;
  
end Acumulador;
