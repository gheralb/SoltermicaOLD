model Control_Colector "Bloque de control del colector o caprador solar" 
  annotation (Diagram, Icon(
      Polygon(points=[-80,34; -40,28; 0,14; 26,-4; 50,-26; 70,-66; -80,-66; -80,
            34], style(
          pattern=0,
          gradient=2,
          fillColor=45,
          rgbfillColor={255,128,0})),
      Rectangle(extent=[-100,-86; 100,84], style(color=3, rgbcolor={0,0,255})),
      Line(points=[-80,-66; 80,-66], style(color=0, rgbcolor={0,0,0})),
      Line(points=[-80,-66; -80,54], style(color=0, rgbcolor={0,0,0})),
      Polygon(points=[-84,54; -76,54; -80,74; -84,54], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=0,
          rgbfillColor={0,0,0})),
      Polygon(points=[80,-62; 80,-70; 100,-66; 80,-62], style(
          color=0,
          rgbcolor={0,0,0},
          fillColor=0,
          rgbfillColor={0,0,0}))));
  Modelica.Blocks.Interfaces.RealInput senalIrradiacion 
    "Senal de irradiacion solar incidente" 
    annotation (extent=[-128,40; -88,80]);
  Modelica.Blocks.Interfaces.RealInput senalTemperaturaAmbiente 
    "Senal de temperatura ambiental exterior" 
    annotation (extent=[-128,0; -88,40]);
  Modelica.Blocks.Interfaces.RealInput senalTemperaturaCaptador 
    "Senal de la temperatura del captador. Utilizada para el control" 
    annotation (extent=[-126,-80; -86,-40]);
  Modelica.Blocks.Interfaces.RealInput factorSombras 
    "Factor de 1 a 0 que representa el porcentaje de perdidas por sombras arrojadas al captador"
    annotation (extent=[-128,-40; -88,0]);
  Modelica.Blocks.Interfaces.RealOutput ganancias 
    "ganancia de calor debidas a la radiacion incidente" 
    annotation (extent=[96,30; 116,50]);
  Modelica.Blocks.Interfaces.RealOutput perdidas 
    "perdidas de calor debidas a la conveccion con el exterior (cuendo este esta mas frio)"
    annotation (extent=[96,-50; 116,-30]);
  Real Rend_captador(min=0,max=1) 
    "Rendimiento instantáneo del captador. Mirar como se define de 0 a 1";
  Real T_corregida 
    "Variable comunmente utilizada en la documentacion tecnica. Es la diferencia entre la temperatura del captador y la del ambiente partido por la irradiacion";
  parameter Soltermica.ColectoresSolares.CatalogoEquipos.Especificaciones espec
    = Soltermica.ColectoresSolares.CatalogoEquipos.Especificaciones() 
    "Especificaciones propias del captador solar";
  
equation 
  //Ganancia solar
  ganancias=espec.A_apertura*senalIrradiacion*espec.Rend_optico*espec.IAM_50*(1-factorSombras);
  //Perdidas ambiente
  perdidas=noEvent(if senalTemperaturaCaptador>senalTemperaturaAmbiente then -espec.A_apertura*(espec.Coef_perdidas_1*(senalTemperaturaCaptador-senalTemperaturaAmbiente)+espec.Coef_perdidas_2*(senalTemperaturaCaptador-senalTemperaturaAmbiente)^2) else 0);
  //Temperatura corregida
  T_corregida=noEvent(if senalTemperaturaCaptador>senalTemperaturaAmbiente then (senalTemperaturaCaptador-senalTemperaturaAmbiente)/senalIrradiacion else 0);
  //Rendimiento captador
  Rend_captador=noEvent(if (senalIrradiacion>1 and T_corregida>0 and abs(perdidas)<ganancias) then espec.Rend_optico-espec.Coef_perdidas_1*T_corregida-espec.Coef_perdidas_2*(T_corregida^2)/senalIrradiacion else 0);
  //and abs(perdidas)<ganancias
end Control_Colector;
