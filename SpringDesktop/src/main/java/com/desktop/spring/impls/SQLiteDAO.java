package com.desktop.spring.impls;



import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import com.desktop.spring.interfaces.ProfileDAO;
import com.desktop.spring.objects.MessageBody;
import com.desktop.spring.objects.User;

@Service("sqliteDAO")
public class SQLiteDAO implements ProfileDAO{
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public void insert(User user) {
		String sql = "insert into admin_spread.profile_inf (name,surname,password,city,gender,age,status,email,birthdate,friends_id) values (?,?,?,?,?,?,?,?,?,?)";
		jdbcTemplate.update(sql,new Object[] {user.getName(),user.getSurname(),
				user.getPassword(),user.getCity(),user.getGender(),user.getAge(),user.getStatus(),user.getEmail(),user.getBirthdate(),"0"});
	}
	@Override
	public void insertPathPhoto(User user) {
		String sql = "Update admin_spread.profile_inf set path_photo = ? Where email = ?";
		jdbcTemplate.update(sql,new Object[] {user.getPathPhoto(),user.getEmail()});
	}

	@Override
	public void delete(User user) {
	}
	@Override
	public void delete(int id) {
		String sql = "delete from admin_spread.profile_inf where id=?";
		jdbcTemplate.update(sql,id);	
	}
	@Override
	public User getUserByEmail(String email) {
		String sql = "Select * from admin_spread.profile_inf where email=?";
		return jdbcTemplate.queryForObject(sql,new Object[] {email},new UserRowMapper());
	}
	@Override
	public User getUserById(int id) {
		String sql = "select * from admin_spread.profile_inf where id=?";
		return jdbcTemplate.queryForObject(sql,new Object[] {id},new UserRowMapper());	
	}
	@Override
	public User getUserByName(String name) {
		String sql = "select * from admin_spread.profile_inf where name=?";
		return jdbcTemplate.queryForObject(sql,new Object[] {name},new UserRowMapper());	
	}
	
	@Override
	public List<User> getUserBySearch(String name) {
		String sql = "select * from admin_spread.profile_inf where name like ?";
		return jdbcTemplate.query(sql,new Object[] {"%"+name+"%"},new UserRowMapper());	
	}
	@Override
	public boolean checkFriend(int userid, int friendId) {
		String sql = "select friends_id from admin_spread.profile_inf where id=?";
		String friendsId = (String) jdbcTemplate.queryForObject(sql,new Object[] {userid},String.class);
		int r = 0;
		for(int j = 0;j<friendsId.length();j++) {
            if(friendsId.charAt(j)==','){
            r++; 
           }
        }
		r++;
		String res[] = new String[r];
        int c = 0;
        int k = 0;
        for (int i = 0; i < friendsId.length(); i++) {
            if(friendsId.charAt(i) == ','){
            c++;
            k=0;
            }else{
            if(k == 0){
            	res[c]  = String.valueOf(friendsId.charAt(i));
            k++;
            }else{
            	res[c] += String.valueOf(friendsId.charAt(i));
            k++;
            }
          }
        }
		Integer fId = friendId;
		for(int j = 0;j<res.length;j++) {
            if(res[j].equals(fId.toString())){
            	return true;
            }  
	}
		return false;
	}
	@Override
	public void sendMessage(int sender_id, int recipient_id,String message) {
		String sqlf = "insert into admin_spread.messages (sender_id,recipient_id,text,date) values (?,?,?,?)";
		jdbcTemplate.update(sqlf,new Object[] {sender_id,recipient_id,message,LocalDateTime.now().format(DateTimeFormatter.ofLocalizedDate(FormatStyle.SHORT)).toString()});
	}
	@Override
	public List<MessageBody> getMesseges(int sender, int recipient) {
		String sqlf = "SELECT * FROM admin_spread.messages where sender_id =? and recipient_id =?  or sender_id =? and recipient_id =? order by date";
		return jdbcTemplate.query(sqlf,new Object[] {sender,recipient,recipient,sender},new StringMessageRowMapper());	
	}
	@Override
	public String getLastMesseges(int sender_id, int recipient_id) {
		String sqlf = "SELECT * FROM admin_spread.messages WHERE id=(SELECT MAX(id) FROM admin_spread.messages) and sender_id=? and recipient_id=?";
		return jdbcTemplate.queryForObject(sqlf,new Object[] {sender_id,recipient_id},new StringRowMapper());
	}
	@Override
	public List<User> getUserListById(int id) {
		String sql = "select friends_id from admin_spread.profile_inf where id=?";
		String friendsId = (String) jdbcTemplate.queryForObject(sql,new Object[] {id},String.class);
		if(friendsId == null || friendsId.equals("0")) {
			return new ArrayList<User>();
		}else {
		int r = 0;
		for(int j = 0;j<friendsId.length();j++) {
            if(friendsId.charAt(j)==','){
            r++; 
           }
        }
		r++;
		String res[] = new String[r];
        int c = 0;
        int j = 0;
        for (int i = 0; i < friendsId.length(); i++) {
            if(friendsId.charAt(i) == ','){
            c++;
            j=0;
            }else{
            if(j == 0){
            	res[c]  = String.valueOf(friendsId.charAt(i));
            j++;
            }else{
            	res[c] += String.valueOf(friendsId.charAt(i));
            j++;
            }
            }
        }
		String sqlf = "select * from admin_spread.profile_inf where ";
		int i = 0;
		while(i<res.length) {
			if(i==0) {
				sqlf +="id="+res[i]+" ";
				i++;
			}else {
			sqlf +="or id="+res[i]+" ";
			i++;
			}
		}
		return jdbcTemplate.query(sqlf,new UserRowMapper());
		}
	}
	@Override
	public List<User> getUserList() {
		String sqlf = "select * from admin_spread.profile_inf";
		return jdbcTemplate.query(sqlf,new UserRowMapper());
	}
	
	@Override
	public void addFriend(int id, int idFriend) {
		String sql = "select friends_id from admin_spread.profile_inf where id=?";
		String friendsId = (String) jdbcTemplate.queryForObject(sql,new Object[] {id},String.class);
		if(friendsId == null || friendsId.equals("0") ) {
			friendsId = String.valueOf(idFriend);
		}else {
		friendsId+=","+String.valueOf(idFriend);
		}
		String sqlf = "update admin_spread.profile_inf set friends_id=?  where id=?";
		jdbcTemplate.update(sqlf,new Object[] {friendsId,id});	
	}
	@Override
	public void updateOnline(int id,boolean online) {
		String sqlf = "update admin_spread.profile_inf set online=?  where id=?";
		jdbcTemplate.update(sqlf,new Object[] {online,id});	
	}
 private static final class UserRowMapper implements RowMapper<User>
{

	@Override
	public User mapRow(ResultSet arg0, int arg1) throws SQLException {
		User user = new User();
		user.setId(arg0.getInt("id"));
		user.setName(arg0.getString("name"));
		user.setSurname(arg0.getString("surname"));
		user.setPassword(arg0.getString("password"));
		user.setEmail(arg0.getString("email"));
		user.setCity(arg0.getString("city"));
		user.setBirthdate(arg0.getString("birthdate"));
		user.setAge(arg0.getString("age"));
		user.setStatus(arg0.getString("status"));
		user.setGender(arg0.getString("gender"));
		user.setPathPhoto(arg0.getString("path_photo"));
		user.setOnline(arg0.getBoolean("online"));
		return user;
	}
 }
 private static final class StringRowMapper implements RowMapper<String>
 {
 	@Override
 	public String mapRow(ResultSet arg0, int arg1) throws SQLException {
 		String s = arg0.getString("text");
 		return s;
 	}
  }
 private static final class StringMessageRowMapper implements RowMapper<MessageBody>
 {
	@Override
 	public MessageBody mapRow(ResultSet arg0, int arg1) throws SQLException {
 		MessageBody messageBody = new MessageBody();
 		messageBody.setSenderId(arg0.getInt("sender_id"));
 		messageBody.setRecipientId(arg0.getInt("recipient_Id"));
 		messageBody.setText(arg0.getString("text"));
 		messageBody.setDate(arg0.getString("date"));
 		return messageBody;
 	}
  }

 
}
