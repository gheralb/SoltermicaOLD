package CatalogoEquipos 
  record Especificaciones 
    "Clase record donde se incluyen las especificaciones de los depositos de acumulacion de agua caliente" 
    extends Soltermica.ClasesBasicas.Iconos.Icono_CatalagoEquipo;
    parameter Modelica.SIunits.VolumeFlowRate V_flow_nom=1 
      "Caudal volumetrico para condiciones nominales de funcionamiento";
    parameter Modelica.SIunits.Pressure dp_nom=1 
      "Caida de presion para condiciones nominales de funcionamiento";
    parameter Modelica.SIunits.Volume volumen=1 
      "Volumen de acumulacion del deposito";
    parameter Modelica.SIunits.Length altura=1 
      "Altura del deposito de acumulacon";
  end Especificaciones;
  
  record IDROGAS_CV200SR = 
      Soltermica.Acumuladores.CatalogoEquipos.Especificaciones (
         V_flow_nom=0.0001, dp_nom=1000, volumen=0.2, altura=1.205-0.2);
  record IDROGAS_CV300SR = 
      Soltermica.Acumuladores.CatalogoEquipos.Especificaciones (
         V_flow_nom=0.0001 "Generica",dp_nom=1000 "Generica",volumen=0.3, altura=1.685-0.2);
end CatalogoEquipos;
