-- 1) Jumlah pend miskin dan rentan miskin jabar semua desil per kabkota

SELECT
    sum(case when percentile is null then 1 else 0 end) nondesil,
    sum(case when percentile between 0 and 10 then 1 else 0 end) desil1,
    sum(case when percentile between 11 and 20 then 1 else 0 end) desil2,
    sum(case when percentile between 21 and 30 then 1 else 0 end) desil3,
    sum(case when percentile between 31 and 40 then 1 else 0 end) desil4,
    sum(case when percentile > 40 then 1 else 0 end) "desil4+"    
FROM
    arts a JOIN krts b ON a.idbdt = b.idbdt

-- Sebaran kabupaten/kota

SELECT
    c.kabkota,
    sum(case when b.percentile is null then 1 else 0 end) nondesil,
    sum(case when b.percentile between 0 and 10 then 1 else 0 end) desil1,
    sum(case when b.percentile between 11 and 20 then 1 else 0 end) desil2,
    sum(case when b.percentile between 21 and 30 then 1 else 0 end) desil3,
    sum(case when b.percentile between 31 and 40 then 1 else 0 end) desil4,
    sum(case when b.percentile > 40 then 1 else 0 end) "desil4+"    
FROM
    arts a 
        JOIN krts b ON a.idbdt = b.idbdt
        JOIN wilayah2020 c ON left(a.kode_kel, 4) = left(c.kode_wilayah, 4)
GROUP BY
    1

-- 2) Jumlah RT miskin dan rentan miskin dengan krt perempuan desil 1-4+ per kabkota 
SELECT DISTINCT ON (b.idbdt)
    
FROM
    krts a 
        JOIN arts b ON a.idbdt = b.idbdt
        JOIN wilayah2020 c ON left(a.kode_kel, 4) = left(c.kode_wilayah, 4)
WHERE
    b.jnskel = 2
ORDER BY
    b.idbdt, hub_krt
