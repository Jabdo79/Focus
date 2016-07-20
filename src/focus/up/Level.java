package focus.up;

public class Level {
	
	//static because calcExp formula is the same for each user 
	public static void calcExp(User user, int startTime, int endTime){
		int exp; 
		//if they start and end in the same hour increase endtime by 1 so they gain 1 exp
		if(startTime == endTime)
			endTime+=1;
		
		exp = Math.abs(startTime - endTime); 
		//if they studied more than 3 hours they get max exp of 3 and a message that they should take a break sooner
		if(exp >= 3)
			exp = 3;
		
		user.setExp(user.getExp() + exp);  
		calcLevel(user);
	}
	//static because calcLevel formula is the same for each user 
	public static void calcLevel(User user){
		//totalExp only need to store once 
		int totalExp = user.getExp();
		if (totalExp < 10){
			user.setLevel(1); 
		}
		else if (totalExp < 30){
		    user.setLevel(2);
		}
		else if (totalExp < 60){
		    user.setLevel(3);
		}
		else if (totalExp < 100){
		    user.setLevel(4);
		}
		else if (totalExp < 150){
			user.setLevel(5);
		}
		else if (totalExp < 210){
			user.setLevel(6);
		}
		else if (totalExp < 280){
			user.setLevel(7);
		}
		else if (totalExp < 360){
			user.setLevel(8);
		}
		else if (totalExp < 450){
			user.setLevel(9);
		}
		else if (totalExp < 550){
			user.setLevel(10);
		}
		else if (totalExp < 660){
			user.setLevel(11);
		}
		else if (totalExp < 780){
			user.setLevel(12);
		}
		else if (totalExp < 910){
			user.setLevel(13);
		}
		else if (totalExp < 1050){
			user.setLevel(14);
		}
		else if (totalExp < 1200){
			user.setLevel(15);
		}
		else if (totalExp < 1360){
			user.setLevel(16);
		}
		else if (totalExp < 1530){
			user.setLevel(17);
		}
		else if (totalExp < 1710){
			user.setLevel(18);
		}
		else if (totalExp < 1900){
			user.setLevel(19);
		}
		else if (totalExp >= 1900){
			user.setLevel(20);
		}
	}
	
}