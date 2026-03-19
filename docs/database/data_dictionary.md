# Data Dictionary

## MySQL Tables

### regions
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| region_id | INT | Primary key | PK, Auto-increment |
| name | VARCHAR(100) | Region name | NOT NULL, Unique |
| country | VARCHAR(50) | Country | NOT NULL |
| climate | VARCHAR(50) | Climate type | |
| area_hectares | DECIMAL(10,2) | Total area | |
| established_year | INT | Year established | |

### wineries
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| winery_id | INT | Primary key | PK, Auto-increment |
| region_id | INT | Foreign key to regions | FK |
| name | VARCHAR(100) | Winery name | NOT NULL |
| founded_year | INT | Year founded | |
| annual_production | INT | Bottles per year | |
| certification | VARCHAR(50) | Organic/Biodynamic/etc | |

### wines
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| wine_id | INT | Primary key | PK, Auto-increment |
| winery_id | INT | Foreign key to wineries | FK |
| name | VARCHAR(100) | Wine name | NOT NULL |
| varietal | VARCHAR(50) | Grape variety | |
| vintage | INT | Year | NOT NULL |
| alcohol_percentage | DECIMAL(3,1) | Alcohol content | |
| price | DECIMAL(10,2) | Price | |
| stock_quantity | INT | Available bottles | |

### users
| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| user_id | INT | Primary key | PK, Auto-increment |
| email | VARCHAR(100) | User email | UNIQUE, NOT NULL |
| username | VARCHAR(50) | Username | UNIQUE, NOT NULL |
| password_hash | VARCHAR(255) | Hashed password | NOT NULL |
| role | ENUM('admin','user','critic') | User role | NOT NULL |
| created_at | TIMESTAMP | Account creation | DEFAULT CURRENT_TIMESTAMP |

## MongoDB Collections

### reviews
```json
{
  "_id": ObjectId,
  "wine_id": NumberInt,
  "user_id": NumberInt,
  "rating": NumberInt,
  "title": String,
  "content": String,
  "tasting_notes": {
    "appearance": String,
    "nose": String,
    "palate": String,
    "finish": String
  },
  "food_pairings": [String],
  "purchase_location": String,
  "price_paid": NumberDecimal,
  "created_at": ISODate,
  "helpful_count": NumberInt,
  "images": [String]
}
```

### analytics_events
```json
{
  "_id": ObjectId,
  "event_type": String,
  "user_id": NumberInt,
  "wine_id": NumberInt,
  "timestamp": ISODate,
  "session_id": String,
  "metadata": Object
}
```
