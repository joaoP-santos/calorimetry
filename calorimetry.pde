import java.math.BigDecimal;
float temperatureVariation, specificHeat, heat, cm, thickness, h50, liX, deltaLX, initialStart, initialEnd;
color red = color(254, 74, 73);
color copper = color(184, 115, 51);
color lightCopper = color(207, 141, 79);
color yellow = color(233, 223, 0);
color blue = color(61, 82, 213);
color white = color(243, 243, 244, 200);
PFont cmusr;
String degree = "\u00B0";
String specificHeatCaption = degree + "C-1";
String frmtspecificHeatCaption = degree + "C\u207B\u00B9";
String lI = "m";
String frmtLI = "Li\u1D62";
String deltaL = "DL";
ArrayList<Button> buttons = new ArrayList<Button>();
float unlocked, unlockMultiplier;
int mouseXSnap;
int mass, massSnap;
float heatSnap, temperatureVariationSnap;
int index = -1;
PImage view, hide, tank;

//<a href="https://www.flaticon.com/free-icons/eye" title="eye icons">Eye icons created by Kiranshastry - Flaticon</a>
//<a href="https://www.flaticon.com/free-icons/password" title="password icons">Password icons created by th studio - Flaticon</a>

void setup() {
    orientation(LANDSCAPE);
    fullScreen();
    mass = 750;
    specificHeat = 1.000;
    cmusr = createFont("CMU Serif Roman.ttf", 36);
    temperatureVariation = 1;
    heat = mass * temperatureVariation * specificHeat;
    deltaLX = initialEnd + heat;
    view = loadImage("view.png");
    hide = loadImage("hide.png");
    tank = loadImage("full-tank.png");
    
    for (int i = 0; i < 4; i++) {
        Button b = new Button(i);
        buttons.add(b);
        b.lockAll();
    }
    }
        
       void draw() {
            background(yellow);
            textAlign(CENTER); 
            textFont(cmusr);
            h50 = height / 2;
            initialEnd = initialStart + mass;
            
            deltaLX = initialEnd + heat;
            liX = initialStart;
            
            temperatureVariation = heat / (specificHeat * mass);

            //Tank
            imageMode(CENTER);
            image(tank, width / 2, height / 2, 0.2 * width, 0.2 * width);
            
            stroke(white); 
            strokeWeight(thickness / 2);
            
            //Temperature variation
            fill(red); textAlign(CENTER, BOTTOM);
            text(buttons.get(1).unlocked == false
                ? "DT = " + BigDecimal.valueOf(temperatureVariation)
               .setScale(2, BigDecimal.ROUND_HALF_UP)
               .floatValue() + degree + "C"
                : "DT = ?", width / 2, 4 * height / 5);

            //specificHeat
            fill(blue); textAlign(LEFT, CENTER);
            text("c = " + specificHeat + " cal/g " + degree + "C", width * 4 / 6, height / 2);

            //Mass
            fill(copper); textAlign(RIGHT, CENTER);
            text("m = " + mass + " g", width * 2 / 6, height / 2);

            //Heat
            fill(lightCopper); textAlign(CENTER, CENTER);
            text(buttons.get(0).unlocked == false
            ? "Q = " + heat + " cal"
            : "Q = ?", width * 3 / 6, height / 2);
            
            //Buttons
            for (Button b : buttons) {
                b.show();
            }
        }
            
           void mouseDragged() {
                for (Button b : buttons) {
                    if (b.unlocked == true) {
                        index = b.index;
                    }
                }
                
              unlockMultiplier = 0.5;
                
              heatSnap = heat + (mouseX - mouseXSnap) * unlockMultiplier;
                
              if (index == 0 && heatSnap / (temperatureVariationSnap * specificHeat) / cm < 1) {
                    heat = temperatureVariationSnap * specificHeat * cm;
                    return;
                }
               heat += (mouseX - mouseXSnap) * unlockMultiplier;
                mouseXSnap =mouseX;
            }
               void mousePressed() {
                   mouseXSnap = mouseX;
                    for (Button b : buttons) {
                        b.checkClick();
                    }
                }
                        
                   void mouseReleased(){
                           mouseXSnap = mouseX;
                    }
