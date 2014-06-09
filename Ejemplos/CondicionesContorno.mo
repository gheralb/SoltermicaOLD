model CondicionesContorno 
  "Modelo de pruebas de adquisicion de distintas condiciones de contorno" 
  annotation (uses(Modelica(version="2.2.1")), Diagram);
  Modelica.Blocks.Sources.CombiTimeTable consumoACS(
    tableOnFile=true,
    offset={0},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    tableName="perfilAnual_1",
    fileName="CondicionesContorno\\perfilConsumoAnual.mat") 
                                  annotation (extent=[-10,-30; 10,-10]);
  Modelica.Blocks.Sources.CombiTimeTable irradiacion(
    tableOnFile=true,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    offset={1},
    tableName="IrradAnual",
    extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
    fileName="CondicionesContorno\\D3pen_Irrad_39_20.mat") 
                            annotation (extent=[-10,-70; 10,-50]);
  Modelica.Blocks.Sources.CombiTimeTable temperaturaRed(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    tableName="Ciudad_Real",
    offset={273.15},
    fileName="CondicionesContorno\\temperaturasRed.mat") 
                                  annotation (extent=[-10,50; 10,70]);
  Modelica.Blocks.Sources.CombiTimeTable temperaturaSeca(
    tableOnFile=true,
    offset={0},
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    fileName="CondicionesContorno\\TemperaturasSeca.mat",
    tableName="D3_TempSec")       annotation (extent=[-14,10; 6,30]);
end CondicionesContorno;
