package stockCode;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

public class RequestChart {
	String onOff = "OFF";
	public void connection(String stockName) {
		if(onOff.equals("OFF"))
			return;
		BufferedReader bin;
		Connection conn;
		PreparedStatement pstmt;
		ResultSet rs;
		String squery;
		String stockCode = null;
		try {
			Socket sock = new Socket("192.168.1.100", 8000);
			// 키보드 데이터 입력 객체 생성
			InputStreamReader inK = new InputStreamReader(System.in);
			BufferedReader keyboard = new BufferedReader(inK);

			// 통신 스트림 객체
			OutputStream out = sock.getOutputStream();
			OutputStreamWriter outW = new OutputStreamWriter(out);
			PrintWriter pw = new PrintWriter(outW);

			InputStream in = sock.getInputStream();
			InputStreamReader inR = new InputStreamReader(in);
			BufferedReader br = new BufferedReader(inR);

			pw.print(stockName);

			pw.flush();
			String echo = br.readLine();
			System.out.print(echo+" => ");
//
//			long end = System.currentTimeMillis();
//
//			System.out.println(end / 1000);
//			System.out.println(end - start);

			pw.close();
			outW.close();
			out.close();
			br.close();
			inR.close();
			in.close();
			sock.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}
}
