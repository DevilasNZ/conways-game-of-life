/*Class for managing the game tiles
    -States (dead or alive)
    -linking nearby tiles
    -computing life and death logic, RULES:
      1. if there are less than two live neighbours, die
      2. if there are two or three live neighbours, live on
      3. if there are more than three neighbours, die
      4. if the tile is dead and there ae exactly three neighbours, become live
*/
class Tile{
  boolean alive;//Current state
  boolean nextState = false;
  Tile[] neighbours;//neighbours stored
  color colour = color(66, 134, 244);
  boolean covered = false;
 
  public Tile(){
    alive = false;
  }
  
  public Tile(boolean alive){
    this.alive = alive;
  }
  
  //set the neighbours of this tile
  public void setNeighbours(ArrayList<Tile> neighbours){
    Tile[] temp = new Tile[neighbours.size()];
    for(int i=0;i<temp.length;i++){
      temp[i] = neighbours.get(i);
    }
    this.neighbours = temp;
  }
  
  //compute one generation of this tile
  public void generate(){
    int neighbourCount = 0;
    
    for(int i=0;i<neighbours.length;i++){
      if(neighbours[i].isAlive()){
        neighbourCount ++;
      }
    }
    
    nextState = false;
    if(alive){
      if(neighbourCount <2){//Rule 1: under population.
        nextState = false;
      }else if(neighbourCount > 3){//Rule 3: over population.
        nextState = false;
      }else{nextState = alive;}//else, live on to the next generation.
      
    }else if(neighbourCount == 3){//Rule 4: reproduction.
      nextState = true;
      covered = true;
    }
    
    //set the colour
    if(covered){
      colour = color(96, 175, 31);
    }if(alive){
      colour = color(226, 9, 9);
    }
  }
  
  public void assertGeneration(){alive=nextState;}
  
  //Getters and setters.
  public boolean isAlive(){
    return alive;
  }
  
  public color getColour(){return colour;}
  
  public void setAlive(boolean alive){
    this.alive = alive;
    if(alive){
      covered = true;
      colour = color(226, 9, 9);
    }
  }
}