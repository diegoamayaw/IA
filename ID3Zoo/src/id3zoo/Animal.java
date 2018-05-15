package id3zoo;

public class Animal {

    private String nombre;
    private boolean pelo, plumas, huevos, leche, volador, acuatico, predador, dientes, columnaVertebral, respira, venenoso, aletas, cola, domestico, pequeño;
    private int clase;

    public Animal(String nombre, String pelo, String plumas, String huevos, String leche, String volador, String acuatico, String predador, String dientes, String columnaVertebral, String respira, String venenoso, String aletas, String cola, String domestico, String pequeño, String clase) {
        this.nombre = nombre;
        this.pelo = pelo.equals("1");
        this.plumas = plumas.equals("1");
        this.huevos = huevos.equals("1");
        this.leche = leche.equals("1");
        this.volador = volador.equals("1");
        this.acuatico = acuatico.equals("1");
        this.predador = predador.equals("1");
        this.dientes = dientes.equals("1");
        this.columnaVertebral =columnaVertebral.equals("1");
        this.respira = respira.equals("1");
        this.venenoso = venenoso.equals("1");
        this.aletas = aletas.equals("1");
        this.cola = cola.equals("1");
        this.domestico = domestico.equals("1");
        this.pequeño = pequeño.equals("1");
        this.clase = Integer.parseInt(clase);
    }

    public String getNombre() {
        return nombre;
    }
        
    public boolean getPelo() {
        return pelo;
    }

    public boolean getPlumas() {
        return plumas;
    }

    public boolean getHuevos() {
        return huevos;
    }

    public boolean getLeche() {
        return leche;
    }

    public boolean getVolador() {
        return volador;
    }

    public boolean getAcuatico() {
        return acuatico;
    }

    public boolean getPredador() {
        return predador;
    }

    public boolean getDientes() {
        return dientes;
    }

    public boolean getColumnaVertebral() {
        return columnaVertebral;
    }

    public boolean getRespira() {
        return respira;
    }

    public boolean getVenenoso() {
        return venenoso;
    }

    public boolean getAletas() {
        return aletas;
    }

    public boolean getCola() {
        return cola;
    }

    public boolean getDomestico() {
        return domestico;
    }

    public boolean getPequeño() {
        return pequeño;
    }
    
    public int getClase() {
        return clase;
    }
}