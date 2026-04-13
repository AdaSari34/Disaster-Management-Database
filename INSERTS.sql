USE DisasterDB;


INSERT INTO dbo.hazard_types (hazard_type_name, category_name) VALUES
('Earthquake','Geophysical'),
('Flood','Hydrological'),
('Storm','Meteorological'),
('Wildfire','Climatological'),
('Landslide','Geophysical'),
('Drought','Climatological'),
('Volcanic Activity','Geophysical'),
('Extreme Temperature','Meteorological'),
('Epidemic','Biological'),
('Tsunami','Geophysical'),
('Avalanche','Hydrological'),
('Heatwave','Meteorological'),
('Cold Wave','Meteorological'),
('Hailstorm','Meteorological'),
('Tornado','Meteorological'),
('Cyclone','Meteorological'),
('Blizzard','Meteorological'),
('Sandstorm','Meteorological'),
('Dense Fog','Meteorological'),
('Lightning','Meteorological'),
('Coastal Erosion','Hydrological'),
('Dam Failure','Technological'),
('Industrial Accident','Technological'),
('Chemical Spill','Technological'),
('Oil Spill','Technological'),
('Radiological Incident','Technological'),
('Power Outage','Technological'),
('Water Contamination','Technological'),
('Building Collapse','Technological'),
('Transport Accident','Technological');
GO


  --2) hazard_subtypes 

INSERT INTO dbo.hazard_subtypes (hazard_type_name, hazard_subtype_name) VALUES
-- Earthquake
('Earthquake','Shallow Crustal'),
('Earthquake','Deep Focus'),
('Earthquake','Aftershock Sequence'),
-- Flood
('Flood','Riverine Flood'),
('Flood','Flash Flood'),
('Flood','Urban Flood'),
-- Storm
('Storm','Severe Thunderstorm'),
('Storm','Windstorm'),
('Storm','Tropical Storm'),
-- Wildfire
('Wildfire','Forest Fire'),
('Wildfire','Grassland Fire'),
('Wildfire','Wildland-Urban Interface Fire'),
-- Landslide
('Landslide','Mudslide'),
('Landslide','Rockfall'),
('Landslide','Debris Flow'),
-- Drought
('Drought','Agricultural Drought'),
('Drought','Hydrological Drought'),
('Drought','Meteorological Drought'),
-- Volcanic 
('Volcanic Activity','Ashfall'),
('Volcanic Activity','Lava Flow'),
('Volcanic Activity','Pyroclastic Flow'),
-- Extreme 
('Extreme Temperature','Extreme Cold'),
('Extreme Temperature','Extreme Heat'),
('Extreme Temperature','Temperature Anomaly'),
-- Epidemic
('Epidemic','Influenza Outbreak'),
('Epidemic','Waterborne Disease Outbreak'),
('Epidemic','Vector-borne Disease Outbreak'),
-- Tsunami
('Tsunami','Near-field Tsunami'),
('Tsunami','Far-field Tsunami'),
('Tsunami','Tsunami Warning Event');
GO


   --3) sectors 

INSERT INTO dbo.sectors (sector_name) VALUES
('Health'),
('Education'),
('Water & Sanitation'),
('Shelter'),
('Food Security'),
('Energy'),
('Transport'),
('Telecommunications'),
('Agriculture'),
('Public Safety'),
('Environment'),
('Finance'),
('Industry'),
('Tourism'),
('Housing'),
('Infrastructure'),
('Logistics'),
('Governance'),
('Child Protection'),
('Mental Health'),
('Search & Rescue'),
('Early Warning'),
('Emergency Management'),
('Waste Management'),
('Coastal Protection'),
('Fire Services'),
('Medical Supply'),
('Community Support'),
('Evacuation'),
('Reconstruction');
GO


 --  4) organizations  (�nce parents, sonra children)

INSERT INTO dbo.organizations
(org_name, org_type, country_name, parent_org_name, contact_phone, contact_email)
VALUES
('Global Relief Network','NGO','USA',NULL,'+1-202-555-0101','info@grn.org'),
('International Aid Union','NGO','UK',NULL,'+44-20-5550-0102','contact@iau.org'),
('Rapid Response Team','Government','T�rkiye',NULL,'+90-312-555-0103','rrt@gov.tr'),
('World Health Support','UN','Switzerland',NULL,'+41-22-555-0104','office@whs.int'),
('Food Assistance Coalition','NGO','Germany',NULL,'+49-30-555-0105','hello@fac.de'),
('Shelter Builders Org','NGO','France',NULL,'+33-1-555-0106','mail@sbo.fr'),
('Rescue Aviation Group','Private','Italy',NULL,'+39-06-555-0107','ops@rag.it'),
('Sea Logistics Alliance','Private','Greece',NULL,'+30-21-555-0108','support@sla.gr'),
('Water First Initiative','NGO','Netherlands',NULL,'+31-20-555-0109','team@wfi.nl'),
('Emergency Tech Partners','Private','USA',NULL,'+1-415-555-0110','help@etp.com'),

-- children (parent_org_name FK -> organizations.org_name)
('GRN - Asia Desk','NGO','Japan','Global Relief Network','+81-3-5550-0111','asia@grn.org'),
('GRN - Europe Desk','NGO','Belgium','Global Relief Network','+32-2-5550-0112','europe@grn.org'),
('IAU - Field Ops','NGO','UK','International Aid Union','+44-20-5550-0113','field@iau.org'),
('IAU - Logistics','NGO','UK','International Aid Union','+44-20-5550-0114','logistics@iau.org'),
('RRT - Ankara Unit','Government','T�rkiye','Rapid Response Team','+90-312-555-0115','ankara.rrt@gov.tr'),
('RRT - Istanbul Unit','Government','T�rkiye','Rapid Response Team','+90-212-555-0116','istanbul.rrt@gov.tr'),
('WHS - Outbreak Lab','UN','Switzerland','World Health Support','+41-22-555-0117','lab@whs.int'),
('WHS - Field Clinics','UN','Switzerland','World Health Support','+41-22-555-0118','clinics@whs.int'),
('FAC - Procurement','NGO','Germany','Food Assistance Coalition','+49-30-555-0119','proc@fac.de'),
('FAC - Distribution','NGO','Germany','Food Assistance Coalition','+49-30-555-0120','dist@fac.de'),
('SBO - Rapid Shelter','NGO','France','Shelter Builders Org','+33-1-555-0121','rapid@sbo.fr'),
('SBO - Materials','NGO','France','Shelter Builders Org','+33-1-555-0122','materials@sbo.fr'),
('RAG - Air Ops','Private','Italy','Rescue Aviation Group','+39-06-555-0123','air@rag.it'),
('RAG - Medical Evac','Private','Italy','Rescue Aviation Group','+39-06-555-0124','medevac@rag.it'),
('SLA - Port Ops','Private','Greece','Sea Logistics Alliance','+30-21-555-0125','ports@sla.gr'),
('SLA - Warehousing','Private','Greece','Sea Logistics Alliance','+30-21-555-0126','warehouse@sla.gr'),
('WFI - Water Labs','NGO','Netherlands','Water First Initiative','+31-20-555-0127','labs@wfi.nl'),
('WFI - Field Teams','NGO','Netherlands','Water First Initiative','+31-20-555-0128','field@wfi.nl'),
('ETP - Sensors','Private','USA','Emergency Tech Partners','+1-415-555-0129','sensors@etp.com'),
('ETP - Comms','Private','USA','Emergency Tech Partners','+1-415-555-0130','comms@etp.com'),

-- additional independent orgs (no parent)
('Community Rescue Volunteers','NGO','T�rkiye',NULL,'+90-216-555-0131','crv@ngo.tr'),
('City Health Directorate','Government','T�rkiye',NULL,'+90-212-555-0132','healthdir@city.gov.tr'),
('National Disaster Agency','Government','T�rkiye',NULL,'+90-312-555-0133','nda@gov.tr'),
('Mountain Search Unit','Government','T�rkiye',NULL,'+90-242-555-0134','msu@gov.tr'),
('Urban Support Foundation','NGO','T�rkiye',NULL,'+90-212-555-0135','usf@ngo.tr'),
('Regional Fire Department','Government','T�rkiye',NULL,'+90-232-555-0136','firedept@city.gov.tr'),
('Medical Supply Hub','Private','T�rkiye',NULL,'+90-216-555-0137','msupply@hub.com'),
('Rebuild Together','NGO','T�rkiye',NULL,'+90-312-555-0138','rebuild@ngo.tr'),
('Safe Schools Program','NGO','T�rkiye',NULL,'+90-212-555-0139','schools@ngo.tr'),
('Coastal Guard Support','Government','T�rkiye',NULL,'+90-212-555-0140','coastguard@gov.tr');
GO


 --  5) events (30)  (FK: (hazard_type_name, hazard_subtype_name) -> hazard_subtypes)

INSERT INTO dbo.events
(event_label, hazard_type_name, hazard_subtype_name,
 country_name, city_name, admin_region,
 location_description, latitude, longitude,
 start_datetime, end_datetime, magnitude_value, magnitude_unit_name, description)
VALUES
('EVT-2025-001','Earthquake','Shallow Crustal','T�rkiye','Istanbul','Marmara','Near city center',41.008200,28.978400,'2025-01-05T03:12:00',NULL,5.4,'Mw','Moderate shaking reported across districts.'),
('EVT-2025-002','Flood','Flash Flood','T�rkiye','Rize','Black Sea','Mountain streams overflow',41.025000,40.517000,'2025-01-12T08:30:00','2025-01-12T20:00:00',NULL,NULL,'Sudden flood affected roads and homes.'),
('EVT-2025-003','Storm','Severe Thunderstorm','T�rkiye','Ankara','Central Anatolia','Hail and strong winds',39.933400,32.859700,'2025-01-20T16:10:00','2025-01-20T19:40:00',NULL,NULL,'Thunderstorm caused local outages.'),
('EVT-2025-004','Wildfire','Forest Fire','T�rkiye','Izmir','Aegean','Forest area near settlements',38.423700,27.142800,'2025-02-03T11:00:00','2025-02-06T18:00:00',NULL,NULL,'Wildfire required evacuations.'),
('EVT-2025-005','Landslide','Debris Flow','T�rkiye','Trabzon','Black Sea','Steep slope collapse',41.001500,39.717800,'2025-02-10T05:25:00',NULL,NULL,NULL,'Debris flow blocked rural road.'),
('EVT-2025-006','Drought','Agricultural Drought','T�rkiye','Konya','Central Anatolia','Low rainfall impacts crops',37.871400,32.484600,'2025-02-18T00:00:00',NULL,NULL,NULL,'Extended dry period impacts agriculture.'),
('EVT-2025-007','Volcanic Activity','Ashfall','Italy','Catania','Sicily','Light ashfall reported',37.507900,15.083000,'2025-03-02T06:00:00','2025-03-02T18:00:00',NULL,NULL,'Ashfall affected air quality and transport.'),
('EVT-2025-008','Extreme Temperature','Extreme Cold','T�rkiye','Erzurum','Eastern Anatolia','Cold snap and snow',39.904300,41.267900,'2025-03-09T00:00:00','2025-03-12T23:59:00',NULL,NULL,'Extreme cold stressed shelter needs.'),
('EVT-2025-009','Epidemic','Influenza Outbreak','T�rkiye','Bursa','Marmara','Seasonal outbreak cluster',40.195000,29.060000,'2025-03-15T00:00:00',NULL,NULL,NULL,'Increase in influenza-like illness.'),
('EVT-2025-010','Tsunami','Tsunami Warning Event','Japan','Sendai','Miyagi','Coastal warning issued',38.268200,140.869400,'2025-03-22T04:10:00','2025-03-22T12:00:00',NULL,NULL,'Warning issued; limited coastal flooding reported.'),

('EVT-2025-011','Earthquake','Aftershock Sequence','Greece','Athens','Attica','Aftershocks felt in metro',37.983800,23.727500,'2025-04-01T02:05:00',NULL,4.8,'Mw','Aftershock sequence continued overnight.'),
('EVT-2025-012','Flood','Riverine Flood','Germany','Cologne','NRW','River levels rose rapidly',50.937500,6.960300,'2025-04-08T10:00:00','2025-04-10T22:00:00',NULL,NULL,'Riverine flooding affected low areas.'),
('EVT-2025-013','Storm','Windstorm','UK','Liverpool','England','Strong coastal winds',53.408400,-2.991600,'2025-04-14T14:30:00','2025-04-14T23:00:00',NULL,NULL,'Windstorm caused tree falls.'),
('EVT-2025-014','Wildfire','Grassland Fire','Spain','Valencia','Valencian Community','Dry grassland ignition',39.469900,-0.376300,'2025-04-20T12:15:00','2025-04-21T09:00:00',NULL,NULL,'Grassland fire contained within 24h.'),
('EVT-2025-015','Landslide','Rockfall','T�rkiye','Antalya','Mediterranean','Rockfall near highway',36.896900,30.713300,'2025-04-27T07:40:00',NULL,NULL,NULL,'Rockfall disrupted transport routes.'),
('EVT-2025-016','Drought','Hydrological Drought','France','Marseille','Provence','Reservoir levels low',43.296500,5.369800,'2025-05-05T00:00:00',NULL,NULL,NULL,'Water restrictions considered.'),
('EVT-2025-017','Volcanic Activity','Lava Flow','Iceland','Reykjavik','Capital Region','Lava flow near roads',64.146600,-21.942600,'2025-05-12T03:00:00','2025-05-12T20:00:00',NULL,NULL,'Lava flow required road closures.'),
('EVT-2025-018','Extreme Temperature','Extreme Heat','T�rkiye','Adana','Mediterranean','Heat stress warning',37.000000,35.321300,'2025-05-18T11:00:00','2025-05-20T20:00:00',NULL,NULL,'Heatwave impacted vulnerable groups.'),
('EVT-2025-019','Epidemic','Waterborne Disease Outbreak','T�rkiye','Samsun','Black Sea','Suspected water contamination',41.286700,36.330000,'2025-05-26T00:00:00',NULL,NULL,NULL,'Waterborne disease cases increased.'),
('EVT-2025-020','Tsunami','Near-field Tsunami','Indonesia','Padang','West Sumatra','Short notice coastal impact',-0.949200,100.354300,'2025-06-02T01:30:00','2025-06-02T06:30:00',NULL,NULL,'Near-field tsunami caused localized flooding.'),

('EVT-2025-021','Earthquake','Deep Focus','Chile','Santiago','RM','Deep quake felt widely',-33.448900,-70.669300,'2025-06-10T09:20:00',NULL,6.2,'Mw','Deep focus earthquake, minor damage.'),
('EVT-2025-022','Flood','Urban Flood','T�rkiye','Gaziantep','Southeastern Anatolia','Drainage overwhelmed',37.066200,37.383300,'2025-06-18T18:05:00','2025-06-19T03:00:00',NULL,NULL,'Urban flooding impacted neighborhoods.'),
('EVT-2025-023','Storm','Tropical Storm','USA','Miami','Florida','Tropical storm landfall',25.761700,-80.191800,'2025-06-25T06:00:00','2025-06-26T18:00:00',NULL,NULL,'Storm surge and rain affected coast.'),
('EVT-2025-024','Wildfire','Wildland-Urban Interface Fire','Canada','Vancouver','BC','Fire near urban edge',49.282700,-123.120700,'2025-07-03T13:00:00','2025-07-06T23:00:00',NULL,NULL,'Smoke impacted air quality.'),
('EVT-2025-025','Landslide','Mudslide','T�rkiye','Artvin','Black Sea','Heavy rain triggered slide',41.182800,41.819400,'2025-07-11T04:45:00',NULL,NULL,NULL,'Mudslide affected rural housing.'),
('EVT-2025-026','Drought','Meteorological Drought','T�rkiye','Sanliurfa','Southeastern Anatolia','Rain deficit persists',37.159100,38.796900,'2025-07-20T00:00:00',NULL,NULL,NULL,'Meteorological drought conditions.'),
('EVT-2025-027','Volcanic Activity','Pyroclastic Flow','Philippines','Legazpi','Albay','High-risk volcanic activity',13.139100,123.743800,'2025-08-01T02:10:00','2025-08-01T10:00:00',NULL,NULL,'Pyroclastic flow risk prompted evacuations.'),
('EVT-2025-028','Extreme Temperature','Temperature Anomaly','T�rkiye','Kars','Eastern Anatolia','Unusual temperature swings',40.601300,43.097500,'2025-08-09T00:00:00','2025-08-12T23:59:00',NULL,NULL,'Temperature anomalies affected agriculture.'),
('EVT-2025-029','Epidemic','Vector-borne Disease Outbreak','T�rkiye','Mugla','Aegean','Mosquito-borne cluster',37.215300,28.363600,'2025-08-18T00:00:00',NULL,NULL,NULL,'Vector-borne disease monitoring increased.'),
('EVT-2025-030','Tsunami','Far-field Tsunami','Peru','Lima','Lima Province','Distant-source wave arrival',-12.046400,-77.042800,'2025-08-26T15:20:00','2025-08-26T22:00:00',NULL,NULL,'Small waves observed; precautionary measures.');
GO


  -- 6) event_impacts (30)  (1 impact per event_label, UNIQUE)

INSERT INTO dbo.event_impacts
(event_label, deaths_count, injuries_count, displaced_people_count,
 total_loss_usd, insured_loss_usd, housing_loss_usd, infrastructure_loss_usd)
VALUES
('EVT-2025-001',3,25,1200, 15000000, 4000000, 6000000, 5000000),
('EVT-2025-002',0,12,300,   1200000,  250000,  450000,  300000),
('EVT-2025-003',0,8,  50,    600000,  100000,  120000,  180000),
('EVT-2025-004',2,15,8000, 22000000, 5000000, 9000000, 4000000),
('EVT-2025-005',0,3, 40,   350000,   50000,  120000,  80000),
('EVT-2025-006',0,0, 0,   18000000, 2000000, 2000000, 1500000),
('EVT-2025-007',0,6,0,     900000,  200000,   80000,  120000),
('EVT-2025-008',1,10,500,   2500000,  400000,  900000,  600000),
('EVT-2025-009',5,120,0,    1100000,  150000,   50000,   80000),
('EVT-2025-010',0,2, 0,     300000,   50000,   20000,   60000),

('EVT-2025-011',0,9,  60,    800000, 150000, 220000,  180000),
('EVT-2025-012',1,18,900,   6500000, 1200000,1800000, 1600000),
('EVT-2025-013',0,7,  20,    500000,  90000, 110000,  140000),
('EVT-2025-014',0,2,  200,   700000,  120000,  250000,  90000),
('EVT-2025-015',0,4, 10,  420000,   70000,  160000,  90000),
('EVT-2025-016',0,0,  0,   9000000, 1500000,  800000,  600000),
('EVT-2025-017',0,1,0,  1200000,  300000,   50000,  150000),
('EVT-2025-018',2,45,120,   1800000,  250000,  140000,  220000),
('EVT-2025-019',1,60,0,   650000,  80000,  30000,   70000),
('EVT-2025-020',3,20,1500,  4200000,  600000, 1600000,  900000),

('EVT-2025-021',4,30,700, 9800000, 2200000, 2800000, 2100000),
('EVT-2025-022',0,11,250,    950000,  120000,  200000,  180000),
('EVT-2025-023',6,55,6000, 31000000, 9000000,12000000, 6000000),
('EVT-2025-024',1,9,  400,  5200000,  800000, 2100000,  900000),
('EVT-2025-025',0,5,  90,    780000,  100000,  260000,  150000),
('EVT-2025-026',0,0,  0,    8000000, 1200000,  700000,  500000),
('EVT-2025-027',8,40,25000, 46000000, 7000000,18000000, 9000000),
('EVT-2025-028',0,0,  0,  900000,  100000,  150000,   80000),
('EVT-2025-029',2,35,0,   520000,   60000,   40000,   50000),
('EVT-2025-030',0,1,  0,     250000,   30000,   15000,   40000);
GO


INSERT INTO dbo.event_sector_impact
(event_label, sector_name, facilities_affected_count, service_disruption_days)
VALUES

('EVT-2025-001','Health',12,3),
('EVT-2025-002','Transport',8,2),
('EVT-2025-003','Energy',5,1),
('EVT-2025-004','Shelter',40,7),

('EVT-2025-005','Transport',2,1),
('EVT-2025-006','Agriculture',15,30),

('EVT-2025-007','Telecommunications',3,1),
('EVT-2025-008','Shelter',10,4),
('EVT-2025-009','Health',6,10),
('EVT-2025-010','Coastal Protection',4,1),

('EVT-2025-011','Infrastructure',6,2),
('EVT-2025-012','Water & Sanitation',10,5),
('EVT-2025-013','Public Safety',3,1),
('EVT-2025-014','Fire Services',7,2),
('EVT-2025-015','Transport',4,2),
('EVT-2025-016','Water & Sanitation',5,14),
('EVT-2025-017','Transport',2,1),
('EVT-2025-018','Health',9,3),

('EVT-2025-019','Water & Sanitation',4,7),
('EVT-2025-020','Evacuation',8,2),

('EVT-2025-021','Search & Rescue',6,2),
('EVT-2025-022','Waste Management',3,2),
('EVT-2025-023','Telecommunications',12,4),
('EVT-2025-024','Environment',8,10),
('EVT-2025-025','Shelter',6,3),
('EVT-2025-026','Agriculture',10,25),
('EVT-2025-027','Emergency Management',20,14),
('EVT-2025-028','Agriculture',3,5),
('EVT-2025-029','Health',4,9),
('EVT-2025-030','Coastal Protection',2,1);
GO


INSERT INTO dbo.aid
(event_label, org_name, amount_usd, quantity, quantity_unit, delivered_datetime, delivery_method)
VALUES
('EVT-2025-001','Global Relief Network',250000, 1200,'kit','2025-01-05T10:00:00','road'),
('EVT-2025-002','Water First Initiative', 80000,  300,'box','2025-01-12T12:00:00','road'),

('EVT-2025-003','Emergency Tech Partners',50000,  50,'unit','2025-01-20T18:30:00','road'),
('EVT-2025-004','Shelter Builders Org', 400000, 900,'kit','2025-02-03T17:00:00','road'),
('EVT-2025-005','Rapid Response Team',   30000,  20,'unit','2025-02-10T09:00:00','road'),
('EVT-2025-006','Food Assistance Coalition',150000, 500,'ton','2025-02-20T09:00:00','road'),

('EVT-2025-007','Sea Logistics Alliance', 90000,  40,'pallet','2025-03-02T12:00:00','sea'),
('EVT-2025-008','Global Relief Network',  70000, 200,'kit','2025-03-09T10:30:00','road'),
('EVT-2025-009','World Health Support',  60000, 150,'box','2025-03-16T11:00:00','air'),
('EVT-2025-010','International Aid Union',50000,  80,'box','2025-03-22T06:00:00','air'),

('EVT-2025-011','GRN - Europe Desk',     45000, 100,'kit','2025-04-01T08:00:00','road'),
('EVT-2025-012','IAU - Logistics',      120000, 30,'pallet','2025-04-08T16:00:00','road'),
('EVT-2025-013','Emergency Tech Partners',30000, 20,'unit','2025-04-14T18:00:00','road'),

('EVT-2025-014','Regional Fire Department',20000, 15,'unit','2025-04-20T15:00:00','road'),
('EVT-2025-015','Mountain Search Unit',  25000, 10,'unit','2025-04-27T12:00:00','road'),

('EVT-2025-016','Water First Initiative', 90000, 60,'pallet','2025-05-06T10:00:00','road'),
('EVT-2025-017','Rescue Aviation Group', 70000, 12,'unit','2025-05-12T09:00:00','air'),
('EVT-2025-018','City Health Directorate',40000, 80,'box','2025-05-18T14:00:00','road'),
('EVT-2025-019','WFI - Field Teams',     30000, 90,'box','2025-05-26T12:00:00','road'),
('EVT-2025-020','Sea Logistics Alliance',110000, 25,'pallet','2025-06-02T03:00:00','sea'),

('EVT-2025-021','International Aid Union',150000, 40,'pallet','2025-06-10T15:00:00','air'),
('EVT-2025-022','Urban Support Foundation',20000, 70,'kit','2025-06-18T21:00:00','road'),
('EVT-2025-023','Global Relief Network', 300000, 80,'pallet','2025-06-25T12:00:00','air'),
('EVT-2025-024','Shelter Builders Org',  180000, 500,'kit','2025-07-03T19:00:00','road'),
('EVT-2025-025','Rapid Response Team',   35000,  25,'unit','2025-07-11T10:00:00','road'),

('EVT-2025-026','Food Assistance Coalition',120000, 300,'ton','2025-07-21T09:00:00','road'),
('EVT-2025-027','World Health Support',  220000, 60,'pallet','2025-08-01T06:00:00','air'),
('EVT-2025-028','Safe Schools Program',   15000, 40,'kit','2025-08-10T10:00:00','road'),
('EVT-2025-029','Medical Supply Hub',     18000, 55,'box','2025-08-18T11:00:00','road'),
('EVT-2025-030','Coastal Guard Support',  20000, 20,'unit','2025-08-26T18:00:00','sea');
GO


   9) org_event_actions (30) 

INSERT INTO dbo.org_event_actions
(event_label, org_name, title, status, action_datetime, hours_to_respond)
VALUES
('EVT-2025-001','Rapid Response Team','Initial assessment & coordination','InProgress','2025-01-05T06:00:00',NULL),
('EVT-2025-002','Water First Initiative','Deploy pumps and purification kits','Planned','2025-01-12T10:00:00',NULL),
('EVT-2025-003','Emergency Tech Partners','Restore communications and power links','Done','2025-01-20T17:30:00',NULL),

('EVT-2025-004','Shelter Builders Org','Set up temporary shelters','InProgress','2025-02-03T15:00:00',NULL),
('EVT-2025-005','Mountain Search Unit','Clear debris and secure hillside','Done','2025-02-10T08:30:00',NULL),
('EVT-2025-006','Food Assistance Coalition','Plan food distribution routes','Planned','2025-02-18T10:00:00',NULL),
('EVT-2025-007','Sea Logistics Alliance','Coordinate sea shipments','InProgress','2025-03-02T09:30:00',NULL),
('EVT-2025-008','Urban Support Foundation','Cold-wave shelter support','Done','2025-03-09T09:00:00',NULL),
('EVT-2025-009','World Health Support','Issue clinical guidance and support','Done','2025-03-15T12:00:00',NULL),
('EVT-2025-010','International Aid Union','Coastal monitoring & public info','InProgress','2025-03-22T05:00:00',NULL),


('EVT-2025-011','GRN - Europe Desk','Coordinate local partner organizations','Done','2025-04-01T03:30:00',NULL),
('EVT-2025-012','IAU - Logistics','Stage supplies and manage dispatch','InProgress','2025-04-08T14:00:00',NULL),
('EVT-2025-013','Emergency Tech Partners','Stabilize network nodes','Done','2025-04-14T18:00:00',NULL),
('EVT-2025-014','Regional Fire Department','Fire containment and patrols','Done','2025-04-20T16:00:00',NULL),
('EVT-2025-015','Rapid Response Team','Traffic safety and road control','InProgress','2025-04-27T09:30:00',NULL),
('EVT-2025-016','Water First Initiative','Coordinate water restrictions comms','Planned','2025-05-05T10:00:00',NULL),
('EVT-2025-017','Rescue Aviation Group','Aerial surveillance and medevac ready','InProgress','2025-05-12T06:30:00',NULL),
('EVT-2025-018','City Health Directorate','Heatwave health advisories','Done','2025-05-18T13:00:00',NULL),
('EVT-2025-019','WFI - Field Teams','Field water testing & reporting','InProgress','2025-05-26T08:00:00',NULL),
('EVT-2025-020','Sea Logistics Alliance','Port coordination for relief cargo','InProgress','2025-06-02T03:30:00',NULL),


('EVT-2025-021','International Aid Union','Support damage assessment team','Planned','2025-06-10T11:00:00',NULL),
('EVT-2025-022','Urban Support Foundation','Neighborhood cleanup coordination','Done','2025-06-18T20:30:00',NULL),
('EVT-2025-023','Global Relief Network','Multi-agency coordination cell','InProgress','2025-06-25T08:00:00',NULL),
('EVT-2025-024','Shelter Builders Org','Smoke shelter & mask distribution','InProgress','2025-07-03T15:00:00',NULL),
('EVT-2025-025','Community Rescue Volunteers','Assist affected households','Done','2025-07-11T08:00:00',NULL),
('EVT-2025-026','Food Assistance Coalition','Supply chain monitoring','InProgress','2025-07-20T10:00:00',NULL),
('EVT-2025-027','World Health Support','Health response coordination','InProgress','2025-08-01T05:00:00',NULL),
('EVT-2025-028','Safe Schools Program','School outreach & safety guidance','Planned','2025-08-09T09:00:00',NULL),
('EVT-2025-029','Medical Supply Hub','Medical supplies staging','Done','2025-08-18T10:30:00',NULL),
('EVT-2025-030','Coastal Guard Support','Coastal watch and communication','Done','2025-08-26T17:00:00',NULL);
GO



--1) hazard_types +10 ekledim sonradan

INSERT INTO dbo.hazard_types (hazard_type_name, category_name)   VALUES
('Coastal Flooding','Hydrological'),
('Sinkhole','Geophysical'),
('Dust Storm','Meteorological'),
('Forest Pest Outbreak','Biological'),
('Urban Fire','Technological'),
('Bridge Failure','Technological'),
('Pipeline Leak','Technological'),
('Cyber Incident','Technological'),
('Marine Pollution','Technological'),
('Severe Rainfall','Meteorological');
GO

--+10 hazardsubtypes
INSERT INTO dbo.hazard_subtypes (hazard_type_name, hazard_subtype_name)  VALUES
('Marine Pollution','Oil Spill'),
('Coastal Flooding','Storm Surge Flooding'),
('Coastal Flooding','High Tide Flooding'),
('Sinkhole','Karst Sinkhole'),
('Dust Storm','Visibility Reduction'),
('Forest Pest Outbreak','Bark Beetle Infestation'),
('Urban Fire','Market Fire'),
('Bridge Failure','Structural Collapse'),
('Pipeline Leak','Gas Pipeline Leak'),
('Cyber Incident','Critical Infrastructure Attack'),
('Severe Rainfall','Atmospheric River');



 --  3) sectors (+10)

INSERT INTO dbo.sectors (sector_name) VALUES
('Air Quality'),
('Animal Health'),
('Supply Chain'),
('Critical Infrastructure'),
('Communications'),
('Public Transport'),
('Ports & Maritime'),
('Road Maintenance'),
('Hospital Capacity'),
('Vaccination');
GO


 --  4) organizations (+10)
   -- org_name UNIQUE
  -- parent_org_name null veya org_name olmal�

INSERT INTO dbo.organizations
(org_name, org_type, country_name, parent_org_name, contact_phone, contact_email)
VALUES
('Disaster Data Center','Government','T�rkiye',NULL,'+90-312-555-0201','ddc@gov.tr'),
('City Water Authority','Government','T�rkiye',NULL,'+90-212-555-0202','water@authority.gov.tr'),
('Air Support Volunteers','NGO','T�rkiye',NULL,'+90-212-555-0203','air@volunteers.org'),
('Community Health NGO','NGO','T�rkiye',NULL,'+90-216-555-0204','contact@communityhealth.org'),
('Road Repair Unit','Government','T�rkiye',NULL,'+90-232-555-0205','roads@city.gov.tr'),
('Maritime Relief Team','Government','T�rkiye',NULL,'+90-212-555-0206','maritime@coast.gov.tr'),
('Supply Chain Helpers','Private','T�rkiye',NULL,'+90-212-555-0207','ops@supplyhelpers.com'),
('GRN - T�rkiye Desk','NGO','T�rkiye','Global Relief Network','+90-212-555-0208','turkiye@grn.org'),
('IAU - Medical Desk','NGO','UK','International Aid Union','+44-20-5550-0209','medical@iau.org'),
('WHS - Rapid Response','UN','Switzerland','World Health Support','+41-22-555-0210','rapid@whs.int');
GO



INSERT INTO  dbo.events
(event_label, hazard_type_name, hazard_subtype_name,
 country_name, city_name, admin_region,
 location_description, latitude, longitude,
 start_datetime, end_datetime, magnitude_value, magnitude_unit_name, description)
VALUES

('EVT-2025-061','Coastal Flooding','Storm Surge Flooding','T�rkiye','Istanbul','Marmara','Coastal surge in low-lying areas',40.980000,28.900000,'2025-09-30T04:10:00','2025-09-30T16:00:00',NULL,NULL,'Storm surge caused localized coastal flooding.'),
('EVT-2025-062','Severe Rainfall','Atmospheric River','T�rkiye','Antalya','Mediterranean','Extreme rainfall on coastline',36.880000,30.700000,'2025-10-02T07:00:00','2025-10-03T01:00:00',NULL,NULL,'Prolonged heavy rainfall affected transport and drainage.'),
('EVT-2025-063','Dust Storm','Visibility Reduction','T�rkiye','Konya','Central Anatolia','Low visibility on highways',37.870000,32.480000,'2025-10-05T10:30:00','2025-10-05T20:00:00',NULL,NULL,'Dust storm reduced visibility and increased accident risk.'),
('EVT-2025-064','Sinkhole','Karst Sinkhole','T�rkiye','Konya','Central Anatolia','Ground collapse reported',37.910000,32.520000,'2025-10-08T13:15:00',NULL,NULL,NULL,'Sinkhole opened near farmland; safety perimeter established.'),
('EVT-2025-065','Urban Fire','Market Fire','T�rkiye','Ankara','Central Anatolia','Fire in commercial district',39.930000,32.850000,'2025-10-11T21:40:00','2025-10-12T03:10:00',NULL,NULL,'Urban market fire required emergency services response.'),
('EVT-2025-066','Bridge Failure','Struc tural Collapse','T�rkiye','Sakarya','Marmara','Partial bridge collapse',40.780000,30.400000,'2025-10-15T09:05:00','2025-10-16T18:00:00',NULL,NULL,'Bridge failure disrupted public transport and logistics.'),
('EVT-2025-067','Pipeline Leak','Gas Pipeline Leak','T�rkiye','Izmir','Aegean','Gas leak detected',38.420000,27.140000,'2025-10-18T06:20:00','2025-10-18T14:30:00',NULL,NULL,'Pipeline leak required evacuation and safety inspection.'),
('EVT-2025-068','Cyber Incident','Critical Infrastructure Attack','T�rkiye','Istanbul','Marmara','Targeted service disruption',41.010000,28.980000,'2025-10-21T02:00:00','2025-10-21T12:00:00',NULL,NULL,'Cyber incident affected critical infrastructure monitoring.'),
('EVT-2025-069','Marine Pollution','Oil Spill','Greece','Piraeus','Attica','Coastal contamination',37.940000,23.640000,'2025-10-24T05:30:00','2025-10-25T19:00:00',NULL,NULL,'Marine pollution event required cleanup operations.'),
('EVT-2025-070','Flood','Flash Flood','T�rkiye','Rize','Black Sea','Intense rain triggered runoff',41.020000,40.520000,'2025-10-28T09:10:00','2025-10-28T22:30:00',NULL,NULL,'Flash flood impacted roads and nearby homes.');
GO   




INSERT INTO    dbo.event_impacts
(event_label, deaths_count, injuries_count, displaced_people_count,
 total_loss_usd, insured_loss_usd, housing_loss_usd, infrastructure_loss_usd)
VALUES
('EVT-2025-061',0,12,450, 1800000, 250000, 600000, 500000),
('EVT-2025-062',1,25,800, 3200000, 600000, 900000, 850000),
('EVT-2025-063',0,8,  0,   420000,  80000,  20000,  90000),
('EVT-2025-064',0,2,  10,  260000,  30000,  40000,  70000),
('EVT-2025-065',0,15,120,  980000, 150000, 220000, 180000),
('EVT-2025-066',0,6,  60,  2400000, 400000, 150000, 900000),
('EVT-2025-067',0,4,  200, 1100000, 200000, 120000, 300000),
('EVT-2025-068',0,0,  0,   750000,  50000,  0,      0),
('EVT-2025-069',0,1,  0,   1300000, 150000, 0,     200000),
('EVT-2025-070',0,10,300,  950000, 120000, 280000, 220000);
GO

INSERT INTO dbo.event_sector_impact
(event_label, sector_name, facilities_affected_count, service_disruption_days)
VALUES
('EVT-2025-061','Ports & Maritime',6,2),
('EVT-2025-062','Road Maintenance',10,3),
('EVT-2025-063','Air Quality',4,1),
('EVT-2025-064','Agriculture',3,7),
('EVT-2025-065','Public Safety',8,1),
('EVT-2025-066','Public Transport',12,4),
('EVT-2025-067','Critical Infrastructure',5,2),
('EVT-2025-068','Communications',7,1),
('EVT-2025-069','Ports & Maritime',9,3),
('EVT-2025-070','Water & Sanitation',6,2);
GO

INSERT INTO dbo.aid
(event_label, org_name, amount_usd, quantity, quantity_unit, delivered_datetime, delivery_method)
VALUES
('EVT-2025-061','Coastal Guard Support', 45000,  30,'unit','2025-09-30T12:00:00','sea'),
('EVT-2025-062','Road Repair Unit',      38000,  20,'unit','2025-10-02T15:00:00','road'),
('EVT-2025-063','Air Support Volunteers',22000,  15,'unit','2025-10-05T14:00:00','air'),
('EVT-2025-064','Rapid Response Team',   15000,  10,'unit','2025-10-08T16:00:00','road'),
('EVT-2025-065','Regional Fire Department',30000,12,'unit','2025-10-11T23:30:00','road'),
('EVT-2025-066','Supply Chain Helpers',  60000,  18,'pallet','2025-10-15T14:00:00','road'),
('EVT-2025-067','City Water Authority',  25000,  40,'box','2025-10-18T10:00:00','road'),
('EVT-2025-068','Emergency Tech Partners',80000, 25,'unit','2025-10-21T08:00:00','road'),
('EVT-2025-069','Sea Logistics Alliance',95000,  14,'pallet','2025-10-24T12:00:00','sea'),
('EVT-2025-070','Water First Initiative',28000,  50,'box','2025-10-28T15:30:00','road');
GO


   --9) org_event_actions veri ekleme

INSERT INTO dbo.org_event_actions
(event_label, org_name, title,  status, action_datetime, hours_to_respond)
VALUES
('EVT-2025-061','Maritime Relief Team','Coastal response coordination','InProgress','2025-09-30T06:30:00',NULL),
('EVT-2025-062','Disaster Data Center','Rainfall impact reporting','Done','2025-10-02T10:30:00',NULL),
('EVT-2025-063','Air Support Volunteers','Visibility risk alerts','Done','2025-10-05T12:30:00',NULL),
('EVT-2025-064','Rapid Response Team','Safety perimeter & evacuation notice','InProgress','2025-10-08T15:00:00',NULL),
('EVT-2025-065','Regional Fire Department','Fire suppression & site securing','Done','2025-10-11T22:30:00',NULL),
('EVT-2025-066','Road Repair Unit','Traffic rerouting & repairs planning','InProgress','2025-10-15T11:30:00',NULL),
('EVT-2025-067','City Water Authority','Gas leak advisory to residents','Planned','2025-10-18T07:30:00',NULL),
('EVT-2025-068','Emergency Tech Partners','Incident containment & monitoring','InProgress','2025-10-21T03:30:00',NULL),
('EVT-2025-069','Sea Logistics Alliance','Cleanup logistics coordination','InProgress','2025-10-24T09:00:00',NULL),
('EVT-2025-070','Water First Initiative','Water safety & hygiene guidance','Done','2025-10-28T12:00:00',NULL);
GO
