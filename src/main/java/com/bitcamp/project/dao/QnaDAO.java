package com.bitcamp.project.dao;

import java.util.List;

import com.bitcamp.project.vo.PagingVO;
import com.bitcamp.project.vo.QnaVO;

public interface QnaDAO {
	public int writeQuestion(QnaVO vo);
	public int writeAnswer(QnaVO vo);
	public int countQna(QnaVO vo);
	public List<QnaVO> qnaList(PagingVO qnaPage); 
	public QnaVO qnaDetail(QnaVO vo);
	public int qnaDelete(QnaVO vo);
	public int qnaUpdate(QnaVO vo);
}
