CREATE TABLE [dbo].[ref_ICDcd] (
    [ID]             INT           IDENTITY (1, 1) NOT NULL,
    [Is10]           BIT           NULL,
    [Ord]            VARCHAR (5)   NULL,
    [Hdr]            BIT           NULL,
    [ICDCode]        VARCHAR (10)  NULL,
    [CodeSet]        VARCHAR (15)  NULL,
    [CodeSetDesc]    VARCHAR (15)  NULL,
    [CodeBlock]      VARCHAR (15)  NULL,
    [CodeBlockDesc]  VARCHAR (15)  NULL,
    [CodeDisease]    VARCHAR (50)  NULL,
    [CodeDesc]       VARCHAR (100) NULL,
    [CodeDescLong]   VARCHAR (255) NULL,
    [CodeParent]     VARCHAR (100) NULL,
    [CodeParentID]   INT           NULL,
    [CodeType]       VARCHAR (50)  NULL,
    [Active]         BIT           NULL,
    [Created]        DATE          NULL,
    [ActStart]       DATE          NULL,
    [ActEnd]         DATE          NULL,
    [YearLastUpdate] SMALLINT      NULL
);

