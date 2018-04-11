#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Aug 29 22:30:46 2017
@author: Fe (kimch0627@gamil.com)
"""
"""
[파일 용도]
 : CSV 파일의 한 셀에 개행이 여러개 들어 있는 경우, 개행이 들어 있는 셀을 행 별로 분리 시킴
"""

import sys
import csv

def Read_CSV_file_to_list (file_name):
    '''
    [함수] 파일명을 인자로 받아서, csv 파일의 값을 list로 출력
    Input: String
    Output: List_in_List_in_String
    '''
    CSV_List = []
    with open(file_name, 'r', encoding='utf-8-sig') as csv_file:
        for row in csv.reader(csv_file):
            CSV_List.append(row)

    return CSV_List

def Check_each_column_count(Listed_string):
    '''
    [함수] 각 줄 별로 열의 개수가 모두 같은지 확인
    Input: List_in_List_in_String
    Output: Boolean
    '''
    Column_Count = 0

    for Index, Each_Line in enumerate(Listed_string):
        if Index == 0:
            Column_Count = len(Each_Line)
        else:
            if len(Each_Line) != Column_Count:
                print("[오류] " + str(Index - 1) + "번째줄과 " + str(Index) + "번째줄의 열(Column) 개수가 다름니다.")
                return False
            else:
                Column_Count = len(Each_Line)

    return True

def Make_newline(Listed_string, Separator='\n'):
    '''
    [함수] 텍스트 처리
    Input: List_in_List_in_String
    Output: List_in_List_in_String
    '''
    parsed_string = []

    for Each_Line in Listed_string:

        Newline_Count = 0

        for Each_Column in Each_Line:
            if Each_Column.count(Separator) > Newline_Count:
                Newline_Count = Each_Column.count(Separator) + 1

        if Newline_Count == 0:
            parsed_string.append(Each_Line)
        else:
            for Seq in range(0, Newline_Count):
                Temp_Line_List = []

                for Each_Column in Each_Line:
                    try:
                        Temp_Line_List.append(Each_Column.split(Separator)[Seq])
                    except:
                        Temp_Line_List.append("")

                parsed_string.append(Temp_Line_List)

    # return type is "list in list in string"
    return parsed_string

def CSV_list_to_string(Listed_string):
    '''
    [함수] list to string
    Input: List_in_List_in_String
    Output: String
    '''
    result_string = ''

    for Each_Line in Listed_string:
        result_string += ",".join(Each_Line) + "\n"

    return result_string[:-1]

# [Main] 단독 실행시 동작
if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("== make_csv_newline ==")
        print("<용도> CSV 파일의 한 셀에 개행이 여러개 들어 있는 경우, 개행이 들어 있는 셀을 행 별로 분리 시킴.")
        print("<사용법-1> make_csv_newline.py TEST.csv [구분자]")
        print("<사용법-2> python make_csv_newline.py TEST.csv [구분자]\n")
        print("<예시> TEST.csv 파일에서 콤마(,)로 구분된 문자를 개행")
        print("      → python make_csv_newline.py TEST.csv ','")
        sys.exit()

    # csv 파일의 텍스트값 불러오기 (string → list)
    #UTF8_String = FileReadToString(sys.argv[1])
    #Before_CSV_List = Read_CSV_file_to_list(UTF8_String)
    Before_CSV_List = Read_CSV_file_to_list(sys.argv[1])

    if Check_each_column_count(Before_CSV_List) == True:
        result_List = Make_newline(Before_CSV_List, Separator=sys.argv[2])
        result_String = CSV_list_to_string(result_List)
        print(result_String)
    else:
        sys.exit()
