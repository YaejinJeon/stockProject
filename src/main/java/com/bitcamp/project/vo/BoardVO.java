package com.bitcamp.project.vo;


import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;


public class BoardVO {
	private int pno; // 글번호
	private String id;
	private String nickname; // 별명
	private String title; // 제목
	private String bcontent; // 내용
	private int views; // 조회수
	private int likes; // 조아용
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm")
	private Date bdateTime; // 작성일
	
	private int bno; // 게시판번호(종류)
	private int commentCount;
	
	private String rtype;
	private String rcontent;
	private String rdateTime;
	
	
	private String thumbnailName;
	
	private int apno;
	private String atitle;
	private String acontent;
	private int acheck;
	
	private Date adateTime;

	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getBcontent() {
		return bcontent;
	}

	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	public Date getBdateTime() {
		return bdateTime;
	}

	public void setBdateTime(Date bdateTime) {
		this.bdateTime = bdateTime;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	public String getRtype() {
		return rtype;
	}

	public void setRtype(String rtype) {
		this.rtype = rtype;
	}

	public String getRcontent() {
		return rcontent;
	}

	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}

	public String getRdateTime() {
		return rdateTime;
	}

	public void setRdateTime(String rdateTime) {
		this.rdateTime = rdateTime;
	}

	public String getThumbnailName() {
		return thumbnailName;
	}

	public void setThumbnailName(String thumbnailName) {
		this.thumbnailName = thumbnailName;
	}

	public int getApno() {
		return apno;
	}

	public void setApno(int apno) {
		this.apno = apno;
	}

	public String getAtitle() {
		return atitle;
	}

	public void setAtitle(String atitle) {
		this.atitle = atitle;
	}

	public String getAcontent() {
		return acontent;
	}

	public void setAcontent(String acontent) {
		this.acontent = acontent;
	}

	public int getAcheck() {
		return acheck;
	}

	public void setAcheck(int acheck) {
		this.acheck = acheck;
	}

	public Date getAdateTime() {
		return adateTime;
	}

	public void setAdateTime(Date adateTime) {
		this.adateTime = adateTime;
	}

	@Override
	public String toString() {
		return "BoardVO [pno=" + pno + ", id=" + id + ", nickname=" + nickname + ", title=" + title + ", bcontent="
				+ bcontent + ", views=" + views + ", likes=" + likes + ", bdateTime=" + bdateTime + ", bno=" + bno
				+ ", commentCount=" + commentCount + ", rtype=" + rtype + ", rcontent=" + rcontent + ", rdateTime="
				+ rdateTime + ", thumbnailName=" + thumbnailName + ", apno=" + apno + ", atitle=" + atitle
				+ ", acontent=" + acontent + ", acheck=" + acheck + ", adateTime=" + adateTime + "]";
	}
	
	
	

	
	
	
}