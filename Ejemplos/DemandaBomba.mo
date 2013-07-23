model DemandaBomba 
  "Modelo en el que se simula la demanda de ACS utilizando una fuente de cuadal. El perfil de consumo se introduce mediante la utilización de una combiTable" 
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient(medium=
          Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=401300) 
      annotation (extent=[-60,0; -80,20]);
    Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(medium=
          Modelica.Thermal.FluidHeatFlow.Media.Water(), p_Ambient=101300) 
      annotation (extent=[40,0; 60,20]);
    annotation (Diagram);
    Modelica.Thermal.FluidHeatFlow.Sources.PrescribedVolumeFlow 
    prescribedVolumeFlow(  medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
        m=0.1) annotation (extent=[-20,0; 0,20]);
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
      table=[0.0,0.0; 3000,1; 2*3000,0.0],
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      tableOnFile=true,
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      tableName="perfil1", 
    fileName="consumo.dat") 
      annotation (extent=[-60,50; -40,70]);
equation 
    connect(ambient.flowPort, prescribedVolumeFlow.flowPort_a) annotation (
        points=[-60,10; -20,10], style(color=1, rgbcolor={255,0,0}));
    connect(prescribedVolumeFlow.flowPort_b, ambient1.flowPort) 
      annotation (points=[0,10; 40,10], style(color=1, rgbcolor={255,0,0}));
    connect(combiTimeTable.y[1], prescribedVolumeFlow.VolumeFlow) annotation (
       points=[-39,60; -10,60; -10,20], style(color=74, rgbcolor={0,0,127}));
end DemandaBomba;
