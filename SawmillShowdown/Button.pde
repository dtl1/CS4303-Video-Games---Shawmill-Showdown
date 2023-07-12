//sourced from https://www.reddit.com/r/processing/comments/exe6k7/an_extremely_simple_button_class/
class Button {
  PVector pos;
  float radius;
  color col;
  String caption;
  boolean visible;

  Button(float x, float y, float r, String txt, color c) {
    pos = new PVector(x, y);
    radius = r;
    caption = txt;
    col = c;
    visible = true;
  }

  void show() {
    fill(col);
    strokeWeight(3);
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
    fill(0);
    float fontSize = radius * 0.22;
    textSize(fontSize);
    float tw = textWidth(caption);
    float tx = pos.x - (tw/2);
    float ty = pos.y + (fontSize / 2);
    text(caption, tx, ty);
  }
}