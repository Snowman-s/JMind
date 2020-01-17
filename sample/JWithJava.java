import java.util.*;
public class JWithJava {
    //MWithJava.srcをコンパイルして、
    //これを実行する。
    public static void main(String[] args) {
        LinkedList<Object> s = new LinkedList<>();
        s.push(30);
        //Mindソースの関数を呼ぶ。
        MWithJava.PrintNumbers(s);
    }
}