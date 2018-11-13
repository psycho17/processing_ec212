 public final float INVERSE_PI = 0.31830988618379067154;
 
 float uniformRandom1D() {
    return random(1.0);
 }

 PVector uniformRandom2D() {
    return new PVector(uniformRandom1D(), uniformRandom1D());
 }
 
 public ArrayList<PVector> stratifiedSample(int samples){
   ArrayList<PVector> points = new ArrayList(samples);
    
    int size = (int)sqrt(samples);
    
    for (int i = 0; i < samples; i++) {
        PVector offset = new PVector(i / size, i % size);
        PVector point = PVector.add(uniformRandom2D(), offset).div(size);
        
        points.add(point);
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
  
  public PVector saturate(PVector n){
    return new PVector(constrain(n.x, 0, 1.0), constrain(n.y, 0, 1.0), constrain(n.z, 0, 1.0));
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
