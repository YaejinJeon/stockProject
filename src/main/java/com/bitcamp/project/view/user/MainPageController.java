package com.bitcamp.project.view.user;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bitcamp.project.service.BoardService;
import com.bitcamp.project.service.MyAccountService;
import com.bitcamp.project.service.MyPostService;
import com.bitcamp.project.service.SignInService;
import com.bitcamp.project.service.TradeService;
import com.bitcamp.project.service.UserInfoService;
import com.bitcamp.project.vo.BoardVO;
import com.bitcamp.project.vo.CommentVO;
import com.bitcamp.project.vo.HoldingStockVO;
import com.bitcamp.project.vo.Info;
import com.bitcamp.project.vo.PagingVO;
import com.bitcamp.project.vo.StockVO;
import com.bitcamp.project.vo.UserVO;

import stockCode.KospiKosdaq;
import stockCode.MainPageNews;
import stockCode.TopStock;

@Controller
public class MainPageController {

	@Autowired
	TradeService tradeService;

	@Autowired
	BoardService boardService;

	@Autowired
	UserInfoService userInfoService;
	
	@Autowired
	MyPostService myPostService;

	@Autowired
	SignInService signInService;
	
	@Autowired
	MyAccountService myAccountService;

	@Autowired
	HttpServletRequest request;
	
	@GetMapping(value = "/")
	public ModelAndView mainPage(BoardVO vo, HttpSession session) {
		
		
		String ip = request.getRemoteAddr();
		SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초");

		Date time_ = new Date();

		String time = format.format(time_);
		System.out.println("ip : " + ip + " " + time + " path " + request.getServletPath());

		
		
		ModelAndView mav = new ModelAndView();
		DecimalFormat formatter = new DecimalFormat("###,###,###");
		Map<String, Object> kospiChart = tradeService.dayChart("종합주가지수");
		Map<String, Object> kosdaqChart = tradeService.dayChart("(코스닥)종합");
		Map<String, Object> map = new HashMap<String, Object>();
		MainPageNews news = new MainPageNews(); 
		Info inf = news.news();

		Integer[][] kospiData = new Integer[6][60];
		Integer[][] kosdaqData = new Integer[6][60];
//
		for (int i = 0; i < 60; i++) {
			kospiData[0][i] = (Integer) ((HashMap) kospiChart.get(i)).get("d");
			kospiData[2][i] = (Integer) ((HashMap) kospiChart.get(i)).get("startprice");
			kospiData[3][i] = (Integer) ((HashMap) kospiChart.get(i)).get("highprice");
			kospiData[4][i] = (Integer) ((HashMap) kospiChart.get(i)).get("lowprice");
			kospiData[5][i] = (Integer) ((HashMap) kospiChart.get(i)).get("lastprice");

			kosdaqData[0][i] = (Integer) ((HashMap) kosdaqChart.get(i)).get("d");
			kosdaqData[2][i] = (Integer) ((HashMap) kosdaqChart.get(i)).get("startprice");
			kosdaqData[3][i] = (Integer) ((HashMap) kosdaqChart.get(i)).get("highprice");
			kosdaqData[4][i] = (Integer) ((HashMap) kosdaqChart.get(i)).get("lowprice");
			kosdaqData[5][i] = (Integer) ((HashMap) kosdaqChart.get(i)).get("lastprice");
		}

		Map<String, Object> bestBoardList = boardService.boardList(vo, 0, "", "", "mainNew", "free", 5);
		Map<String, Object> newBoardList = boardService.boardList(vo, 0, "", "", "mainBest", "free", 5);
		mav.addObject("bestBoardList", (List<BoardVO>) bestBoardList.get("boardList"));
		mav.addObject("newBoardList", (List<BoardVO>) newBoardList.get("boardList"));

		mav.addObject("current_kospi", ((HashMap) kospiChart.get(0)).get("lastprice"));
		mav.addObject("current_kosdaq", ((HashMap) kosdaqChart.get(0)).get("lastprice"));

		mav.addObject("kosdaq_d", kosdaqData[0]);
		mav.addObject("kosdaq_startprice", kosdaqData[2]);
		mav.addObject("kosdaq_highprice", kosdaqData[3]);
		mav.addObject("kosdaq_lowprice", kosdaqData[4]);
		mav.addObject("kosdaq_lastprice", kosdaqData[5]);

		mav.addObject("kospi_d", kospiData[0]);
		mav.addObject("kospi_startprice", kospiData[2]);
		mav.addObject("kospi_highprice", kospiData[3]);
		mav.addObject("kospi_lowprice", kospiData[4]);
		mav.addObject("kospi_lastprice", kospiData[5]);
		
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		mav.addObject("loginUser", loginUser);
		
		KospiKosdaq kos = new KospiKosdaq();
		Info kosUpdown = kos.kosUpdown();
		mav.addObject("kospi", kosUpdown.getKospi());
		mav.addObject("kosdaq", kosUpdown.getKosdaq());

		

		List<Map> list = userInfoService.getCurrentRevenue();
		for (int i = 0; i < list.size(); i++) {
			list.get(i).put("revenue", Math.round((double) list.get(i).get("revenue") * 100) / 100.0);
		}
		//System.out.println(list);
		mav.addObject("currentRevenue", list);

		if (session.getAttribute("loginUser") != null)
			mav.addObject("money", formatter.format(tradeService.getMoney(((UserVO) session.getAttribute("loginUser")).getId())));
				
		// 메인뉴스 
		mav.addObject("news", inf.getMainNews());
		
		mav.setViewName("mainpage");
		return mav;
	}

	@GetMapping(value = "/mainPage/stockRankAjax")
	@ResponseBody
	public Map topRankAjax() {
		Map<String, Object> map = new HashMap<String, Object>();
		TopStock ts = new TopStock();
		
		Info topStock = ts.topStock();
		String[] topName = topStock.getTopName();
		String[] topCurrentPrice = topStock.getTopCurrentPrice();
		String[] topBefore = topStock.getTopBefore();
		String[] topUpDown = topStock.getTopUpDown();
		String[] searchName = topStock.getSearchName();
		String[] searchCurrentPrice = topStock.getSearchCurrentPrice();
		String[] searchUpDown = topStock.getSearchUpDown();
		String[] searchSangHa = topStock.getSearchSangHa();
		String[] searchBefore = topStock.getSearchBefore();

		for (int i = 0; i < topName.length; i++) {
			map.put("topName", topName);
			map.put("topCurrentPrice", topCurrentPrice);
			map.put("topBefore", topBefore);
			map.put("topUpDown", topUpDown);
		}

		for (int i = 0; i < searchUpDown.length; i++) {
			map.put("searchName", searchName);
			map.put("searchCurrentPrice", searchCurrentPrice);
			map.put("searchBefore", searchBefore);
			map.put("searchUpDown", searchUpDown);
			map.put("searchSangHa", searchSangHa);
		}
		
		
		return map;
	}
	
	@GetMapping(value = "/mainPage/newsAjax")
	@ResponseBody
	public Map news() {
		Map<String, Object> map = new HashMap<String, Object>();
		Info news_ = new Info();
		map.put("news1", news_.getNews1());
		map.put("news2", news_.getNews2());
		map.put("news3", news_.getNews3());
		return map;
	}
	
	@GetMapping(value="/selectUserBoard")
	public ModelAndView selectUserBoard(UserVO vo, Model model, HttpSession session, @ModelAttribute("bnowPage") String bnowPage,
			@ModelAttribute("cnowPage") String cnowPage, @ModelAttribute("bSearchStyle") String bSearchStyle,
			@ModelAttribute("boardKeyword") String boardKeyword,
			@ModelAttribute("commentKeyword") String commentKeyword, @ModelAttribute("type") String type) {
	
		ModelAndView mav = new ModelAndView();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if(loginUser == null) {
			mav.addObject("msg", "로그인 후 이용 가능합니다.");
			mav.addObject("location", "/signInPage");
			mav.addObject("icon", "error");
			mav.setViewName("msg/msg");
			return mav;
		}
		if (bnowPage == null || bnowPage.equals("")) {
			bnowPage = "1";
		}
		if (cnowPage == null || cnowPage.equals("")) {
			cnowPage = "1";
		}
		if (bSearchStyle.equals(""))
			boardKeyword = "";
		if(type.equals(""))
			type = "board";
		
		UserVO user = null;
		user = myPostService.selectUser(vo);
		user = signInService.logIn(user);
		
		if(user == null) {
			mav.addObject("msg", "해당 회원의 정보를 볼 수 없습니다.");
			mav.addObject("location", "");
			mav.addObject("icon", "error");
			mav.setViewName("msg/msg");
			return mav;
		}
		
		
		Map<String, Object> myPost = myPostService.myPostList(user, Integer.parseInt(bnowPage),
				Integer.parseInt(cnowPage), bSearchStyle, boardKeyword, commentKeyword);
		mav.addObject("user", user);
		mav.addObject("userBoard", (List<BoardVO>) myPost.get("myBoard"));
		mav.addObject("userComment", (List<CommentVO>) myPost.get("myComment"));
		mav.addObject("boardPage", (PagingVO) myPost.get("boardPage"));
		mav.addObject("commentPage", (PagingVO) myPost.get("commentPage"));
		mav.addObject("bSearchStyle", bSearchStyle);
		mav.addObject("boardKeyword", boardKeyword);
		mav.addObject("commentKeyword", commentKeyword);
		mav.addObject("type", type);
		
		mav.setViewName("/myPage/selectUserBoard");
		
		
		return mav;
		
		
		
	}
	
	@GetMapping(value="/selectUserMoney")
	public ModelAndView selectUserMoney(HttpSession session, UserVO vo, Model model,
										@ModelAttribute("nowPage1") String nowPage1/* 계좌용 */,
										@ModelAttribute("nowPage2") String nowPage2/* 날짜별 */, @ModelAttribute("nowPage3") String nowPage3/* 종류별 */,
										@ModelAttribute("accountSearch") String accountSearch, @ModelAttribute("tradeSearch") String tradeSearch,
										@ModelAttribute("startDate") String startDate, @ModelAttribute("endDate") String endDate,
										@ModelAttribute("type") String type) {
		if (type.equals(""))
			type = "rate";
		if (nowPage1.equals(""))
			nowPage1 = "1";
		if (nowPage2.equals(""))
			nowPage2 = "1";
		if (nowPage3.equals(""))
			nowPage3 = "1";
		UserVO user = null;
		user = myPostService.selectUser(vo);
		user = signInService.logIn(user);
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		session.setAttribute("loginUser", loginUser);
		ModelAndView mav = new ModelAndView();

		if(loginUser == null) {
			mav.addObject("msg", "로그인 후 이용 가능합니다.");
			mav.addObject("location", "/signInPage");
			mav.addObject("icon", "error");
			mav.setViewName("msg/msg");
			return mav;
		}
		
		
		
		else if(user == null || user.getShowEsetSetting() == 0) {
			mav.addObject("msg", "해당 회원의 정보를 볼 수 없습니다.");
			mav.addObject("location", "");
			mav.addObject("icon", "error");
			mav.setViewName("msg/msg");
			return mav;
		}
		else {
			
			HashMap<String, Object> hm1 = myAccountService.getMyStockList(user, Integer.parseInt(nowPage1),
					accountSearch);
			HashMap<String, Object> hm2 = myAccountService.getMyTradeHistoryList(user,
					Integer.parseInt(nowPage2), startDate, endDate, tradeSearch);
//			   HashMap<String, Object> hm3 = myAccountService.getMyTradeHistoryListByStock(loginUser, Integer.parseInt(nowPage3), tradeSearch);
			HashMap<String, Object> hm4 = userInfoService.getRate(user.getId());
			mav.addObject("user", user);
			mav.addObject("pv1", (PagingVO) hm1.get("pv1"));
			mav.addObject("holdingStockList", (List<HoldingStockVO>) hm1.get("holdingStockList"));
			mav.addObject("pv2", (PagingVO) hm2.get("pv2"));
			mav.addObject("stockHistoryList", (List<StockVO>) hm2.get("stockHistoryList"));
//			   mav.addObject("pv3", (PagingVO)hm3.get("pv3"));
//			   mav.addObject("stockHistoryListByStock", (List<StockVO>)hm3.get("stockHistoryListByStock"));
			mav.addObject("accuntSearch", accountSearch);
			mav.addObject("tradeSearch", tradeSearch);
			mav.addObject("startDate", startDate);
			mav.addObject("endDate", endDate);
			mav.addObject("type", type);
			mav.addObject("accumAsset", hm4.get("accumAsset"));
			mav.addObject("ranking", hm4.get("ranking"));
			mav.setViewName("/myPage/selectUserMoney");
			
			System.out.println("1 "+(PagingVO) hm1.get("pv1"));
			System.out.println("2 "+(PagingVO) hm2.get("pv2"));
			
			
			return mav;
		}
	}

//	@GetMapping(value = "/mainPage/userRank")
//	@ResponseBody
//	public List userRank() {
//		List list = userInfoService.getCurrentRevenue();
//		System.out.println(list);
//		return list;
//	}
	
	@PostMapping(value="/accumRanking")
	@ResponseBody
	public HashMap<String, Object> accumRanking() {
		HashMap<String, Object> map = userInfoService.getAccumRankingInfoList();
		return map;
	}

}
