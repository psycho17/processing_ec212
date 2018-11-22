public class Renderer{
  RenderOptions options;
  Camera camera;
  Scene scene;
  
  public Renderer(){}
  public Renderer(RenderOptions options, Camera camera, Scene scene){
    this.options = options;
    this.camera = camera;
    this.scene = scene;
  }

  public PVector computeDirectIllumination(BSDF bsdf, ShaderGlobals shaderGlobals){
    PVector directIllumination = new PVector(0, 0, 0);
    
    for(int i = 0; i < scene.shapes.size(); i++){
      Shape light = scene.shapes.get(i);
      
      if(light.explicitLight){
        shaderGlobals.lightDirection = PVector.sub(((Sphere)light).position, shaderGlobals.point).normalize();
        Ray ray = new Ray(shaderGlobals.point, shaderGlobals.lightDirection);
        
        Intersection intersection = scene.intersects(ray);
        
        if(intersection.hit && intersection.index == i){         
          PVector bsdfValue = bsdf.evaluate(shaderGlobals);
          PVector lightIntensity = light.evaluate(shaderGlobals);
          //PVector lightIntensity = PVector.mult(light.evaluate(shaderGlobals), 1);
          float cosine = shaderGlobals.normal.dot(shaderGlobals.lightDirection);
          
          directIllumination.add(multiplyColor(bsdfValue, lightIntensity).mult(cosine));
        }
      }
      
    }
    
    return directIllumination;
  }
  
  public PVector computeIndirectIllumination(BSDF bsdf, ShaderGlobals shaderGlobals, int depth){
    return null;
  }

  public PVector trace(Ray ray, int depth){
    Intersection intersection = scene.intersects(ray);
    if(intersection.hit){
      Shape shape = scene.shapes.get(intersection.index);
      ShaderGlobals shaderGlobals = shape.calculateShaderGlobals(ray, intersection);
      
      if(shape.explicitLight){
        return shape.evaluate(shaderGlobals);
      }
        
      return computeDirectIllumination(shape.bsdf, shaderGlobals);
    }
    return new PVector(0, 0, 0);
  }
  
  public PImage render(){
    
    PImage pImage = createImage(options.width, options.height, RGB);
    
    for(int i = 0; i < options.width; i++){
     for(int j = 0; j < options.height; j++){
       
       ArrayList<PVector> samples = stratifiedSample(options.cameraSamples);
       
       PVector pVector = new PVector(0, 0, 0);
       float totalWeight = 0;
       
       for(int k = 0; k < options.cameraSamples; k++){
         
         PVector sample = PVector.mult(samples.get(k).sub(new PVector(0.5, 0.5)), options.filterWidth);
         Ray ray = camera.generateRay(i, j, sample);
         float weight = gauss2D(sample, options.filterWidth);
         
         pVector.add(PVector.mult(trace(ray, 0), weight));
         totalWeight += weight;
         
       }
       pVector.div(totalWeight).mult(255);
//pVector = saturate(exposure(gamma(pVector, options.gamma), options.exposure)).mult(255.0);
       
       pImage.set(i, j, color(pVector.x, pVector.y, pVector.z));
     }
   }
    return pImage;
  }

}
