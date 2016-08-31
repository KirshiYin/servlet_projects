package beans;

public class User {
	
	private int id;
	private String name;
	private String password;

	private String message = "";
	
	public String getMessage() {
		return message;
	}
	public int getId() {
		return id;
	}

	public User(String name, String password) {
		super();
		this.name = name;
		this.password = password;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	public boolean validate() {
		
		if(name == null) {
			message = "Invalid name";
			return false;
		}
		
		if(password == null) {
			message = "Invalid password";
			return false;
		}
		
		if(!name.matches("\\w+@\\w+\\.\\w+")) {
			message = "Invalid name";
			return false;
		}
		
		if(password.length() < 4) {
			message = "Password must be at least 4 characters.";
			return false;
		}
		else if(password.matches("\\w*\\s+\\w*")) {
			message = "Password cannot contain space.";
			return false;
		}
		
		return true;
	}
}
