/* autogenerated by Processing revision 1283 on 2022-05-26 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class seeSort extends PApplet {

/* Sort visualizer program */ 

/* 

make the screen actually display what is happening!!!!

make it faster somehow, the bad sort works. 

*/

int blockAmt = 100;
int bg = 0xFF000000; int bc = 0xFFFFFFFF; 
int[] blocks = new int[blockAmt+1]; 
int greenBlock = blockAmt+1; 
int GREEN = 0xFF00FF00; 
int last = 0;   
int m = 0; 
int sortDelay = 0;   
int state = 0; // 0 means do nothing, 1
int shuffleCnt = 0; 

 public boolean frame(int d){
    m = millis()-last; 
    if (millis() > last+d){
      last = millis();  
      return true; 
    }
    return false; 
}

 public void swap(int a, int b){
    int temp = blocks[a]; 
    int temp2 = blocks[b];
    blocks[b] = temp; 
    blocks[a] = temp2;  
}

 public void initiateBlocks(){
    for(int i = 0; i < blockAmt; i++){
        blocks[i]=i+1; 
        println(blocks[i]);  
    }
}

 public void displayBlocks(){
    clearFrame(); 
    noStroke();
    for(int i = 0; i < blockAmt; i++){
        int h = (int)((blocks[i])*((float)height/(float)blockAmt));
        int w = width/blockAmt; 
        if (i == greenBlock){
            fill(GREEN); 
        } else {
            fill(bc);
        }
        rect(i*w, height-h, w, h); 
    }
}

 public void displayBlock(int i){ 
    int h = (int)((blocks[i])*((float)height/(float)blockAmt));
    int w = width/blockAmt; 
    
    fill(bg);
    rect(i*w, 0, w, height);

    if (greenBlock == i){
        fill(GREEN); 
    } else {
        fill(bc); 
    }
    rect(i*w, height-h, w, h);  
}

 public boolean verify(){
    boolean verify = true;
    for(int i = 0; i < blockAmt; i++){
        if(blocks[i] != i+1){
            verify = false; 
            break; 
        }
    }
    return verify; 
}

 public void clearFrame(){
    noStroke(); 
    fill(bg); 
    rect(0, 0, width, height); 
}

 public void shuffleBlocks(){
    int i = shuffleCnt; 
    println("Shuffling");
    if(i < blockAmt){
        state = 1; 
        int r = (int)random(0, blockAmt); 
        swap(i, r); 
        redraw(); 
        shuffleCnt++; 
    } else {
        state = 0; shuffleCnt = 0; 
        println("Shuffling Complete"); 
        return; 
    }
}


// when state is 2 
boolean doneSorting = false; 
int badSortCnt = 0; 
 public void badSort(){
    println("Starting badsort"); 
    state = 2; 
    int i = badSortCnt; 
    if (badSortCnt == 0){
        doneSorting = true; 
    }
    if (badSortCnt >= blockAmt){
        badSortCnt = 0; 
    }
    if (i < blockAmt){
        greenBlock=i; 
        if (blocks[i] > blocks[i+1]){
            doneSorting = false; 
            swap(i, i+1); 
        }
        badSortCnt++; 
        redraw(); 
    }
    if (i == blockAmt-1 && doneSorting == true){
        badSortCnt = 0; 
        state = 0; 
        println("Done badsort!"); 
        return; 
    }
}

 public void testSort(int i){
    delay(1); 
    println("Iterating at ", i); 
    greenBlock = i; displayBlock(i);
    if (i!=0){displayBlock(i-1);}    
    
}

 public void setup() {
  // setting up the window size and name 
  /* size commented out by preprocessor */;
  background(bg);
  frameRate(100); 
  
  surface.setTitle("Sort Visualizer"); 
  initiateBlocks(); 
  displayBlocks();   
  noStroke(); 
  shuffleBlocks(); 
  //noLoop(); 

}

 public void draw() {   
    m = millis()-last;
    if (millis() > last+sortDelay){ 
        last = millis();  
        for(int i = 0; i < blockAmt; i++){
            displayBlock(i); 
        }
        if (state == 1){
            // Shuffling sequence. 
            shuffleBlocks(); 
        }
        if (state == 2){
            badSort(); 
        }
    }
}

 public void keyPressed() {
    if (key == 'w'){
        sortDelay+=10; 
    } else if (key == 's'){
        sortDelay-=10; 
    } else if (key == 'q'){
        exit(); 
    }
    shuffleBlocks(); 
}

 public void mousePressed() {
    badSort(); 
}


  public void settings() { size(1000, 1000); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "seeSort" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
