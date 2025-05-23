import java.util.*;

public class ArrayListExample {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ArrayList<String> names = new ArrayList<>();

        System.out.print("Enter number of students: ");
        int count = scanner.nextInt();
        scanner.nextLine(); // consume newline

        for (int i = 0; i < count; i++) {
            System.out.print("Enter name: ");
            names.add(scanner.nextLine());
        }

        System.out.println("Student Names:");
        for (String name : names) {
            System.out.println(name);
        }

        scanner.close();
    }
}