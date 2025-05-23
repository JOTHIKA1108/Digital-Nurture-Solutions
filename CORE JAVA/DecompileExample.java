public class DecompileExample {
    public int square(int x) {
        return x * x;
    }

    public static void main(String[] args) {
        System.out.println(new DecompileExample().square(5));
    }
}