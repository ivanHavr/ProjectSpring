package com.desktop.spring;


import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import com.desktop.spring.impls.SQLiteDAO;
import com.desktop.spring.objects.User;
import com.google.gson.Gson;

@Controller
@SessionAttributes("user")
public class CheckController {
	@Autowired
	SQLiteDAO sqliteDAO;
	private Logger log = LoggerFactory.getLogger(CheckController.class);
	@RequestMapping(value = "/mainPage", method = RequestMethod.POST)
	public String checkUser(@Valid @ModelAttribute("user") User user,BindingResult result, Model model, HttpSession httpSession) {
		if(result.hasErrors()) {
			return "login";
		}
		if(!user.getEmail().isEmpty() || !user.getPassword().isEmpty()) {
		User userValid = new User();
		userValid = sqliteDAO.getUserByEmail(user.getEmail());
		if(user.getPassword().equals(userValid.getPassword())) {
			model.addAttribute("user",userValid);
			httpSession.setAttribute("userself",userValid);
			httpSession.setAttribute("usersOnline", sqliteDAO.getUserListById(userValid.getId()));
			log.info(httpSession.getAttribute("usersOnline").toString());
			sqliteDAO.updateOnline(userValid.getId(),true);
			return "messagePage";
		}
		}
		return "login";
	}
	@RequestMapping(value = "/checkStrength", method = RequestMethod.GET)
	public @ResponseBody String checkStrength(@RequestParam String password) {
		String result = "<span id=\"check\" style=\"color:%s;\">%s</span>";
		if(password.length() >= 3 && password.length() < 6) {
			return String.format(result, "#FF0000" ,"Easy");
		}else if(password.length() >= 6 && password.length() < 10) {
			return String.format(result, "#FF9900" ,"Medium");
		}else if(password.length() >= 10) {
			return String.format(result, "#0099CC" ,"Hard");
		}
	return "";
	}
	@RequestMapping(value = "/usersOnline", method = RequestMethod.GET)
	public @ResponseBody String usersOnline(HttpSession httpSession) {
		User user = (User) httpSession.getAttribute("userself");
		List<User> users = sqliteDAO.getUserListById(user.getId());
		Gson gson = new Gson();
		
		return gson.toJson(users);
	}
}
