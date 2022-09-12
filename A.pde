// 22 de maio de 2020
// MAURO SANTOS

void settings() {
  COLUNAS = mapa.length;
  LINHAS = mapa[0].length;
  
  TOTAL_X = LINHAS * LADO_QUADRADO;
  TOTAL_Y = COLUNAS * LADO_QUADRADO;
  size(TOTAL_X, TOTAL_Y);
}

void setup(){
  frame.setLocationRelativeTo(null);
  surface.setTitle("Pacman");
  background(BRANCO);
  maze = new Maze();
  setarPosicoes();
}

int TOTAL_X;
int TOTAL_Y;
int COLUNAS;
int LINHAS;
final static int LADO_QUADRADO = 25;

//CORES
final color BRANCO = color(255, 255, 255);
final color AMARELO = color(255, 255, 0);
final color PRETO = color(0, 0, 0);
final color VERMELHO = color(255, 0, 0);
final color COR_MAZE = color(18,10,143);

//CORES DOS FANTASMAS
final color ROSA = color(255, 203, 219);
final color LARANJA = color(255, 165, 0);
final color CIANO = color(0,139,139);
final color AZUL_CLARO = color(135,205,250);

//PACMAN
final static int TAMANHO_PACMAN = 20;
Direcao DIRECAO_BOCA_PACMAN = Direcao.DIREITA;
Posicao POSICAO_INICIAL = new Posicao(0,0);

//FANTASMA
static final int TAMANHO_FANTASMA = 15;
Ghost fantasmas[] = new Ghost[4];

//VELOCIDADE DOS FANTASMAS
final static int VELOCIDADE_BLINKY = 30;
final static int VELOCIDADE_INKY = 60;
final static int VELOCIDADE_PINKY = 60;
final static int VELOCIDADE_CLYDE = 120;

//PASTILHAS
final int COR_PASTILHA = AMARELO;
final static int RAIO_PASTILHA = 5;

Maze maze;
final Jogo jogo = new Jogo();

// Map for very simple maze. Put ghosts anywhere in the cells with 0.
final int map1[][] = {
    {1,1,1,1,1,1},
    {1,0,0,0,0,1},
    {1,0,0,0,0,1},
    {1,1,1,1,1,1}};
      
// Slightlh more complicated map for  maze. Put ghosts anywhere in the cells with 0,
// typically on the first line.
final int map2[][] = {
    {1,1,1,1,1,1,1,1,1},
    {1,0,0,0,1,0,0,0,1},
    {1,0,0,0,1,0,0,0,1},
    {1,1,1,1,1,1,1,1,1},
    {1,0,0,0,1,0,0,0,1},
    {1,0,0,0,1,0,0,0,1},
    {1,1,1,1,1,1,1,1,1},
};
  // This is an "official" map. Pacman is on the lower right corner.
  // The ghosts are in the positions with coordinates
  // (10,7), (11,7), (14,7) and (15,7).
  final int map3[][] = {
  // 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9
    {1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,0,0,0,1},
    {1,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,0,0,0,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1},
    
    {1,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1},
    {1,1,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,1,1},
    {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    
    {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    
    {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    {0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
    {1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,0,0,0,1},
    
    {1,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,0,0,0,1},
    {1,1,1,0,0,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,0,0,1,1,1},
    {0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0},
    {0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,1,0,0},
    {1,1,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,1,1},
    
    {1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  };
  
final int[][] mapa = map3;

public class Posicao {
  private int x;
  private int y;
  
  public Posicao(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public int getX() {
    return x;
  }
  
  public int getY() {
    return y;
  }
}

public abstract class Personagem {
  private int x;
  private int y;
  private Direcao direcao;
  
  public Personagem(int x, int y, Direcao direcao) {
    this.x = x;
    this.y = y;
    this.direcao = direcao;
  }
  
  public void north() {
    direcao = Direcao.CIMA;
    if (!inBounds(x, y-1)) return;
    y--;
  }
  
  public void south() {
    direcao = Direcao.BAIXO;
    if (!inBounds(x, y+1)) return;
    y++;
  }
  
  public void east() {
    direcao = Direcao.DIREITA;
    if (!inBounds(x+1, y)) return;
    x++;
  }
  
  public void west() {
    direcao = Direcao.ESQUERDA;
    if (!inBounds(x-1, y)) return;
    x--;
  }
  
  private int getCoordenadaParaDesenho(int num) {
    return num * LADO_QUADRADO + LADO_QUADRADO / 2;
  }
  
  private boolean inBounds(int x, int y) {
    return x >= 0 && y >= 0 && x < LINHAS && y < COLUNAS && mapa[y][x] != 0;
  }
  
  public int getX() {
    return x;
  }
  
  public int getY() {
    return y;
  }
}

public class Pacman extends Personagem {
  public Pacman() {
    super(POSICAO_INICIAL.getX(), POSICAO_INICIAL.getY(), DIRECAO_BOCA_PACMAN);
  }
  
  public void draw() {
    stroke(1);
    fill(AMARELO);
    arc(super.getCoordenadaParaDesenho(super.x), super.getCoordenadaParaDesenho(super.y), TAMANHO_PACMAN, TAMANHO_PACMAN, 
                                                                                  super.direcao.getAnguloInicial(), super.direcao.getAnguloFinal(), PIE);
  }
}

public enum Direcao {
  
  DIREITA, BAIXO, ESQUERDA, CIMA;
  
  public float getAnguloInicial() {
    return QUARTER_PI + PI / 2 * ordinal();
  }
  
  public float getAnguloFinal() {
    return QUARTER_PI * 7 + PI / 2 * ordinal();
  }
  
  public Direcao inverso() {
    switch(this) {
      case ESQUERDA: return DIREITA;
      case DIREITA: return ESQUERDA;
      case CIMA: return BAIXO;
      case BAIXO: return CIMA;
    }
    return null;
  }
}

public class Ghost extends Personagem {
  
  private color cor;
  private int velocidade;
  
  public Ghost(int x, int y, Direcao direcao, color cor, int velocidade) {
    super(x,y, direcao);
    this.cor = cor;
    this.velocidade = velocidade;
  }
  
  public void draw(){
    fill(cor);
    noStroke();
    
    int x = super.getCoordenadaParaDesenho(super.x);
    int y = super.getCoordenadaParaDesenho(super.y) - 5;
    arc(x, y, TAMANHO_FANTASMA, TAMANHO_FANTASMA, -PI, 0 , PIE);
    rect(x - 8, y, TAMANHO_FANTASMA, TAMANHO_FANTASMA / 2 + 10);
    drawOlho(x - 5, y);
    drawOlho(x + 5, y);
  }
  
  private void drawOlho(int x, int y) {
    fill(BRANCO);
    circle(x,y,6);
    fill(AZUL_CLARO);
    circle(x,y,3);
  }
  
  public void moverAleatorio() {
    if (deveInverterOSentido())  moverPorDirecao(super.direcao.inverso());
    escolherMovimento();
  }
  
  private void escolherMovimento() {
    Direcao dir;
    
    int xOld = super.x;
    int yOld = super.y;
    
    Direcao direcaoInversa = super.direcao.inverso();
    
    while (xOld == super.x && yOld == super.y) {
      dir = Direcao.values()[(int) random(4)];
      
      if (dir == direcaoInversa) continue;
      moverPorDirecao(dir);
    } 
  }
  
  private void moverPorDirecao(Direcao dir) {
    switch(dir){
      case ESQUERDA:
        west();
        break;
      case DIREITA:
        east();
        break;
      case CIMA:
        north();
        break;
      case BAIXO:
        south();
        break;
    }
  }
  
  private boolean deveInverterOSentido() {
    int x = super.x;
    int y = super.y;
    int result = 0;
    
    if (y-1 > 0 && mapa[y-1][x] == 0) result++;
    if (y+1 < COLUNAS && mapa[y+1][x] == 0) result++;
    if (x-1 > 0 && mapa[y][x-1] == 0) result++;
    if (x+1 < LINHAS && mapa[y][x+1] == 0) result++;
    
    return result == 3;
  }
  
  public int getVelocidade() {
    return velocidade;
  }
}

public class Maze {
  
  public Maze() {
    mapa[POSICAO_INICIAL.y][POSICAO_INICIAL.x]++;
  }
  
  public void draw() {
    for (int i = 0; i < COLUNAS; i++) {
      for (int j = 0; j < LINHAS;j++) {
        setarCor(i, j);
        stroke(0, 100);
        square(j * LADO_QUADRADO, i * LADO_QUADRADO, LADO_QUADRADO);
        adicionarPastilhas(i, j);
      }
    }
  }
  
  private void setarCor(int i, int j) {
    if (mapa[i][j] == 0) fill(PRETO);
    else fill(COR_MAZE);
  }
  
  private void adicionarPastilhas(int i, int j) {
    if (mapa[i][j] == 1) {
      fill(COR_PASTILHA);
      circle(j*LADO_QUADRADO + LADO_QUADRADO/2, i*LADO_QUADRADO + LADO_QUADRADO/2, RAIO_PASTILHA);
    }
  }
    
}

public class Jogo {
  
  private Pacman pacman;
  private boolean terminou = false;
  private String msgFinal = "";
  
  public Jogo() {
    this.pacman = new Pacman();
  }
  
  int counter = 0;
  public void draw() {
    maze.draw();
    mostrarMsgFimDeJogo();
    pacman.draw();
    drawFantasmas();
    
    if (terminou) return;
    moverFantasmas();
    counter++;
  }
  
  private void mostrarMsgFimDeJogo() {
    if (terminou) {
      fill(BRANCO);
      textSize(30);
      textAlign(CENTER, CENTER);
      text(msgFinal, TOTAL_X / 2, TOTAL_Y / 2);
    }
  }
  
  private void moverFantasmas() {
    if (counter == 0) return;
    for (Ghost fantasma : fantasmas) {
      if (counter % fantasma.getVelocidade() == 0) {
        fantasma.moverAleatorio();
        checkEndOfGameFantasma(fantasma);
      }
    }
  }
  
  private void drawFantasmas(){
    for(Ghost fantasma : fantasmas) {
      if (fantasma != null) fantasma.draw();
    }
  }
  
  private void checkEndOfGameFantasma(Ghost fantasma){
    if (foiComido(fantasma)) {
      terminou = true;
      msgFinal = "Apanhámos-te!";
    } 
  }
  
  private void checkEndOfGamePacman() {
    if (comeuTudo()) {
      terminou = true;
      msgFinal = "Comi tudo!";
    } else if (foiComido()) {
      terminou = true;
      msgFinal = "Apanhámos-te!";
    } 
  }
  
  private boolean comeuTudo() {
    for (int i[] : mapa) {
      for (int j : i) {
        if (j == 1) return false;
      }
    }
    return true;
  }
  
  private boolean foiComido(Ghost fantasma) {
    return pacman.getX() == fantasma.getX() && pacman.getY() == fantasma.getY();
  }
  
  private boolean foiComido() {
    for (Ghost fantasma : fantasmas) {
      if (foiComido(fantasma)) return true;
    }
    
    return false;
  }
  
  private void keyPressed() {
    if (terminou) return;
    if (keyCode == UP) {
      pacman.north();
    } else if (keyCode == DOWN) {
      pacman.south();
    } else if (keyCode == RIGHT) {
      pacman.east();
    } else if (keyCode == LEFT) {
      pacman.west();
    }
    
    if (mapa[pacman.getY()][pacman.getX()] == 1) {
      mapa[pacman.getY()][pacman.getX()]++;
    }
    checkEndOfGamePacman();
  }
}

private void setarPosicoes() {
  if (mapa == map1) {
    
  } else if (mapa == map2) {
    
  } else if (mapa == map3) {
    fantasmas[0] = new Ghost(10,7, Direcao.ESQUERDA, VERMELHO, VELOCIDADE_BLINKY); //BLINKY
    fantasmas[1] = new Ghost(11,7, Direcao.ESQUERDA, ROSA, VELOCIDADE_PINKY); //PINKY
    fantasmas[2] = new Ghost(14,7, Direcao.ESQUERDA, LARANJA, VELOCIDADE_CLYDE); //CLYDE
    fantasmas[3] = new Ghost(15,7, Direcao.ESQUERDA, CIANO, VELOCIDADE_INKY); //INKY
    
    POSICAO_INICIAL = new Posicao(1, 0);
  }
}

public void draw() {
  background(BRANCO);
  jogo.draw();
}

public void keyPressed() {
  jogo.keyPressed();
}
