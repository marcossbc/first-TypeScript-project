-- Create bookmarks table for Ayahs and Ducooyin
CREATE TABLE public.bookmarks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('quran', 'dua')),
  surah INTEGER,
  ayah INTEGER,
  dua_id UUID,
  arabic_text TEXT,
  translation TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create user_settings table
CREATE TABLE public.user_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL UNIQUE,
  font_size INTEGER DEFAULT 18 CHECK (font_size >= 12 AND font_size <= 32),
  theme TEXT DEFAULT 'light' CHECK (theme IN ('light', 'dark', 'sepia')),
  default_translation TEXT DEFAULT 'en' CHECK (default_translation IN ('en', 'so', 'ar')),
  reciter TEXT DEFAULT 'ar.alafasy',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create ducooyin (supplications) table
CREATE TABLE public.ducooyin (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  text_ar TEXT NOT NULL,
  text_en TEXT,
  text_so TEXT,
  audio_url TEXT,
  category TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.bookmarks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ducooyin ENABLE ROW LEVEL SECURITY;

-- RLS Policies for bookmarks
CREATE POLICY "Users can view their own bookmarks"
  ON public.bookmarks FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own bookmarks"
  ON public.bookmarks FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own bookmarks"
  ON public.bookmarks FOR DELETE
  USING (auth.uid() = user_id);

-- RLS Policies for user_settings
CREATE POLICY "Users can view their own settings"
  ON public.user_settings FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own settings"
  ON public.user_settings FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own settings"
  ON public.user_settings FOR UPDATE
  USING (auth.uid() = user_id);

-- RLS Policies for ducooyin (public read access)
CREATE POLICY "Everyone can view ducooyin"
  ON public.ducooyin FOR SELECT
  USING (true);

-- Insert some sample ducooyin
INSERT INTO public.ducooyin (title, text_ar, text_en, text_so, category) VALUES
  ('Morning Remembrance', 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ', 'We have entered the morning and the sovereignty belongs to Allah', 'Waxaan aroornay, boqortooyaduna waa tan Allaah', 'morning'),
  ('Evening Remembrance', 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ', 'We have entered the evening and the sovereignty belongs to Allah', 'Waxaan fiidnay, boqortooyaduna waa tan Allaah', 'evening'),
  ('Before Sleep', 'بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي', 'In Your name my Lord, I lay down my side', 'Magacaaga Eebahayow, dhinacayga ayaan dhigayaa', 'sleep');

-- Trigger to update updated_at
CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_user_settings_updated_at
  BEFORE UPDATE ON public.user_settings
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at();