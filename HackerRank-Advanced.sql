DECLARE @i INT = 20
WHILE (@i > 0) 
BEGIN
   PRINT REPLICATE('* ', @i) 
   SET @i = @i - 1
END


SELECT GROUP_CONCAT(NUMB SEPARATOR '&')
FROM (
    SELECT @num:=@num+1 as NUMB FROM
    information_schema.tables t1,
    information_schema.tables t2,
    (SELECT @num:=1) tmp
) tempNum
WHERE NUMB<=1000 AND NOT EXISTS(
      SELECT * FROM (
         SELECT @nu:=@nu+1 as NUMA FROM
             information_schema.tables t1,
             information_schema.tables t2,
             (SELECT @nu:=1) tmp1
             LIMIT 1000
         ) tatata
      WHERE FLOOR(NUMB/NUMA)=(NUMB/NUMA) AND NUMA<NUMB AND NUMA>1
   )



SELECT T1.SUBMISSION_DATE, HKR_CNT, T2.HACKER_ID, NAME
FROM (SELECT P1.SUBMISSION_DATE, 
             COUNT(DISTINCT P1.HACKER_ID) AS HKR_CNT
      FROM (SELECT SUBMISSION_DATE, HACKER_ID, 
                   @H_RNK := CASE WHEN @H_GRP != HACKER_ID THEN 1 ELSE @H_RNK+1 END AS HACKER_RANK,
                   @H_GRP := HACKER_ID AS HACKER_GROUP
            FROM (SELECT DISTINCT SUBMISSION_DATE, HACKER_ID 
                  FROM SUBMISSIONS
                  ORDER BY HACKER_ID, SUBMISSION_DATE) AS A, 
                 (SELECT @H_RNK := 1, @H_GRP := 0) AS R) AS P1
      JOIN (SELECT SUBMISSION_DATE, 
                   @D_RNK := @D_RNK + 1 AS DATE_RANK
            FROM (SELECT DISTINCT SUBMISSION_DATE
                  FROM SUBMISSIONS 
                  ORDER BY SUBMISSION_DATE) AS B, 
                 (SELECT @D_RNK := 0) R) AS P2
      ON P1.SUBMISSION_DATE = P2.SUBMISSION_DATE 
         AND HACKER_RANK = DATE_RANK
      GROUP BY P1.SUBMISSION_DATE) AS T1
JOIN (SELECT SUBMISSION_DATE, HACKER_ID, SUB_CNT,
             @S_RNK := CASE WHEN @D_GRP != SUBMISSION_DATE THEN 1 ELSE @S_RNK+1 END AS MAX_RNK,
             @D_GRP := SUBMISSION_DATE AS DATE_GROUP
      FROM (SELECT SUBMISSION_DATE, HACKER_ID, COUNT(*) AS SUB_CNT
            FROM SUBMISSIONS AS S
            GROUP BY SUBMISSION_DATE, HACKER_ID
            ORDER BY SUBMISSION_DATE, SUB_CNT DESC, HACKER_ID) AS C,
           (SELECT @S_RNK := 1, @D_GRP := 0) AS R) AS T2                            
ON T1.SUBMISSION_DATE = T2.SUBMISSION_DATE AND MAX_RNK = 1
JOIN HACKERS AS H ON H.HACKER_ID = T2.HACKER_ID            
ORDER BY T1.SUBMISSION_DATE
;


SELECT RPAD('* ',LEVEL*2,'* ') FROM DUAL CONNECT BY LEVEL <=20;
