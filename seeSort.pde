/* Sort visualizer program */ 

/* 

make the screen actually display what is happening!!!!

make it faster somehow, the bad sort works. 

*/

int blockAmt = 100;
color bg = #000000; color bc = #ffffff; 
int[] blocks = new int[blockAmt+1]; 
int greenBlock = blockAmt+1; 
color GREEN = #00FF00; 
int last = 0;   
int m = 0; 
int sortDelay = 10;   
int state = 0; // 0 means do nothing, 1

boolean frame(int d){
    m = millis()-last; 
    if (millis() > last+d){
      last = millis();  
      return true; 
    }
    return false; 
}

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

void displayBlock(int i){ 
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
    println("Shuffling");
    int i = 0; 
    while(i < blockAmt){
        m = millis()-last; 
        if (millis() > last+sortDelay){ 
            last = millis();
            int r = (int)random(0, blockAmt); 
            swap(i, r); 
            i++; q
        }
    }
    println("Shuffling Complete");
    redraw(); 
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

void testSort(int i){
    delay(1); 
    println("Iterating at ", i); 
    greenBlock = i; displayBlock(i);
    if (i!=0){displayBlock(i-1);}    
    
}

void setup() {
  // setting up the window size and name 
  size(1000, 1000);
  background(bg);
  surface.setTitle("Sort Visualizer"); 
  initiateBlocks(); 
  displayBlocks();   
  noStroke(); 
  noLoop(); 

}

void draw() {   
    // m = millis()-last;
    // if (millis() > last+sortDelay){ 
        last = millis();  
        for(int i = 0; i < blockAmt; i++){
            displayBlock(i); 
        }
    //}
}

void keyPressed() {
    if (key == 'w'){
        sortDelay+=10; 
    }   
    if (key == 's'){
        sortDelay-=10; 
    }
    if (key == 'q'){
        exit(); 
    }
    shuffleBlocks(); 
}
