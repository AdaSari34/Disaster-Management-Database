
CREATE DATABASE DisasterDB;
GO

USE DisasterDB;
GO

/* tablolar */

CREATE TABLE events   (
   event_id             INT IDENTITY(1,1)   NOT NULL PRIMARY KEY,
   event_label          VARCHAR(200)        NOT NULL UNIQUE,

   hazard_type_name     VARCHAR(80)       NOT NULL,
   hazard_subtype_name  VARCHAR(100)      NOT NULL,

   country_name         VARCHAR(120)      NOT NULL,
   city_name            VARCHAR(120)    NOT NULL,
   admin_region         VARCHAR(120)    NOT NULL,

   location_description VARCHAR(200)      NULL,
   latitude             NUMERIC(9,6)      NULL,
   longitude            NUMERIC(9,6)      NULL,

   start_datetime         DATETIME2         NOT NULL,
   end_datetime           DATETIME2         NULL,

   magnitude_value      NUMERIC(10,2)     NULL,
   magnitude_unit_name   VARCHAR(20)       NULL,

   description          VARCHAR(MAX)      NULL
);

CREATE TABLE hazard_types (
   hazard_type_id   INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   hazard_type_name   VARCHAR(80)       NOT NULL UNIQUE,
   category_name    VARCHAR(60)       NULL
);

CREATE TABLE hazard_subtypes (
   hazard_subtype_id   INT IDENTITY(1,1)  NOT NULL  PRIMARY KEY,

   -- FK art�k ID ile de�il value ile ba�l�! hazard_type_name

   hazard_type_name     VARCHAR(80)       NOT NULL,
   hazard_subtype_name    VARCHAR(100)      NOT NULL,

   CONSTRAINT UQ_hazard_subtypes_natural  UNIQUE  (hazard_type_name, hazard_subtype_name)
);

  -- Subtype�  tek ba��na unique yapmad�m ��nk� ayn� isim farkl� typelarda ge�ebilir. O y�zden (type, subtype) beraber unique



CREATE TABLE event_impacts (
   impact_id               INT IDENTITY(1,1)   NOT NULL   PRIMARY KEY,

   -- FK art�k event_id de�il event_label (eventlabel un�que,bu y�zden event ba��na 1 kay�t)
   event_label               VARCHAR(200) UNIQUE NOT NULL,

   deaths_count            INT               null,
   injuries_count            INT               NULL,
   displaced_people_count    INT               NULL,
   total_loss_usd          NUMERIC(15,2)     NULL,
   insured_loss_usd        NUMERIC(15,2)     NULL,
   housing_loss_usd         NUMERIC(15,2)     NULL,
   infrastructure_loss_usd    NUMERIC(15,2)     NULL
);

CREATE TABLE sectors (
   sector_id  INT IDENTITY(1,1)  NOT NULL PRIMARY KEY,
   sector_name  VARCHAR(60)       NOT NULL UNIQUE
);

CREATE TABLE event_sector_impact (
   event_sector_id             INT IDENTITY(1,1) NOT NULL PRIMARY KEY,

   -- FK�ler value
   event_label                VARCHAR(200) NOT NULL,
   sector_name                VARCHAR(60)  NOT NULL,

   facilities_affected_count   INT          NULL,
   service_disruption_days    INT          NULL,

   -- ayn� event sector ikilisi iki kere olamaz
   CONSTRAINT UQ_event_sector_impact_event_sector  UNIQUE (event_label, sector_name)
);

CREATE TABLE organizations (
   org_id            INT IDENTITY(1,1) NOT NULL PRIMARY KEY,

   -- parent referans� da value olaca�� i�in org_name unique
   org_name          VARCHAR(160)      NOT NULL UNIQUE,

   org_type          VARCHAR(40)       NULL,

   country_name      VARCHAR(120)      NULL,

   
   parent_org_name    VARCHAR(160)      NULL,

   contact_phone     VARCHAR(40)       NULL,
   contact_email       VARCHAR(160)      NULL
);

CREATE TABLE aid (
   aid_id               INT IDENTITY(1,1) NOT NULL PRIMARY KEY,

   -- FK�ler value
   event_label        VARCHAR(200) NOT NULL,
   org_name           VARCHAR(160) NOT NULL,

   amount_usd         NUMERIC(14,2) NULL,
   quantity             NUMERIC(14,2) NULL,
   quantity_unit       VARCHAR(20)   NULL,
   delivered_datetime  DATETIME2     NOT NULL,
   delivery_method     VARCHAR(20)   NOT NULL,

   --Ayn� kurum ayn� olaya ayn� anda ayn� y�ntemle duplicate yard�m giremez  2 kez girmeyi �nler 

   CONSTRAINT    UQ_aid_natural  UNIQUE  (event_label, org_name, delivered_datetime, delivery_method)
);

CREATE TABLE   org_event_actions (
   action_id        INT IDENTITY(1,1) NOT NULL PRIMARY KEY,

   -- FK�ler value
   event_label      VARCHAR(200) NOT NULL,
   org_name         VARCHAR(160) NOT NULL,

   title            VARCHAR(160) NULL,
   status           VARCHAR(20)  NULL,
   action_datetime  DATETIME2    NOT NULL,
   hours_to_respond NUMERIC(8,2) NULL,

   --Ayn� kurumun ayn� event i�in ayn� anda tek  aksiyonu olabilir.

   CONSTRAINT  UQ_org_event_actions_event_org_time  UNIQUE   (event_label, org_name, action_datetime)
);


 --  FOREIGN KEYS  --ALTER SECTION


-- event_impacts >events (label)
ALTER TABLE    event_impacts
ADD CONSTRAINT FK_event_impacts_events_label
FOREIGN KEY (event_label)
REFERENCES events(event_label)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- event_sector_impact > events

ALTER TABLE event_sector_impact
ADD CONSTRAINT   FK_event_sector_impact_events_label
FOREIGN KEY (event_label)
REFERENCES events(event_label)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- aid>events(label)
ALTER TABLE    aid
ADD CONSTRAINT FK_aid_events_label
FOREIGN KEY (event_label)
REFERENCES   events(event_label)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

--orgeventacitons events(label)
ALTER TABLE   org_event_actions
ADD CONSTRAINT FK_org_event_actions_events_label
FOREIGN KEY (event_label)
REFERENCES  events(event_label)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


-- hazard_subtypes >hazard_types(name)
ALTER TABLE hazard_subtypes
ADD CONSTRAINT  FK_hazard_subtypes_hazard_types_name
FOREIGN KEY  (hazard_type_name)
REFERENCES hazard_types(hazard_type_name)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- event_sector_impact > sectors (name)
ALTER TABLE event_sector_impact
ADD CONSTRAINT  FK_event_sector_impact_sectors_name
FOREIGN KEY (sector_name)
REFERENCES  sectors(sector_name)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


ALTER TABLE organizations
ADD CONSTRAINT FK_organizations_parent_org_name
FOREIGN KEY (parent_org_name)
REFERENCES organizations(org_name)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


-- aid > organizations(name)
ALTER TABLE aid
ADD CONSTRAINT FK_aid_organizations_name
FOREIGN KEY (org_name)
REFERENCES organizations(org_name)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- org_event_actions > organizations(name)
ALTER TABLE org_event_actions
ADD CONSTRAINT FK_org_event_actions_organizations_name
FOREIGN KEY (org_name)
REFERENCES organizations(org_name)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- hours_to_respond negatif olmas�n
ALTER TABLE org_event_actions
ADD CONSTRAINT CK_org_event_actions_hours_nonnegative
CHECK (hours_to_respond IS NULL OR hours_to_respond >= 0);


ALTER TABLE events
ADD CONSTRAINT FK_events_hazard_subtypes_natural
FOREIGN KEY (hazard_type_name, hazard_subtype_name)
REFERENCES hazard_subtypes(hazard_type_name, hazard_subtype_name)
ON DELETE NO ACTION
ON UPDATE NO ACTION;




ALTER TABLE dbo.event_impacts
ADD CONSTRAINT CK_event_impacts_nonnegative
CHECK (
    (deaths_count IS NULL OR deaths_count >= 0) AND
    (injuries_count IS NULL OR injuries_count >= 0) AND
    (displaced_people_count IS NULL OR displaced_people_count >= 0) AND
    (total_loss_usd IS NULL OR total_loss_usd >= 0) AND
    (insured_loss_usd IS NULL OR insured_loss_usd >= 0) AND
    (housing_loss_usd IS NULL OR housing_loss_usd >= 0) AND
    (infrastructure_loss_usd IS NULL OR infrastructure_loss_usd >= 0)
);


ALTER TABLE dbo.event_sector_impact
ADD CONSTRAINT CK_event_sector_impact_nonnegative
CHECK (
    (facilities_affected_count IS NULL OR facilities_affected_count >= 0) AND (service_disruption_days IS NULL OR service_disruption_days >= 0)
);


ALTER TABLE dbo.aid
ADD CONSTRAINT CK_aid_nonnegative
CHECK (
    (amount_usd IS NULL OR amount_usd >= 0) AND
    (quantity IS NULL OR quantity >= 0)
);

ALTER TABLE dbo.events
ADD CONSTRAINT CK_events_magnitude_nonnegative
CHECK (magnitude_value IS NULL OR  magnitude_value >= 0);
