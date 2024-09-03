# Event Registration

## Overview

Command line application build with `tty-prompt` gem.

Covered stories:
- As an event organiser, I would like to create new events, so that participants can register for them.

- As a participant, I would like to register for an event, so that I can attend it.

- As an event organiser, I would like to see a list of all participants for a specific event, so I can manage attendance.

- As a participant, I would like to see all events I am registered for, so I can keep track of my schedule.

- As an event organiser, I would like to limit the number of participants for an event, so that events do not exceed capacity.

In provided CLI there is no division to event organiser and participant, it could be added as login layer.

## Areas to improve

1. Add tests for `GetAllHashedTicketsByParticipantNameQuery` class, right now this class is tested in indirect way.

1. Move long code to some kind of command line interface class and remove some duplications. Duplications exists in web app view layer so I have assumed that it isn't big problem

## How to run

1. Download repository

   ```
   $ git clone git@github.com:wafcio/event_registration.git
   ```

1. Change directory

   ```
   $ cd event_registration
   ```

1. Fetch gems

   ```
   $ bundle install
   ```

1. Run main file

   ```
   $ ruby run.rb
   ```

## Check code style

```
$ rubocop
```

## Check tests

```
$ rspec spec
```
