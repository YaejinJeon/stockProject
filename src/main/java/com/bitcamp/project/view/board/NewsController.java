package com.bitcamp.project.view.board;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitcamp.project.vo.Info;

import stockCode.News;

@Controller
public class NewsController {
	
	@Autowired
	HttpServletRequest request;
	
	@GetMapping("/news")
	public String newsBoard() {
		return "board/newsboard";
	}
	
	@GetMapping("/newsAjax")
	@ResponseBody
	public Map<String, Object> newsBoard(Model model) {
		News newsBoard = new News();
		Info news_ = newsBoard.news();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("news1", news_.getNews1());
		map.put("news2", news_.getNews2());
		map.put("news3", news_.getNews3());
		return map;
	}
}
