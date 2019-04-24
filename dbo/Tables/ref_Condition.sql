CREATE TABLE [dbo].[ref_Condition] (
    [ID]               INT           IDENTITY (1, 1) NOT NULL,
    [ConditionID]      INT           NULL,
    [Condition]        VARCHAR (25)  NULL,
    [CondDesc]         VARCHAR (100) NULL,
    [CondFamily]       VARCHAR (50)  NULL,
    [CondType]         VARCHAR (15)  NULL,
    [RelatedTo]        INT           NULL,
    [RelationshipType] VARCHAR (15)  NULL,
    [CondRelSource]    VARCHAR (50)  NULL,
    [CreatedOn]        DATE          NULL,
    [LastUpdated]      DATE          NULL,
    [NextReview]       DATE          NULL,
    [Active]           BIT           NULL,
    [StartDte]         DATE          NULL,
    [EndDte]           DATE          NULL
);

