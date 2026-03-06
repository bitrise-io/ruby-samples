# Ruby on Rails Sample Projects

This repository contains Ruby on Rails sample projects covering typical combinations of testing frameworks and databases.

## Samples

| Directory | Testing | Relational DB | Non-relational DB |
|-----------|---------|---------------|-------------------|
| [sample-ruby-on-rails-rspec-postgres-redis](sample-ruby-on-rails-rspec-postgres-redis/) | RSpec | PostgreSQL | Redis |
| [sample-ruby-on-rails-minitest-sqlite-mongodb](sample-ruby-on-rails-minitest-sqlite-mongodb/) | Minitest | SQLite | MongoDB |

---

### sample-ruby-on-rails-rspec-postgres-redis

**Stack:** RSpec · FactoryBot · PostgreSQL · Redis · Sidekiq

**What it demonstrates:**
- REST API with full CRUD and validation testing
- Model and request specs with RSpec, FactoryBot, Faker, Shoulda-matchers
- Background job processing with Sidekiq (backed by Redis)
- Redis-backed caching

**How to run:**
```bash
cd sample-ruby-on-rails-rspec-postgres
bundle install
bundle exec rake db:create db:schema:load RAILS_ENV=test
bundle exec rspec
```

> Requires PostgreSQL and Redis running locally (or via Docker).

---

### sample-ruby-on-rails-minitest-sqlite-mongodb

**Stack:** Minitest · SQLite · MongoDB (Mongoid)

**What it demonstrates:**
- Rails-default testing setup with Minitest
- ActiveRecord with SQLite for structured/relational data
- Mongoid with MongoDB for flexible document data
- Dual ORM pattern in a single Rails application

**How to run:**
```bash
cd sample-ruby-on-rails-minitest-sqlite-mongodb
bundle install
bin/rails db:prepare
bin/rails test
```

> Requires MongoDB running locally (or via Docker).
