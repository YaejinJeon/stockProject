//package com.bitcamp.project;
//
//import java.util.Date;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.Map;
//
//import org.jsoup.Jsoup;
//import org.jsoup.nodes.Document;
//import org.jsoup.nodes.Element;
//import org.jsoup.select.Elements;
//import org.mybatis.spring.SqlSessionTemplate;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.scheduling.annotation.Scheduled;
//import org.springframework.stereotype.Component;
//
//import com.bitcamp.project.vo.Info;
//import com.bitcamp.project.vo.StockVO;
//
//@Component
//public class TradingCheck {
//
//	@Autowired
//	private SqlSessionTemplate mybatis;
//
//	public Map<String, Info> stockToMap() {
//		Map<String, Info> info = new HashMap<String, Info>();
//		try {
//			String crwaling = "";
//			for (int i = 1; i <= 32; i++) {
//				String url = "https://finance.naver.com/sise/sise_market_sum.nhn?&page=" + i; // 크롤링할 url지정
//				Document doc = null; // Document에는 페이지의 전체 소스가 저장된다
//				doc = Jsoup.connect(url).get();
//				Elements element = doc.select("table.type_2");
//				Iterator<Element> ie1 = element.select("td").iterator();
//				while (ie1.hasNext()) {
//					crwaling += ie1.next().text() + "ㅇ";
//				}
//			}
//			String[] list = null;
//			int currentPrice = 0;
//			int n = 0;
//			list = crwaling.split("ㅇ");
//			// byte[] by=(Arrays.deepToString(list).getBytes());
//			// output.write(by);
//			Info inf = null;
//
//			for (int i = 0; i < list.length; i++) {
//				if (!list[i].equals("")) {
//					++n;
//				} else {
//					continue;
//				}
//
//				if (n % 12 == 2) {
//					inf = new Info();
//					inf.setStockName(list[i]);
//					list[i] = inf.getStockName();
//					info.put(inf.getStockName(), inf);
//
//				} else if (n % 12 == 3) {
//					String currentPrice_ = list[i].replace(",", "");
//					currentPrice = Integer.parseInt(currentPrice_);
//					inf.setCurrentPrice(currentPrice);
//				}
//
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return info;
//	}
//
//	@Scheduled(fixedDelay = 500)
//	public void TestScheduler() {
//		Map<String, Info> info = stockToMap();
//
//		// unsettledcheck테이블에서 모두 가져와서 map에 주입
//		Map<String, Object> unsettled = mybatis.selectMap("stock.getUnsettled", "uno");
//		for (Object key : unsettled.keySet()) {
//			HashMap map = (HashMap) unsettled.get(key);
//			int price = info.get(map.get("stockName")).getCurrentPrice();
//			System.out.println("check" + price);
//			System.out.println(key + ": [" + map.get("stockName") + "] & [요청 가격: " + map.get("rPrice") + "]");
//			System.out.print("   [현재가 : " + price + "]");
//
//			if (price == (Integer) map.get("rPrice")) { // 가격 동일시
//				System.out.println(" --> 동일가격 확인 & 거래 실행");
//				StockVO sv = mybatis.selectOne("stock.completeUnsettled", map.get("uno"));
//				sv.setrPrice((Integer) map.get("rPrice"));
//				sv.setStockName((String) map.get("stockName"));
//				mybatis.delete("stock.delUnsettled", sv);
//
//				if (sv.getCategory().equals("buy")) { // 구매 거래시
//					sv.setBuysell(1);
//					System.out.println("case: buy");
//					mybatis.insert("stock.buying", sv);
//					if (mybatis.selectOne("stock.getStockQuantity", sv) == null)
//						mybatis.insert("stock.insertHoldingstock", sv);
//					else
//						mybatis.update("stock.updateHoldingstock", sv);
//				} else if (sv.getCategory().equals("sell")) { // 판매 거래시
//					System.out.println("case: sell");
//					sv.setBuysell(1);
//					mybatis.insert("stock.selling", sv);
//					mybatis.update("stock.updateMoney", sv);
//				}
//			} else
//				System.out.println(" --> 거래 실패");
//		}
//
//		Date now = new Date();
//		System.out.println(now);
//	}
//
//}
