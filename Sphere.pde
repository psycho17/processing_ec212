public class Sphere extends Shape{
   public PVector position;
   public float radius;
   
   public Sphere(){}
   public Sphere(PVector position, float radius) {
     this.position = position;
     this.radius = radius;
   }
   
   //methods from Shape interface
   @Override
   public Intersection intersects(Ray ray){
     Intersection i = new Intersection();
     
     PVector L = PVector.sub(position, ray.origin); // L = C - O
     float tm = L.dot(ray.direction); // tm = L ∙ D
     float d = sqrt(L.dot(L) -  tm * tm); // d = √(L ∙ L - tm²)
     float deltaT = sqrt(radius * radius - d * d); // Δt = √(r² - d²)
     
     if(tm < 0 || d > radius)
       return i;
     else{
       i.hit = true;
       i.distance = tm - deltaT;
       return i;
     }
   }
   
   @Override
   public ShaderGlobals calculateShaderGlobals(Ray ray, Intersection intersection){
        ShaderGlobals shaderGlobals = new ShaderGlobals();
        
        shaderGlobals.point = ray.point(intersection.distance);
        shaderGlobals.normal = PVector.sub(shaderGlobals.point, position);
        float phi = acos(shaderGlobals.normal.y);
        float theta = atan2(shaderGlobals.normal.x, shaderGlobals.normal.z);
        
        shaderGlobals.uv.x = (1 + theta/PI) * 0.5;
        shaderGlobals.uv.y = phi/PI;
        shaderGlobals.tangentU = new PVector(cos(theta), 0, -sin(theta));
        shaderGlobals.tangentV = new PVector(sin(theta) * cos(phi), -sin(phi), cos(theta) * cos(phi));
        shaderGlobals.viewDirection = PVector.mult(ray.direction, -1);
        return shaderGlobals;
   }
   
   @Override
   public float surfaceArea(){
     return 4 * PI * radius * radius;
   }
   
   //methods from Light interface
   @Override
   public PVector evaluate(ShaderGlobals shaderGlobals){
     return null; //???
   }
   
   @Override
   public float pdf(ShaderGlobals shaderGlobals){
     return 0.1;
   }
   
   @Override
   public PVector sample(ShaderGlobals shaderGlobals, PVector sample){
     return position;
   }
   
}
