model VolumenControlUnico 
  extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort(m=Volumen*medium.rho, T0=T_ini,T(start=T_ini));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a puertoInt 
    annotation (extent=[-10,90; 10,110]);                                                                        //Puerto de intercambio de calor interno
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b puertoExt 
    annotation (extent=[-10,-110; 10,-90]);
                                         //Puerto de intercambio de calor externo
  Modelica.SIunits.HeatFlowRate Q_flow_int 
    "Intercambio de calor con elementos internos";
  Modelica.SIunits.HeatFlowRate Q_flow_ext 
    "Intercambio de calor con el ambiente";
  parameter Modelica.SIunits.Volume Volumen=1;
  parameter Modelica.SIunits.Pressure dP_nom=1;
  parameter Modelica.SIunits.VolumeFlowRate cV_nom=1;
  parameter Modelica.SIunits.Temp_K T_ini=273.15;
equation 
//Modelo de friccion
dp = -dP_nom * (flowPort_a.m_flow^2) / ((cV_nom*medium.rho)^2);
//Definicion de los puertos de intercambio de calor
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
initial equation 
  //T=T_ini;
end VolumenControlUnico;
