model IntercambiadorPlacas 
  "Primeras implementaciones de un intercambiador. Definición parámetros mediante clase record" 
  
  annotation (
    uses(Modelica(version="2.2.1")),
    Diagram,
    Icon(
      Rectangle(extent=[-60,80; 60,-80], style(
          color=0,
          rgbcolor={0,0,0},
          thickness=2,
          fillColor=9,
          rgbfillColor={175,175,175})),
      Line(points=[-100,60; 40,60; -40,40; 40,20; -40,0; 40,-20; -40,-40; 40,
                -60; -100,-60],
                            style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=9,
          rgbfillColor={175,175,175})),
      Line(points=[100,-60; -40,-60; 40,-40; -40,-20; 40,0; -40,20; 40,40;
                -40,60; 100,60],
                         style(color=0, rgbcolor={0,0,0}))));
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b_1(final 
      medium=medium) 
    annotation (extent=[-110,-70; -90,-50]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a_2(final 
      medium=medium) 
    annotation (extent=[90,-70; 110,-50]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b_2(final 
      medium=medium) 
    annotation (extent=[90,50; 110,70]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a_1(final 
      medium=medium) annotation (extent=[-110,50; -90,70]);
  Modelica.SIunits.Enthalpy H_1;
  Modelica.SIunits.Enthalpy H_2;
  Modelica.SIunits.Temp_K T_in_1;
  Modelica.SIunits.Temp_K T_out_1;
  Modelica.SIunits.Temp_K T_1;
  Modelica.SIunits.Temp_K T_in_2;
  Modelica.SIunits.Temp_K T_out_2;
  Modelica.SIunits.Temp_K T_2;
  Modelica.SIunits.EnergyFlowRate Q_int_1;
  Modelica.SIunits.EnergyFlowRate Q_int_2;
  Modelica.SIunits.TemperatureDifference DeltaT;
  //Modelica.SIunits.TemperatureDifference LMTD;
  //Modelica.SIunits.TemperatureDifference DeltaT_1;
  //Modelica.SIunits.TemperatureDifference DeltaT_2;
  
  //Parametros
  //Medios circulantes por el intercambiador
  //parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium_1=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  //parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium_2=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  /*//Hidraulicos
  parameter Modelica.SIunits.MassFlowRate m_flow_nom_1=1;
  parameter Modelica.SIunits.Pressure dp_nom_1=1;
  parameter Modelica.SIunits.MassFlowRate m_flow_nom_2=1;
  parameter Modelica.SIunits.Pressure dp_nom_2=1;
  //Propios del intercambiador
  parameter Modelica.SIunits.Volume V_1=1;//Volumen de la seccion 1 del intercambiador
  parameter Modelica.SIunits.Volume V_2=1;//Volumen de la sección 2 del intercambiador
  parameter Real U_int=1;//Coeficiente global de intercambio
  parameter Real A_int=1;//Área de intercambio*/
  parameter Soltermica.Intercambiadores.Placas.Especificaciones esp =               Soltermica.Intercambiadores.Placas.Especificaciones();
  //Parametros de inicializacion
  parameter Real T0_1=293.15;
  parameter Real T0_2=293.15;
equation 
  
//Caidas de presion
flowPort_a_1.p-flowPort_b_1.p = -esp.dp_nom_1 * (flowPort_a_1.m_flow^2) / ((esp.V_flow_nom_1*medium.rho)^2);
flowPort_a_2.p-flowPort_b_2.p = -esp.dp_nom_2 * (flowPort_a_2.m_flow^2) / ((esp.V_flow_nom_2*medium.rho)^2);
  
//Balance de materia
flowPort_a_1.m_flow+flowPort_b_1.m_flow=0;
flowPort_a_2.m_flow+flowPort_b_2.m_flow=0;
  
//Balance de energia en cada volumen de control
flowPort_a_1.H_flow+flowPort_b_1.H_flow+Q_int_1=der(H_1);
flowPort_a_2.H_flow+flowPort_b_2.H_flow+Q_int_2=der(H_2);
Q_int_1+Q_int_2=0;
  
//Entalpías
H_1=esp.V_1*medium.rho*medium.cp*T_1;
H_2=esp.V_2*medium.rho*medium.cp*T_2;
  
//Temperaturas
flowPort_a_1.H_flow=flowPort_a_1.m_flow*medium.cp*T_in_1;
flowPort_b_1.H_flow=flowPort_b_1.m_flow*medium.cp*T_out_1;
flowPort_a_2.H_flow=flowPort_a_2.m_flow*medium.cp*T_in_2;
flowPort_b_2.H_flow=flowPort_b_2.m_flow*medium.cp*T_out_2;
T_in_1=flowPort_a_1.h/medium.cp;
T_in_2=flowPort_a_2.h/medium.cp;
T_out_1=T_1;
T_out_2=T_2;
  
//Potencia intercambiada
DeltaT=((T_in_1+T_1)/2)-((T_in_2+T_2)/2);
Q_int_2=esp.U_int*esp.S_int*DeltaT;
  
/*DeltaT_1=if T_in_1>=T_out_2 then T_in_1-T_out_2 else 0;
DeltaT_2=if T_out_1>=T_in_2 then T_out_1-T_in_2 else 0;
Q_int_1=U_int*A_int*LMTD;
LMTD = if (DeltaT_1*DeltaT_2>=0) and (DeltaT_1*DeltaT_2<=0) then (0.5*(DeltaT_1+DeltaT_2)) else 
       if (abs(DeltaT_1-DeltaT_2)>0.05*max(abs(DeltaT_1),abs(DeltaT_2))) then (DeltaT_1-DeltaT_2)/Modelica.Math.log(DeltaT_1/DeltaT_2) else 
       0.5*(DeltaT_1+DeltaT_2)+(1-sqrt(DeltaT_1-DeltaT_2)/(DeltaT_1*DeltaT_2)+(1+sqrt(DeltaT_1-DeltaT_2)/(DeltaT_1*DeltaT_2)/2/12));*/
  
initial equation 
H_1=esp.V_1*medium.rho*medium.cp*T0_1;
H_2=esp.V_2*medium.rho*medium.cp*T0_2;
  
end IntercambiadorPlacas;
