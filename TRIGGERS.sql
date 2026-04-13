USE DisasterDB;

GO
CREATE TRIGGER dbo.trg_actions_validate_status
ON dbo.org_event_actions
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- status NULL olabilir ama doluysa d�rt de�erden biri olmal�.trim yap�oy�r
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE status IS NOT NULL
          AND LTRIM(RTRIM(status)) NOT IN ('Planned','InProgress','Done','Cancelled')
    )
    BEGIN
        RAISERROR('Invalid status. Allowed: Planned, InProgress, Done, Cancelled (or NULL).', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM inserted i JOIN deleted d ON i.action_id = d.action_id)
    BEGIN
        UPDATE oa
        SET
            oa.event_label      = i.event_label,
            oa.org_name         = i.org_name,
            oa.title            = i.title,
            oa.status           = CASE WHEN i.status IS NULL THEN NULL ELSE LTRIM(RTRIM(i.status)) END,
            oa.action_datetime  = i.action_datetime,
            oa.hours_to_respond = i.hours_to_respond
        FROM dbo.org_event_actions oa
        JOIN inserted i ON oa.action_id = i.action_id;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.org_event_actions
        (event_label, org_name, title, status, action_datetime, hours_to_respond)
        SELECT
            event_label,
            org_name,
            title,
            CASE WHEN status IS NULL THEN NULL ELSE LTRIM(RTRIM(status)) END,
            action_datetime,
            hours_to_respond
        FROM inserted;
    END
END;
GO

--org_name bo� olamaz.ve tr�mler.

GO
CREATE TRIGGER dbo.trg_orgs_trim_name
ON dbo.organizations
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted WHERE org_name IS NULL OR LTRIM(RTRIM(org_name)) = '')
    BEGIN
        RAISERROR('org_name cannot be empty.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM inserted i JOIN deleted d ON i.org_id = d.org_id)
    BEGIN
        UPDATE o
        SET
            o.org_name        = LTRIM(RTRIM(i.org_name)),
            o.org_type        = i.org_type,
            o.country_name    = i.country_name,
            o.parent_org_name = CASE WHEN i.parent_org_name IS NULL THEN NULL ELSE LTRIM(RTRIM(i.parent_org_name)) END,
            o.contact_phone   = i.contact_phone,
            o.contact_email   = i.contact_email
        FROM dbo.organizations o
        JOIN inserted i ON o.org_id = i.org_id;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.organizations
        (org_name, org_type, country_name, parent_org_name, contact_phone, contact_email)
        SELECT
            LTRIM(RTRIM(org_name)),
            org_type,
            country_name,
            CASE WHEN parent_org_name IS NULL THEN NULL ELSE LTRIM(RTRIM(parent_org_name)) END,
            contact_phone,
            contact_email
        FROM inserted;
    END
END;
GO


--email check
GO
CREATE TRIGGER dbo.trg_orgs_basic_email_check
ON dbo.organizations
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE contact_email IS NOT NULL
          AND (
                contact_email NOT LIKE '%_@_%._%'  -- en basit @  nokta kontrol�
             OR contact_email LIKE '% %'           -- bo�luk olmas�n
          )
    )
    BEGIN
        RAISERROR('Invalid contact_email format (basic check).', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO


--Event label ve sector name�i TRImlemek
GO
CREATE TRIGGER dbo.trg_event_sector_impact_trim_keys
ON dbo.event_sector_impact
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted i JOIN deleted d ON i.event_sector_id = d.event_sector_id)
    BEGIN
        UPDATE esi
        SET
            esi.event_label               = LTRIM(RTRIM(i.event_label)),
            esi.sector_name               = LTRIM(RTRIM(i.sector_name)),
            esi.facilities_affected_count = i.facilities_affected_count,
            esi.service_disruption_days   = i.service_disruption_days
        FROM dbo.event_sector_impact esi
        JOIN inserted i ON esi.event_sector_id = i.event_sector_id;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.event_sector_impact
        (event_label, sector_name, facilities_affected_count, service_disruption_days)
        SELECT
            LTRIM(RTRIM(event_label)),
            LTRIM(RTRIM(sector_name)),
            facilities_affected_count,
            service_disruption_days
        FROM inserted;
    END
END;
GO

--eventlabel trim,di�er metrikleri normal yazmak i�in

GO
CREATE TRIGGER dbo.trg_event_impacts_trim_event_label
ON dbo.event_impacts
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted i JOIN deleted d ON i.impact_id = d.impact_id)
    BEGIN
        UPDATE ei
        SET
            ei.event_label             = LTRIM(RTRIM(i.event_label)),
            ei.deaths_count            = i.deaths_count,
            ei.injuries_count          = i.injuries_count,
            ei.displaced_people_count  = i.displaced_people_count,
            ei.total_loss_usd          = i.total_loss_usd,
            ei.insured_loss_usd        = i.insured_loss_usd,
            ei.housing_loss_usd        = i.housing_loss_usd,
            ei.infrastructure_loss_usd = i.infrastructure_loss_usd
        FROM dbo.event_impacts ei
        JOIN inserted i ON ei.impact_id = i.impact_id;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.event_impacts
        (event_label, deaths_count, injuries_count, displaced_people_count,
         total_loss_usd, insured_loss_usd, housing_loss_usd, infrastructure_loss_usd)
        SELECT
            LTRIM(RTRIM(event_label)),
            deaths_count, injuries_count, displaced_people_count,
            total_loss_usd, insured_loss_usd, housing_loss_usd, infrastructure_loss_usd
        FROM inserted;
    END
END;
GO


--Event silinmeden �nce,evente ba�l� kay�t var m� kontrol e

GO
CREATE TRIGGER dbo.events_prevent_delete_if_used
ON dbo.events
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM deleted d
        WHERE EXISTS (SELECT 1 FROM dbo.aid a WHERE a.event_label = d.event_label)
           OR EXISTS (SELECT 1 FROM dbo.event_impacts ei WHERE ei.event_label = d.event_label)
           OR EXISTS (SELECT 1 FROM dbo.org_event_actions oa WHERE oa.event_label = d.event_label)
           OR EXISTS (SELECT 1 FROM dbo.event_sector_impact esi WHERE esi.event_label = d.event_label)  -- EKLEND�
    )
    BEGIN
        RAISERROR(
          'Event cannot be deleted because it has related operational data.',
          16, 1
        );
        RETURN;
    END

    DELETE e
    FROM dbo.events e
    JOIN deleted d ON d.event_label = e.event_label;
END;
GO



--Organizasyon aksyonu event ba�lamadan �nce olmaz

GO
CREATE TRIGGER dbo.org_event_action_time_validation
ON org_event_actions
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN events e
          ON e.event_label = i.event_label
        WHERE i.action_datetime < e.start_datetime
    )
    BEGIN
        RAISERROR(
          'Invalid action time: organization action cannot occur before event start.',
          16, 1
        );
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO


--hours_to_respond girilmediyse otomatik hesaplma

GO
CREATE TRIGGER dbo.trg_actions_autofill_hours_to_respond
ON dbo.org_event_actions
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE oa
    SET oa.hours_to_respond =
        CASE
            WHEN oa.hours_to_respond IS NOT NULL THEN oa.hours_to_respond
            ELSE CAST(DATEDIFF(MINUTE, e.start_datetime, oa.action_datetime) AS NUMERIC(8,2)) / 60.0
        END
    FROM dbo.org_event_actions oa
    JOIN inserted i ON i.action_id = oa.action_id
    JOIN dbo.events e ON e.event_label = oa.event_label
    WHERE oa.action_datetime >= e.start_datetime; 
END;


GO

-- delivery_method sadece road/air/sea olsun + lowercase + trim

CREATE TRIGGER dbo.trg_aid_normalize_delivery_method
ON dbo.aid
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- 0) delivery_method whitelist (road/air/sea)
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE LOWER(LTRIM(RTRIM(delivery_method))) NOT IN ('road','air','sea')
    )
    BEGIN
        RAISERROR('Invalid delivery_method. Allowed: road, air, sea.', 16, 1);
        RETURN;
    END

    -- UPDATE mi INSERT mi
    IF EXISTS (SELECT 1 FROM inserted i JOIN deleted d ON i.aid_id = d.aid_id)
    BEGIN
        UPDATE a
        SET
            a.event_label        = LTRIM(RTRIM(i.event_label)),
            a.org_name           = LTRIM(RTRIM(i.org_name)),
            a.amount_usd         = i.amount_usd,
             a.quantity           = i.quantity,
            a.quantity_unit      = i.quantity_unit,
             a.delivered_datetime = i.delivered_datetime,
            a.delivery_method    = LOWER(LTRIM(RTRIM(i.delivery_method)))
        FROM dbo.aid a
        JOIN inserted i ON a.aid_id = i.aid_id;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.aid
        (event_label, org_name, amount_usd, quantity, quantity_unit, delivered_datetime, delivery_method)
        SELECT
            LTRIM(RTRIM(event_label)),
            LTRIM(RTRIM(org_name)),
            amount_usd,
            quantity,
            quantity_unit,
            delivered_datetime,
            LOWER(LTRIM(RTRIM(delivery_method)))
        FROM inserted;
    END
END;
GO
