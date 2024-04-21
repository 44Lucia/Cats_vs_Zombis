class Button {
  UIManager ui;
  float x, y;
  String buttonText;
  PImage sprite, hoverSprite;

  Button(UIManager p_ui, float p_x, float p_y, String p_text, PImage p_sprite, PImage p_hoverSprite) {
    ui = p_ui;
    x = p_x;
    y = p_y;
    buttonText = p_text;
    sprite = p_sprite;
    hoverSprite = p_hoverSprite;
  }

  void display() {
    //button sprite
    imageMode(CORNER);
    if (!isMouseOver()) {image(sprite, x, y);}
    else {image(hoverSprite, x, y);}

    //button text
    fill(0);
    textSize(40);
    textAlign(CENTER, CENTER);
    text(buttonText, x + sprite.width / 2 , y + sprite.height / 2 - 8);
  }
  
  void displayCharacterButton(boolean p_isSelected) {
    if (p_isSelected) {image(hoverSprite, x, y);}
    else {image(sprite, x, y);}  
  }
  
  boolean isMouseOver() {
    return utilities.isMouseOver(x, y, sprite.width, sprite.height);
  }
}
