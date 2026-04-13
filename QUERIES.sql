USE DisasterDB;


SELECT COUNT(event_label) AS eventlabelsay�s� from org_event_actions
select action_id,org_name as organizasyonAd� from org_event_actions  where status = 'InProgress' order by action_id asc



--events tablosundan en son ba�layan 5 olay� getirme

SELECT TOP (5) *
FROM dbo.events
ORDER BY    start_datetime   DESC;


-- sadece T�rkiye�deki event�ler
SELECT event_label, hazard_type_name, city_name, start_datetime
FROM dbo.events
  WHERE country_name = 'T�rkiye'
ORDER BY start_datetime;

--Belirli hazard type
SELECT event_label, city_name, start_datetime
FROM dbo.events
  WHERE hazard_type_name = 'Flood'
ORDER BY start_datetime;

--arih aral��
SELECT event_label, hazard_type_name, city_name, start_datetime
   FROM dbo.events
WHERE start_datetime >= '2025-06-01' AND start_datetime <  '2025-07-01'
ORDER BY start_datetime;

-- Event + Impact (event_label ile ba�lan�yor)
SELECT
  e.event_label,
  e.hazard_type_name,
  e.city_name,
  ei.deaths_count,
  ei.total_loss_usd
FROM dbo.events e
  JOIN dbo.event_impacts ei
     ON ei.event_label = e.event_label
ORDER BY ei.total_loss_usd DESC;

--Event + Aid hangi olaya kim yard�m etmi�
SELECT
  a.event_label,
  a.org_name,
  a.amount_usd,
  a.delivered_datetime,
  a.delivery_method
FROM dbo.aid a
ORDER BY a.delivered_datetime DESC;

--Hazard type�a g�re ka� event var?
SELECT hazard_type_name, COUNT(*) AS event_count
FROM  dbo.events
GROUP BY hazard_type_name
ORDER  BY event_count DESC;


--�lkeye g�re event say�s� (top 10
SELECT TOP (10) country_name, COUNT(*) AS event_count
FROM  dbo.events
GROUP BY country_name
ORDER BY  event_count DESC;


--Organizasyon ba��na toplam yard�m dolar
SELECT
  org_name,
  SUM(ISNULL(amount_usd, 0)) AS total_aid_usd,
  COUNT(*) AS delivery_count
FROM dbo.aid
GROUP BY org_name
ORDER BY total_aid_usd DESC;

--En pahal� 5 event impact�e g�re
SELECT TOP (5)
  e.event_label,
  e.hazard_type_name,
  e.country_name,
  e.city_name,
  ei.total_loss_usd
   FROM dbo.events e
JOIN dbo.event_impacts ei
  ON ei.event_label = e.event_label
  ORDER BY ei.total_loss_usd DESC;


--Event�in sekt�r etkileri (impact detay)
SELECT
  esi.event_label,
  esi.sector_name,
  esi.facilities_affected_count,
  esi.service_disruption_days
FROM dbo.event_sector_impact esi
  WHERE esi.event_label = 'EVT-2025-004'
ORDER BY esi.service_disruption_days DESC;
