SELECT
  *
from
  GiangVien
where
  IDKV in (
    SELECT
      IDKV
    from
      KhoaVien
    where
      TenKV like N'%Vien CNTT&TT%'
  );

--2 
SELECT
  m.TenMB,
  gv.TenGV
from
  MonHoc
where
  IDMH in (
    SELECT
      dg.IDMH
    from
      GiangDay gd
    where
      IDGV in
    SELECT
      IDGV
    from
      GiangVien
    where
      TenGV like N'%Nguyen Van A%'
  )
  --3
SELECT
  count(*)
from
  KhoaVien
where
  TenKV like N'%Vien CNTT&TT%'
group by
  TenKV;

--4 
SELECT
  K.TenKV
FROM
  KhoaVien K
WHERE
  K.IDKV IN (
    SELECT
      GV.IDKV
    FROM
      GiangVien GV
    WHERE
      GV.IDGV IN (
        SELECT
          GD.IDGV
        FROM
          GiangDay GD
        WHERE
          GD.IDMH IN (
            SELECT
              MH.IDMH
            FROM
              MonHoc MH
            GROUP BY
              MH.IDMH
            HAVING
              COUNT(MH.IDMH) = (
                SELECT
                  MAX(MHCount)
                FROM
                  (
                    SELECT
                      COUNT(IDMH) AS MHCount
                    FROM
                      MonHoc
                    GROUP BY
                      IDMH
                  ) AS MHCounts
              )
          )
      )
  );

--c
DELETE from MonHoc
where
  IDMH = 'MH2010'
  --d
UPDATE GiangVien
SET
  DienThoai = 012345678
where
  IDGV = 'GV2011'