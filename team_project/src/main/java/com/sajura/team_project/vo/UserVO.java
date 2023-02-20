package com.sajura.team_project.vo;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserVO {
   
   private int user_no;
   private String user_id;
   private String user_pw;
   private String user_pw_check;
   private String user_name;
   private String user_tel;
   private String user_tel_check;
   private String user_tel2;
   private String user_tel3;
   private String user_email;
   private String user_email2;
   private String user_email_check;
   private String user_address;
   private String user_address_detail;
   private String user_post;
   private int product_no;
   private int user_grade;

}