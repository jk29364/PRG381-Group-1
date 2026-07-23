/*
Contains sample data
*/

/*materials table*/
INSERT INTO Materials (materialName, category, quantity, reorderLevel, supplierId) 
VALUES 
    -- Cleaning Chemicals
    ('Heavy Duty Floor Disinfectant 5L', 'Chemicals', 45, 15, 101),
    ('Multi-Surface Glass Cleaner 750ml', 'Chemicals', 80, 20, 101),
    ('Bleach & Sanitizing Liquid 5L', 'Chemicals', 12, 25, 102),
    ('Hand Soap Refill 5L', 'Chemicals', 60, 20, 101),

    -- Cleaning Equipment & Tools
    ('Microfiber Cleaning Cloths (Pack of 10)', 'Equipment', 150, 30, 103),
    ('Industrial Wet & Dry Vacuum Dust Bags', 'Equipment', 8, 10, 104),
    ('Commercial Mop Heads (Cotton)', 'Equipment', 40, 15, 103),
    ('Floor Scrubbing Pads (Red)', 'Equipment', 25, 10, 104),

    -- Protective Gear & Consumables
    ('Nitrile Disposable Gloves (Large, Box 100)', 'Safety', 100, 25, 105),
    ('Heavy Duty Yellow Rubber Gloves', 'Safety', 35, 15, 105),
    ('2-Ply Toilet Paper Rolls (Case of 48)', 'Paper Products', 200, 50, 102),
    ('Paper Hand Towel Folded (Pack of 2000)', 'Paper Products', 85, 30, 102);