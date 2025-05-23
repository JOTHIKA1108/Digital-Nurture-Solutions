import java.util.*;

public class HashMapExample {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        HashMap<Integer, String> students = new HashMap<>();

        System.out.print("Enter number of entries: ");
        int count = scanner.nextInt();

        for (int i = 0; i < count; i++) {
            System.out.print("Enter student ID: ");
            int id = scanner.nextInt();
            scanner.nextLine(); // consume newline
            System.out.print("Enter name: ");
            String name = scanner.nextLine();
            students.put(id, name);
        }

        System.out.print("Enter student ID to retrieve name: ");
        int searchId = scanner.nextInt();
        String result = students.get(searchId);

        if (result != null) {
            System.out.println("Student Name: " + result);
        } else {
            System.out.println("ID not found.");
        }

        scanner.close();
    }
}