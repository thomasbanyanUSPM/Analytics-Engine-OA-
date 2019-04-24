CREATE TABLE [dbo].[ref_ICDtoCond] (
    [ID]             INT          IDENTITY (1, 1) NOT NULL,
    [ICDID]          INT          NULL,
    [ICDCode]        VARCHAR (10) NULL,
    [InclChildICD]   BIT          NULL,
    [ConditionID]    INT          NULL,
    [Condition]      VARCHAR (25) NULL,
    [CondGrp]        VARCHAR (50) NULL,
    [CondGrpCondLbl] VARCHAR (25) NULL,
    [GrpOrd]         SMALLINT     NULL,
    [GrpHierOrd]     SMALLINT     NULL,
    [CondGrpType]    VARCHAR (50) NULL,
    [Active]         BIT          NULL,
    [ICD10]          BIT          NULL,
    [ActStart]       DATE         NULL,
    [ActEnd]         DATE         NULL
);

