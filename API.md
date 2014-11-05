Staging endpoints are located at `https://skillpocket.com/api/`. API version is scoped via the URL. For example:

    https://skillpocket.com/api/v1/experts/:id

All `POST` and `PATCH` endpoints accept JSON data in the body of the request. All requests require a `'Content-Type': 'application/json'` header. All responses are JSON.

`GET /experts`
------------
Shows all the nearest experts for the current request.
Also supports GET parameter named category, as `GET /experts?category=programming`

Example response:

```javascript
[
  {
    "about" : "Building and designing iOS apps since 2009. I started as an independent developer, later worked for a mobile studio and designed product for GetYourGuide, a travel startup. I've gained some knowledge about what might or might not work in apps.",
    "behance_url" : "https://www.behance.net/andyjakubowski",
    "categories" : [
      {
        "id" : 12,
        "name" : "CSS"
      }
    ],
    "email" : "hello@andyjakubowski.com",
    "github_url" : "https://github.com/andyjakubowski",
    "full_name" : "Andy Jakubowski",
    "id" : 20,
    "job" : "Product Designer",
    "linkedin_url" : "https://www.linkedin.com/profile/view?id=304613669",
    "photo" : "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/1525326_714327698586243_837977757_n.jpg",
    "price" : 20,
    "profile_banner_url": "http://api.skillpocket.com/assets/profile_stub.jpeg",
    "skill_description" : "Online Marketing and Paid Acquisition - Where Can I Buy Customers",
    "skill_title" : "Designer",
    "slug" : "andy-jakubowski",
    "tags" : [
      {
        "id" : 12,
        "name" : "CSS"
      },
      {
        "id" : 15,
        "name" : "HTML5"
      }
    ],
    "twitter_url" : "https://twitter.com/jakubowskiandy",
    "website_url" : "http://andyjakubowski.com"
  },
  {
    "about" : "Building and designing iOS apps since 2009. I started as an independent developer, later worked for a mobile studio and designed product for GetYourGuide, a travel startup. I've gained some knowledge about what might or might not work in apps.",
    "behance_url" : "https://www.behance.net/andyjakubowski",
    "categories" : [
      {
        "id" : 12,
        "name" : "CSS"
      }
    ],
    "color" : "E14744",
    "email" : "hello@andyjakubowski.com",
    "github_url" : "https://github.com/andyjakubowski",
    "full_name" : "Andy Jakubowski",
    "id" : 20,
    "job" : "Product Designer",
    "linkedin_url" : "https://www.linkedin.com/profile/view?id=304613669",
    "photo" : "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/1525326_714327698586243_837977757_n.jpg",
    "price" : 20,
    "profile_banner_url": "http://api.skillpocket.com/assets/profile_stub.jpeg",
    "skill_description" : "Online Marketing and Paid Acquisition - Where Can I Buy Customers",
    "skill_title" : "Designer",
    "slug" : "andy-jakubowski",
    "tags" : [
      {
        "id" : 12,
        "name" : "CSS"
      },
      {
        "id" : 15,
        "name" : "HTML5"
      }
    ],
    "twitter_url" : "https://twitter.com/jakubowskiandy",
    "website_url" : "http://andyjakubowski.com"
  }
]
```

`GET /experts/:id`
------------
Shows the info about one expert, according to its id. Id can be either number or a human-readable slug like "andy-jakubowski".
Also supports GET parameter named category, as `GET /experts?category=programming`

Example response:

```javascript
  {
    "about" : "Building and designing iOS apps since 2009. I started as an independent developer, later worked for a mobile studio and designed product for GetYourGuide, a travel startup. I've gained some knowledge about what might or might not work in apps.",
    "behance_url" : "https://www.behance.net/andyjakubowski",
    "categories" : [
      {
        "id" : 12,
        "name" : "CSS"
      }
    ],
    "email" : "hello@andyjakubowski.com",
    "github_url" : "https://github.com/andyjakubowski",
    "full_name" : "Andy Jakubowski",
    "id" : 20,
    "job" : "Product Designer",
    "linkedin_url" : "https://www.linkedin.com/profile/view?id=304613669",
    "photo" : "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/1525326_714327698586243_837977757_n.jpg",
    "price" : 20,
    "profile_banner_url": "http://api.skillpocket.com/assets/profile_stub.jpeg",
    "skill_description" : "Online Marketing and Paid Acquisition - Where Can I Buy Customers",
    "skill_title" : "Designer",
    "slug" : "andy-jakubowski",
    "tags" : [
      {
        "id" : 12,
        "name" : "CSS"
      },
      {
        "id" : 15,
        "name" : "HTML5"
      }
    ],
    "twitter_url" : "https://twitter.com/jakubowskiandy",
    "website_url" : "http://andyjakubowski.com"
  }
```

`GET /categories`
------------
Shows all the categories on which you can perform search on experts.

Example response:

```javascript
[
  {
    "id" : ,
    "name" : "CSS"
  },
  {
    "id" : ,
    "name" : "HTML5"
  }
]
```

`POST /profile`
-----------
Creates the new profile for a user or returns an existing one if it already has one.
Should accept twitter token and secret as 'token' and 'secret' POST parameters. Returns a token for a client to use.

Example request data:

```javascript
{
    token: "d5c2accedd5338ae6bdb7024589a0636",
    secret: "d5c2accedd5338ae6bdb7024589a0636"
}
```

Example response:

```javascript
{
    token: "d5c2accedd5338ae6bdb7024589a0636"
}
```

`GET /profile`
------------
Shows the profile of a user that is currently using an application.
Should be signed with authentication token via Authorisation header.
Example response:

```javascript
  {
    "about" : "Building and designing iOS apps since 2009. I started as an independent developer, later worked for a mobile studio and designed product for GetYourGuide, a travel startup. I've gained some knowledge about what might or might not work in apps.",
    "behance_url" : "https://www.behance.net/andyjakubowski",
    "categories" : [
      {
        "id" : 12,
        "name" : "CSS"
      }
    ],
    "email" : "hello@andyjakubowski.com",
    "github_url" : "https://github.com/andyjakubowski",
    "full_name" : "Andy Jakubowski",
    "id" : 20,
    "job" : "Product Designer",
    "linkedin_url" : "https://www.linkedin.com/profile/view?id=304613669",
    "photo" : "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xap1/t1.0-9/1525326_714327698586243_837977757_n.jpg",
    "price" : 20,
    "profile_banner_url": "http://api.skillpocket.com/assets/profile_stub.jpeg",
    "skill_description" : "Online Marketing and Paid Acquisition - Where Can I Buy Customers",
    "skill_title" : "Designer",
    "slug" : "andy-jakubowski",
    "tags" : [
      {
        "id" : 12,
        "name" : "CSS"
      },
      {
        "id" : 15,
        "name" : "HTML5"
      }
    ],
    "twitter_url" : "https://twitter.com/jakubowskiandy",
    "website_url" : "http://andyjakubowski.com"
  }
```


`PUT /profile`
-----------
Updates profile
Should be signed with authentication token via Authorisation header.
Accepts either combination of full_name, email, job, about, website_url, twitter_url, linkedin_url, behance_url, github_url, stackoverflow_url as request parameters.
Returns HTTP 201 and an empty body.


`POST /profile/pushtoken`
-----------
Updates iOS device push token.
Should be signed with authentication token via Authorisation header.
Accepts 'ios_device_token' parameter.
Returns HTTP 200 and an empty body.


`POST /profile/location`
-----------
Updates iOS device push token.
Should be signed with authentication token via Authorisation header.
Accepts 'latitude' and 'longitude' parameters.
Returns HTTP 200 and an empty body.


`GET /contacts`
-----------
Should be signed with authentication token via Authorisation header.
Returns a list of contacts ordered by date of last conversation and count of unread messages.
Returns HTTP 200 and JSON of the following format:

```javascript
    [
      {
        "id": 212,
        "full_name": 'John Smith',
        "about": 'Software engineer',
        "unread":1,
        "text":'whatup',
        "time":1234568000
      },
      ...
    ]
```

`GET /message/:id`
-----------
Get a list of messages with a specific person.
Should be signed with authentication token via Authorisation header.
Accepts user id.
Returns HTTP 200 and JSON of the following format:

```javascript
    [
      {"incoming":false, "read":true,  "date":1413234444, "message":"Ready, let`s roll" },
      {"incoming":false, "read":true,  "date":1413234333, "message":"Hello back" }
    ]
```


`POST /message/:id`
------------
Send a message to a specific person.
Should be signed with authentication token via Authorisation header.
Accepts a user 'id' and 'text' in parameters.
Returns HTTP 201 and an empty body.


`GET /message/unread`
------------
Gets a list of total unread messages.
Should be signed with authentication token via Authorisation header.
Returns HTTP 200 and JSON of the following format:

```javascript
    {"unread": 20}
```
