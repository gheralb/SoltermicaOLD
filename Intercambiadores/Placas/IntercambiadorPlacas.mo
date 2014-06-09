model IntercambiadorPlacas "Modelo de intercambiador de placas" 
  
  annotation (uses(Modelica(version="2.2.1")), Diagram,
    Icon(
      Rectangle(extent=[-60,80; 60,-80], style(
          color=0,
          rgbcolor={0,0,0},
          gradient=3,
          fillColor=30,
          rgbfillColor={215,215,215})),
      Line(points=[-100,60; 40,60; -40,30; 40,0; -40,-30; 40,-60; -100,-60],
          style(
          color=1,
          rgbcolor={255,0,0},
          gradient=3)),
      Line(points=[100,-60; -38,-60; 40,-30; -40,0; 40,30; -40,60; 100,60; 100,
            62], style(
          color=69,
          rgbcolor={0,128,255},
          gradient=3))));
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b_1(final 
      medium = medium_1) 
    annotation (extent=[-110,-70; -90,-50]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a_2(final 
      medium=medium_2) 
    annotation (extent=[90,-70; 110,-50]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b_2(final 
      medium=medium_2) 
    annotation (extent=[90,50; 110,70]);
  Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a_1(final 
      medium=medium_1) 
                     annotation (extent=[-110,50; -90,70]);
  Soltermica.ClasesBasicas.VolumenesControl.VolumenesControl1D 
    volumenesControl1D_1(
    final n=n,
    final volumen=espec.V_1,
    final longitud=espec.L_int,
    final dp_nom=espec.dp_nom_1,
    final V_flow_nom=espec.V_flow_nom_1,
    final medium=medium_1,
    T_ini=T_ini) 
    annotation (extent=[-40,-10; -60,10], rotation=90);
  Soltermica.ClasesBasicas.VolumenesControl.VolumenesControl1D 
    volumenesControl1D_2(
    final n=n,
    final volumen=espec.V_2,
    final longitud=espec.L_int,
    final dp_nom=espec.dp_nom_2,
    final V_flow_nom=espec.V_flow_nom_2,
    final medium=medium_2,
    T_ini=T_ini) 
    annotation (extent=[40,-10; 60,10], rotation=90);
  Soltermica.ClasesBasicas.TransferenciaCalor.TransmisionCalor1D 
    transmisionCalor1D[                               n](
    each U=espec.U_int,
    each A=(espec.S_int/n)) 
    annotation (extent=[-10,-10; 10,10]);
  Modelica.SIunits.Power potTotInter;
  
  parameter Integer n=1;
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium_1=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium_2=Modelica.Thermal.FluidHeatFlow.Media.Medium();
  
  parameter Soltermica.Intercambiadores.Placas.CatalogoEquipos.Especificaciones
    espec = Soltermica.Intercambiadores.Placas.CatalogoEquipos.Especificaciones();
  
  parameter Modelica.SIunits.Temp_K T_ini;
  
equation 
//Definición de la potencia total intercambiada
potTotInter=sum(transmisionCalor1D[i].port_a.Q_flow for i in 1:n);
  connect(flowPort_a_1, volumenesControl1D_1.flowPort_b) annotation (points=[
        -100,60; -50,60; -50,10], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=1,
      rgbfillColor={255,0,0},
      fillPattern=1));
  connect(flowPort_b_1, volumenesControl1D_1.flowPort_a) annotation (points=[
        -100,-60; -50,-60; -50,-10], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=1,
      rgbfillColor={255,0,0},
      fillPattern=1));
  connect(flowPort_a_2, volumenesControl1D_2.flowPort_a) annotation (points=[
        100,-60; 50,-60; 50,-10], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=1,
      rgbfillColor={255,0,0},
      fillPattern=1));
  connect(volumenesControl1D_2.flowPort_b, flowPort_b_2) annotation (points=[50,
        10; 50,60; 100,60], style(
      color=1,
      rgbcolor={255,0,0},
      fillColor=1,
      rgbfillColor={255,0,0},
      fillPattern=1));
  connect(volumenesControl1D_1.puertoInt, transmisionCalor1D.port_a) 
    annotation (points=[-40,6.12303e-016; -26,6.12303e-016; -26,0; -10,0],
      style(
      color=42,
      rgbcolor={191,0,0},
      fillColor=1,
      rgbfillColor={255,0,0},
      fillPattern=1));
  connect(transmisionCalor1D.port_b, volumenesControl1D_2.puertoInt) 
    annotation (points=[10,0; 25,0; 25,6.12303e-016; 40,6.12303e-016], style(
      color=42,
      rgbcolor={191,0,0},
      fillColor=1,
      rgbfillColor={255,0,0},
      fillPattern=1));
end IntercambiadorPlacas;
