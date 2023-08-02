class Button {
    float bX;
    float bY;
    float side;
    color bColor;
    String caption;
    boolean unlocked;
    int index;
    String type;
    
    Button(int i) {
        index = i;
        switch(index) {
            case 0:
                bColor = lightCopper;
                caption = "Q";
                type = "showUnshow";
                break;
            case 1:
                bColor = red;
                caption = "DT";
                type = "showUnshow";
                break;
        }
        if (type == "lock") {
            bX = width / 2;
            bY = 0.9 * height; 
            side = width * 0.1;
        } else if (type == "showUnshow") {
            bX = (index + 4) * width / 9;
            bY = 0.15 * height;
            side = width * 0.07;
        }
    }

    
    void show() {
        imageMode(CENTER);
        if (type == "lock") {
            rectMode(CENTER); 
            textAlign(CENTER, CENTER);
            if (unlocked == true) {
                fill(white);
            } else {
                fill(bColor);
            }
            rect(bX, bY, side, side, 10);
            if (unlocked == true) {
                fill(red);
            } else {
                fill(yellow);
            }
            text(caption, bX, bY - 10);
        } else if (type == "showUnshow") {
            rectMode(CENTER); 
            textAlign(CENTER, CENTER);
            if (unlocked == true) {
                image(hide, bX, bY - side * 0.8, side * 0.5, side * 0.5);
                fill(white);
            } else {
                image(view, bX, bY - side * 0.8, side * 0.5, side * 0.5);
                fill(bColor);
            }
            rect(bX, bY, side, side, 10);
            if (unlocked == true) {
                fill(red);
            } else {
                fill(yellow);
            }
            text(caption, bX, bY - 10);
        }
    }
        
       void checkClick() {
            if (bX -side / 2 < mouseX && mouseX < bX + side / 2 && bY - side / 2 < mouseY && mouseY < bY + side) {
                
                if (type== "lock") {
                    lockAll();
                };
                if (unlocked == false) {
                    unlocked= true;
                } else if (unlocked == true) {
                    unlocked= false;
                }
            }
        }
            
           void lockAll() {
                for (Button b : buttons) { 
                    if (b.type == "lock") {
                        b.unlocked =false;
                    }
                }
            }
                
            }
                
                