package focus.up;

public class Level {
	
	//static because calcExp formula is the same for each user 
	public static void calcExp(User user, Broadcast broadcast, int endTime){
		int exp; 
		//calculate studying time duration
		//time is in hours 
		//add previous experiences with new experience and set experience 
		exp = Math.abs(broadcast.getStartTime() - endTime); 
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