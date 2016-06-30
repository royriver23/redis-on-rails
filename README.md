# Redis + Rails

Be sure to have read the presentation:
https://slidebean.com/p/yivnFXTyJh/DRG-Academy-Redis
and review references at the end.

Any question, just let me know.

Install Redis server first, when testing these projects locally, be sure server is ON:
```bash
redis-server
```
****

**There are two projects here:**

## redis_on_rails

### Goals
1. Use redis to index keywords searched, indexing previous coincidences related to Person Model, specifically name field.
2. Count visits by browser and store them in Redis Server.

### Setup
- use ruby 2.x.x
- use postgres database
- $ bundle
- Create a login role called redis_user
- Run: 
```bash
rake db:create
rake db:migrate
rake db:populate
```
- For indexing/precalculate search coincidences, run:
```bash
rake search_suggestions:index
```
This process can be checked here:
https://github.com/rails-gap/redis-rails/blob/master/redis_on_rails/app/models/search_suggestion.rb#L10-L37
The first (commented) section are methods corresponding to search querying database.
The second section, we are using REDIS!

****

### redis_on_rails_model_caching

### Goals
1. Store all records of Person model into Redis for faster access

### Setup
- use ruby 2.x.x
- use postgres database
- $ bundle
- Create a login role called redis_user
- Run: 
```bash
rake db:create
rake db:migrate
rake db:populate
