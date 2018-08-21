import java.util.ArrayList;

Tile[] tiles;

int tileSize = 10;
int tilingWidth;
int tilingHeight;

void setup(){
  size(1000,1000);
  
  tilingWidth = width/tileSize;
  tilingHeight = height/tileSize;
  tiles = new Tile[tilingWidth*tilingHeight];
  
  //Initialise the tiles.
  for(int i=0;i<tiles.length;i++){
    tiles[i] = new Tile();
  }
  
  //Add neighbours
  for(int x=0;x<tilingWidth;x++){
    for(int y=0;y<tilingHeight;y++){
      ArrayList neighbours = new ArrayList<Tile>();
      
      int topLeft = (x-1)+(y-1)*tilingWidth;
      int topCenter = x+(y-1)*tilingWidth;
      int topRight = (x+1)+(y-1)*tilingWidth;
      int left = (x-1)+y*tilingWidth;
      int right = (x+1)+y*tilingWidth;
      int bottomLeft = (x-1)+(y+1)*tilingWidth;
      int bottomCenter = x+(y+1)*tilingWidth;
      int bottomRight = (x+1)+(y+1)*tilingWidth;
      if((y-2) >= 0){//check the top row is in frame
        neighbours.add(tiles[topCenter]);//check topCenter
        if((x-2) >=0){
          neighbours.add(tiles[topLeft]);//check topLeft
          neighbours.add(tiles[left]);//also add left
        }
        if((x+2) <= tilingWidth){
          neighbours.add(tiles[topRight]);//check topRight
          neighbours.add(tiles[right]);//also add right
        }
      }
      if((y+2) <= tilingHeight){//check the bottom row is in frame
        neighbours.add(tiles[bottomCenter]);//check topCenter
        if((x-2) >=0){
          neighbours.add(tiles[bottomLeft]);//check topLeft
        }
        if((x+2) <= tilingWidth){
          neighbours.add(tiles[bottomRight]);//check topRight
        }
      }
      
      tiles[x+y*tilingWidth].setNeighbours(neighbours);
    }
  }
}

void draw(){
  for(int x = 0;x<tilingWidth;x++){
    for(int y = 0;y<tilingHeight;y++){
      fill(tiles[x+y*tilingWidth].getColour());
      rect(x*tileSize,y*tileSize,tileSize,tileSize);
    }
  }
  
  if(mousePressed){
    tiles[(mouseX/tileSize)+(mouseY/tileSize)*tilingWidth].setAlive(true);
  }
}

void generate(){
  for(int i=0;i<tiles.length;i++){
    tiles[i].generate();
  }
  for(int i=0;i<tiles.length;i++){
    tiles[i].assertGeneration();
  }
}

void keyPressed(){
  if(key == ' '){
    generate();
  }
  if(key == 'l'){
    for(int i=0;i<tilingWidth;i++){
      tiles[i+50*tilingWidth].setAlive(true);
    }
  }
}