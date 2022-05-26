/* Sort visualizer program */ 

/* 

make the screen actually display what is happening!!!!

make it faster somehow, the bad sort works. 

*/

int blockAmt = 25;
color bg = #000000; color bc = #ffffff; 
int[] blocks = new int[blockAmt+1]; 
color[] blockColors = new color[blockAmt+1]; 
int greenBlock = blockAmt+1; 
color GREEN = #00FF00; 
int last = 0;   
int m = 0; 
int sortDelay = 0;   
int state = 0; // 0 means do nothing, 1
int shuffleCnt = 0; 
ArrayList<Integer> blockCache = new ArrayList<Integer>();

void swap(int a, int b){
    int temp = blocks[a]; 
    int temp2 = blocks[b];
    blocks[b] = temp; 
    blocks[a] = temp2;  
}

void initiateBlocks(){
    for(int i = 0; i < blockAmt; i++){
        blocks[i]=i+1;
        blockColors[i] = bc; 
        println(blocks[i]);
    }
}

void displayBlocks(){
    clearFrame(); 
    noStroke();
    for(int i = 0; i < blockAmt; i++){
        int h = (int)((blocks[i])*((float)height/(float)blockAmt));
        int w = width/blockAmt; 
        fill(blockColors[i]); 
        rect((i)*w, height-h, w, h); 
    }
}

void displayBlock(int i){ 
    int h = (int)((blocks[i])*((float)height/(float)blockAmt));
    int w = width/blockAmt; 
    
    fill(bg);
    rect(i*w, 0, w, height);

    fill(blockColors[i]); 
    rect((i)*w, height-h, w, h); 
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
    int i = shuffleCnt; 
    println("Shuffling");
    if(i < blockAmt){
        state = 1; 
        int r = (int)random(0, blockAmt); 
        swap(i, r); 
        blockCache.add(i); blockCache.add(r); 
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
void badSort(){
    if (state != 2){
        state = 2; 
        println("Starting badsort"); 
    }
    int i = badSortCnt; 
    if (badSortCnt == 0){
        doneSorting = true; 
    }
    if (badSortCnt >= blockAmt){
        badSortCnt = 0; 
    }
    if (i <= blockAmt){ 
        blockColors[i] = GREEN; 
        blockCache.add(i);
        if (i > 0){
            blockCache.add(i-1);
            blockColors[i-1] = bc;
        }
        if (i+1 < blockAmt && blocks[i] > blocks[i+1]){
            doneSorting = false;
            swap(i, i+1);
            blockColors[i+1] = bc;
            blockCache.add(i+1);
        }
        badSortCnt++;
        redraw();
    }
    if (i == blockAmt-1 && doneSorting == true && state == 2){
        
        badSortCnt = 0;
        state = 0; // start the greenerizer  
        i = 0;
        println("Done badsort!");
    }
}

void setup() {
  // setting up the window size and name 
  size(500, 500);
  background(bg);
  frameRate(120); 
  surface.setTitle("Sort Visualizer"); 
  initiateBlocks(); 
  displayBlocks();   
  noStroke(); 
}

void draw() {       
    m = millis()-last;
    if (millis() > last+sortDelay){ 
        last = millis();  
        for(int i = blockCache.size()-1; i >= 0; i--){ 
            displayBlock(blockCache.get(i)); 
            blockCache.remove(i);
        }
        // Shuffle sequence 
        if (state == 1){
            shuffleBlocks(); 
        }
        // Bad sort O(n^2)
        if (state == 2){
            badSort(); 
        }
        if (state == 3){
            badSort(); 
        }
    }
}

void keyPressed() {
    if (key == 'w'){
        sortDelay+=10; 
    } else if (key == 's'){
        sortDelay-=10; 
    } else if (key == 'q'){
        exit(); 
    }
    shuffleBlocks(); 
}

void mousePressed() {
    badSort(); 
}
