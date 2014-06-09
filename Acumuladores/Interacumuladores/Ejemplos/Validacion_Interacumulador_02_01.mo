model Validacion_Interacumulador_02_01 
  "Modelo que muestra el comportamiento basico de un interacumulador" 
  Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow CaudalEntrada(
      medium=Modelica.Thermal.FluidHeatFlow.Media.Water(), m=0.1) 
            annotation (extent=[-28,-8; -8,12]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ida(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    p_Ambient=101300,
    T_Ambient=Modelica.SIunits.Conversions.from_degC(80)) 
    annotation (extent=[-50,-50; -30,-30], rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient retorno(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[-12,-50; 8,-30],   rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient red(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[50,-50; 70,-30],rotation=0);
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    rising=10,
    falling=10,
    startTime=10,
    offset=0,
    amplitude=0.0001388,
    width=3600,
    period=10000)     annotation (extent=[-50,30; -30,50]);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient sumidero(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
    annotation (extent=[70,30; 50,50], rotation=-180);
  Soltermica.Acumuladores.Interacumuladores.Interacumulador_Mezcla 
    interacumulador_Mezcla(
    medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
    espec=
        Soltermica.Acumuladores.Interacumuladores.CatalogoEquipos.LAPESA_CV_80_M1S(),
    T_ini=293.15,
    n=6,
    n_int=3)      annotation (extent=[14,-4; 34,16]);
  
equation 
  connect(ida.flowPort,CaudalEntrada. flowPort_a)            annotation (points=[-40,-30;
        -40,2; -28,2],              style(color=1, rgbcolor={255,0,0}));
  connect(trapezoid.y,CaudalEntrada. VolumeFlow)        annotation (points=[-29,40;
        -18,40; -18,12],    style(color=74, rgbcolor={0,0,127}));
  annotation (Diagram);
  connect(CaudalEntrada.flowPort_b, interacumulador_Mezcla.flowPort_a1) 
    annotation (points=[-8,2; 4,2; 4,6; 14,6], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=1,
      fillColor=71,
      rgbfillColor={85,170,255}));
  connect(retorno.flowPort, interacumulador_Mezcla.flowPort_b1) 
    annotation (points=[-2,-30; 6,-30; 6,-2; 14,-2], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=1,
      fillColor=71,
      rgbfillColor={85,170,255}));
  connect(interacumulador_Mezcla.flowPort_a, red.flowPort)      annotation (
      points=[24,-4; 24,-40; 50,-40], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=1,
      fillColor=71,
      rgbfillColor={85,170,255}));
  connect(interacumulador_Mezcla.flowPort_b, sumidero.flowPort) 
    annotation (points=[24,16; 24,40; 50,40], style(
      color=1,
      rgbcolor={255,0,0},
      gradient=1,
      fillColor=71,
      rgbfillColor={85,170,255}));
end Validacion_Interacumulador_02_01;
