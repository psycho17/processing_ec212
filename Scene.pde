public class Scene{
    public ArrayList<Shape> shapes = new ArrayList();
    
    public Scene(){}
    public Scene(ArrayList<Shape> shapes){
      this.shapes = shapes;
    }

    public Intersection intersects(Ray ray){
        Intersection i = new Intersection();
        
        for (int count = 0; count < shapes.size(); count++){
          Intersection i2 = shapes.get(count).intersects(ray);
          
          if(i2.hit && i2.distance < i.distance){
            i = i2;
            i.index = count;
          }
        }
        return i;
    }
}
