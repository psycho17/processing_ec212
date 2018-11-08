public class Intersection {
  public boolean hit;
  public float distance;
  public int index;
  
  public Intersection(){
    hit = false;
    distance = Float.MAX_VALUE;
    index = -1;
  }
  
  public Intersection(boolean hit, float distance, int index){
    this.hit = hit;
    this.distance = distance;
    this.index = index;
  }

}
