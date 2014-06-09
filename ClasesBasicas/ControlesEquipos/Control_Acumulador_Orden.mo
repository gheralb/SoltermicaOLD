model Control_Acumulador_Orden 
  "Bloque que controla el balance de energia a nivel interno en un volumen de fluido. Modela el fenomeno de estratificacion por ordenamiento de carga" 
    annotation (Diagram, Icon(Rectangle(extent=[-80,80; 80,28],style(
          pattern=0,
          gradient=1,
          fillColor=1,
          rgbfillColor={255,0,0})), Rectangle(extent=[-80,-28; 80,-80],
                                                                      style(
          pattern=0,
          gradient=1,
          fillColor=71,
          rgbfillColor={85,170,255})),
      Rectangle(extent=[-88,-88; 88,88], style(color=3, rgbcolor={0,0,255})),
                            Rectangle(extent=[-80,28; 80,-28], style(
          pattern=0,
          gradient=1,
          fillColor=45,
          rgbfillColor={255,128,0}))));
  Modelica.Blocks.Interfaces.RealInput T_in 
    annotation (extent=[-120,40; -80,80]);
  Modelica.Blocks.Interfaces.RealInput m_flow 
    annotation (extent=[-120,-20; -80,20]);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a 
    annotation (extent=[-110,-70; -90,-50]);
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium() 
    "Medio del volumen de control a controlar";
  parameter Integer n=3 "Numero de segmentos del volumen de control";
  parameter Real volumen=1 "Volumen del volumen de control";
  parameter Real altura=1 "Altura o longitud del volumen de control";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b puertoInt[n] 
    annotation (extent=[90,-10; 110,10]);
  Real Q_int 
    "Flujo de calor intercambiador con medio exteriores al volumen de control";
  Real Q_in[n] "Flujo de calor entrante en cada volumen";
  Real Q_cond[n] 
    "Flujo de calor intercambiado por conduccion entre capas vecinas";
  Real Q_neto[n] "Flujo de calor neto recibido por cada volumen de control";
equation 
//Balance de energía neta que entra en el volumen
Q_int=noEvent(if m_flow>0.0001 then m_flow*medium.cp*(T_in-puertoInt[n].T) else 0);
port_a.Q_flow=Q_int;
//Determinacion flujo de calor por los puertos del deposito
//Flujo de calor entrante desde el exterior
Q_in[1]=noEvent(if (T_in>=puertoInt[1].T) then -Q_int else 0);
for i in 2:n loop
  Q_in[i]=noEvent(if (T_in>=puertoInt[i].T and puertoInt[i-1].T>T_in) then -Q_int else 0);
end for;
//Flujo de calor por el fenomeno de conduccion de calor
Q_cond[1]=-(((volumen/altura)*medium.lamda*(puertoInt[1+1].T-puertoInt[1].T))/(altura/n));
for i in 2:n-1 loop
  Q_cond[i]=-(((volumen/altura)*medium.lamda*(puertoInt[i-1].T-puertoInt[i].T))/(altura/n)+
((volumen/altura)*medium.lamda*(puertoInt[i+1].T-puertoInt[i].T))/(altura/n));
end for;
Q_cond[n]=-(((volumen/altura)*medium.lamda*(puertoInt[n-1].T-puertoInt[n].T))/(altura/n));
//Balance de todos los flujos de calor
Q_neto[1]=Q_in[1]+Q_cond[1];
for i in 2:n loop
  Q_neto[i]=Q_in[i]+Q_cond[i];
end for;
//Flujo calor neto en cada elemento
for i in 1:n loop
  puertoInt[i].Q_flow=Q_neto[i];
end for;
end Control_Acumulador_Orden;
