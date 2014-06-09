model Control_Interacumulador_Mezcla 
  "Bloque que controla el balance de energia a nivel interno en un volumen de fluido. Modela el fenomeno de estratificacion por mezcla de volumenes" 
  annotation (Diagram, Icon(Rectangle(extent=[-80,80; 80,0], style(
        color=3,
        rgbcolor={0,0,255},
        gradient=1,
        fillColor=1,
        rgbfillColor={255,0,0})), Rectangle(extent=[-80,0; 80,-80], style(
        color=3,
        rgbcolor={0,0,255},
        gradient=1,
        fillColor=71,
        rgbfillColor={85,170,255})),
    Rectangle(extent=[-88,-86; 88,88], style(color=3, rgbcolor={0,0,255}))));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b puertoInt[n] 
    annotation (extent=[90,-10; 110,10]);
  Real Q_cond[n] 
    "Flujo de calor intercambiado por conduccion entre capas vecinas";
  Real Q_invTemp[n] "Flujo de calor producido por inversion de temperaturas";
  Real Q_neto[n] "Flujo de calor neto recibido por cada volumen de control";
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  parameter Integer n=3;
  parameter Real volumen=1;
  parameter Real altura=1;
  parameter Real cteTiempo=1 
    "Constante de tiempo para el fenomeno de inversion de temperatura";
equation 
//Determinacion flujo de calor por los puertos del deposito
//Flujo de calor por el fenomeno de conduccion de calor
Q_cond[1]=(((volumen/altura)*medium.lamda*(puertoInt[1+1].T-puertoInt[1].T))/(altura/n));
for i in 2:n-1 loop
  Q_cond[i]=(((volumen/altura)*medium.lamda*(puertoInt[i-1].T-puertoInt[i].T))/(altura/n)+
((volumen/altura)*medium.lamda*(puertoInt[i+1].T-puertoInt[i].T))/(altura/n));
end for;
Q_cond[n]=(((volumen/altura)*medium.lamda*(puertoInt[n-1].T-puertoInt[n].T))/(altura/n));
  
//Flujo de calor por el fenomeno de inversion de temperatura
for i in 1:n-1 loop
  Q_invTemp[i]=noEvent(if puertoInt[i+1].T-puertoInt[i].T>0 then ((volumen/altura)*medium.cp*(((puertoInt[i+1].T+puertoInt[i].T)/2)-puertoInt[i].T))/cteTiempo else 0);
end for;
Q_invTemp[n]=0;
  
//Balance de todos los flujos de calor
Q_neto[1]=Q_cond[1]+Q_invTemp[1];
for i in 2:n loop
  Q_neto[i]=Q_cond[i]+Q_invTemp[i]-Q_invTemp[i-1];
end for;
  
//Flujo calor neto en cada elemento
for i in 1:n loop
  puertoInt[i].Q_flow=-Q_neto[i];
end for;
  
end Control_Interacumulador_Mezcla;
