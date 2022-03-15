# Peek iOS Coding Challenge

<img src="https://cdn.worldvectorlogo.com/logos/graphql.svg" width="200" height="200" /><img src="https://d2z5w7rcu7bmie.cloudfront.net/assets/images/logo.png" width="200" height="200" />

## Goal

Build a universial iOS app that queries GitHub for repositories that mention the phrase `GraphQL`.

The code necessary to communicate with and parse the results from GitHub have been provided for you.

Your responsibility is to showcase your ability to build a great UI/UX for interacting with the data provided in ~4 hours.

Please explain in a README file the choices you made to complete the code challenge and list the things you would have added if you had more time to spend on it.


## Achievements

The following are **hard** requirements. Every requirement is expected to be completed with your submission.

1. ✅ Initial launch: fetch the initial set of repos that contain the string `graphql`
1. ✅  Display the result of each repository returned from the query
1. ✅ Infinite scrolling - when reaching the bottom of the currently loaded dataset, the query should continue from the last point
1. ✅ Error handling - let the user know when an error happens
1. ✅ MVVM architecture

## How it was built
1. Used protocols and delegates for communication
2. Non reactive code
3. Used view code to build all views and cells

## Frameworks used
1. Kingfisher: easy and realiable framework to download images

## What I would like to add if I had more time
1.  Dark mode
1.  Search bar
1.  User's detail screen
2.  Animated launcher
3.  Unit tests
  
