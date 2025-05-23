// File: NumberGuessingGame.java
import java.util.Random;
import java.util.Scanner;

public class NumberGuessingGame {
    public static void main(String[] args) {
        Random random = new Random();
        int numberToGuess = random.nextInt(100) + 1; // 1 to 100
        Scanner scanner = new Scanner(System.in);
        int guess = 0;

        System.out.println("Guess the number between 1 and 100:");

        while (guess != numberToGuess) {
            System.out.print("Enter your guess: ");
            guess = scanner.nextInt();

            if (guess < numberToGuess) {
                System.out.println("Too low, try again!");
            } else if (guess > numberToGuess) {
                System.out.println("Too high, try again!");
            } else {
                System.out.println("Congratulations! You guessed correctly.");
            }
        }
        scanner.close();
    }
}