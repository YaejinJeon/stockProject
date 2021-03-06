import pymysql
import win32com.client
import datetime

g_objCodeMgr = win32com.client.Dispatch('CpUtil.CpCodeMgr')
g_objCpStatus = win32com.client.Dispatch('CpUtil.CpCybos')
g_name = win32com.client.Dispatch('CpUtil.CpStockCode')


class CpStockChart:

    def __init__(self):
        self.objStockChart = win32com.client.Dispatch("CpSysDib.StockChart")

    # 차트 요청 - 기간 기준으로
    def RequestFromTo(self, code, fromDate, toDate, caller):
        # 연결 여부 체크
        bConnect = g_objCpStatus.IsConnect
        if (bConnect == 0):
            print("PLUS가 정상적으로 연결되지 않음. ")
            return False

        self.objStockChart.SetInputValue(0, code)  # 종목코드
        self.objStockChart.SetInputValue(1, ord('1'))  # 기간으로 받기
        self.objStockChart.SetInputValue(2, toDate)  # To 날짜
        self.objStockChart.SetInputValue(3, fromDate)  # From 날짜
        # self.objStockChart.SetInputValue(4, 500)  # 최근 500일치
        self.objStockChart.SetInputValue(5, [0, 2, 3, 4, 5, 8])  # 날짜,시가,고가,저가,종가,거래량
        self.objStockChart.SetInputValue(6, ord('D'))  # '차트 주기 - 일간 차트 요청
        self.objStockChart.SetInputValue(9, ord('1'))  # 수정주가 사용
        self.objStockChart.BlockRequest()

        rqStatus = self.objStockChart.GetDibStatus()
        rqRet = self.objStockChart.GetDibMsg1()
        if rqStatus != 0:
            exit()

        len = self.objStockChart.GetHeaderValue(3)

        caller.dates = []
        caller.opens = []
        caller.highs = []
        caller.lows = []
        caller.closes = []
        caller.vols = []
        for i in range(len):
            caller.dates.append(self.objStockChart.GetDataValue(0, i))
            caller.opens.append(self.objStockChart.GetDataValue(1, i))
            caller.highs.append(self.objStockChart.GetDataValue(2, i))
            caller.lows.append(self.objStockChart.GetDataValue(3, i))
            caller.closes.append(self.objStockChart.GetDataValue(4, i))
            caller.vols.append(self.objStockChart.GetDataValue(5, i))


    # 차트 요청 - 최근일 부터 개수 기준
    def RequestDWM(self, code, dwm, count, caller):
        # 연결 여부 체크
        bConnect = g_objCpStatus.IsConnect
        if (bConnect == 0):
            print("PLUS가 정상적으로 연결되지 않음. ")
            return False

        self.objStockChart.SetInputValue(0, code)  # 종목코드
        self.objStockChart.SetInputValue(1, ord('2'))  # 개수로 받기
        self.objStockChart.SetInputValue(4, count)  # 최근 500일치
        self.objStockChart.SetInputValue(5, [0, 2, 3, 4, 5, 8])  # 요청항목 - 날짜,시가,고가,저가,종가,거래량
        self.objStockChart.SetInputValue(6, dwm)  # '차트 주기 - 일/주/월
        self.objStockChart.SetInputValue(9, ord('1'))  # 수정주가 사용
        self.objStockChart.BlockRequest()

        rqStatus = self.objStockChart.GetDibStatus()
        rqRet = self.objStockChart.GetDibMsg1()
        if rqStatus != 0:
            exit()

        len = self.objStockChart.GetHeaderValue(3)

        caller.dates = []
        caller.opens = []
        caller.highs = []
        caller.lows = []
        caller.closes = []
        caller.vols = []
        caller.times = []
        for i in range(len):
            caller.dates.append(self.objStockChart.GetDataValue(0, i))
            caller.opens.append(self.objStockChart.GetDataValue(1, i))
            caller.highs.append(self.objStockChart.GetDataValue(2, i))
            caller.lows.append(self.objStockChart.GetDataValue(3, i))
            caller.closes.append(self.objStockChart.GetDataValue(4, i))
            caller.vols.append(self.objStockChart.GetDataValue(5, i))



        return

    # 차트 요청 - 분간, 틱 차트
    def RequestMT(self, code, dwm, count, caller):
        # 연결 여부 체크
        bConnect = g_objCpStatus.IsConnect
        if (bConnect == 0):
            print("PLUS가 정상적으로 연결되지 않음. ")
            return False

        self.objStockChart.SetInputValue(0, code)  # 종목코드
        self.objStockChart.SetInputValue(1, ord('2'))  # 개수로 받기
        self.objStockChart.SetInputValue(4, count)  # 조회 개수
        self.objStockChart.SetInputValue(5, [0, 1, 2, 3, 4, 5, 8])  # 요청항목 - 날짜, 시간,시가,고가,저가,종가,거래량
        self.objStockChart.SetInputValue(6, dwm)  # '차트 주기 - 분/틱
        self.objStockChart.SetInputValue(7, 1)  # 분틱차트 주기
        self.objStockChart.SetInputValue(9, ord('1'))  # 수정주가 사용
        self.objStockChart.BlockRequest()

        rqStatus = self.objStockChart.GetDibStatus()
        rqRet = self.objStockChart.GetDibMsg1()
        if rqStatus != 0:
            exit()

        len = self.objStockChart.GetHeaderValue(3)

        caller.dates = []
        caller.opens = []
        caller.highs = []
        caller.lows = []
        caller.closes = []
        caller.vols = []
        caller.times = []
        for i in range(len):
            caller.dates.append(self.objStockChart.GetDataValue(0, i))
            caller.times.append(self.objStockChart.GetDataValue(1, i))
            caller.opens.append(self.objStockChart.GetDataValue(2, i))
            caller.highs.append(self.objStockChart.GetDataValue(3, i))
            caller.lows.append(self.objStockChart.GetDataValue(4, i))
            caller.closes.append(self.objStockChart.GetDataValue(5, i))
            caller.vols.append(self.objStockChart.GetDataValue(6, i))
        return


class FastApi():

    def __init__(self):
        self.dates = []
        self.opens = []
        self.highs = []
        self.lows = []
        self.closes = []
        self.vols = []
        self.times = []

        # FastApi.codeSet = '004980'

    def makeChart(self, codeSet, fileName):
        self.objChart = CpStockChart()
        stockCode = g_name.NameToCode(codeSet)
        self.setCode(stockCode)
        try:
            print("setcode: " + self.code)
        except:
            self.code = "Q" + FastApi.codeSet

        self.objChart.RequestDWM(self.code, ord('D'), 60, self)  # 일차트 (갯수)
        conn = pymysql.connect(host='localhost', user='stock', password='stock', db='stock', charset='utf8')
        try:
            with conn.cursor() as curs:
                sql = 'delete from daychart where stockname=%s'
                curs.execute(sql, codeSet)
            conn.commit()
            with conn.cursor() as curs:
                sql = 'insert into daychart values(%s, %s, %s, %s, %s, %s, %s);'
                for i in range(0, len(self.dates)):
                    curs.execute(sql, (codeSet, i,
                                       self.dates[i], self.opens[i], self.highs[i], self.lows[i], self.closes[i]))
            conn.commit()
        finally:
            conn.close()

        self.objChart.RequestMT(self.code, ord('m'), 60, self)  # 분차트
        conn = pymysql.connect(host='localhost', user='stock', password='stock', db='stock', charset='utf8')
        try:
            with conn.cursor() as curs:
                sql = 'delete from minutechart where stockname=%s'
                curs.execute(sql, codeSet)
            conn.commit()
            with conn.cursor() as curs:
                sql = 'insert into minutechart values(%s, %s, %s, %s, %s, %s, %s, %s)'
                for i in range(0, len(self.dates)):
                    curs.execute(sql, (codeSet,
                                       i, self.dates[i], self.times[i], self.opens[i], self.highs[i], self.lows[i],
                                       self.closes[i]))
            conn.commit()
        finally:
            conn.close()
        print(datetime.datetime.now())


    def codeEditChanged(self):
        code = self.codeEdit.text()
        self.setCode(code)

    def setCode(self, code):
        if len(code) < 6:
            return

        if not (code[0] == "A"):
            code = "A" + code

        name = g_objCodeMgr.CodeToName(code)

        if len(name) == 0:
            print("종목코드 확인")
            return

        self.code = code
