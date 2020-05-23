package com.bitcamp.project.service.impl;
//package com.bitcamp.project.dao.impl;
//
//import java.io.File;
//import java.io.IOException;
//import java.util.List;
//
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//import org.springframework.web.multipart.MultipartFile;
//
//import com.bitcamp.project.board.BoardService;
//import com.bitcamp.project.dao.BoardDAO;
//import com.bitcamp.project.vo.BoardVO;
//
//
//@Service("boardService")
//public class BoardServiceImpl implements BoardService{
//	
//	@Autowired
//	private BoardDAO boardDAO;
//	
//	@Autowired
//	HttpSession session;
//
//
//	@Override
//	public void insertBoard(BoardVO vo) {
//		boardDAO.insertBoard(vo);
//	}
//
//	@Override
//	public void updateBoard(BoardVO vo) {
//		boardDAO.updateBoard(vo);
//	}
//
//	@Override
//	public void deleteBoard(BoardVO vo) {
//		boardDAO.deleteBoard(vo);
//	}
//
//	@Override
//	public BoardVO getBoard(BoardVO vo) {
//		return boardDAO.getBoard(vo);
//	}
//
//	@Override
//	public List<BoardVO> getBoardList(BoardVO vo) {
//		return boardDAO.getBoardList(vo);
//	}
//
//	@Override
//	public void uploadBoard(BoardVO vo) throws IllegalStateException, IOException {
//		MultipartFile uploadFile = vo.getUploadFile();
//		// 업로드 파일있니?
//		if(!uploadFile.isEmpty()) {
//			// 파일이름
//			String fileName = uploadFile.getOriginalFilename();
//			// 절대 경로 파일 저장
////			uploadFile.transferTo(new File("/Users/ekkkk1/Desktop/" + fileName));
//			
//			// 상대 경로 파일 저장
//			String rootPath = session.getServletContext().getRealPath("/");
//			String attachPath = "/WEB-INF/images/";
//			uploadFile.transferTo(new File(rootPath + attachPath + fileName));
//		}		
//	}
//}
//
//
//
//
//