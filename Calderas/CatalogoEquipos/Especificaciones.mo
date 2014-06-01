record Especificaciones "Especificaciones de las calderas" 
  extends Soltermica.ClasesBasicas.Iconos.Icono_CatalagoEquipo;
  parameter Modelica.SIunits.Volume V_cald=1 
    "Volumen de l�quido que contiene la caldera";
  parameter Modelica.SIunits.VolumeFlowRate V_flow_nom=1 
    "Caudal en condiciones nominales";
  parameter Modelica.SIunits.Pressure dp_nom=1 
    "Caida de presion en condiciones nominales";
  parameter Modelica.SIunits.HeatCapacity CapacidadTermicaVacio=1 
    "Capacidad t�rmica de la caldera sin contar el fluido de trabajo";
  parameter Real RendimientoInstantaneo=1 
    "Rendimiento instant�neo en condiciones nominales m�ximas";
  parameter Modelica.SIunits.VolumeFlowRate V_flow_min=1 
    "Caudal m�nimo de ACS que hace encender la caldera";
  parameter Real ModulacionMinima=1 
    "Grado de modulaci�n m�nima que soporta la caldera";
  parameter Modelica.SIunits.HeatFlowRate PotenciaNominal=1 
    "Potencia nominal m�xima de la caldera";
  parameter Real PCCombustible=1 "Poder calorifico del combustible utilizado";
  parameter Modelica.SIunits.Area S_cald=1 
    "Superficie de la caldera expuesta al ambiente";
  
end Especificaciones;
