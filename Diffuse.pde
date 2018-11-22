public class Diffuse extends BSDF{
    public PVector albedo;
    
    public Diffuse() {}
    public Diffuse(PVector albedo) {
      this.albedo = albedo;
    }
    
    public PVector evaluate(ShaderGlobals shaderGlobals){
      //return albedo;
      return PVector.div(albedo, PI);
      //return PVector.mult(albedo, INVERSE_PI);
    }
    
    public float pdf(ShaderGlobals shaderGlobals){
      return 0;
    }
    
    public PVector sample(ShaderGlobals shaderGlobals, PVector sample){
      return null;
    }
  
    public float surfaceArea(){return 0.0;}
    public  ShaderGlobals calculateShaderGlobals(Ray ray, Intersection intersection){return new ShaderGlobals();}
    public  Intersection intersects(Ray ray){return new Intersection();}
}
