USE [Northwind]
GO
/****** Object:  StoredProcedure [dbo].[spTelefonFormatlama]    Script Date: 22.09.2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author      : <BEKİR BERAT KAMACI>
-- Create date : <22.09.2022>
-- Description : <Farklı formatlarda ve çeşitli karakterlerle birlikte girilen telefon numaraları tek bir formata dönüştürülür>
-- =============================================
ALTER PROCEDURE [dbo].[spTelefonFormatlama]  
	 @Phone VARCHAR(50)   -- Girilecek Telefon numarası
AS

BEGIN
	SET NOCOUNT ON;

    WHILE PATINDEX('%[^0-9]%', @Phone) > 0	-- Girilen numarada [^0-9] karakterleri bulunduğu sürece döngüye girilir
    BEGIN
        SET @Phone = STUFF(@Phone, PATINDEX('%[^0-9]%', @Phone), 1, '')   -- Girilen numara [^0-9] karakterlerinden arındırılır. 
    END
    
SET @Phone = (

CASE 

WHEN len(@Phone)=10   -- Eğer numara yabancı karakterler hariç 10 haneli ise (530 123 12 12 gibi) bu durum uygulanır

THEN LEFT(@Phone, 3) + ' ' + 

SUBSTRING(@Phone, 4,3) + ' ' + 

SUBSTRING(@Phone, 7,2) + ' ' + 

RIGHT(@Phone,2) 


WHEN len(@Phone)=11   -- Eğer numara yabancı karakterler hariç 11 haneli ise (0530 123 12 12 gibi) bu durum uygulanır

THEN SUBSTRING(@Phone, 2,3) + ' ' + 

SUBSTRING(@Phone, 5,3) + ' ' + 

SUBSTRING(@Phone, 8,2) + ' ' + 

RIGHT(@Phone,2) 


WHEN len(@Phone)=12   -- Eğer numara yabancı karakterler hariç 12 haneli ise (90 530 123 12 12 gibi) bu durum uygulanır

THEN SUBSTRING(@Phone, 3,3) + ' ' + 

SUBSTRING(@Phone, 6,3) + ' ' + 

SUBSTRING(@Phone, 9,2) + ' ' + 

RIGHT(@Phone,2) 

ELSE @Phone 

END

);

SELECT @Phone

END
