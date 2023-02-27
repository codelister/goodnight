# README

Goodnight is a simply CRUD application for managing a user's sleep.
The model, db migrations, and json api are included.
I just used the Rails project generator for setting things up.
While I've added a basic implementation, there could some bugs and inaccuracy. For clarity, I've provided my intention behind the implementation.

1. Clock In operation, and return all clocked-in times, ordered by created time.

I introduced a table to manage sleep_records.

For clocking in, the field `sleep_time` is used.
For clocking out, the field `wake_time` is used.

`POST /users/:user_id/sleep_records` creates a new sleep record. Use this to clock-in.
`PUT /users/:user_id/sleep_records/:id` updates an existing sleep record. Use this to clock-out.

2. Users can follow and unfollow other users.

I introduced a table to manage relationships, using the terms `follower` and `followee`. 

`POST /users/:user_id/user_follows` allows a user to follow.
`DELETE /users/:user_id/user_follows/:id` allows a user to unfollow.

3. See the sleep records over the past week for their friends, ordered by the length of their sleep.

Note that I've assumed "friends" means someone that you follow. 

`GET /users/:user_id/user_follows/sleep_records` will return the list of sleep_records ordered by sleep duration in descending order.

It could be better to update the endpoint and retrieve particular attributes of a user's followers if we care about extensibility e.g. 

`GET /users/:user_id/user_follows?value="sleep_records"`

