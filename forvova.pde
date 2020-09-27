void setup() {
  size(900, 500);
}

//Шарик
int ballX = 450;
int ballY = 250;
int ballsize = 50;
int ballSpeedX = 5;
int ballSpeedY = 5;

//Игрок и бот
int sizeX = 20;
int sizeY = 100;
int playerX = 50;
int playerY = 250-sizeY/2;
int playerSpeed = 5;
int botX = 830;
int botY = 250-sizeY/2;
int BotSpeed = 5;

int playerScore = 0;
int botScore = 0;

void draw() {
  background(#FFD500);
  if (!ChekForEnd()) {
    Ball();
    BOT();
    Player();
    GameInterface();
  } else {
    EndScrean();
  }
}

void BOT() {
  if (ballX > width/2) {
    if (ballY + ballsize/2 > botY + sizeY) botY += BotSpeed;
    if (ballY - ballsize/2 < botY) botY-= BotSpeed;
  }
  noStroke();
  fill(#FC1008);
  rect(botX, botY, sizeX, sizeY);
}

void Ball() {
  noStroke();
  fill(#08E4FA);
  ellipse(ballX, ballY, ballsize, ballsize);

  ballX += ballSpeedX;
  ballY += ballSpeedY;

  if (ballX > width) {
    playerScore++;
    ballX = 450;
    ballY = 250;
    if ((int)random(0, 2) == 1) ballSpeedX *=-1;
    ballSpeedY = 5;
  }
  if (ballX < 0) {
    botScore++;
    ballX = 450;
    ballY = 250;
    if ((int)random(0, 2) == 1) ballSpeedX *=-1;
    ballSpeedY = 5;
  }

  if (ballY > height - ballsize/2 || ballY < ballsize/2) ballSpeedY *= -1;
  if (ballY + ballsize/2 > playerY && ballY - ballsize/2 < playerY + sizeY && ballX - ballsize/2 < playerX + sizeX) { 
    ballSpeedX *=-1; 
    ballSpeedY += (int)random(-2, 2);
  }
  if (ballY + ballsize/2 > botY && ballY - ballsize/2 < botY + sizeY && ballX + ballsize/2 > botX) { 
    ballSpeedX *=-1; 
    ballSpeedY += (int)random(-2, 2);
  }
}

void Player() {
  noStroke();
  fill(0, 255, 0);
  rect(playerX, playerY, sizeX, sizeY);

  if (keyPressed) {
    switch(key) {
    case 'w':
      if (playerY >= 0)
        playerY -= playerSpeed;
      break;
    case 's':
      if (playerY <= 500 - sizeY)
        playerY += playerSpeed;
      break;
    }
  }
}

void GameInterface() {
  textSize(20);
  fill(255, 0, 0);
  text("Player Score "+ playerScore, 50, 50);

  textSize(20);
  fill(255, 0, 0);
  text("Bot Score "+ botScore, 700, 50);
}

void EndScrean() {
  textSize(40);
  fill(255, 0, 0);
  if (playerScore > 7 ) {
    text("Player Win", 400, 250);
  } else {
    text("Bot Win", 400, 250);
  }

  textSize(30);
  text("Press r to restart", 300, 350);
  if (keyPressed) {
    if (key == 'r') {
      playerScore = 0;
      botScore = 0;
      ballX = 450;
      ballY = 250;
      playerX = 50;
      playerY = 250-sizeY/2;
      botX = 830;
      botY = 250-sizeY/2;
      ballSpeedX = 5;
      ballSpeedY = 5;
    }
  }
}

boolean ChekForEnd() {
  if (playerScore > 7 || botScore > 7)
  {
    return true;
  }
  return false;
}
