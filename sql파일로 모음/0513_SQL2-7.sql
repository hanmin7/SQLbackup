---SQL2-   7강   ----------------------------------
--정규화표현식

--메타문자
--labs에서 q1~~~

SELECT * FROM t1;

SELECT fname, lname
FROM t1
WHERE REGEXP_LIKE (fname, '^Ste(v|ph)en$');
--Steven Stephen 찾기  LIKE 확장판느낌.


SELECT fname, phone
FROM t1
WHERE REGEXP_LIKE (phone, '...\...\.....\.......');
--\. 은 진짜 점    보통.은 한칸의 문자표현


SELECT fname, phone
FROM t1
WHERE REGEXP_LIKE (phone, '[0-9]{3}\.[0-9]{2}\.[0-9]{4}\.[0-9]{6}');
--[0-9] 0에서9사이 {3}3개나오고~~~ 마지막에도 0-9 숫자 6개있는 거 찾기

SELECT fname, phone
FROM t1
WHERE REGEXP_LIKE (phone, '\d{3}\.\d{2}\.\d{4}\.\d{6}');
--위의 범주로 나타내거나 \d로도 같은 값 가능



SELECT fname, phone, REGEXP_REPLACE ( phone , '\.' , '-' ) new_format
FROM t1;


SELECT fname, phone,
REGEXP_REPLACE (phone, '(\d{3})\.(\d{3})\.(\d{4})','(\1)-\2-\3') new_phone
FROM t1;


--이전에 instr
SELECT INSTR('helloworld', 'l'),
          INSTR('helloworld', 'l', 1, 3), --첫글자부터 3번째 l의 위치(근데 여기서 이것도 메타문자임)
          INSTR('helloworld', 'a')
FROM dual;
--------------------------

SELECT fname, addr,
REGEXP_INSTR ( addr, '[[:alpha:]]' ) pos ,
phone,
REGEXP_INSTR ( phone, '[[:alpha:]]') pos
FROM t1;


--q7  substr
SELECT fname, addr,
REGEXP_SUBSTR ( addr, ' [^ ]+ ') road
FROM t1;
--공백과공백사이 글자 즉 거리명만 뽑아냄.


SELECT fname, phone,
REGEXP_SUBSTR(phone,'\.(\d{3})\.') code
FROM t1;


SELECT fname, phone,
REPLACE(REGEXP_SUBSTR(phone,'\.(\d{3})\.'),'.') code
FROM t1;
--.과 .사이 숫자 추출
--그냥 substr만 쓰면 .도 같이 나오게되어서 replace써서 중첩사용했음.
--replace( 값, 값에서 변환 할문자, 대치할 문자
-- 저기식에서는 대치할 문자를 널값으로 할꺼라 생략함.


SELECT fname, addr,
REGEXP_COUNT(addr,'a') cnt
FROM t1;


SELECT REGEXP_SUBSTR ('0123456789',
'(123)(4(56)(78))', 1, 1, 'i', 1 ) "Exp1" ,
REGEXP_SUBSTR ('0123456789',
'(123)(4(56)(78))', 1, 1, 'i', 2 ) "Exp2" ,
REGEXP_SUBSTR ('0123456789',
'(123)(4(56)(78))', 1, 1, 'i', 3 ) "Exp3" ,
REGEXP_SUBSTR ('0123456789',
'(123)(4(56)(78))', 1, 1, 'i', 4 ) "Exp4"
FROM dual;
--서브표현식


SELECT REGEXP_INSTR ('0123456789',
'(123)(4(56)(78))', 1, 1, 0, 'i', 2 ) "Position"
FROM dual;
--위치값 2번 서브표현식의 시작이 어디냐
--2번식인 45678 의 시작이 '0123456789'에서 5번째에 나오니까. 5반환.

SELECT
REGEXP_INSTR('ccacctttccctccactcctcacgttctcacctgtaaagcgtccctc
cctcatccccatgcccccttaccctgcagggtagagtaggctagaaaccagagagctccaagc
tccatctgtggagaggtgccatccttgggctgcagagagaggagaatttgccccaaagctgcc
tgcagagcttcaccacccttagtctcacaaagccttgagttcatagcatttcttgagttttca
ccctgcccagcaggacactgcagcacccaaagggcttcccaggagtagggttgccctcaagag
gctcttgggtctgatggccacatcctggaattgttttcaagttgatggtcacagccctgaggc
atgtaggggcgtggggatgcgctctgctctgctctcctctcctgaacccctgaaccctctggc
taccccagagcacttagagccag',
'(gtc(tcac)(aaag))',
1, 1, 0, 'i',
1) "Position"
FROM dual;
--(gtctcacaaag)이게 나오면서 1번식 gtc가 나오는 위치 묻는거.



SELECT REGEXP_COUNT(
'ccacctttccctccactcctcacgttctcacctgtaaagcgtccctccctcatccccatgcccccttaccctgcag
ggtagagtaggctagaaaccagagagctccaagctccatctgtggagaggtgccatccttgggctgcagagagaggag
aatttgccccaaagctgcctgcagagcttcaccacccttagtctcacaaagccttgagttcatagcatttcttgagtt
ttcaccctgcccagcaggacactgcagcacccaaagggcttcccaggagtagggttgccctcaagaggctcttgggtc
tgatggccacatcctggaattgttttcaagttgatggtcacagccctgaggcatgtaggggcgtggggatgcgctctg
ctctgctctcctctcctgaacccctgaaccctctggctaccccagagcacttagagccag',
'gtc') AS Count
FROM dual;