//Creado por Daniela Maldonado. Muestra la cantidad de investigadores por áreea y sexo en el año 2013.

// Creación de Tablas
Table intGAS, invS, gruSL, invA;

//Creacion de Fuentes
PFont texlin, texTit, texInv, texTinv, texGen, textPA, textPP;

//Variables auxiliares
float invMujGrad, invHomGrad;
float [] intS = new float[14];
int dCons=60;
int xGrup=1150;
int yGrup=170;

//Diámetros
int difD=16;
int diamArc=510;
int diamCirc=460;
int escArea=14;

//VAR Diámetro círculos
float dCN;
float dIT;
float dME;
float dAG;
float dSO;
float dHU;
float dOT;


void setup() {
  size(1350, 700);

  //Fuente de los textos que indican las áreas
  texlin = loadFont("SourceSansPro-Semibold-14.vlw");
  texTit = loadFont("GillSansLight-Regular-48.vlw");
  texInv= loadFont("GillSansLight-Regular-28.vlw");
  texTinv= loadFont("GillSansLight-Regular-14.vlw");
  texGen= loadFont("GillSansLight-Regular-18.vlw");
  textPA= loadFont("Overlock-Black-80.vlw");
  textPP= loadFont("SourceSansPro-Semibold-14.vlw");


  //Carga las tablas donde están los valores
  intGAS=loadTable("Tabla Integrantes Area Sexo.csv", "header");
  invS=loadTable("Tabla Inves Sexo.csv", "header");
  invA=loadTable("Tabla Inves Area.csv", "header");
  gruSL=loadTable("Tabla Lider Grupos Sexo.csv", "header");
}

void draw() {

  background(8, 35, 68);

  //Coordenadas de Objetos centrados en el canvas

  float centroY=height/2 +45;
  float centroX=width/2;

  //TÍTULO........................................................................
  fill(255);
  textFont(texTit);
  text("Investigadores por Área y Género", 360, 70);

  //GRUPOS DE INVESTIGACIÓN........................................................................
  //Detecta que se pase el mouse por los bordes para indicar la información

  if (overCircle(centroX, centroY, diamCirc) == true || overCircle(centroX, centroY, diamArc) == false ) {

    fill(255, 255, 255, 200);
    textFont(texInv);
    text("Grupos de", xGrup, yGrup);
    text("Investigación", xGrup-10, yGrup+28);

    //Rectángulo de la Zona. Aparece siempre y cuando no se esté sobre el arco
    if (overCircle(centroX, centroY, diamCirc) == false && overCircle(centroX, centroY, diamArc) == true) {
    } else {

      //Rectángulo de la Zona
      noStroke();
      fill(255, 255, 255, 15);
      rect(xGrup-50, yGrup-40, 220, 560, 7);
    }
    //Grupos Mujeres puntos

    fill(255);
    ellipse(xGrup+60, yGrup+160, 160, 160);
    fill(255, 255, 255, 180);
    noStroke();
    ellipse(xGrup+60, yGrup+160, 180, 180);

    textFont(texTinv);
    text(gruSL.getString (0, 10)+ " Liderados por Mujeres", xGrup-20, yGrup+160+110);

    for (int i=0; i<gruSL.getInt (0, 10); i++) {
      float radius = random(80);
      float am = random(TWO_PI);
      float xm = xGrup+60+cos(am)*radius;
      float ym = yGrup+160+sin(am)*radius;
      noStroke();
      fill(110, 120, 135);
      ellipse(xm, ym, 2, 2);
    }

    //Grupos Hombres puntos

    fill(255);
    ellipse(xGrup+60, yGrup+390, 160, 160);
    fill(255, 255, 255, 180);
    noStroke();
    ellipse(xGrup+60, yGrup+390, 180, 180);

    text(gruSL.getString (1, 10)+ " Liderados por Hombres", xGrup-20, yGrup+390+110);

    for (int i=0; i<gruSL.getInt (1, 10); i++) {
      float radius = random(80);
      float ah = random(TWO_PI);
      float xh = xGrup+60+cos(ah)*radius;
      float yh = yGrup+390+sin(ah)*radius;
      noStroke();
      fill(110, 120, 135);
      ellipse(xh, yh, 2, 2);
    }
  }


  //INVESTIGADORES POR SEXO........................................................................

  //Mapeo del porcentaje de hombres y mujeres a radianes 

  invMujGrad= map(invS.getFloat(9, 4), 0, 100, 0, 2*PI);
  invHomGrad= map(invS.getFloat(9, 5), 0, 100, 0, 2*PI);

  //Dibujo de los arcos si se coloca el mouse en él

  if (overCircle(centroX, centroY, diamCirc) == false && overCircle(centroX, centroY, diamArc) == true) {
    //Convenciones
    noStroke();
    fill(255, 255, 255, 15);
    rect(60, 580, 115, 65, 7);

    textFont(texGen);
    fill(170, 225, 75, 200);
    text("Hombres", 96, 603);
    ellipse(80, 597, 12, 12);

    fill(255, 255, 255, 200);
    text("Mujeres", 96, 633);
    ellipse(80, 627, 12, 12);

    //Porcentajes
    fill(255, 255, 255, 50);
    textFont(textPA);
    text(invS.getFloat(9, 4) + " %", 960, 600);
    text(invS.getFloat(9, 5) + " %", 130, 250);

    noStroke();
    //Arco Mujeres
    fill(255, 255, 255, 200);
    arc(centroX, centroY, diamArc, diamArc, 0, invMujGrad);

    //Arco Hombres
    fill(170, 225, 75, 200);
    arc(centroX, centroY, diamArc, diamArc, invMujGrad, invHomGrad+ invMujGrad);
  }

  //CÍRCULO CENTRAL........................................................................
  noStroke();
  fill(8, 35, 68);
  ellipse(centroX, centroY, diamCirc, diamCirc);

  noStroke();
  fill(255, 255, 255, 60);
  ellipse(centroX, centroY, diamCirc, diamCirc);

  fill(255, 255, 255, 20);
  ellipse(centroX, centroY, diamArc, diamArc);


  //INVESTIGADORES POR ÁREA DE CONOCIMIENTO........................................................................

  //Círculos

  //VAR Coordenadas Círulos Área
  float CNx=centroX - 100;
  float CNy=centroY -90;

  float ITx=centroX -50;
  float ITy=centroY +100;

  float MEx=centroX - 170;
  float MEy=centroY +50;

  float AGx=centroX + 50;
  float AGy=centroY -70;

  float SOx=centroX + 120;
  float SOy=centroY +50;

  float HUx=centroX + 85;
  float HUy=centroY -155;

  float OTx=centroX + 40;
  float OTy=centroY + 170;

  //VAR Diámetro círculos
  dCN=invA.getInt(0, 4)/escArea;
  dIT=invA.getInt(1, 4)/escArea;
  dME=invA.getInt(2, 4)/escArea;
  dAG=invA.getInt(3, 4)/escArea;
  dSO=invA.getInt(4, 4)/escArea;
  dHU=invA.getInt(5, 4)/escArea;
  dOT=invA.getInt(6, 4)/escArea;

  //Círculos  si el mouse NO está dentro del círculo central

  if (overCircle(centroX, centroY, diamCirc) == false) {

    //Ciencias Naturales y Exactas
    fill(146, 191, 178);
    noStroke();
    ellipse(CNx, CNy, dCN, dCN);
    //Ingeniería y Tecnología
    ellipse(ITx, ITy, dIT, dIT);
    //Ciencias Médicas y de la Salud
    ellipse(MEx, MEy, dME, dME);
    //Ciencias Agrícolas
    ellipse(AGx, AGy, dAG, dAG);
    //Ciencias Sociales
    ellipse(SOx, SOy, dSO, dSO);
    //Humanidades
    ellipse(HUx, HUy, dHU, dHU);
    //Otros
    ellipse(OTx, OTy, dOT, dOT);
  }

  //Líneas Indicadoras. If para que imprima textos excepto enlos arcos externos

  if (overCircle(centroX, centroY, diamCirc) == false && overCircle(centroX, centroY, diamArc) == true) {
  } else {
    //Líneas Indicadoras
    stroke(160, 160, 160, 60);
    strokeWeight(1);
    noFill();

    //Ciencias Naturales
    beginShape();
    vertex(CNx, CNy);
    vertex(CNx-110, CNy-110);
    vertex(CNx-270, CNy-110);
    endShape();

    //Ingeniería y Tecnología
    beginShape();
    vertex(ITx, ITy);
    vertex(ITx-110, ITy+60);
    vertex(ITx-320, ITy+60);
    endShape();

    //Ciencias Médicas y de la Salud
    beginShape();
    vertex(MEx, MEy);
    vertex(MEx-110, MEy-80);
    vertex(MEx-280, MEy-80);
    endShape();  

    //Ciencias Agrícolas
    beginShape();
    vertex(AGx, AGy);
    vertex(AGx+340, AGy);
    endShape(); 

    //Ciencias Sociales
    beginShape();
    vertex(SOx, SOy);
    vertex(SOx+265, SOy);
    endShape(); 

    //Humanidades
    beginShape();
    vertex(HUx, HUy);
    vertex(HUx+110, HUy-50);
    vertex(HUx+205, HUy-50);
    endShape();  

    //Otros
    beginShape();
    vertex(OTx, OTy);
    vertex(OTx+205, OTy);
    endShape();  

    //Texto
    textFont(texlin);
    fill(180);
    text(invA.getString(0, 0), CNx-270, CNy-110-5); //Ciencias Naturales
    text(invA.getString(1, 0), ITx-320, ITy+60-5); //Ingeniería y Tecnología
    text(invA.getString(2, 0), MEx-280, MEy-80-5); //Ciencias Médicas y de la Salud
    text(invA.getString(3, 0), AGx+230, AGy-5); //Ciencias Agrícolas
    text(invA.getString(4, 0), SOx+160, SOy-5); //Ciencias Sociales
    text(invA.getString(5, 0), HUx+120, HUy-50-5); //Humanidades
    text(invA.getString(6, 0), OTx+170, OTy-5); //Otros
  }

  //INVESTIGADORES POR ÁREA Y SEXO........................................................................

  //Mapeo del porcentaje de hombres y mujeres a radianes
  for (int i=0; i<intGAS.getRowCount ()-2; i++) {
    intS[i]=map(intGAS.getFloat(i, 14), 0, 100, 0, 2*PI);
  }

  //Círculos  si el mouse SI está dentro del círculo central
  if (overCircle(centroX, centroY, diamCirc) == true) {

    //Convenciones

    noStroke();
    fill(255, 255, 255, 15);
    rect(60, 580, 115, 65, 7);


    textFont(texGen);
    fill(170, 225, 75);
    text("Hombres", 96, 603);
    ellipse(80, 597, 12, 12);

    fill(255, 255, 255);
    text("Mujeres", 96, 633);
    ellipse(80, 627, 12, 12);

    //Ciencias Naturales y Exactas
    fill(170, 225, 75);
    noStroke();
    textFont(textPP);

    ellipse(CNx, CNy, dCN, dCN);
    if (overCircle(CNx, CNy, dCN) == true) {
      fill(255);
      text(intGAS.getFloat(1, 14) + " %", CNx  -18, CNy- dCN/2 -15);
      text(intGAS.getFloat(0, 14) + " %", CNx  -18, CNy+ dCN/2+25);
    }
    //Ingeniería y Tecnología
    fill(170, 225, 75);
    ellipse(ITx, ITy, dIT, dIT);
    if (overCircle(ITx, ITy, dIT) == true) {
      fill(255);
      text(intGAS.getFloat(3, 14) + " %", ITx -18, ITy- dIT/2 -15);
      text(intGAS.getFloat(2, 14) + " %", ITx -18, ITy+ dIT/2+25);
    }
    //Ciencias Agrícolas
    if (overCircle(AGx, AGy, dAG) == true) {
      fill(255);
      text(intGAS.getFloat(7, 14) + " %", AGx -18, AGy- dAG/2 -15);
      text(intGAS.getFloat(6, 14) + " %", AGx -18, AGy+ dAG/2+25);
    }
    fill(170, 225, 75);
    ellipse(AGx, AGy, dAG, dAG);
    //Ciencias Sociales
    if (overCircle(SOx, SOy, dSO) == true) {
      fill(255);
      text(intGAS.getFloat(9, 14) + " %", SOx -18, SOy- dSO/2 -15);
      text(intGAS.getFloat(8, 14) + " %", SOx -18, SOy+ dSO/2+25);
    }
    fill(170, 225, 75);
    ellipse(SOx, SOy, dSO, dSO);
    //Humanidades
    if (overCircle(HUx, HUy, dHU) == true) {
      fill(255);
      text(intGAS.getFloat(11, 14) + " %", HUx -18, HUy- dHU/2 -15);
      text(intGAS.getFloat(10, 14) + " %", HUx -18, HUy+ dHU/2+25);
    }
    fill(170, 225, 75);
    ellipse(HUx, HUy, dHU, dHU);
    //Otros
    if (overCircle(OTx, OTy, dOT) == true) {
      fill(255);
      text(intGAS.getFloat(13, 14) + " %", OTx -18, OTy- dOT/2 -15);
      text(intGAS.getFloat(12, 14) + " %", OTx -18, OTy+ dOT/2+25);
    }
    fill(170, 225, 75);
    ellipse(OTx, OTy, dOT, dOT);
    fill(255, 255, 255);
    //Ciencias Médicas y de la Salud
    if (overCircle(MEx, MEy, dME) == true) {
      fill(255);
      text(intGAS.getFloat(5, 14) + " %", MEx -18, MEy- dME/2 -15);
      text(intGAS.getFloat(4, 14) + " %", MEx -18, MEy+ dME/2+25);
    }
    ellipse(MEx, MEy, dME, dME);

    //Aros Mujeres
    noFill();
    strokeWeight(3);
    stroke(255, 255, 250, 150);

    arc(CNx, CNy, dCN+difD, dCN+difD, 0, intS[0], OPEN);
    arc(ITx, ITy, dIT+difD, dIT+difD, 0, intS[2], OPEN);
    arc(MEx, MEy, dME+difD, dME+difD, 0, intS[4], OPEN);
    arc(AGx, AGy, dAG+difD, dAG+difD, 0, intS[6], OPEN);
    arc(SOx, SOy, dSO+difD, dSO+difD, 0, intS[8], OPEN);
    arc(HUx, HUy, dHU+difD, dHU+difD, 0, intS[10], OPEN);
    arc(OTx, OTy, dOT+difD, dOT+difD, 0, intS[12], OPEN);

    //Aros Hombres
    stroke(98, 152, 0);
    arc(CNx, CNy, dCN+difD, dCN+difD, intS[0], intS[0]+intS[1], OPEN);
    arc(ITx, ITy, dIT+difD, dIT+difD, intS[2], intS[2]+intS[3], OPEN);
    arc(MEx, MEy, dME+difD, dME+difD, intS[4], intS[4]+intS[5], OPEN);
    arc(AGx, AGy, dAG+difD, dAG+difD, intS[6], intS[6]+intS[7], OPEN);
    arc(SOx, SOy, dSO+difD, dSO+difD, intS[8], intS[8]+intS[9], OPEN);
    arc(HUx, HUy, dHU+difD, dHU+difD, intS[10], intS[10]+intS[11], OPEN);
    arc(OTx, OTy, dOT+difD, dOT+difD, intS[12], intS[12]+intS[13], OPEN);
  }
  save("export.jpg");
}


//Botón Circular. Detecta si se está dentro de algún círculo ingresando las coordenadas del centro y el diámetro
boolean overCircle(float x, float y, float diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

//Botón Rectangular. Detecta si se está dentro de algún rect ingresando las coordenadas del punto inicial, ancho y alto
boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

