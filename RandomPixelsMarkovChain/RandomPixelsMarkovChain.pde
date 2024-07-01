final int SCALING_FACTOR = 4;
final color WHITE = color( 255 );
final color BLACK = color( 0 );

final int CHANCE_INITIAL_WHITE = 50;
final int CHANCE_INITIAL_BLACK = 100 - CHANCE_INITIAL_WHITE;

final int CHANCE_WHITE_TO_WHITE = 90;
final int CHANCE_WHITE_TO_BLACK = 100 - CHANCE_WHITE_TO_WHITE;

final int CHANCE_BLACK_TO_BLACK = CHANCE_WHITE_TO_WHITE;
final int CHANCE_BLACK_TO_WHITE = 100 - CHANCE_BLACK_TO_BLACK;

final float I_WHITE = - ld( ( CHANCE_WHITE_TO_WHITE + CHANCE_BLACK_TO_WHITE ) / 2f / 100 );
final float I_BLACK = - ld( ( CHANCE_BLACK_TO_BLACK + CHANCE_WHITE_TO_BLACK ) / 2f / 100  );

PImage g_bb;

void setup()
{
  size( 512, 512 );
  noSmooth();
  background( color( 255, 0, 255 ) );
  
  println( "Information of WHITE: " + I_WHITE );
  
  g_bb = createImage( width / SCALING_FACTOR, height / SCALING_FACTOR, ARGB );
  for( int i = 0; i < g_bb.pixels.length; i++ )
    g_bb.pixels[ i ]= color( random( 255 ) );
   
  float probWhite;
  int countWhite = 0;
  for( int y = 0; y < g_bb.height; y++ )
  {
    //color prev = WHITE;    // imaginary pixel left of the border
    color prev = random(100)<CHANCE_INITIAL_WHITE?WHITE:BLACK;    // imaginary pixel left of the border
    for( int x = 0; x < g_bb.width; x++ )
    {
      probWhite = ( prev == WHITE ? CHANCE_WHITE_TO_WHITE : CHANCE_BLACK_TO_WHITE );
      prev = ( random( 100 ) < probWhite ? WHITE : BLACK );
      if ( prev == WHITE )
        countWhite++;
      g_bb.pixels[ x + y * g_bb.width ] = prev;
    }
  }
  g_bb.updatePixels();
  
  println( "--> White came up " + countWhite + " times." );
  println( "--> Measured probability = " + ( (float) countWhite / ( g_bb.width * g_bb.height ) ) );
  println( "--> I(WHITE) = " + ( - ld ( (float) countWhite / ( g_bb.width * g_bb.height ) ) ) );
  
  scale( SCALING_FACTOR );
  image( g_bb, 0, 0 );
}


void draw()
{
  
}
