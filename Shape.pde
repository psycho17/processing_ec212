public abstract class Shape extends Light{
  public boolean explicitLight;
  public PMatrix3D worldMatrix;
  public BSDF bsdf;
  
  public Shape() {}
  public Shape(PMatrix3D worldMatrix, BSDF bsdf, boolean explicitLight, PVector emission) {
      super(emission);
      this.worldMatrix = worldMatrix;
      this.bsdf = bsdf;
      this.explicitLight = explicitLight;
  }
  
  public void transform(PMatrix3D transformation) {
      worldMatrix.preApply(transformation);
  }
  
  public abstract Intersection intersects(Ray ray);
  public abstract ShaderGlobals calculateShaderGlobals(Ray ray, Intersection intersection);
  public abstract float surfaceArea();

}
