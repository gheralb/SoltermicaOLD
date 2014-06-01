model VolumenesControl1D 
  
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=
        medium) 
    annotation (extent=[-110,-10; -90,10]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=
        medium) 
    annotation (extent=[90,-10; 110,10]);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a puertoInt[n] 
    annotation (extent=[-10,90; 10,110]);//Puerto de intercambio de calor interno
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b puertoExt[n] 
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
  Soltermica.ClasesBasicas.VolumenesControl.VolumenControlUnico volumenControl[
                                                              n](
    each Volumen=volumen/n,
    each dP_nom=dp_nom,
    each cV_nom=V_flow_nom,
    each medium=medium,
    each T_ini=T_ini);
  
  parameter Integer n(min=1)=1;//Número de volumenes de control
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  
  parameter Real volumen=1;//Volumen total del conjunto
  parameter Real longitud=1;//Longitud total del conjunto en el eje principal de estudio
  parameter Real dp_nom=1;
  parameter Real V_flow_nom=1;
  
  parameter Modelica.SIunits.Temp_K T_ini=273.15;
equation 
connect(flowPort_b,volumenControl[1].flowPort_a);
//conexion de los volumenes de control
for i in 1:n-1 loop
  connect(volumenControl[i].flowPort_b,volumenControl[i+1].flowPort_a);
end for;
connect(flowPort_a,volumenControl[n].flowPort_b);
for i in 1:n loop
  connect(volumenControl[i].puertoInt,puertoInt[i]);
  connect(volumenControl[i].puertoExt,puertoExt[i]);
end for;
end VolumenesControl1D;
