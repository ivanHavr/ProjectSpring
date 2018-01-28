package com.desktop.spring;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import com.desktop.spring.impls.SQLiteDAO;
import com.desktop.spring.objects.MessageBody;
import com.desktop.spring.objects.User;
import com.google.gson.Gson;



@Controller
@SessionAttributes("user")
public class HomeController {
	private Logger log = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	SQLiteDAO sqliteDAO;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(HttpSession httpSession) {
		
		return new ModelAndView("index","user",new User());
		
	}
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(HttpSession httpSession) {
		
		return new ModelAndView("login","user",new User());
		
	}
	@RequestMapping(value = "/logOut", method = RequestMethod.GET)
	public ModelAndView logOut(HttpSession httpSession) {
		User user = (User)httpSession.getAttribute("userself");
		sqliteDAO.updateOnline(user.getId(), false);
		httpSession.removeAttribute("userself");
		return new ModelAndView("login","user",new User());
		
	}
	
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public ModelAndView main(HttpSession httpSession) {
		User user = (User) httpSession.getAttribute("userself");
		return new ModelAndView("profile","user",user);
	}
	@RequestMapping(value = "/addFriend", method = RequestMethod.GET)
	@ResponseBody 
	public String addFriend(HttpSession httpSession) {
		User Iam = (User)httpSession.getAttribute("userself");
		User Add = (User)httpSession.getAttribute("userON");
		sqliteDAO.addFriend(Iam.getId(), Add.getId());
		List<User> users;
		users = sqliteDAO.getUserListById(Iam.getId());
		httpSession.setAttribute("usersOnline", users);
		return "sure";
	}
	
	@RequestMapping(value = "/AboutMe", method = RequestMethod.GET)
	public String aboutMe(HttpSession httpSession) {
		return "AboutMe";
	}
	@RequestMapping(value = "/message", method = RequestMethod.GET)
	public String MyMessage(HttpSession httpSession) {
		return "messagePage";
	}
	@RequestMapping(value = "/gotoFriend",  method = RequestMethod.GET)
	@ResponseBody public ModelAndView gotoFriend(@RequestParam("name") String name,HttpSession httpSession) {
		User users = new User();
		users = sqliteDAO.getUserByName(name);
		httpSession.setAttribute("userON", users);
		return new ModelAndView("UnUserPage","userON",users);
	}
	@RequestMapping(value = "/selectFriend",  method = RequestMethod.POST)
	@ResponseBody public String selectFriend(@RequestParam("selectF") int selectF,HttpSession httpSession) {
		User users = new User();
		users = sqliteDAO.getUserById(selectF);
		httpSession.setAttribute("userON", users);
		httpSession.setAttribute("user",users);
		return "Write to: "+users.getName() + " " +users.getSurname() ;
	}
	@RequestMapping(value = "/buttonShow",  method = RequestMethod.GET)
	@ResponseBody public String buttonShow(HttpSession httpSession) {
		User Iam = (User)httpSession.getAttribute("userself");
		User Add = (User)httpSession.getAttribute("userON");
		
		if(sqliteDAO.checkFriend(Iam.getId(), Add.getId())==true) {
			log.info("true");
			return "true";
			
		}
		    log.info("false");
			return "false";
		
	}
	
	@RequestMapping(value = "/searchUsers",  method = RequestMethod.GET)
	@ResponseBody public String searchUsers(@RequestParam("searchUser") String searchUser) {
		List<User> users = new ArrayList<User>();
		if(!searchUser.isEmpty()) {
			users = sqliteDAO.getUserBySearch(searchUser);
		}
		for(int i=0;i<users.size();i++) {
			log.info(users.get(i).getName());
		}
		Gson gson = new Gson();
		return gson.toJson(users);
	}
	
	@RequestMapping(value = "/sendMessage",  method = RequestMethod.POST)
	@ResponseBody public String sendMessage(@RequestParam("message") String message,HttpSession httpSession,HttpServletResponse response) {
		User Iam = (User)httpSession.getAttribute("userself");
		User Add = (User)httpSession.getAttribute("userON");
		String created = LocalDateTime.now().format(DateTimeFormatter.ofLocalizedTime(FormatStyle.SHORT)).toString();
		sqliteDAO.sendMessage(Iam.getId(), Add.getId(), message,created);
		response.setHeader("Content-Type", "text/html; charset=UTF-8");
		List<String> result = new ArrayList<String>();
		result.add(message);
		result.add(created);
		Gson gson = new Gson();
		return gson.toJson(result);
	}
	@RequestMapping(value = "/getMessage",  method = RequestMethod.POST)
	@ResponseBody public String getMessage(HttpSession httpSession, HttpServletResponse response) {
		User Iam = (User)httpSession.getAttribute("userself");
		User Add = (User)httpSession.getAttribute("userON");
		List<MessageBody> result = sqliteDAO.getMesseges(Iam.getId(), Add.getId());
		Gson gson = new Gson();
		response.setHeader("Content-Type", "text/html; charset=UTF-8");
		return gson.toJson(result);
	}
	
}
