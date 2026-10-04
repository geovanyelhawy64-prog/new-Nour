// Feature Flags - Gating for incomplete/unverified modules
// These flags control visibility of features that are not yet reviewed/approved.

class FeatureFlags {
  FeatureFlags._();

  // Kids Mode - Stories, coloring, etc.
  // Quarantined: content is authored/unverified, needs priest review
  static const bool kFeatureKids = false;

  // Coptic Dictionary - 110 words only, incomplete
  // Quarantined: printed source but incomplete coverage, needs specialist review
  static const bool kFeatureCopticDictionary = false;

  // Monasteries / Holy Places - Empty table (0 records in DB)
  // Quarantined: no data populated yet
  static const bool kFeatureMonasteries = false;

  // Emotion Prayers - Authored content, not from printed source
  // Quarantined: visibility=private, only in dev builds
  static const bool kFeatureEmotionPrayers = false;

  // Daily Verses (Reflections/Meditations) - Authored content
  // Quarantined: visibility=private, only in dev builds
  // Note: This is distinct from the Bible daily verse which is printed
  static const bool kFeatureDailyVerses = false;

  // Theology Articles - Authored content
  // Quarantined: visibility=private, only in dev builds
  static const bool kFeatureTheology = false;

  // Occasional Prayers - Authored content
  // Quarantined: visibility=private, only in dev builds
  static const bool kFeatureOccasionalPrayers = false;

  // Content Library (browse all) - controlled by individual flags above
  static const bool kFeatureContentLibrary = false;
}