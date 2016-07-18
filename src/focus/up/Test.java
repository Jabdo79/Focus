package focus.up;
import java.util.Scanner;

public class Test {

	public static void main(String[] args) {
		
		Scanner scan = new Scanner(System.in);
		User a = new User();
		
		System.out.println("Please enter your name");
		String aName = scan.nextLine();
		a.setEmail(aName);
		
		System.out.println(a.getEmail() + " your current level is " + a.getLevel());
		
		System.out.println("Study duration: ");
		System.out.println("Start time: ");
		int aStartTime = scan.nextInt(); 
		a.setStartTime(aStartTime);
		System.out.println(a.getExp());
		a.cooldownTimer(a);
		System.out.println(a.getExp());
		System.out.println("End time: ");
		int aEndTime = scan.nextInt();
		a.setEndTime(aEndTime);
		
		Level.calcExp(a); 
		
		System.out.println(a.getEmail() + " your updated level is " + a.getLevel());
		scan.close();
	}

}
