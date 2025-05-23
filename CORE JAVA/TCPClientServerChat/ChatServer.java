import java.io.*;
import java.net.*;

public class ChatServer {
    public static void main(String[] args) {
        try (ServerSocket serverSocket = new ServerSocket(12345)) {
            System.out.println("Server started. Waiting for client...");
            Socket socket = serverSocket.accept();
            System.out.println("Client connected!");

            BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter output = new PrintWriter(socket.getOutputStream(), true);

            BufferedReader keyboard = new BufferedReader(new InputStreamReader(System.in));
            String message;

            while ((message = input.readLine()) != null) {
                System.out.println("Client: " + message);
                System.out.print("You: ");
                output.println(keyboard.readLine());
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}