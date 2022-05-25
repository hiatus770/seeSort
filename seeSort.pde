/* Sort visualizer program */ 

/* 

make the screen actually display what is happening!!!!

make it faster somehow, the bad sort works. 

*/
int blockAmt = 250; 
color bg = #000000; color bc = #ffffff; 
int[] blocks = new int[blockAmt+1]; 
int greenBlock = blockAmt+1; 
color GREEN = #00FF00; 


void swap(int a, int b){
    int temp = blocks[a]; 
    int temp2 = blocks[b];
    blocks[b] = temp; 
    blocks[a] = temp2;  
}

void initiateBlocks(){
    for(int i = 0; i < blockAmt; i++){
        blocks[i]=i+1; 
        println(blocks[i]); 
    }
}

void displayBlocks(){
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

boolean verify(){
    boolean verify = true;
    for(int i = 0; i < blockAmt; i++){
        if(blocks[i] != i+1){
            verify = false; 
            break; 
        }
    }
    return verify; 
}

void clearFrame(){
    noStroke(); 
    fill(bg); 
    rect(0, 0, width, height); 
}

void shuffleBlocks(){
    println("Shuffling!");
    for(int i = 0; i < blockAmt; i++){
        swap(i, (int)random(0, blockAmt)); 
    }
    println("Done shuffling!"); 
    displayBlocks(); 
}

void badSort(){
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

void setup() {
  // setting up the window size and name 
  size(250, 250);
  background(bg);
  surface.setTitle("Sort Visualizer"); 
  initiateBlocks(); 
  displayBlocks();  
  shuffleBlocks(); 
  delay(5000); 
  badSort(); 
}

  
void draw() {   

}

void keyPressed() {
}