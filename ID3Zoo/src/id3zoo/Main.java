package id3zoo;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Scanner;
import java.util.StringTokenizer;

public class Main {

    public static void main(String[] args) throws FileNotFoundException {
        Scanner scan = new Scanner(new FileReader("data.txt"));
        StringTokenizer str;
        Zoo z;
        
        z = new Zoo();
        
        while(scan.hasNext()) {
            String linea = scan.nextLine();
            str = new StringTokenizer(linea, ",");
            z.agregaAnimal(new Animal(str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken(), str.nextToken()));
        }
        
        z.calcEnt();
        z.controlador();
    }
    
}
