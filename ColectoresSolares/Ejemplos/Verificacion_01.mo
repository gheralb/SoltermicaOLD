model Verificacion_01 
  "Pruebas funcionales y de verificacion del modelo del captador. Calentamiento de caudal con mediante una entrada de energía" 
  annotation (uses(Modelica(version="2.2.1")), Diagram);
  Modelica.Thermal.HeatTransfer.PrescribedHeatFlow prescribedHeatFlow 
    annotation (extent=[-40,50; -20,70]);
  Modelica.Thermal.FluidHeatFlow.Sources.ConstantVolumeFlow constantVolumeFlow(
      medium=Soltermica.Media.Propilenglicol_40(), 
    m=0.1, 
    T0=303.15, 
    VolumeFlow=0.00011133) 
              annotation (extent=[-60,-20; -40,-40], rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient(
    p_Ambient=101300,
      medium=Soltermica.Media.Propilenglicol_40(), 
    T_Ambient=337.65) 
                   annotation (extent=[-40,-78; -60,-58], rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(
    p_Ambient=101300,
    T_Ambient=293.15,
      medium=Soltermica.Media.Propilenglicol_40()) 
                   annotation (extent=[20,0; 40,20]);
  Modelica.Blocks.Sources.Constant RadiacionCte(k=883) 
    annotation (extent=[-80,50; -60,70]);
  Modelica.Blocks.Sources.Constant TemperaturaConstante(k=302.55) 
    annotation (extent=[-80,8; -60,28]);
  ColectorSolar colectorSolar(
    esp=Soltermica.ColectoresSolares.CatalogoEquipos.BAXIROCA_PS_2_0(), 
    T0=302.55, 
    medium=Soltermica.Media.Propilenglicol_40())
    annotation (extent=[-20,0; 0,20]);
equation 
  connect(ambient.flowPort, constantVolumeFlow.flowPort_a) 
    annotation (points=[-50,-58; -50,-40], style(color=1, rgbcolor={255,0,0}));
  connect(RadiacionCte.y, prescribedHeatFlow.Q_flow) 
                                              annotation (points=[-59,60; -40,
        60], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
  connect(prescribedHeatFlow.port, colectorSolar.port_a) annotation (points=[
        -20,60; -10,60; -10,20], style(color=42, rgbcolor={191,0,0}));
  connect(TemperaturaConstante.y, colectorSolar.u)
    annotation (points=[-59,18; -20,18], style(color=74, rgbcolor={0,0,127}));
  connect(colectorSolar.flowPort_b, ambient1.flowPort)
    annotation (points=[0,10; 20,10], style(color=1, rgbcolor={255,0,0}));
  connect(constantVolumeFlow.flowPort_b, colectorSolar.flowPort_a) annotation (
      points=[-50,-20; -50,10; -20,10], style(color=1, rgbcolor={255,0,0}));
end Verificacion_01;
