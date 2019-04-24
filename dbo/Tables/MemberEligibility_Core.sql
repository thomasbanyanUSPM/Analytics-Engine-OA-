﻿CREATE TABLE [dbo].[MemberEligibility_Core]
(
	    [ID]                     INT           IDENTITY (1, 1) NOT NULL,
    [ClientId]               INT           NULL,
    [YrMth]                  CHAR (6)      NULL,
    [MemEligType]            VARCHAR (10)  NULL,
    [MemberID]               VARCHAR (50)  NULL,
    [IDSource]               VARCHAR (15)  NULL,
    [MemberRelationship]     VARCHAR (25)  NULL,
    [MemberRelationshipOrig] VARCHAR (25)  NULL,
    [PlanID]                 VARCHAR (100) NULL,
    [PlanType]               VARCHAR (25)  NULL,
    [PlanGroupID]            VARCHAR (25)  NULL,
    [PlanGroup]              VARCHAR (25)  NULL,
    [CostCenter]             VARCHAR (50)  NULL,
    [DepLoc]                 VARCHAR (50)  NULL,
    [Custom1]                VARCHAR (100) NULL,
    [Custom1_lbl]            VARCHAR (25)  NULL,
    [Custom2]                VARCHAR (100) NULL,
    [Custom2_lbl]            VARCHAR (25)  NULL,
    [Custom3]                VARCHAR (100) NULL,
    [AsOfDate]               DATE          NULL,
    [StartDte]               DATE          NULL,
    [EndDte]                 DATE          NULL,
    [Current]                BIT           NULL,
    [originalfiledate]       DATE          NULL,
    [lastfiledate]           DATE          NULL,
    [CreatedOn]              DATE          NULL,
    [LastUpdatedOn]          DATE          NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 100)
)
