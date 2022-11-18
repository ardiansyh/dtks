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
    a.kdkab,
    sum(case when b.percentile is null then 1 else 0 end) nondesil,
    sum(case when b.percentile between 0 and 10 then 1 else 0 end) desil1,
    sum(case when b.percentile between 11 and 20 then 1 else 0 end) desil2,
    sum(case when b.percentile between 21 and 30 then 1 else 0 end) desil3,
    sum(case when b.percentile between 31 and 40 then 1 else 0 end) desil4,
    sum(case when b.percentile > 40 then 1 else 0 end) "desil4+"    
FROM
    arts a 
        JOIN krts b ON a.idbdt = b.idbdt
GROUP BY
    1

-- 2) Jumlah RT miskin dan rentan miskin dengan krt perempuan desil 1-4+ per kabkota 
SELECT
    kdkab,
    sum(case when percentile between 0 and 10 then 1 else 0 end) desil1,
    sum(case when percentile between 11 and 20 then 1 else 0 end) desil2,
    sum(case when percentile between 21 and 30 then 1 else 0 end) desil3,
    sum(case when percentile between 31 and 40 then 1 else 0 end) desil4,
    sum(case when percentile > 40 then 1 else 0 end) "desil4+"    
FROM
    (SELECT DISTINCT ON (b.idbdt)
        a.percentile,
        b.*,
    FROM
        krts a JOIN arts b ON a.idbdt = b.idbdt
    WHERE
        b.jnskel = 2
    ORDER BY
        b.idbdt, b.hub_krt) t
GROUP BY
    1

-- 3) Komposisi pend miskin dan rentan miskin menurut kelompok usia dan jenis kelamin
SELECT
    jnskel,
    sum(case when percentile between 0 and 10 then 1 else 0 end) desil1,
    sum(case when percentile between 11 and 20 then 1 else 0 end) desil2,
    sum(case when percentile between 21 and 30 then 1 else 0 end) desil3,
    sum(case when percentile between 31 and 40 then 1 else 0 end) desil4,
    sum(case when percentile > 40 then 1 else 0 end) "desil4+"    
FROM
    krts a JOIN arts b ON a.idbdt = b.idbdt
WHERE
    -- (umur+1) < 7
    -- (umur+1) between 7 and 12
    -- (umur+1) between 13 and 15
    -- (umur+1) between 16 and 18
    -- (umur+1) between 19 and 23
    -- (umur+1) between 24 and 59
    -- (umur+1) > 59
GROUP BY
    1

-- 4) Jumlah anak dari rumah tangga miskin dan rentan miskin yang tidak bersekolah usia 7-18 tahun per kabkota
SELECT
    kdkab,
    sum(case when percentile between 0 and 10 then 1 else 0 end) desil1,
    sum(case when percentile between 11 and 20 then 1 else 0 end) desil2,
    sum(case when percentile between 21 and 30 then 1 else 0 end) desil3,
    sum(case when percentile between 31 and 40 then 1 else 0 end) desil4,
    sum(case when percentile > 40 then 1 else 0 end) "desil4+" 
FROM
    krts a JOIN arts b ON a.idbdt = b.idbdt
WHERE
    ((umur+1) between 7 and 18) and partisipasi_sekolah in (0, 2)
GROUP BY
    1

-- 5) Jumlah pend miskin dan rentan miskin yang tidak bekerja menurut kelompok usia 15-59 tahun per kabkota
SELECT
    kdkab,
    sum(case when percentile between 0 and 10 then 1 else 0 end) desil1,
    sum(case when percentile between 11 and 20 then 1 else 0 end) desil2,
    sum(case when percentile between 21 and 30 then 1 else 0 end) desil3,
    sum(case when percentile between 31 and 40 then 1 else 0 end) desil4,
    sum(case when percentile > 40 then 1 else 0 end) "desil4+" 
FROM
    krts a JOIN arts b ON a.idbdt = b.idbdt
WHERE
    ((umur+1) between 15 and 59) and sta_bekerja = 2

-- 6) Jumlah pend miskin dan rentan miskin usia 15-59 tahun yang bekerja menurut lapangan usaha per kabkota
SELECT
    kdkab,
    sum(case when lapangan_usaha = 1 then 1 else 0 end) pertanian,
    sum(case when lapangan_usaha = 1 then 1 else 0 end) pertanian,
    
FROM
    krts a JOIN arts b ON a.idbdt = b.idbdt
WHERE
    ((umur+1) between 15 and 59) and sta_bekerja = 1

-- 7) Jumlah RT miskin dan rentan miskin yang mempunyai rutilahu per kabkota
SELECT
    kdkab,
    sum(case when percentile between 0 and 10 then 1 else 0 end) desil1,
    sum(case when percentile between 11 and 20 then 1 else 0 end) desil2,
    sum(case when percentile between 21 and 30 then 1 else 0 end) desil3,
    sum(case when percentile between 31 and 40 then 1 else 0 end) desil4,
    sum(case when percentile > 40 then 1 else 0 end) "desil4+" 
FROM
    krts
WHERE
    (dinding in (2, 3, 4, 5, 6, 7) or
	atap in (5, 6, 7, 8, 9, 10) or
	lantai in (6, 7, 8, 9, 10) or
	luas_lantai < 8) and sta_lahan = 1 and fasbab = 4 
