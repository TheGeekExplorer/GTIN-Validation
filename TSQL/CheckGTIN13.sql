 CREATE FUNCTION [dbo].[CheckGTIN13]
(
  @gtin AS VARCHAR(20)
) 
RETURNS SMALLINT
AS BEGIN
DECLARE @gtinLength int;
DECLARE @modifier int;
DECLARE @gtinMaths NVARCHAR(17) = '31313131313131313';
DECLARE @tmpChecksum int = 0;
DECLARE @tmpCheckDigit int = 0;
DECLARE @CheckDigitArray TABLE
(
	i int,
	c char
)

IF ISNUMERIC(@gtin)<>1
BEGIN
 return 0;
END
ELSE
BEGIN

SELECT @gtinLength = LEN(@gtin);
IF @gtinLength != 13
BEGIN
	return 0;
END

SELECT @modifier = 17 - (@gtinLength - 1);

DECLARE @i int = 0;
WHILE(@i< (@gtinLength - 1))
BEGIN
	INSERT INTO @CheckDigitArray SELECT @modifier + @i,SUBSTRING(@gtin,@i + 1 ,1)
	SELECT @i = @i+1;
END

set @i = @modifier;
WHILE(@i <17)
BEGIN
DECLARE @c int;
SELECT @c = CAST(c as INT) FROM  @CheckDigitArray where i = @i;
	SELECT @tmpChecksum = @tmpChecksum + (@c * CAST(SUBSTRING(@gtinMaths,@i + 1,1) as INT));
	SELECT @i = @i+1;
END
SELECT @tmpCheckDigit = ( CEILING(CAST(@tmpChecksum as FLOAT) / 10) * 10) - @tmpChecksum;
END
return IIF( RIGHT(@gtin,1) = @tmpCheckDigit,1,0)
END