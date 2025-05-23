public class RecursionExample {
    // Recursive method to calculate factorial
    public int factorial(int n) {
        if (n <= 1) return 1;
        else return n * factorial(n - 1);
    }

    public static void main(String[] args) {
        RecursionExample obj = new RecursionExample();
        int result = obj.factorial(5);
        System.out.println("Factorial of 5 is " + result);
    }
}