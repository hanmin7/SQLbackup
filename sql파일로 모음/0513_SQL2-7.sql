---SQL2-   7��   ----------------------------------
--����ȭǥ����

--��Ÿ����
--labs���� q1~~~

SELECT * FROM t1;

SELECT fname, lname
FROM t1
WHERE REGEXP_LIKE (fname, '^Ste(v|ph)en$');
--Steven Stephen ã��  LIKE Ȯ���Ǵ���.


SELECT fname, phone
FROM t1
WHERE REGEXP_LIKE (phone, '...\...\.....\.......');
--\. �� ��¥ ��    ����.�� ��ĭ�� ����ǥ��


SELECT fname, phone
FROM t1
WHERE REGEXP_LIKE (phone, '[0-9]{3}\.[0-9]{2}\.[0-9]{4}\.[0-9]{6}');
--[0-9] 0����9���� {3}3��������~~~ ���������� 0-9 ���� 6���ִ� �� ã��

SELECT fname, phone
FROM t1
WHERE REGEXP_LIKE (phone, '\d{3}\.\d{2}\.\d{4}\.\d{6}');
--���� ���ַ� ��Ÿ���ų� \d�ε� ���� �� ����



SELECT fname, phone, REGEXP_REPLACE ( phone , '\.' , '-' ) new_format
FROM t1;


SELECT fname, phone,
REGEXP_REPLACE (phone, '(\d{3})\.(\d{3})\.(\d{4})','(\1)-\2-\3') new_phone
FROM t1;


--������ instr
SELECT INSTR('helloworld', 'l'),
          INSTR('helloworld', 'l', 1, 3), --ù���ں��� 3��° l�� ��ġ(�ٵ� ���⼭ �̰͵� ��Ÿ������)
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
--������������ ���� �� �Ÿ��� �̾Ƴ�.


SELECT fname, phone,
REGEXP_SUBSTR(phone,'\.(\d{3})\.') code
FROM t1;


SELECT fname, phone,
REPLACE(REGEXP_SUBSTR(phone,'\.(\d{3})\.'),'.') code
FROM t1;
--.�� .���� ���� ����
--�׳� substr�� ���� .�� ���� �����ԵǾ replace�Ἥ ��ø�������.
--replace( ��, ������ ��ȯ �ҹ���, ��ġ�� ����
-- ����Ŀ����� ��ġ�� ���ڸ� �ΰ����� �Ҳ��� ������.


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
--����ǥ����


SELECT REGEXP_INSTR ('0123456789',
'(123)(4(56)(78))', 1, 1, 0, 'i', 2 ) "Position"
FROM dual;
--��ġ�� 2�� ����ǥ������ ������ ����
--2������ 45678 �� ������ '0123456789'���� 5��°�� �����ϱ�. 5��ȯ.

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
--(gtctcacaaag)�̰� �����鼭 1���� gtc�� ������ ��ġ ���°�.



SELECT REGEXP_COUNT(
'ccacctttccctccactcctcacgttctcacctgtaaagcgtccctccctcatccccatgcccccttaccctgcag
ggtagagtaggctagaaaccagagagctccaagctccatctgtggagaggtgccatccttgggctgcagagagaggag
aatttgccccaaagctgcctgcagagcttcaccacccttagtctcacaaagccttgagttcatagcatttcttgagtt
ttcaccctgcccagcaggacactgcagcacccaaagggcttcccaggagtagggttgccctcaagaggctcttgggtc
tgatggccacatcctggaattgttttcaagttgatggtcacagccctgaggcatgtaggggcgtggggatgcgctctg
ctctgctctcctctcctgaacccctgaaccctctggctaccccagagcacttagagccag',
'gtc') AS Count
FROM dual;