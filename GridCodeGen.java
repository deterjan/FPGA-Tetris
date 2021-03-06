public class GridCodeGen
{
    public static void main( String[] args)
    {
        /*
         *video structure constants
         *parameter hpixels = 800;// horizontal pixels per line
         *parameter vlines = 521; // vertical lines per frame
         *parameter hpulse = 96;  // hsync pulse length
         *parameter vpulse = 2;  // vsync pulse length
         *parameter hbp = 144;  // end of horizontal back porch
         *parameter hfp = 784;  // beginning of horizontal front porch
         *parameter vbp = 31;  // end of vertical back porch
         *parameter vfp = 511;  // beginning of vertical front porch 
         */
        
        final int VBP = 31;
        final int HBP = 144;
        final int DISTANCE_FROM_VBP = 9;
        final int DISTANCE_FROM_HBP = 6;
        final int CELL_SIDE = 10;
        
        int counti = 0;
        int countj;
        for ( int i = 2; i < 23; i++) // := 2, < 23 for game; := 0, < 24 for debug
        {
            if ( counti != 0) System.out.print( "else ");
            System.out.println( "if (vc > "+ (VBP + DISTANCE_FROM_VBP + i * CELL_SIDE + counti) + " &&  vc <= "+ (VBP + DISTANCE_FROM_VBP  + (i + 1)  * CELL_SIDE + counti) +") begin" );
            countj = 0;
            for ( int j = 1; j < 11; j++ ) // := 1, < 11 for game; := 0, < 12 for debug
            {
                if ( countj != 0) System.out.print( "else ");
                System.out.println( "\tif (hc >" + (HBP + DISTANCE_FROM_HBP  + j  * CELL_SIDE + countj) + " &&  hc <=" + (HBP + DISTANCE_FROM_HBP + (j + 1)  * CELL_SIDE + countj) +") begin" );
                
                System.out.println( "\t\tif ( ( posY1 == " + i + " && posX1 == " + j + ") || ( posY2 == " + i + " && posX2 == " + j +") || ( posY3 == " + i + " && posX3 == " + j +") || ( posY4 == " + i + " && posX4 == " + j +")) begin");
                System.out.println( "\t\t\tred = 4'b1111;");
                System.out.println( "\t\t\tgreen = 4'b0000;");
                System.out.println( "\t\t\tblue = 4'b0000;");
                System.out.println( "\t\tend");
                
                System.out.println( "\t\telse if ( grid["+ i +"]["+ j +"]) begin");
                System.out.println( "\t\t\tred = 4'b0000;");
                System.out.println( "\t\t\tgreen = 4'b1111;");
                System.out.println( "\t\t\tblue = 4'b0000;");
                System.out.println( "\t\tend");
                
                System.out.println( "\t\telse begin");
                System.out.println( "\t\t\t red = 4'b1111;");
                System.out.println( "\t\t\t green = 4'b1111;");
                System.out.println( "\t\t\t blue = 4'b1111;");
                System.out.println( "\t\tend");
                System.out.println( "\tend");
                
                countj++;
            }
            System.out.println( "\telse begin");
            System.out.println( "\t\tred = 4'b0000;");
            System.out.println( "\t\tgreen = 4'b0000;");
            System.out.println( "\t\tblue = 4'b0000;");
            System.out.println( "\tend");            
            
            System.out.println("end");
            counti++;
            
        }
    }
}
