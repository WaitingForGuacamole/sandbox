DECLARE @loop INT = 0, @limit INT = 100000;
DECLARE @rownum int, @pzjar varchar(128), @pzpackage varchar(256), @pzclass varchar(256), @pzpatchdata datetime;
DECLARE @scratch VARBINARY(MAX);

DECLARE @classes TABLE(
	rownum int PRIMARY KEY IDENTITY(1, 1), 
	pzjar varchar(128), 
	pzpackage varchar(256), 
	pzclass varchar(256), 
	pzpatchdate datetime
);
INSERT INTO @classes SELECT pzjar, pzpackage, pzclass, pzpatchdate 
	FROM PegaRULES870.pr_engineclasses;

DECLARE @classCount int = (SELECT COUNT(*) from @classes);

DECLARE @start datetime = GETDATE();

WHILE @loop < @limit
BEGIN
   SELECT @rownum = ROUND(RAND()*@classCount, 0);
   SELECT @pzjar = pzjar, @pzpackage = pzpackage, @pzclass = pzclass FROM @classes WHERE rownum = @rownum;
   SELECT TOP 1 @scratch = pzbinarycontent FROM PegaRULES870.pr_engineclasses WHERE 
		pzjar = @pzjar AND pzpackage = @pzpackage AND pzclass = @pzclass;

   SET @loop = @loop + 1;
END;

DECLARE @elapsed float = DATEDIFF(MILLISECOND, @start, GETDATE())/1000.00;
SELECT @limit AS iterations, @elapsed AS elapsed;
