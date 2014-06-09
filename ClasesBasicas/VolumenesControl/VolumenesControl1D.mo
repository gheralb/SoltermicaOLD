model VolumenesControl1D 
  "Volumen de control divisible en n elemento. Distribucion unidimensional" 
    Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(
    final medium=medium) 
    "Puerto de entrada de caudal al sistema global de volumenes desde el entorno"
    annotation (extent=[-110,-10; -90,10]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(
    final medium=medium) 
    "Puerto de salida de caudal al sistema global de volumenes desde el entorno"
    annotation (extent=[90,-10; 110,10]);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a puertoInt[n] 
    "Puertos de intercambio de calor entre elementos internos al sistema" 
    annotation (extent=[-10,90; 10,110]);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b puertoExt[n] 
    "Puertos de intercambio de calor entre elementos externos al sistema como el ambiente"
    annotation (extent=[-10,-110; 10,-90]);
  annotation (Diagram, Icon(Rectangle(extent=[-88,-80; -48,80], style(
          pattern=0,
          gradient=2,
          fillColor=71,
          rgbfillColor={85,170,255})),
                            Rectangle(extent=[-20,-80; 20,80], style(
          pattern=0,
          gradient=2,
          fillColor=71,
          rgbfillColor={85,170,255})),
                            Rectangle(extent=[50,-80; 90,80], style(
          pattern=0,
          gradient=2,
          fillColor=71,
          rgbfillColor={85,170,255})),
      Rectangle(extent=[-100,88; -40,-90], style(
          color=0,
          rgbcolor={0,0,0},
          pattern=3)),
      Rectangle(extent=[-30,88; 30,-90], style(
          color=0,
          rgbcolor={0,0,0},
          pattern=3)),
      Rectangle(extent=[40,88; 100,-90], style(
          color=0,
          rgbcolor={0,0,0},
          pattern=3))));
  Soltermica.ClasesBasicas.VolumenesControl.VolumenControlUnico volumenControl[n](
    each Volumen=volumen/n,
    each dP_nom=dp_nom,
    each cV_nom=V_flow_nom,
    each medium=medium,
    each T_ini=T_ini);
  parameter Integer n(min=1)=2 
    "Numero de volumenes de control incluidos en el sistema";
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium() 
    "Medio fluido representativo de los volumenes de control. Igual para todos.";
  
  parameter Real volumen=1 "Volumen total en del sistema";
  parameter Real longitud=1 
    "Longitud total del conjunto en el eje principal de estudio";
  parameter Real dp_nom=1 
    "Caida de presion en condiciones nominales en los volumenes de control. Igual para todos";
  parameter Real V_flow_nom=1 
    "Caudal circulante en condiciones nominales en los volumenes de control. Igual para todos";
  parameter Modelica.SIunits.Temp_K T_ini=273.15 
    "Tempertura inicial de todos los volumenes de control";
equation 
connect(flowPort_b,volumenControl[1].flowPort_a);
//conexion de los volumenes de control. Uno detrás de otro (unidimensional)
for i in 1:n-1 loop
  connect(volumenControl[i].flowPort_b,volumenControl[i+1].flowPort_a);
end for;
connect(flowPort_a,volumenControl[n].flowPort_b);
for i in 1:n loop
  connect(volumenControl[i].puertoInt,puertoInt[i]);
  connect(volumenControl[i].puertoExt,puertoExt[i]);
end for;
end VolumenesControl1D;
