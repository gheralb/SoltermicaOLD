model Verificacion_02 
  "Pruebas funcionales y de verificacion del modelo del captador. Estancamiento del colector" 
  annotation (uses(Modelica(version="2.2.1")), Diagram);
  Modelica.Thermal.HeatTransfer.PrescribedHeatFlow prescribedHeatFlow 
    annotation (extent=[-40,50; -20,70]);
  Modelica.Thermal.FluidHeatFlow.Sources.ConstantVolumeFlow constantVolumeFlow(
      T0=301.95,
      m=0.001,
      medium=Soltermica.Media.Propilenglicol_40(),
      VolumeFlow=0.0000000000000000001) 
              annotation (extent=[-60,-20; -40,-40], rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient(
    p_Ambient=101300,
      medium=Soltermica.Media.Propilenglicol_40(),
      T_Ambient=301.95) 
                   annotation (extent=[-40,-78; -60,-58], rotation=-90);
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(
    p_Ambient=101300,
    T_Ambient=293.15,
      medium=Soltermica.Media.Propilenglicol_40()) 
                   annotation (extent=[20,0; 40,20]);
  Modelica.Blocks.Sources.Constant const(k=1000) 
    annotation (extent=[-80,50; -60,70]);
  Modelica.Blocks.Sources.Constant const1(k=303.15) 
    annotation (extent=[-80,8; -60,28]);
    Soltermica.ColectoresSolares.ColectorSolar colectorSolar_01_1(
                                        medium=
          Soltermica.Media.Propilenglicol_40(), esp=
          CatalogoEquipos.BAXIROCA_PS_2_0()) 
      annotation (extent=[-20,0; 0,20]);
equation 
  connect(ambient.flowPort, constantVolumeFlow.flowPort_a) 
    annotation (points=[-50,-58; -50,-40], style(color=1, rgbcolor={255,0,0}));
  connect(const.y, prescribedHeatFlow.Q_flow) annotation (points=[-59,60; -40,
        60], style(
      color=74,
      rgbcolor={0,0,127},
      fillColor=10,
      rgbfillColor={135,135,135},
      fillPattern=1));
    connect(prescribedHeatFlow.port, colectorSolar_01_1.port_a) annotation (
       points=[-20,60; -10,60; -10,20], style(color=42, rgbcolor={191,0,0}));
    connect(colectorSolar_01_1.flowPort_b, ambient1.flowPort) annotation (
        points=[0,10; 20,10], style(color=1, rgbcolor={255,0,0}));
    connect(const1.y, colectorSolar_01_1.u) annotation (points=[-59,18; -20,
          18], style(color=74, rgbcolor={0,0,127}));
    connect(constantVolumeFlow.flowPort_b, colectorSolar_01_1.flowPort_a) 
      annotation (points=[-50,-20; -50,10; -20,10], style(color=1, rgbcolor=
           {255,0,0}));
end Verificacion_02;
