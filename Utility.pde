 public ArrayList<PVector> stratifiedSample(int samples){
   int size = (int)sqrt(samples);
   ArrayList<PVector> points = new ArrayList<PVector>(samples);
   
   for(int i = 0; i < size; i++){
     for(int j = 0; j < size; j++){
       PVector offset = new PVector(i, j);
       points.set(i * size + j, PVector.div(PVector.add(offset, uniform_random_2D()),size));
     }
   }
   return points;
 }
 
 public PVector gamma(PVector pVector, float value){
    float inverseGamma = 1/value;
    return new PVector(pow(pVector.x, inverseGamma),
                       pow(pVector.y, inverseGamma),
                       pow(pVector.z, inverseGamma));
  }
  
  public PVector exposure(PVector pVector, float value){
    float power = pow(2, value);
    return new PVector(pVector.x * power,
                       pVector.y * power,
                       pVector.z * power);
  }
  
  public float saturate(PVector n){
    return log(n.dot(n)/ n.y)/log(2);
  }
  
  public PVector uniform_random_2D(){
    return new PVector(random(1.0), random(1.0));
  }
  
  public float gauss1D(float n, float width){
    float r = width/2;
    return max( exp(-1 * n * n) - exp(-1 * r * r) , 0);
  }
  
  public float gauss2D(PVector pVector, float width){
    return gauss1D(pVector.x, width) * gauss1D(pVector.y, width);
  }
