

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs  = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public static int NUM_ROWS = 5;
public static int NUM_COLS = 5;
public static int NUM_BOMBS = 1;
private boolean isLose = false;


void setup ()
{
    size(200, 200);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    

     for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){   
            buttons[r][c]=new MSButton(r, c);
        }
    }

    bombs = new ArrayList<MSButton>();
    for (int i = 0; i < NUM_BOMBS; i++) {
    setBombs();
  }






}
public void setBombs()
{
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
  if (bombs.contains(buttons[row][col])) {
        setBombs();
    } 
        else {
        bombs.add(buttons[row][col]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for (int i = 0; i < NUM_ROWS; i++) {
    for (int j = 0; j < NUM_COLS; j++) {
      if (!bombs.contains(buttons[i][j]) && buttons[i][j].isClicked() == false) {
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{
        buttons[0][0].setLabel("L");
        buttons[0][1].setLabel("O");
        buttons[0][2].setLabel("S");
        buttons[0][3].setLabel("E");
}
public void displayWinningMessage()
{
        buttons[0][0].setLabel("W");
        buttons[0][1].setLabel("I");
        buttons[0][2].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 200/NUM_COLS;
         height = 200/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed)
            marked =!marked;
        if(!marked==false)
            clicked=false;
        else if(bombs.contains(this))
            displayLosingMessage();
        else if(countBombs(r,c)>0)
            setLabel(("" + countBombs(r,c)));
        else
        {
            if(c>0 && buttons[r][c-1].clicked ==false)
                buttons[r][c-1].mousePressed();
            if(c<19 && buttons[r][c+1].clicked ==false)
                buttons[r][c+1].mousePressed();
            if(r>0 && buttons[r-1][c].clicked ==false)
                buttons[r-1][c].mousePressed();
            if(r<19 && buttons[r+1][c].clicked ==false)
                buttons[r+1][c].mousePressed();
            if(r>0 && c>0 && buttons[r-1][c-1].clicked ==false)
                buttons[r-1][c-1].mousePressed();
            if(r<19 && c<19 && buttons[r+1][c+1].clicked ==false)
                buttons[r+1][c+1].mousePressed();
            if(r<19 && c>0 && buttons[r+1][c-1].clicked ==false)
                buttons[r+1][c-1].mousePressed();
            if(r>0 && c<19 && buttons[r-1][c+1].clicked ==false)
                buttons[r-1][c+1].mousePressed();
        } 
        
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r < NUM_ROWS && c < NUM_COLS && r>= 0 && c>=0)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(row-1,col) == true && bombs.contains(buttons[row-1][col]))      {numBombs++;}       
        if (isValid(row+1,col) == true && bombs.contains(buttons[row+1][col]))      {numBombs++;}       
        if (isValid(row,col-1) == true && bombs.contains(buttons[row][col-1]))      {numBombs++;}      
        if (isValid(row,col+1) == true && bombs.contains(buttons[row][col+1]))      {numBombs++;}    
        if (isValid(row-1,col+1) == true && bombs.contains(buttons[row-1][col+1]))  {numBombs++;}   
        if (isValid(row-1,col-1) == true && bombs.contains(buttons[row-1][col-1]))  {numBombs++;}     
        if (isValid(row+1,col+1) == true && bombs.contains(buttons[row+1][col+1]))  {numBombs++;}     
        if (isValid(row+1,col-1) == true && bombs.contains(buttons[row+1][col-1]))  {numBombs++;}    
        return numBombs;
    }




}



