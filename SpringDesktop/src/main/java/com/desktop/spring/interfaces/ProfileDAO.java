package com.desktop.spring.interfaces;

import java.util.List;

import com.desktop.spring.objects.MessageBody;
import com.desktop.spring.objects.User;




public interface ProfileDAO {
	void insert(User user);
	void insertPathPhoto(User user);
	void delete(User user);
	void delete(int id);
	User getUserById(int id);
	User getUserByName(String name);
	User getUserByEmail(String email);
	List<User> getUserBySearch(String name);
	List<User> getUserListById(int id);
	List<User> getUserList();
	void addFriend(int id, int idFriend);
	boolean checkFriend(int userid, int friendId);	
	void sendMessage(int sender_id, int recipient_id,String message);
	List<MessageBody> getMesseges(int sender, int recipient);
	String getLastMesseges(int sender_id, int recipient_id);
	void updateOnline(int id,boolean online);
}
