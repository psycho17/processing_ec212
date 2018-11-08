public class Camera{
  public float fieldOfView;
  public Film film;
  public PMatrix3D worldMatrix;

  public Camera(){}
  public Camera(float fieldOfView, Film film, PMatrix3D worldMatrix) {
     this.fieldOfView = fieldOfView;
     this.film = film;
     this.worldMatrix = worldMatrix;
  }
   
   public void lookAt(PVector position, PVector target, PVector up){
     PVector auxW = position.sub(target);
     float absW = sqrt(auxW.x * auxW.x + auxW.y * auxW.y + auxW.z * auxW.z);   
     PVector W = auxW.div(absW);
     
     PVector auxU = up.cross(W);
     float absU = sqrt(auxU.x * auxU.x + auxU.y * auxU.y + auxU.z * auxU.z);   
     PVector U = auxU.div(absU);
     
     PVector V = W.cross(U);
     
     worldMatrix.set(U.x, V.x, W.x, position.x,
                     U.y, V.y, W.y, position.y,
                     U.z, V.z, W.z, position.z, 
                      0,   0,   0,   1);
   }

   public void transform(PMatrix3D transformation){
     worldMatrix.preApply(transformation);
   }

   public Ray generateRay(float x, float y, PVector sample){
     float scale = tan(fieldOfView * 0.5);
        
     PVector pixel = new PVector();
        
     pixel.x = (2.0 * (x + 0.5 + sample.x) / film.width - 1.0) * scale * film.aspectRatio();
     pixel.y = (1.0 - 2.0 * (y + 0.5 + sample.y) / film.height) * scale;
     pixel.z = -1.0;
        
     worldMatrix.mult(pixel, pixel);
        
     PVector origin = new PVector(worldMatrix.m03, worldMatrix.m13, worldMatrix.m23);
     PVector direction = PVector.sub(pixel, origin).normalize();
        
     return new Ray(origin, direction);
   }


}
