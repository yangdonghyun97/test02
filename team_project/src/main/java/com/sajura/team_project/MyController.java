package com.sajura.team_project;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MyController {
		
	@GetMapping("/")
	public  String root() {
		return "main";
	}
	
	@GetMapping("/user_RegForm")
	public  void user_RegForm() {
		
	}
	
	
}
