public class SwitchPatternMatching {
    public static void main(String[] args) {
        testType("Hello");
        testType(123);
        testType(45.67);
        testType(true);
    }

    public static void testType(Object obj) {
        switch (obj) {
            case Integer i -> System.out.println("Integer: " + i);
            case String s -> System.out.println("String: " + s);
            case Double d -> System.out.println("Double: " + d);
            default -> System.out.println("Unknown type: " + obj);
        }
    }
}