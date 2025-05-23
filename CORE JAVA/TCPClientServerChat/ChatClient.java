import java.io.*;
import java.net.*;

public class ChatClient {
    public static void main(String[] args) {
        try (Socket socket = new Socket("localhost", 12345)) {
            System.out.println("Connected to server!");

            BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter output = new PrintWriter(socket.getOutputStream(), true);

            BufferedReader keyboard = new BufferedReader(new InputStreamReader(System.in));
            String message;

            while (true) {
                System.out.print("You: ");
                output.println(keyboard.readLine());
                System.out.println("Server: " + input.readLine());
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}