/* @pjs preload="assets/start.png, assets/end.png";  */
/* @pjs preload="assets/flats.png, assets/sky.png, assets/street.png";  */
/* @pjs preload="assets/barrel0.png, assets/barrel1.png";  */
/* @pjs preload="assets/playerOne0.png, assets/playerOne1.png, assets/playerOneJump.png, assets/playerOneHurt.png";  */
/* @pjs preload="assets/playerTwo0.png, assets/playerTwo1.png, assets/playerTwoJump.png, assets/playerTwoHurt.png";  */
/* @pjs preload="assets/playerThree0.png, assets/playerThree1.png, assets/playerThreeJump.png, assets/playerThreeHurt.png";  */

long time = 0;
Player[] player = new Player[3];
Barrel[] barrel = new Barrel[3];

PImage startImg;
PImage endImg;

PImage skyImg;
float skyX = 0;
float skyY = 0;
float skySpeed = 0.5;

PImage flatsImg;
float flatsX = 0;
float flatsY = 0;
float flatsSpeed = 1;

PImage streetImg;
float streetX = 0;
float streetY = 0;
float streetSpeed = 1.5;

int levelTimeout = 2000;
int playersTimeout = 100;
long ticksTime = 0;
int frame = 0;

int heightOffset = -200;

String screenName = "start";

boolean controlsHidden = true;
boolean stuffHidden = true;

int frame = 0;

void setup()
{
  size(1366,768);

  startImg = loadImage("assets/start.png");
  endImg = loadImage("assets/end.png");
  
  player[0] = new Player("assets/playerOne0.png", "assets/playerOne1.png", "assets/playerOneJump.png", "assets/playerOneHurt.png");
  player[1] = new Player("assets/playerTwo0.png", "assets/playerTwo1.png", "assets/playerTwoJump.png", "assets/playerTwoHurt.png");
  player[2] = new Player("assets/playerThree0.png", "assets/playerThree1.png", "assets/playerThreeJump.png", "assets/playerThreeHurt.png");
  for (int i=0; i < player.length; i++)
  {
    player[i].SetPosition(3*width/4 - i*50, 6*height/8 + i*25);
    player[i].SetSize(43,100);
  }

  for (int i=0; i < barrel.length; i++)
  {
    barrel[i] = new Barrel("assets/barrel0.png", "assets/barrel1.png");
    barrel[i].SetPosition(0, (height/2)-50);
    barrel[i].SetGround(0, height/2+50, width, height+50);
    barrel[i].SetSize(50,50);
    barrel[i].SetScreenSize(width,height);
  }
  
  flatsX = -width;
  flatsY = -height/2 + heightOffset;
  flatsImg = loadImage("assets/flats.png");
  
  skyX = -width;
  skyY = -height/2 + heightOffset;
  skyImg = loadImage("assets/sky.png");
  
  streetX = -width;
  streetY = -height/2;
  streetImg = loadImage("assets/street.png");
}

void draw()
{
  if(screenName == "start")
  {
    set(0, 0,startImg);
    /*if(stuffHidden == true)
    {
      showStuff();
      stuffHidden = false;
    }
    textSize(40);
    text("Click to Play", 580,750);
    */
  }
  else if(screenName == "game")
  {
    gameLoop();
  }
  else if(screenName == "end")
  {
    set(0, 0,endImg);
  }
}

void gameLoop()
{
  updateBackground();
  
  if(time < levelTimeout)
  {
    for (int i=0; i<(int)(time/(levelTimeout/3))+1; i++)
    {
      barrel[i].UpdatePosition();
      barrel[i].UpdateImage();
    
      for (int o=0; o<player.length; o++)
        if(testCollision(player[o], barrel[i])) player[o].Hurt();
    }
  }
  else
  {
    for (int i=0; i<player.length; i++)
    {
      player[i].Y -= streetSpeed;
      player[i].X -= streetSpeed * 3.557;
    }
    
    if(player[0].X < 0)
      screenName = "end";
  }
    
  for (int i=0; i<player.length; i++)
  {
    player[i].UpdatePosition(time);
    player[i].UpdateImage();
  }
    
  time++;
}

void startGame()
{
  screenName = "game";
}

void pauseGame()
{
  if(screenName == "pause")
    screenName = "game";
  else
    screenName = "pause";
}

void mouseClicked() 
{
  if(screenName == "start")
    startGame();
  else if(screenName == "game")
  {

  }
}


void keyTyped()
{
  if(key == 'q' || key == 'Q')
    player[0].Jump();
  if(key == 'v' || key == 'V')
    player[1].Jump();
  if(key == 'p' || key == 'P')
    player[2].Jump();
}

boolean valueInRange(int value, int min, int max)
{ 
  return (value >= min) && (value <= max); 
}

boolean testCollision(Player p, Barrel b)
{
    boolean xOverlap = valueInRange(p.X, b.X, b.X + b.Width) ||
                    valueInRange(b.X, p.X, p.X + p.Width);

    boolean yOverlap = valueInRange(p.Y, b.Y, b.Y + b.Height) ||
                    valueInRange(b.Y, p.Y, p.Y + p.Height);

    return xOverlap && yOverlap;
}

void updateBackground()
{
  background(83,125,40); 
  
  //Update flats
  if(flatsX + flatsSpeed > 0)
  {
    flatsX = -width;
    flatsY = -height/2 + heightOffset;
  }
  else
  {
    flatsY += flatsSpeed;   
    flatsX += flatsSpeed * 3.557;     
  }
  
  //Update sky
  if(skyX + skySpeed > 0)
  {
    skyX = -width;
    skyY = -height/2 + heightOffset;
  }
  else
  {
    skyY += skySpeed;   
    skyX += skySpeed * 3.557;     
  }
  
  //Update street
  if(streetX + streetSpeed > 0)
  {
    streetX = -width;
    streetY = -height/2;
  }
  else
  {
    streetY += streetSpeed;   
    streetX += streetSpeed * 3.557;     
  }
  
  set(skyX, skyY, skyImg);
  set(flatsX, flatsY, flatsImg);
  set(streetX, streetY, streetImg);
}
