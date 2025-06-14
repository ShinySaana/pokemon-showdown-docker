# pokemon-showdown-docker

Collection of configuration files for running a Pokemon Showdown stack within Docker.  
Includes `psim-dc`, an helper utility to setup, configure, and run the stack.

The "in progress" part of "this project is a work in progress" cannot be understated.
There is very little use out of this project for now. A bunch of stuff should be redone.
For now at least; treat this project with little more regards than me rambling into the void.

## TODO

- Generate config from a single sources
    - Currently in progress
    - Architecture of the code doing that needs much more thought than it is currently being given.
        - Fine for now while I figure things out. 
- Checkout `.dockerignore`s directly next to the `Dockerfile`s.
- Figure out everything that include the word "database".
    - DB are shared
    - Probably manage their schemas entirely out of the main showdown projects?
- Centralize exported environment variables in some sane manner.
    - Source an equivalent to `.env`?
        If this, not `.env` because compose will pick it up
    - Read `./.env` and explicitely exclude it in `psim-dc`'s compose calls?
        - If so, ensure calls to compose fail if not called through `psim-dc` and warn the user.
            - Probably through some manner of error on undefined variable in `docker-compose.yml`
- Actually manage assets
    - Serves them from play.pokemonshowdown.com for now.
    - I don't like that, for a lot of reasons.
- Replays
- Diff config from upstreams
    - Probably diff the templates from config-generator and the various config-examples
- Prevent httpd from internal caching
- Calc server
- psbattletools?

## Quick start

```sh
# Checkout and build the images.
./bin/psim-dc all build

# Create directories on the host.
./bin/psim-dc all mkdir

# Generate self-signed SSL certificates.
./bin/psim-dc all generate-nginx-ssl

# Alternatively, copy your certificates to `./services/config/nginx/ssl/`.
# The nginx container expects what `certbot` produces.
# TODO: Allow `export`-ing the path to the certificates.

# Copy `./config/stack/config.example.yml` to `./config/stack/config.yml`.
# Fill some values with your specific needs.

# Generate config files from `./config/stack/config.yml`
# Currently a work in progress
./bin/psim-dc all generate-config

# Fill in the config for each service (by default, in `./services/config`).
# I know that this is step 2 of drawing an owl. I'm getting to that.

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
