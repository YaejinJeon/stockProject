package stockCode;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import com.bitcamp.project.vo.Info;

public class News {
	public Info news() {
//	public static void main(String[] args) {
		try {
//			for (int i= 1; i <= 450; i++) {
			Info inf = new Info();
			
			
			SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
			Date today_ = new Date();
			String today = format1.format(today_);
			
			// 실시간 속보
			String naverUrl = "https://finance.naver.com/news/news_list.nhn?mode=LSS2D&section_id=101&section_id2=258&date="+today;
			Document doc = null; // Document에는 페이지의 전체 소스가 저장된다
			doc = Jsoup.connect(naverUrl).get();
			String news = doc.select("#contentarea_left > ul").html();
			String[] title_ = null;
			title_ = news.split("title=\"");
			List<String> title = new ArrayList<String>();

			String[] content_ = null;
			content_ = news.split("title=\"");
			List<String> content = new ArrayList<String>();


			String[] writer_ = null;
			writer_ = news.split("title=\"");
			List<String> writer = new ArrayList<String>();

			String[] time_ = null;
			time_ = news.split("<span class=\"wdate\">");
			List<String> time = new ArrayList<String>();

			String[] url_ = null;
			url_ = news.split("class=\"articleSubject\"");
			List<String> url = new ArrayList<String>();

			String[] img_ = null;
			img_ = news.split("title=\"");
			String[] img_A = new String[img_.length];
			List<String> img = new ArrayList<String>();


			int start = 0;
			int end = 0;
			int cnt = 0;
			for (int i = 0; i < title_.length; i++) {
				if(title_[i].indexOf("newsList top") == -1) {


					if(title_[i].contains("articleSubject") || title_[i].contains("articleSummary")) {
						if(title_[i].indexOf("\">\"") != -1) {
							end = title_[i].indexOf("\">\"");
						}else if(title_[i].indexOf("\">'") != -1) {
							end = title_[i].indexOf("\">'");
						}else {
							end = title_[i].indexOf("\">");
						}
						title_[i] = title_[i].substring(0, end);
						title_[i] = title_[i].replace("&quot;", "");
						title.add(title_[i]);
					}
				}

				if(content_[i].indexOf("class=\"articleSummary\">") != -1) {
					start = content_[i].indexOf("\"articleSummary\">");
					end = content_[i].indexOf(" <span class=\"press\">");
					content_[i] = content_[i].substring(start+22, end);
					content.add(content_[i]);
				}


				if(writer_[i].indexOf("<span class=\"press\">") != -1) {
					start = writer_[i].indexOf("<span class=\"press\">");
					end = writer_[i].indexOf("</span> <span class=\"bar\">");
					writer_[i] = writer_[i].substring(start+20, end);
					writer_[i] = writer_[i].replace("&quot;", "");
					writer.add(writer_[i]);
				}	


				if(time_[i].indexOf("newsList top") == -1) {
					end = time_[i].indexOf("</span>");
					time_[i] = time_[i].substring(0, end);
//					time_[i] = time_[i].replace("&quot;", "");
					time.add(time_[i]);
				}	

//					if(i < url_.length) {
					if(url_[i].indexOf("newsList top") == -1) {
						start = url_[i].indexOf("<a href=\"");
						if(url_[i].indexOf("\" title=\"") != -1){
							end = url_[i].indexOf("\" title=\"");
							url_[i] = url_[i].substring(start+9, end);
						}else if(url_[i].indexOf("<img src=\"") != -1) {
							end = url_[i].indexOf("<img src=\"");
							url_[i] = url_[i].substring(start+9, end);
						}else continue;
						url_[i] = url_[i].replace("&quot;", "");
						url_[i] = url_[i].replace("amp;", "");

						url.add(url_[i]);
					}

				if(img_[i].indexOf("<a href=\"/") != -1) {
					if(img_[i].indexOf("<img src=\"") != -1) {
						img_A[cnt] = img_[i];	
						start = img_A[cnt].indexOf("<img src=\"");
						end = img_A[cnt].indexOf("alt=");
						img.add(img_A[cnt].substring(start+10, end-2));
						cnt++;
					}
					else {
						img.add(null);
						cnt++;
					}
				}	
			}
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("title", title);
			map.put("content", content);
			map.put("writer", writer);
			map.put("time", time);
			map.put("url", url);
			map.put("img", img);
			inf.setNews1(map);
//			System.out.println("asdglkasndglkasnd salgggggkdgnalsdgggggggggggggg "+inf.getNews1());
//			map.clear();
//			title.clear(); content.clear(); writer.clear(); time.clear(); url.clear(); img.clear();
//			System.out.println(map);
//			System.out.println(img);
//			inf.setTitle(title);
//			inf.setContent(content);
//			inf.setWriter(writer);
//			inf.setTime(time);
//			}
//			String naverUrl = null;
//			Document doc = null;
			
			
			
			
			
			
//				// 시황 전망
				naverUrl = "https://finance.naver.com/news/news_list.nhn?mode=LSS3D&section_id=101&section_id2=258&section_id3=401";
				doc = null; // Document에는 페이지의 전체 소스가 저장된다
				doc = Jsoup.connect(naverUrl).get();
//			
				news = doc.select("#contentarea_left > ul").html();
				

				title_ = null;
				title_ = news.split("title=\"");
				title = new ArrayList<String>();

				content_ = null;
				content_ = news.split("title=\"");
				content = new ArrayList<String>();

				
				writer_ = null;
				writer_ = news.split("title=\"");
				writer = new ArrayList<String>();

				time_ = null;
				time_ = news.split("<span class=\"wdate\">");
				time = new ArrayList<String>();
				
				url_ = null;
				url_ = news.split("class=\"articleSubject\"");
				url = new ArrayList<String>();
				
				img_ = null;
				img_ = news.split("title=\"");
				img_A = new String[img_.length];
				img = new ArrayList<String>();
				cnt = 0;
				
				
				for (int i = 0; i < title_.length; i++) {
					if(title_[i].indexOf("newsList top") == -1) {
						
					
						if(title_[i].contains("articleSubject") || title_[i].contains("articleSummary")) {
							if(title_[i].indexOf("\">\"") != -1) {
								end = title_[i].indexOf("\">\"");
							}else if(title_[i].indexOf("\">'") != -1) {
								end = title_[i].indexOf("\">'");
							}else {
								end = title_[i].indexOf("\">");
							}
							title_[i] = title_[i].substring(0, end);
							title_[i] = title_[i].replace("&quot;", "");
							title.add(title_[i]);
						}
					}
					
					if(content_[i].indexOf("class=\"articleSummary\">") != -1) {
						start = content_[i].indexOf("\"articleSummary\">");
						end = content_[i].indexOf(" <span class=\"press\">");
						content_[i] = content_[i].substring(start+22, end);
						content.add(content_[i]);
					}
					
					
					if(writer_[i].indexOf("<span class=\"press\">") != -1) {
						start = writer_[i].indexOf("<span class=\"press\">");
						end = writer_[i].indexOf("</span> <span class=\"bar\">");
						writer_[i] = writer_[i].substring(start+20, end);
						writer_[i] = writer_[i].replace("&quot;", "");
						writer.add(writer_[i]);
					}	
	
					
					if(time_[i].indexOf("newsList top") == -1) {
						end = time_[i].indexOf("</span>");
						time_[i] = time_[i].substring(0, end);
	//					time_[i] = time_[i].replace("&quot;", "");
						time.add(time_[i]);
					}	
					
//					if(i < url_.length) {
						if(url_[i].indexOf("newsList top") == -1) {
							start = url_[i].indexOf("<a href=\"");
							if(url_[i].indexOf("\" title=\"") != -1){
								end = url_[i].indexOf("\" title=\"");
								url_[i] = url_[i].substring(start+9, end);
							}else if(url_[i].indexOf("<img src=\"") != -1) {
								end = url_[i].indexOf("<img src=\"");
								url_[i] = url_[i].substring(start+9, end);
							}else continue;
							url_[i] = url_[i].replace("&quot;", "");
							url_[i] = url_[i].replace("amp;", "");
		
							url.add(url_[i]);
						}
					if(img_[i].indexOf("<a href=\"/") != -1) {
						if(img_[i].indexOf("<img src=\"") != -1) {
							img_A[cnt] = img_[i];	
							start = img_A[cnt].indexOf("<img src=\"");
							end = img_A[cnt].indexOf("alt=");
							img.add(img_A[cnt].substring(start+10, end-2));
							cnt++;
						}
						else {
							img.add(null);
							cnt++;
						}
					}	
				}
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("title", title);
				map2.put("content", content);
				map2.put("writer", writer);
				map2.put("time", time);
				map2.put("url", url);
				map2.put("img", img);
//				System.out.println(map2);
				inf.setNews2(map2);
				
				
				
				
				// 기업 종목분석
				naverUrl = "https://finance.naver.com/news/news_list.nhn?mode=LSS3D&section_id=101&section_id2=258&section_id3=402";
				doc = null; // Document에는 페이지의 전체 소스가 저장된다
				doc = Jsoup.connect(naverUrl).get();
//			
				news = doc.select("#contentarea_left > ul").html();
				

				title_ = null;
				title_ = news.split("title=\"");
				title = new ArrayList<String>();

				content_ = null;
				content_ = news.split("title=\"");
				content = new ArrayList<String>();

				
				writer_ = null;
				writer_ = news.split("title=\"");
				writer = new ArrayList<String>();

				time_ = null;
				time_ = news.split("<span class=\"wdate\">");
				time = new ArrayList<String>();
				
				url_ = null;
				url_ = news.split("class=\"articleSubject\"");
				url = new ArrayList<String>();
				
				img_ = null;
				img_ = news.split("title=\"");
				img_A = new String[img_.length];
				img = new ArrayList<String>();
				cnt = 0;
				
				
				for (int i = 0; i < title_.length; i++) {
					if(title_[i].indexOf("newsList top") == -1) {
						
					
						if(title_[i].contains("articleSubject") || title_[i].contains("articleSummary")) {
							if(title_[i].indexOf("\">\"") != -1) {
								end = title_[i].indexOf("\">\"");
							}else if(title_[i].indexOf("\">'") != -1) {
								end = title_[i].indexOf("\">'");
							}else {
								end = title_[i].indexOf("\">");
							}
							title_[i] = title_[i].substring(0, end);
							title_[i] = title_[i].replace("&quot;", "");
							title.add(title_[i]);
						}
					}
					
					if(content_[i].indexOf("class=\"articleSummary\">") != -1) {
						start = content_[i].indexOf("\"articleSummary\">");
						end = content_[i].indexOf(" <span class=\"press\">");
						content_[i] = content_[i].substring(start+22, end);
						content.add(content_[i]);
					}
					
					
					if(writer_[i].indexOf("<span class=\"press\">") != -1) {
						start = writer_[i].indexOf("<span class=\"press\">");
						end = writer_[i].indexOf("</span> <span class=\"bar\">");
						writer_[i] = writer_[i].substring(start+20, end);
						writer_[i] = writer_[i].replace("&quot;", "");
						writer.add(writer_[i]);
					}	
	
					
					if(time_[i].indexOf("newsList top") == -1) {
						end = time_[i].indexOf("</span>");
						time_[i] = time_[i].substring(0, end);
	//					time_[i] = time_[i].replace("&quot;", "");
						time.add(time_[i]);
					}	
					
//					if(i < url_.length) {
						if(url_[i].indexOf("newsList top") == -1) {
							start = url_[i].indexOf("<a href=\"");
							if(url_[i].indexOf("\" title=\"") != -1){
								end = url_[i].indexOf("\" title=\"");
								url_[i] = url_[i].substring(start+9, end);
							}else if(url_[i].indexOf("<img src=\"") != -1) {
								end = url_[i].indexOf("<img src=\"");
								url_[i] = url_[i].substring(start+9, end);
							}else continue;
							url_[i] = url_[i].replace("&quot;", "");
							url_[i] = url_[i].replace("amp;", "");
		
							url.add(url_[i]);
						}
					if(img_[i].indexOf("<a href=\"/") != -1) {
						if(img_[i].indexOf("<img src=\"") != -1) {
							img_A[cnt] = img_[i];	
							start = img_A[cnt].indexOf("<img src=\"");
							end = img_A[cnt].indexOf("alt=");
							img.add(img_A[cnt].substring(start+10, end-2));
							cnt++;
						}
						else {
							img.add(null);
							cnt++;
						}
					}	
				}
				Map<String, Object> map3 = new HashMap<String, Object>();
				map3.put("title", title);
				map3.put("content", content);
				map3.put("writer", writer);
				map3.put("time", time);
				map3.put("url", url);
				map3.put("img", img);
				inf.setNews3(map3);
				
				
				
				
				
				
//				inf.setNews2(news);
//
//				// 시황 전망
//				naverUrl = "https://finance.naver.com/news/news_list.nhn?mode=LSS3D&section_id=101&section_id2=258&section_id3=401";
//				doc = null; // Document에는 페이지의 전체 소스가 저장된다
//				doc = Jsoup.connect(naverUrl).get();
//					
//				news = doc.select("#contentarea_left > ul").html();
//				inf.setNews3(news);

				
			
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
