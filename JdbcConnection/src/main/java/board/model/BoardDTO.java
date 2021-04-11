package board.model;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
@Data
public class BoardDTO implements Serializable{
	private long no;
	private String title;
	private String name;
	private String password;
	private String content;
	private Date regdate;
	private int readcount;
}
