record Especificaciones "Especificaciones de los circuladores" 
  extends Soltermica.ClasesBasicas.Iconos.Icono_CatalagoEquipo;
  parameter Modelica.SIunits.Volume V_circ=1 
    "Volumen de líquido que contiene el circulador";
  parameter Modelica.SIunits.VolumeFlowRate V_flow_nom=1 
    "Caudal impulsado por el circulador en condiciones nominales";
  parameter Modelica.SIunits.Pressure dp_nom=1 
    "Aumento de presion producido entre la aspiración y la descarga del circulador en condiciones nominales";
  parameter Modelica.SIunits.Power Pot_elec_nom=1 
    "Potencia electrica consumida por el circulador en condiciones nominales";
end Especificaciones;
