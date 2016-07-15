package focus.up;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FocusUpController {

	@RequestMapping("/index")
	public ModelAndView index() {
		return new ModelAndView("index", "message", "Welcome to Focus UP!");
	}

	@RequestMapping("/createLogin")
	public ModelAndView createLogin() {
		return new ModelAndView("login", "command", new User());
	}
}