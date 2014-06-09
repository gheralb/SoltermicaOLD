model VolumenControlUnico "Volumen de control un solo elemento" 
  extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort(m=Volumen*medium.rho, T0=T_ini,T(start=T_ini));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a puertoInt 
    "Puerto de intercambio de calor interno" 
    annotation (extent=[-10,90; 10,110]);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b puertoExt 
    "Puerto de intercambio de calor externo" 
    annotation (extent=[-10,-110; 10,-90]);
  Modelica.SIunits.HeatFlowRate Q_flow_int 
    "Intercambio de calor con elementos internos";
  Modelica.SIunits.HeatFlowRate Q_flow_ext 
    "Intercambio de calor con el ambiente";
  parameter Modelica.SIunits.Volume Volumen=1 "Volumen del sistema";
  parameter Modelica.SIunits.Pressure dP_nom=1 
    "Caida de presion en condiciones nominales";
  parameter Modelica.SIunits.VolumeFlowRate cV_nom=1 
    "Caudal volumetrico en condiciones nominales";
  parameter Modelica.SIunits.Temp_K T_ini=273.15 
    "Temperatura inicial del volumen de control";
equation 
//Modelo de friccion en el volumen de control
dp = -dP_nom * (flowPort_a.m_flow^2) / ((cV_nom*medium.rho)^2);
//Definicion de las variables en el interfaz de intercambio de calor
puertoInt.Q_flow=Q_flow_int;
puertoInt.T=T;
puertoExt.Q_flow=Q_flow_ext;
puertoExt.T=T;
//Flujo de calor neto en el volumen de control
Q_flow=Q_flow_int+Q_flow_ext;
  annotation (Diagram, Icon(
         Rectangle(extent=[-80,-80; 80,80], style(
          color=0,
          rgbcolor={0,0,0},
          pattern=3)), Rectangle(extent=[-60,60; 60,-60], style(
          color=0,
          rgbcolor={0,0,0},
          gradient=2,
          fillColor=71,
          rgbfillColor={85,170,255}))));
end VolumenControlUnico;
