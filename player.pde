class Player 
{ 
  public PImage Image;
  public PImage Frame0;
  public PImage Frame1;
  public PImage FrameJump;
  public PImage FrameHurt;
  
  public int Frame = 0;
  
  public int X = 0;
  public int Y = 0;
  public int Width = 50;
  public int Height = 50;
  public int MaxX = 0;
  public int MaxY = 0;
  public int Speed = 30;
  public int VelocityX = 10;
  public int VelocityY = 10;
  public int OriginY = 0;

  public int HurtTime = 20;
  public int HurtTicks = 10;

  public int JumpTime = 200;
  public int JumpTicks = 200;
  public int JumpSpeed = 40;
  int JumpAcceleration = 2;
  public boolean Active = true;
  
  public int Score = 0;
  
  Player (String frame0Uri, String frame1Uri, String frameJumpUri, String frameHurtUri)
  {  
    Frame0 = loadImage(frame0Uri);
    Frame1 = loadImage(frame1Uri);
    FrameJump = loadImage(frameJumpUri);
    FrameHurt = loadImage(frameHurtUri);
  } 
  
  public void UpdateFrames()
  {
    if (Frame < 6)
    {
      Image = Frame0;
      Frame++;
    }
    else if (Frame < 12)
    {
      Image = Frame1;
      Frame++;
    }
    else
    {
      Frame = 0;
    }
  }
  
  public void UpdatePosition(long time)
  {
    if (JumpTicks < JumpTime)
    {
      if (Y <= OriginY)
      {
        Y = (int)(OriginY - (JumpSpeed * JumpTicks) + (0.5 * JumpAcceleration * JumpTicks * JumpTicks));
        JumpTicks++;
      }
      else
      {
        Y = OriginY;
        JumpTicks = JumpTime;
      }
    }
    
    if (HurtTicks < HurtTime)
      HurtTicks++;
    
    MaxX = X + Width;
    MaxY = Y + Height;
  }
  
  public void UpdateImage()
  {
    UpdateFrames();
      
    if (JumpTicks < JumpTime)
      Image = FrameJump;
    
    if (HurtTicks < HurtTime)
      Image = FrameHurt;
    
    set(X, Y, Image);
  }
  
  public void SetPosition(int x, int y)
  {
    OriginY = y;
    X = x;
    Y = y;

    MaxX = X + Width;
    MaxY = Y + Height;
  }
  
  public void SetSize(int wid, int hei)
  {
    this.Width = wid;
    this.Height = hei;

    MaxX = X + Width;
    MaxY = Y + Height;
  }
  
  public void Jump()
  {
    if (JumpTicks >= JumpTime)
    {
      JumpTicks = 0;
    }
  }
  
  public void Hurt()
  {
    if (HurtTicks >= HurtTime)
    {
      HurtTicks = 0;
    }
  }
  
  public void Hide()
  {
    Active = false;
    X = -1000;
    Y = -1000;
  }
}
