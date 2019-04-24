CREATE TABLE [dbo].[DateTable_Month] (
    [Date]            DATE        NOT NULL,
    [YrMth]           VARCHAR (4) NOT NULL,
    [MonthYear]       CHAR (7)    NOT NULL,
    [Month]           TINYINT     NOT NULL,
    [Year]            INT         NOT NULL,
    [FirstDayOfMonth] DATE        NOT NULL,
    [LastDayOfMonth]  DATE        NOT NULL
);

