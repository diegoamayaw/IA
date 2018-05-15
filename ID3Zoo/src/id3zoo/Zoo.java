package id3zoo;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Scanner;

public class Zoo {
    
    private ArrayList<Animal> animalesBD;
    private double[] entropias;

    public Zoo() {
        animalesBD = new ArrayList();
        entropias = new double[15];
    }

    public void agregaAnimal(Animal a) {
        animalesBD.add(a);
    }

    public double[] calcEnt() {
        entropias[0] = entropiaPelo();
        entropias[1] = entropiaPlumas();
        entropias[2] = entropiaHuevos();
        entropias[3] = entropiaLeche();
        entropias[4] = entropiaVolador();
        entropias[5] = entropiaAcuatico();
        entropias[6] = entropiaPredador();
        entropias[7] = entropiaDientes();
        entropias[8] = entropiaColumnaVertebral();
        entropias[9] = entropiaRespira();
        entropias[10] = entropiaVenenoso();
        entropias[11] = entropiaAletas();
        entropias[12] = entropiaCola();
        entropias[13] = entropiaDomestico();
        entropias[14] = entropiaCatsize();
        
        return entropias;
    }

    public double calcEntBool(double n, double cantUnos, double[] o, double[] z) {
        double ent, entO, entZ;
        double cantCeros;
        double cumOnes = 0;
        double cumZeros = 0;

        cantCeros = n - cantUnos;
        ent = 0;
        entO = 0;
        entZ = 0;

        if (cantUnos != 0) {
            for (int j = 0; j < 7; j++)
                if (o[j] != 0)
                    cumOnes = cumOnes + ((o[j] / cantUnos) * (Math.log(o[j] / cantUnos) / Math.log(2)));
            entO = (cantUnos / n) * (-1) * cumOnes;
        }
        
        if (cantCeros != 0) {
            for (int j = 0; j < 7; j++)
                if (z[j] != 0)
                    cumZeros = cumZeros + ((z[j] / cantCeros) * (Math.log(z[j] / cantCeros) / Math.log(2)));
            entZ = (cantCeros / n) * (-1) * cumZeros;
        }
        
        ent = entO + entZ;
        
        return ent;
    }

    public void swchArr(int clase, double[] arr) {
        switch (clase) {
            case 1:
                arr[0]++;
                break;
                
            case 2:
                arr[1]++;
                break;
                
            case 3:
                arr[2]++;
                break;
                
            case 4:
                arr[3]++;
                break;
                
            case 5:
                arr[4]++;
                break;
                
            case 6:
                arr[5]++;
                break;
                
            case 7:
                arr[6]++;
                break;
        }
    }

    public double entropiaPelo() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getPelo() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            }
            else
                swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaPlumas() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getPlumas() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            }
            else 
                swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaHuevos() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getHuevos() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            } 
            else
                swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaLeche() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getLeche() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            }
            else
                swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaVolador() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getVolador() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            } 
            else 
                swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaAcuatico() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getAcuatico() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            }
            else
            swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaPredador() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getPredador() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            }
            else
                swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaDientes() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getDientes() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            } 
            else
                swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaColumnaVertebral() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getColumnaVertebral() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            }
            else
                swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaRespira() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getRespira() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            } 
            else swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaVenenoso() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getVenenoso() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            } 
            else swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaAletas() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getAletas() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            } 
            else 
                swchArr(animalesBD.get(i).getClase(), zeros);
                
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaCola() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++) 
            if (animalesBD.get(i).getCola() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            } 
            else
                swchArr(animalesBD.get(i).getClase(), zeros);
            
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaDomestico() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++) 
            if (animalesBD.get(i).getDomestico() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            }
            else 
                swchArr(animalesBD.get(i).getClase(), zeros); 
        
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }

    public double entropiaCatsize() {
        double ent;
        double n = animalesBD.size();
        double cantUnos = 0;
        double[] ones = new double[7];
        double[] zeros = new double[7];

        for (int i = 0; i < n; i++)
            if (animalesBD.get(i).getPequeño() == true) {
                cantUnos++;
                swchArr(animalesBD.get(i).getClase(), ones);
            }
            else
                swchArr(animalesBD.get(i).getClase(), zeros);
        
        ent = calcEntBool(n, cantUnos, ones, zeros);
        
        return ent;
    }
    
    public String tipoNom(int tipo) {

        switch (tipo) {
            case 1:
                return "mamífero";
            case 2:
                return "ave";
            case 3:
                return "réptil";
            case 4:
                return "pez";
            case 5:
                return "anfibio";
            case 6:
                return "insecto volador";
            default:
                return "artrópodo";
        }
    }
    
    public void preguntas(int pos) {
        
        switch(pos) {
            case 0:
                System.out.println("¿Tiene pelo? S/N");
                break;
                
            case 1:
                System.out.println("¿Tiene plumas? S/N");
                break;
                
            case 2:
                System.out.println("¿Es ovíparo? S/N");
                break;
                
            case 3:
                System.out.println("¿Da leche a sus crías? S/N");
                break;
                
            case 4:
                System.out.println("¿Tiene la habilidad de volar? S/N");
                break;
                
            case 5:
                System.out.println("¿Es acuático? S/N");
                break;
                
            case 6:
                System.out.println("¿Es predador? S/N");
                break;
                
            case 7:
                System.out.println("¿Tiene dientes? S/N");
                break;
                
            case 8:
                System.out.println("¿Es vertebrado? S/N");
                break;
                
            case 9:
                System.out.println("¿Tiene respiración pulmonar? S/N");
                break;
                
            case 10:
                System.out.println("¿Es venenoso? S/N");
                break;
                
            case 11:
                System.out.println("¿Tiene aletas? S/N");
                break;
                
            case 12:
                System.out.println("¿Tiene cola? S/N");
                break;
                
            case 13:
                System.out.println("¿Es doméstico? S/N");
                break;
                
            case 14:
                System.out.println("¿Es más grande que un gato? S/N");
                break;
        }
    }
    
    public void controlador() {
        ArrayList<Integer> res = new ArrayList<>();
        ArrayList<Integer> entAn = new ArrayList<>();
        Scanner sc = new Scanner(System.in);
        String resP;
        
        double entMin;
        int pos, j;
        boolean fl = true;

        for (int i = 1; i < 8; i++)
            res.add(i);
        
        while (res.size() != 1 && entAn.size() < 15) {
            j = 0;
            while (fl && j < 15)
                if (entAn.contains(j))
                    j++;
                else
                    fl = false;
            
            fl = true;
            entMin = this.entropias[j];
            pos = j;
            
            for (int k = j; k < 15; k++)
                if (!entAn.contains(k))
                    if (this.entropias[k] < entMin) {
                        entMin = this.entropias[k];
                        pos = k;
                    }
            
            entAn.add(pos);
            preguntas(pos);
            resP = sc.next();
            
            if (resP.equals("S") || resP.equals("s"))
                res = posibles(pos, true);
            else
                res = posibles(pos, false);
            
            this.calcEnt();
        }
        
        if (res.size() == 1) 
            System.out.println("El animal es un " + this.tipoNom(res.get(0)));
        else
            System.out.println("No pude adivinar que tipo de animal estabas pensando :( .");
    }
    
    public void eliminaTipo(ArrayList<Integer> res) {
        int j = 0;
        
        for(int i = 1; i < 8; i++)
            if(!res.contains(i)){
                while(j < this.animalesBD.size())
                    if(animalesBD.get(j).getClase() == i)
                        animalesBD.remove(j);
                    else 
                        j++;
        }
    }

    public ArrayList<Integer> posibles(int pos, boolean resP) {
        ArrayList<Integer> res = new ArrayList<>();
        Iterator<Animal> iterator = animalesBD.iterator();
        Animal aux;

        switch (pos) {
            case 0:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getPelo() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 1:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getPlumas() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 2:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getHuevos() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 3:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getLeche() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 4:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getVolador() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 5:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getAcuatico() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 6:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getPredador() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 7:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getDientes() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 8:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getColumnaVertebral() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 9:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getRespira() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 10:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getVenenoso() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 11:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getAletas() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 13:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getCola() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 14:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getDomestico() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;

            case 15:
                while (iterator.hasNext()) {
                    aux = iterator.next();
                    if (aux.getPequeño() == resP)
                        if (!res.contains(aux.getClase()))
                            res.add(aux.getClase());
                }

                eliminaTipo(res);
                break;
        }
        return res;
    }
}