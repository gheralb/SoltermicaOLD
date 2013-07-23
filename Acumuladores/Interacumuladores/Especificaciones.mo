record Especificaciones "Especificaciones de los interacumuladores" 
  parameter Modelica.SIunits.Volume V_dep=1;//Volumen de acumulacion del deposito
  parameter Modelica.SIunits.Volume V_int=1;//Volumen interno del serpentin
  parameter Modelica.SIunits.MassFlowRate m_flow_int_nom=1;//Caudal circulante por el intercambiador en condiciones nominales
  parameter Modelica.SIunits.Pressure dp_int_nom=1;//Caída de presión en el intercambiador en condiciones nominales
  parameter Modelica.SIunits.MassFlowRate m_flow_dep_nom=1;//Caudal circualnte por el deposito en condiciones nominales
  parameter Modelica.SIunits.Pressure dp_dep_nom=1;//Caída de presión en el deposito en condiciones nominales
  parameter Modelica.SIunits.Area A_int=1;//Superficie de intercabio del serpentin
  parameter Real U_int=1;//Coeficiente global de intercambio
  
end Especificaciones;
