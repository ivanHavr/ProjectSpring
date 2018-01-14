package com.desktop.spring;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.desktop.spring.impls.SQLiteDAO;
import com.desktop.spring.objects.User;

@Controller
@SessionAttributes("user")
public class RegisterController {
	private Logger log = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	SQLiteDAO sqliteDAO;
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public ModelAndView checkUser(HttpSession httpSession) {
		return new ModelAndView("regs","user",new User());
	}
	
	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	public ModelAndView reg(@Valid @ModelAttribute("user") User user,BindingResult result) {
		if(!result.hasErrors()) {
			 ModelAndView modelAndView = new ModelAndView();
				modelAndView.setViewName("redirect:/rUploadPhoto");
				modelAndView.addObject("user",user);
				sqliteDAO.insert(user);
				return modelAndView;
		}
		   return new ModelAndView("regs","user",user);
	}
	@RequestMapping(value = "/rUploadPhoto", method = RequestMethod.GET)
	public String rUploadPhoto(@ModelAttribute("user") User user) {
			return "uploadPhoto";
	}
	
	@RequestMapping(value = "/uploadPhoto", method = RequestMethod.POST)
	public ModelAndView uploadPhoto(@RequestParam("photo") MultipartFile file, HttpSession httpSession) {
		String name = null;
		User user = new User();
		if(!file.isEmpty() || file!=null) {
			try {
				byte[] bytes = file.getBytes();
				name = file.getOriginalFilename();
				if(name == null || name.isEmpty()) {
					user = (User)httpSession.getAttribute("user");
					user.setPathPhoto("/resources/images/persona.png");
					sqliteDAO.insertPathPhoto(user);
					return new ModelAndView("redirect:/Complete","user",user);
				}
				String appPath = httpSession.getServletContext().getRealPath("");
				File uploadedFile = new File(appPath+File.separator + "resources/images/"+ name);
				
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(uploadedFile));
				stream.write(bytes);
				stream.flush();
				stream.close();
				user = (User)httpSession.getAttribute("user");
				user.setPathPhoto("/resources/images/"+name);
				sqliteDAO.insertPathPhoto(user);
				log.info("uploaded: "+ uploadedFile.getAbsolutePath());
				return new ModelAndView("redirect:/Complete","user",user);
			} catch (Exception e) {
//				return "You failed to upload"+ name + "=>" + e.getMessage();
			}
		} 
		return new ModelAndView("redirect:/Complete");
	}
	@RequestMapping(value = "/Complete", method = RequestMethod.GET)
	public String Complete(@ModelAttribute("user") User user) {
			return "thanks";
	}
	@RequestMapping(value = "/returnToLogin", method = RequestMethod.GET)
	public String returnToLogin(HttpSession httpSession) {
			return "login";
	}
}
