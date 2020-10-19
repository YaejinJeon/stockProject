package stockCode;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import com.bitcamp.project.vo.Info;

public class KospiKosdaq {
	public Info kosUpdown() {
//	public static void main(String[] args) {
		try {
//			for (int i= 1; i <= 450; i++) {
			Info inf = new Info();
			
			
			
				String naverUrl = "https://finance.naver.com/";
				Document doc = null; // Document에는 페이지의 전체 소스가 저장된다
				doc = Jsoup.connect(naverUrl).get();
				String kospi = doc.select("#content > div.article > div.section2 > div.section_stock_market > div.section_stock > div.kospi_area.group_quot > div.heading_area > a > span").html();
				if(kospi.contains("+") || kospi.contains("상승") || kospi.contains("상한가")) {
					kospi = "+";
				}else if(kospi.contains("-") || kospi.contains("하락") || kospi.contains("하한가"))  {
					kospi = "-";
				}else
					kospi = "0";

				String kosdaq = doc.select("#content > div.article > div.section2 > div.section_stock_market > div.section_stock > div.kosdaq_area.group_quot > div.heading_area > a > span").html();
				if(kosdaq.contains("+") || kosdaq.contains("상승") || kosdaq.contains("상한가")) {
					kosdaq = "+";
				}else if(kosdaq.contains("-") || kosdaq.contains("하락") || kosdaq.contains("하한가")) {
					kosdaq = "-";
				}
				else
					kosdaq = "0";
				

				inf.setKospi(kospi);
				inf.setKosdaq(kosdaq);
			
			return inf;
			
		} catch (Exception er) {
			er.printStackTrace();
		}
		
		return null;
		
		
	}
//	static boolean isStringDouble(String s) {
//		try {
//			Double.parseDouble(s);
//			return true;
//		} catch (NumberFormatException e) {
//			return false;
//		}
//	}
}