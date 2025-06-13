# GrubDaily Gourmet

GrubDaily Gourmet is a Rails 8 food blog and recipe management application that allows users to create, manage, and share recipes and blog posts. The application features a sophisticated content management system with image processing, tagging, and collection organization.

## Application Overview

This is a content-focused web application built for food enthusiasts, featuring:

- **Recipe Management**: Create and manage detailed recipes with ingredients, method steps, and nutritional information
- **Blog Publishing**: Write and publish food-related blog posts with rich content and images
- **Content Organization**: Organize content using tags and collections
- **Image Processing**: Advanced image handling with multiple variants and responsive sizing
- **Email Marketing**: Newsletter subscription management with Mailchimp integration
- **Import System**: YAML-based recipe import functionality

## Model Architecture

The application uses a sophisticated polymorphic architecture centered around the `Entry` model, which serves as a unified interface for different content types.

### Core Architecture Pattern: Delegated Types

The application implements Rails' delegated type pattern with `Entry` as the central hub:

```
Entry (delegated_type hub)
├── Recipe (entryable)
├── BlogPost (entryable) 
└── StapleRecipe (entryable)
```

### Key Model Relationships

#### Entry Model (Central Hub)
- **Purpose**: Unified interface for all content types (recipes, blog posts, etc.)
- **Contains**: `title`, `summary`, `content`, `published_at`, `marked_for_promotion_at`
- **Relationships**:
  - `delegated_type :entryable` → Recipe, BlogPost, StapleRecipe
  - `has_many :entry_taggings` → Tags (through join table)
  - `has_many :collection_entries` → Collections (through join table)

#### Recipe Model
- **Purpose**: Detailed recipe management with ingredients and cooking instructions
- **Key Features**: 
  - ISO 8601 time format validation
  - Serves/makes validation logic
  - Nutrition data integration
- **Relationships**:
  - `has_one :entry, as: :entryable` (polymorphic)
  - `has_many :ingredient_sets` → IngredientSet
  - `has_many :method_steps` → MethodStep
  - `has_one_attached :image` (Active Storage)
  - `belongs_to :collection` (optional)
- **Delegated Methods**: `tags`, `content`, `summary` (to Entry)

#### BlogPost Model
- **Purpose**: Blog content with multiple images and sectioned content
- **Key Features**:
  - Content section delimiter validation (requires `---`)
  - Multiple image attachments
  - Word count and SEO features
- **Relationships**:
  - `has_one :entry, as: :entryable` (polymorphic)
  - `has_many_attached :attached_images` (Active Storage)
- **Delegated Methods**: `tags`, `content`, `summary` (to Entry)

#### Ingredient System
```
Recipe
├── IngredientSet (has_many)
    ├── IngredientEntry (has_many)
        ├── IngredientEntryIngredientSource → Ingredient
        └── IngredientEntryRecipeSource → Recipe (for recipe references)
```

- **IngredientSet**: Groups ingredients (e.g., "Main ingredients", "For garnish")
- **IngredientEntry**: Individual ingredient with quantity, unit, size, modifier
- **Ingredient**: Master ingredient database with synonyms
- **Source Tables**: Link ingredients to their sources (ingredients or other recipes)

#### Tagging System
```
Entry/Recipe/BlogPost
├── EntryTagging → Tag
├── RecipeTagging → Tag (legacy)
└── BlogPostTagging → Tag (legacy)
```

#### Collection System
- **Collection**: Curated groups of entries (e.g., "Summer Recipes")
- **CollectionEntry**: Join table linking Collections to Entries

### Shared Concerns

The application uses several concerns to share functionality:

- **Entryable**: Polymorphic relationship setup for Entry association
- **Publishable**: Publishing/unpublishing functionality with timestamps
- **Image**: Advanced image processing with multiple variants and responsive sizing
- **Taggable**: Tag management functionality
- **TitleFormatter**: URL-friendly title generation
- **Excerptable**: Content excerpt generation
- **Logging**: Structured logging functionality

### Image Processing Architecture

The application implements a sophisticated image processing system:

- **Multiple Variants**: Tiny, Small, Medium, Large squares + Landscape variants
- **Responsive Sizing**: Different sizes for mobile, tablet, desktop
- **Format Optimization**: WebP conversion for modern browsers
- **Placeholder Handling**: Graceful fallbacks for missing images
- **Active Storage Integration**: Rails 8 Active Storage with variant processing

## Technical Stack

* **Ruby version**: 3.4.3
* **Rails version**: 8.0.2
* **Database**: PostgreSQL
* **Asset Pipeline**: Propshaft (Rails 8 default)
* **CSS**: Dart Sass with Bulma framework
* **JavaScript**: Import maps with Stimulus
* **Image Processing**: Active Storage with MiniMagick/Vips
* **Background Jobs**: Solid Queue (Rails 8)
* **Caching**: Solid Cache (Rails 8)
* **WebSockets**: Solid Cable (Rails 8)

## System Dependencies

- PostgreSQL (database)
- ImageMagick or libvips (image processing)
- Node.js (for Dart Sass compilation)

## Configuration

The application uses Rails credentials for sensitive configuration:
- Mailchimp API keys
- Database credentials
- Nutrition API keys

## Database Creation

```bash
rails db:create
rails db:migrate
```

## Database Initialization

```bash
rails db:seed
```

The seed file includes a comprehensive recipe import system that fetches ~140 recipes from a production API.

## How to Run the Test Suite

```bash
# Run all tests
bundle exec rspec

# Run specific test files
bundle exec rspec spec/models/recipe_spec.rb
bundle exec rspec spec/requests/recipes_spec.rb

# Run with coverage
COVERAGE=true bundle exec rspec
```

The test suite includes:
- Model unit tests with factory-based data
- Request/integration tests
- Image processing tests with placeholder handling
- API integration tests with proper stubbing

## Services

- **Background Jobs**: Solid Queue for image processing and email tasks
- **Caching**: Solid Cache for performance optimization
- **Email Marketing**: Mailchimp integration for newsletter management
- **Image Processing**: Active Storage variants with responsive sizing
- **Search**: Custom recipe search functionality

## Deployment Instructions

The application is configured for Heroku deployment:

1. **Environment Setup**:
   ```bash
   heroku config:set RAILS_ENV=production
   heroku config:set RAILS_MASTER_KEY=<your_master_key>
   ```

2. **Database Migration**:
   ```bash
   heroku run rails db:migrate
   heroku run rails db:seed
   ```

3. **Asset Compilation**:
   - Propshaft handles asset compilation automatically
   - Ensure Dart Sass compilation works in production

4. **Image Storage**:
   - Configure Active Storage for cloud storage (S3, etc.)
   - Set up CDN for image delivery

## Development Notes

- **Rails 8 Features**: Uses Solid Queue, Solid Cache, and Solid Cable
- **Modern Asset Pipeline**: Propshaft with import maps
- **Image Variants**: Comprehensive responsive image system
- **Polymorphic Design**: Flexible content architecture with delegated types
- **Test Coverage**: Comprehensive test suite with 248 examples

## API Integration

- **Nutritionix API**: Automatic nutrition data fetching for recipes
- **Mailchimp API**: Newsletter subscription management
- **Recipe Import**: YAML-based bulk recipe import system
