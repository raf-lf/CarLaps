Car car1;
Engine	engine1;
float maxSpeed = 50;
float acceleration = .5;
int laps;

void setup()
{
    size(500,500);
       
	car1 = new Car(width/2-25, height/2, 50, 75);
}

void draw()
{
    background (150);
    
    textAlign(RIGHT,BOTTOM);
    textSize(20);
    fill(255);
    text("Laps: " + laps, width-15, height-45);
    
    car1.FrameUpdate();
    
}

void mousePressed()
{
    car1.speeding = true;
}

void mouseReleased()
{
    car1.speeding = false;
}

class Car
{
    int posX, posY;
    int sizeX, sizeY;
    float velX, velY;
    boolean speeding;
    
    Car(int pX, int pY, int sX, int sY)
    {
        posX = pX;
        posY = pY;
        sizeX = sX;
        sizeY = sY;
        
        engine1 = new Engine(posX, posY, sizeX, sizeY);
    }
    
    void SpeedChange()
    {
        if (speeding)
        {
            if (velY>=maxSpeed) velY = maxSpeed;
            else velY += acceleration;
        }
        else 
        {
            if (velY <= 0) velY = 0;
        	else velY -= acceleration * 2;
        }
        
    }
    
    void SpeedDial()
    {
        if (velY>=maxSpeed) fill(255,0,0);
        else fill(255 * velY/maxSpeed,125*velY/maxSpeed,250-250*velY/maxSpeed);
        
        stroke(0,0,0,0);
        rect(15, height -35, (width -30) *(velY/maxSpeed), 20);
        stroke(0,0,0,255);
        
        textAlign(LEFT,BOTTOM);
        textSize(20);
        text("Speed",15 , height-45);
        
        textAlign(LEFT,BOTTOM);
        textSize(20 + (80 * velY/maxSpeed));
        text((int)velY + "/" + (int)maxSpeed,80, height-45);
        
        
    }
    
    void Teleport()
    {
        if (posX > width) 
        {
            posX = 0 - sizeX;
            posY += random(-sizeY,sizeY);
        }
        if (posX < 0 - sizeX) 
        {
            posX = width;
            posY += random(-sizeY,sizeY);
        }
        
        if (posY > height) 
        {
            posY = 0 - sizeY;
            posX += random(-sizeX,sizeX);
        laps +=1;
        }
        if (posY < 0 - sizeY) 
        {
            posY = height;
            posX += random(-sizeX,sizeX);
        laps +=1;
        }
    }
    
    void FrameUpdate()
    {
        SpeedChange();
        
        SpeedDial();
        Teleport();
        
        fill(100);
        posX += velX;
        posY += velY;
        rect(posX, posY, sizeX, sizeY);     
        engine1.FrameUpdate(posX, posY, sizeX, sizeY);
        
    }
}

class Engine
{
    int posX, posY;
    float radius;
    color light;
    
    Engine(int pX, int pY, int sX, int sY)
    {
        posX = pX + sX/2;
        posY = pY + sX/3 *2;
        radius = sY/4;
        
    }
    
    void Signal()
    {
        if (car1.speeding == false && car1.velY>0) light = color(255,255,100);
        else if (car1.velY > 0) light = color(100,255,100);
        else light = color(255,100,100);
    }
    
    void FrameUpdate(int pX, int pY, int sX, int sY)
    {
        Signal();
        fill(light);
        ellipse(pX + sX/2, pY + sY/2, radius, radius);
    }
}
