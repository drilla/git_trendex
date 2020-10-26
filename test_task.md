
Please implement a service, which will
Check GitHub API every X minutes and pull trending repositories;
Trending - with most number of Stars;
Please DO NOT user cron or anything like that;
Save received repositories in the database
We’re expecting you to choose the database and explain us your decision;
It could be PostgreSQL, MySQL, etc.

Your service should provide a public API with three endpoints
Get a repository by name or ID;
Get all repositories;
Start sync with Github;
Force sync should reset the internal timer for automatic sync.

Please provide us with the CLI client for this service, which uses the above-mentioned API. Use any technology you like for the CLI client.

As an advanced level, please build a simple SPA using ReactJS to work with yours API and do the same as CLI.

Be creative. Show us what you can. Good luck. Happy coding.
