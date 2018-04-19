import controlP5.*;
import java.util.*;
import java.lang.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;

ControlP5 cp5;
RadioButton r;

int w = 7, h = 6, bs = 100, player = 1, dificultad = 1;
boolean delay = false;
int[][] board = new int[h][w];

void setup(){
  size(700,800);
  background(0,120,100);
  frameRate(3);
  ellipseMode(CORNER);
  
  cp5 = new ControlP5(this);
  r = cp5.addRadioButton("dificultad")
  .setPosition(220,650)
  .setSize(40,20)
  .setColorForeground(color(120))
  .setColorActive(color(255,0,0))
  .setColorLabel(color(0))
  .setItemsPerRow(5)
  .setSpacingColumn(50)
  .addItem("Facil",1)
  .addItem("Medio",2)
  .addItem("Dificil",3);
 r.activate(0);
  
  for(Toggle t:r.getItems()) {
    t.getCaptionLabel().setColorBackground(color(255,80));
    t.getCaptionLabel().getStyle().moveMargin(-7,0,0,-3);
    t.getCaptionLabel().getStyle().movePadding(7,0,0,3);
    t.getCaptionLabel().getStyle().backgroundWidth = 45;
    t.getCaptionLabel().getStyle().backgroundHeight = 13;
  }
}

int conexionLisp(String lsp){
  String comando = "./prueba.sh (" + dificultad + " " + lsp +")";
  File wd = new File("/Users/Leandro/Desktop/IA/Conecta4/GUI/Tablero");
  
  // Correr script
  String res;
  int r=-1;
  try {
    Process p = Runtime.getRuntime().exec(comando, null, wd);
    int i = p.waitFor();
    if (i == 0) {
      BufferedReader entrada = new BufferedReader(new InputStreamReader(p.getInputStream()));
      int j=0; //<>//
      while ( (res = entrada.readLine ()) != null) {
        println(res);
          if (j==1){
            res=res.replaceAll("\\s","");
            r=Integer.parseInt(res);
          }
        j=j+1;
      }
    }
    
    //Errores
    else {
      BufferedReader entradaError = new BufferedReader(new InputStreamReader(p.getErrorStream()));
      while ( (res = entradaError.readLine ()) != null) {
        println(res);
      }
    }
  }
  
  // if there is any other error, let us know
  catch (Exception e) {
    println("Error al ejecutar shell");
    println(e);
  }
  return r;
}

int p(int  y, int x){
  return (y<0||x<0||y>=h||x>=w)?0:board[y][x];
}

int getGanador(){
  //renglones
  for (int y=0;y<h;y++)
    for(int x=0;x<w;x++)
      if(p(y,x)!=0 && p(y,x)==p(y,x+1) && p(y,x)==p(y,x+2) && p(y,x)==p(y,x+3))
        return p(y,x);
  
  //columnas
  for (int y=0;y<h;y++)
    for(int x=0;x<w;x++)
      if(p(y,x)!=0 && p(y,x)==p(y+1,x) && p(y,x)==p(y+2,x) && p(y,x)==p(y+3,x))
        return p(y,x);
  
  //diagonales
  for (int y=0;y<h;y++)
    for(int x=0;x<w;x++)
      for(int d=-1;d<=1;d+=2)
        if(p(y,x)!=0 && p(y,x)==p(y+1*d,x+1) && p(y,x)==p(y+2*d,x+2) && p(y,x)==p(y+3*d,x+3))
          return p(y,x);
  
  //empate
  for (int y=0;y<h;y++)
    for(int x=0;x<w;x++)
      if(p(y,x)==0) return 0;
        return -1;
}

int siguienteEspacio (int n){
  for (int i=h-1; i>=0; i--)
    if(n>=0)
      if(board[i][n]==0)
        return i;
  return -1;
}

void mousePressed(){
  if(mouseY<600 && player==1){
    int x = mouseX/bs, y= siguienteEspacio(x);
   
    if(y>=0){
      board[y][x] = player;
      player = player==1?2:1;
      
      if(getGanador()==0){
        String r = generaEdoActual();
        int a=conexionLisp(r), b= siguienteEspacio(a);
        
        if(b>=0 && a!=-1){
          draw();
          delay=true;
          board[b][a] = player;
          player = player==1?2:1;
        }
        else
          print("ERROR");
      }
    }
  } //<>//
}

void draw(){
  if(getGanador()==0){
    for(int j=0; j<h; j++)
      for(int i=0; i<w; i++){
        fill(0,120,100);
        rect(i*bs,j*bs,bs,bs);
        fill(255);
        ellipse(i*bs,j*bs,bs,bs);
        
        if(board[j][i]>0){
          fill(255, board[j][i]==2?255:0, 0);
          ellipse(i*bs,j*bs,bs,bs);
        }
      }
  }
  else{
    for(int j=0; j<h; j++)
      for(int i=0; i<w; i++){
        fill(0,120,100);
        rect(i*bs,j*bs,bs,bs);
        fill(255);
        ellipse(i*bs,j*bs,bs,bs);
        
        if(board[j][i]>0){
          fill(255, board[j][i]==2?255:0, 0);
          ellipse(i*bs,j*bs,bs,bs);
        }
      }
    background(0);
    fill(255);
    textSize(12);
    if(getGanador()==-1)
      text("Empate"+"\nReinicia con espacio.",300,350);
    else
      text("Ganador: " + getGanador()+"\nReinicia con espacio.",300,350);
      
    if(keyPressed && key==' '){
      player=1;
      for (int y=0;y<h;y++)
        for(int x=0;x<w;x++)
          board[y][x]=0;
      background(0,120,100);
    }
  }
  if(delay){
    delay(1000);
    delay=false;
  }
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(r)) {
    if(r.getItem(0).getState()){
      dificultad=4;
    }
    else
      if(r.getItem(1).getState())
        dificultad=6;
      else
        dificultad=10;
  }
}
  
String generaEdoActual(){
  String res=null;
  
  //Cada lista es una columna
  res="((" + board[0][0] + " " + board[1][0] + " " + board[2][0] + " " + board[3][0] + " " + board[4][0] + " " + board[5][0] + ") "
      + "(" + board[0][1] + " " + board[1][1] + " " + board[2][1] + " " + board[3][1] + " " + board[4][1] + " " + board[5][1] + ") "
      + "(" + board[0][2] + " " + board[1][2] + " " + board[2][2] + " " + board[3][2] + " " + board[4][2] + " " + board[5][2] + ") "
      + "(" + board[0][3] + " " + board[1][3] + " " + board[2][3] + " " + board[3][3] + " " + board[4][3] + " " + board[5][3] + ") "
      + "(" + board[0][4] + " " + board[1][4] + " " + board[2][4] + " " + board[3][4] + " " + board[4][4] + " " + board[5][4] + ") "
      + "(" + board[0][5] + " " + board[1][5] + " " + board[2][5] + " " + board[3][5] + " " + board[4][5] + " " + board[5][5] + ") "
      + "(" + board[0][6] + " " + board[1][6] + " " + board[2][6] + " " + board[3][6] + " " + board[4][6] + " " + board[5][6] + "))";

  return res;
}
