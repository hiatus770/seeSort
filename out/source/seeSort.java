/* autogenerated by Processing revision 1282 on 2022-05-24 */
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
int blockAmt = 250; 
int bg = 0xFF000000; int bc = 0xFFFFFFFF; 
int[] blocks = new int[blockAmt+1]; 
int greenBlock = blockAmt+1; 
int GREEN = 0xFF00FF00; 


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
    println("Shuffling!");
    for(int i = 0; i < blockAmt; i++){
        swap(i, (int)random(0, blockAmt)); 
    }
    println("Done shuffling!"); 
    displayBlocks(); 
}

 public void badSort(){
    println("Starting badsort"); 
    boolean doneSorting = false; 
    while(!doneSorting){
        doneSorting = true; 
        for(int i = 0; i < blockAmt-1; i++){
                greenBlock=i; 
                if (blocks[i] > blocks[i+1]){
                    doneSorting = false; 
                    swap(i, i+1); 
                }
                displayBlocks(); 
        }
    }

    println("Done badsort!"); 
}

 public void setup() {
  // setting up the window size and name 
  /* size commented out by preprocessor */;
  background(bg);
  surface.setTitle("Sort Visualizer"); 
  initiateBlocks(); 
  displayBlocks();  
  shuffleBlocks(); 
  delay(5000); 
  badSort(); 
}

  
 public void draw() {   

}

 public void keyPressed() {
}


  public void settings() { size(250, 250); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "seeSort" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}