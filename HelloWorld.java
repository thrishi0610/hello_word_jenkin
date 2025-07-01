import java.io.FileWriter;
import java.io.IOException;

public class HelloWorld {
    public static void main(String[] args) {
        try {
            FileWriter writer = new FileWriter("output.html");
            writer.write("<h1>Hello, World from Docker28</h1>");
            writer.close();
            System.out.println("HTML file created");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
