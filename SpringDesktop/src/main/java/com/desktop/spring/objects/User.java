package com.desktop.spring.objects;




import javax.validation.constraints.Size;

import org.springframework.stereotype.Component;


@Component
public class User {
	private int id;
	@Size(min = 3,message = "Name is required!")
	private String name;
	
	@Size(min = 3,message = "Surname is required!")
	private String surname;
	
	@Size(min = 3,message = "Password must be min 3 symbols")
	private String password;
	
	@Size(min = 3,max = 25,message = "Email must be between 3 and 25 symbols")
	private String email;
	
	private String birthdate;
	
	@Size(min = 3,message = "City is required!")
	private String city;
	
	private String gender;
	
	@Size(min = 2,message = "Age is required!")
	private String age;
	
	private String status;
	
	private String PathPhoto;
	
	private String FriendsId;
	
	private boolean online = false;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	//Getters and Setters
	public boolean isOnline() {
		return online;
	}
	public void setOnline(boolean online) {
		this.online = online;
	}
	public String getPathPhoto() {
		return PathPhoto;
	}
	public void setPathPhoto(String pathPhoto) {
		PathPhoto = pathPhoto;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	public String getFriendsId() {
		return FriendsId;
	}
	public void setFriendsId(String friendsId) {
		FriendsId = friendsId;
	}
	
}
