class Utilities {

  boolean isClicked(){ return isClicked; } //<>//
  
  //Overlaping between two intervals
  boolean isOverlap(float min1, float max1, float min2, float max2) {
    return !(max1 < min2 || max2 < min1);
  }
}
