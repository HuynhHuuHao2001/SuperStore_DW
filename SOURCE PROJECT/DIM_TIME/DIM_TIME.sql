create table Dim_Time
(
OrderDate    datetime    primary key,
OrderMonth    int,
OrderYear    int,
OrderQuarter    int
)

CREATE PROCEDURE InsertTableDimTime
As
Begin
Declare @Smalldate datetime
Declare @MaxDate datetime    
    delete from Dim_Time
    select @Smalldate= Min(OrderDate) from Fact
    select @MaxDate= Max(OrderDate) from Fact
    WHILE (@SmallDate<=@MaxDate)
    BEGIN    
       INSERT INTO Dim_Time (OrderDate,OrderMonth,OrderYear,OrderQuarter)
       values (@SmallDate,MONTH(@SmallDate), YEAR(@SmallDate),DATEPART(QUARTER,@SmallDate))
     set @SmallDate=@SmallDate+1    
    end    
End

exec InsertTableDimTime

alter table Fact
add constraint time_fk foreign key (OrderDate) references Dim_Time(OrderDate)