# pokemon-showdown-docker

Collection of configuration files for running a Pokemon Showdown stack within Docker.  
Includes `psim-dc`, a tool help running things.

The "in progress" part of "this project is a work in progress" cannot be understated.
There is very little use out of this project for now. A bunch of stuff should be redone,
and it hasn't been a week since I started.

## TODO

- Generate config from a single sources
- Same for the routes
- Figure out everything that include the word "database".
    - The schemas are duplicated accross repositories apparently?
    - I don't even know what is supposed to be MySQL, PostgreSQL, SQLite, or agnostic, or how much agnostic.
- Generate the SSL certificate if not provided
- What to do with `.dockerignore`s
    - Just wouldn't work as-is in any meaningful capacity without them
    - They're not checkout out rn
- Actually manage assets
    - Serves them from play.pokemonshowdown.com for now.
    - I don't like that, for a lot of reasons.
- Calc server
- Replays
- Diff config from upstreams. No idea how.
- Prevent httpd from internal caching 

## Quick start

```sh
# Checkout and build the images
./bin/psim-dc all build

# Create directories on the host
./bin/psim-dc all mkdir

# Copy the examples config from the images to the host
./bin/psim-dc all base-config

# Fill in the config (by default, in `./services/config`)

# Start a new Pokemon Showdown stack
./bin/psim-dc all up -d
```

## Design choices

### Docker
#### Images
Every image builds from `psim-root`. 
It doesn't matter what `psim-root` is `FROM`, as long as it's `FROM` a manifest that provides as many CPU architectures as needed.

#### Healthcheck
Don't override `HEALTHCHECK`, overwrite `healthcheck.sh` in the image.

#### `depends_on`
Only OK to use for DNS availability, nothing else.

### macOS
Not as first class as Linux (because of macOS's kernel shenanigans), but it *should* work outside the box.
A big emphasis of that is *trying* to make `psim-dc` work on Bash 3.2. I don't own any machine I can test it on, however.

### Windows
WSL2 works well enough, and I do not have that much experience on Windows systems to be able to implement anything
with any shred of condidence there. If you care, feel free to PR.
