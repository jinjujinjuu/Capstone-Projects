USE Olist
GO

--Add constraints PRIMARY KEY to mql_id column in marketing_qualified_leads table.
ALTER TABLE marketing_qualified_leads 
ADD CONSTRAINT pk_mqlid primary key (mql_id);

--Add constraints FORIEGN KEY to mql.id column in closed_deals table with reference to PRIMARY KEY mql_id column 
--in marketing_qualified_leads table.
ALTER TABLE closed_deals 
ADD CONSTRAINT fk_mqlid foreign key (mql_id)
	references marketing_qualified_leads (mql_id); 

--DROP columns in closed_deals table 
ALTER TABLE closed_deals
DROP COLUMN has_company, has_gtin, average_stock, declared_product_catalog_size, declared_monthly_revenue;

--DROP columns in marketing_qualified_leads table 
ALTER TABLE marketing_qualified_leads
DROP COLUMN landing_page_id;

--Change data type of won_date column in closed_deals table to date only
ALTER TABLE closed_deals
ALTER COLUMN won_date date;

--Replace 'other', 'unknown' & NULL values with 'other_publicities' for origin column in marketing_qualified_leads table 
UPDATE marketing_qualified_leads 
SET origin = 'other_publicities'
WHERE origin = 'other' OR origin = 'unknown' OR origin IS NULL;

UPDATE closed_deals
SET business_segment = COALESCE(business_segment, 'other');

UPDATE closed_deals
SET lead_type = COALESCE(lead_type, 'other');

--Categorize those profile with 2 types for lead_behaviour_profile column into 'mixed'.
UPDATE closed_deals
SET lead_behaviour_profile = 'mixed'
WHERE lead_behaviour_profile IN ('cat, wolf', 'eagle, cat', 'eagle, wolf', 'shark, wolf', 'shark, cat');

--Change value for first_contact_date for mql_id = 'b91cf8812365f50ff4bda4bcd6206b05' in marketing_qualified_leads table 
--as the won_date for the same mql_id is earlier than first_contact_date
UPDATE marketing_qualified_leads 
SET first_contact_date = '2018-03-06'
WHERE mql_id = 'b91cf8812365f50ff4bda4bcd6206b05';
