-- إنشاء جدول الطلبات المخصصة للشوكولا
CREATE TABLE custom_chocolate_orders (
  id SERIAL PRIMARY KEY,
  customer_name VARCHAR(255) NOT NULL,
  customer_phone VARCHAR(20) NOT NULL,
  chocolate_type VARCHAR(50) NOT NULL,
  ingredients TEXT NOT NULL, -- JSON array of selected ingredients
  presentation_type VARCHAR(50) NOT NULL,
  weight_grams INTEGER NOT NULL,
  notes TEXT,
  total_price DECIMAL(10,2) NOT NULL,
  status VARCHAR(50) DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- إنشاء RLS (Row Level Security) للطلبات المخصصة
ALTER TABLE custom_chocolate_orders ENABLE ROW LEVEL SECURITY;

-- سياسات الأمان للطلبات المخصصة (السماح بالقراءة والكتابة للجميع)
CREATE POLICY "Allow all operations on custom_chocolate_orders" ON custom_chocolate_orders FOR ALL USING (true);

-- إنشاء دالة لتحديث updated_at
CREATE OR REPLACE FUNCTION update_custom_orders_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- إنشاء trigger لتحديث updated_at
CREATE TRIGGER update_custom_chocolate_orders_updated_at BEFORE UPDATE ON custom_chocolate_orders
    FOR EACH ROW EXECUTE FUNCTION update_custom_orders_updated_at_column();





