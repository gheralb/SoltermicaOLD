model InteracumuladorSerpentin 
  "Modelo simplificado acumulador sin aportación de energía" 
  
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a_dep(final 
      medium=medium_dep) 
    annotation (extent=[-10,-110; 10,-90]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b_dep(final 
      medium=medium_dep) 
    annotation (extent=[-10,90; 10,110]);
  annotation (Icon(
         Rectangle(extent=[-60,100; 60,-100], style(
          color=3,
          rgbcolor={0,0,255},
          thickness=2,
          gradient=1,
          fillColor=75,
          rgbfillColor={85,85,255})), Line(points=[-100,-80; 38,-80; -40,-60;
            40,-40; -40,-20; 40,0; -100,0], style(color=0, rgbcolor={0,0,0}))),
                                       DymolaStoredErrors,
      Diagram);
  //Modelica.SIunits.Energy H_dep_abajo;
  //Modelica.SIunits.Temp_K T_dep_abajo;
  //Modelica.SIunits.Energy H_dep_arriba;
  //Modelica.SIunits.Temp_K T_dep_arriba;
  Modelica.SIunits.Energy H_dep;
  Modelica.SIunits.Temp_K T_dep(start=T0);
  Modelica.SIunits.Temp_K T_in_AF;
  Modelica.SIunits.Temp_K T_out_ACS;
  Modelica.SIunits.EnergyFlowRate Q_int_dep;
  
  Modelica.SIunits.Energy H_int;
  Modelica.SIunits.Temp_K T_int(start=T0);
  Modelica.SIunits.Temp_K T_in_int;
  Modelica.SIunits.Temp_K T_out_int;
  Modelica.SIunits.EnergyFlowRate Q_int_int;
  
  Modelica.SIunits.TemperatureDifference DeltaT;
  
  //Medios
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium_int=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium_dep=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  
  //Hidraulicos
  //parameter Modelica.SIunits.MassFlowRate m_flow_dep_nom=1;
  //parameter Modelica.SIunits.Pressure dp_dep_nom=1;
  
  //parameter Modelica.SIunits.MassFlowRate m_flow_int_nom=1;
  //parameter Modelica.SIunits.Pressure dp_int_nom=1;
  
  //parameter Modelica.SIunits.Volume V_dep=1;
  //parameter Modelica.SIunits.Volume V_int=1;
  
  //parameter Real U_int=1;
  //parameter Real A_int=1;
  
  //Especificaciones
  parameter Acumuladores.Interacumuladores.Especificaciones esp=Especificaciones();
  
  //Condiciones iniciales. Al iniciar la simulación todo el volumen de líquido (incluyendo el del intercambiador) está a la misma temperatura
  parameter Modelica.SIunits.Temp_K T0;
  
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a_int(final 
      medium=medium_int) annotation (extent=[-110,-10; -90,10]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b_int(final 
      medium=medium_int) annotation (extent=[-110,-90; -90,-70]);
  Modelica.Blocks.Interfaces.RealOutput SenTemp
    annotation (extent=[96,70; 116,90]);
equation 
  //Temperaturas
  T_in_AF=if noEvent(flowPort_a_dep.m_flow>0) then flowPort_a_dep.h/medium_dep.cp else T_dep;
  T_out_ACS=T_dep;
  T_in_int=if noEvent(flowPort_a_int.m_flow>0) then flowPort_a_int.h/medium_int.cp else T_int;
  T_out_int=T_int;
  SenTemp=T_dep;
  
  //Caidas de presion
  flowPort_a_dep.p-flowPort_b_dep.p = -esp.dp_dep_nom*(flowPort_a_dep.m_flow^2) / (esp.m_flow_dep_nom^2);
  flowPort_a_int.p-flowPort_b_int.p = -esp.dp_dep_nom*(flowPort_a_int.m_flow^2) / (esp.m_flow_dep_nom^2);
  
  //Balance de materia
  flowPort_a_dep.m_flow+flowPort_b_dep.m_flow=0;
  flowPort_a_int.m_flow+flowPort_b_int.m_flow=0;
  
  //Balance de energia
  flowPort_a_dep.H_flow+flowPort_b_dep.H_flow+Q_int_dep=esp.V_dep*medium_dep.rho*medium_dep.cp*der(T_dep);
  flowPort_a_int.H_flow+flowPort_b_int.H_flow+Q_int_int=esp.V_int*medium_int.rho*medium_int.cp*der(T_int);
  Q_int_dep+Q_int_int=0;
  
  //Entalpias
  H_dep=esp.V_dep*medium_dep.rho*medium_dep.cp*T_dep;
  H_int=esp.V_int*medium_int.rho*medium_int.cp*T_int;
  
  flowPort_a_dep.H_flow=if noEvent(flowPort_a_dep.m_flow >0) then flowPort_a_dep.m_flow*medium_dep.cp*T_in_AF else 0;
  flowPort_b_dep.H_flow=if noEvent(flowPort_b_dep.m_flow <0) then flowPort_b_dep.m_flow*medium_dep.cp*T_out_ACS else 0;
  flowPort_a_int.H_flow=if noEvent(flowPort_a_int.m_flow >0) then flowPort_a_int.m_flow*medium_int.cp*T_in_int else 0;
  flowPort_b_int.H_flow=if noEvent(flowPort_b_int.m_flow <0) then flowPort_b_int.m_flow*medium_int.cp*T_out_int else 0;
  
  //Potencia intercambiada
  DeltaT=((T_in_int+T_int)/2)-T_dep;
  Q_int_dep=esp.U_int*esp.A_int*DeltaT;
  
initial equation 
  T_in_int=T_int;
  T_in_AF=T_dep;
  
end InteracumuladorSerpentin;
